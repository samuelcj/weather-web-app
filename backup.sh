#!/bin/bash

# Define the lower and upper bounds
LOWER_BOUND=1437
UPPER_BOUND=7328361

# Generate a random number in the specified range
RANGE=$((UPPER_BOUND - LOWER_BOUND + 1))
unique=$((RANDOM % RANGE + LOWER_BOUND))

# Print the random number
echo "Random number between $LOWER_BOUND and $UPPER_BOUND: $unique"

# Set the source and destination directories
SOURCE_DIR="/var/www/html/weather_data"
DEST_DIR="/var/www/html/backup_data"
BUCKET_NAME="backup-bucket-group-10-project"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Loop through each folder in the source directory
for folder in "$SOURCE_DIR"/*/; do
    # Check if it's a directory
    if [ -d "$folder" ]; then
        # Get the folder name without the path
        folder_name=$(basename "$folder")
        # Zip the contents of the folder and send it to the destination directory
        (cd "$folder" && zip -r "$DEST_DIR/$folder_name.zip" .) > /dev/null
        echo "Zipped $folder_name to $DEST_DIR/$folder_name.zip"
    fi
done

# Check if the S3 bucket exists, if not, create it
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo "Bucket '$BUCKET_NAME' already exists."
else
    echo "Bucket '$BUCKET_NAME' does not exist. Creating it now..."
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region us-east-1
    echo "Bucket '$BUCKET_NAME' created successfully."
fi

# Sync the backup data to S3
aws s3 sync "$DEST_DIR/" "s3://$BUCKET_NAME"

# List objects in the S3 bucket and store their keys in a file
aws s3api list-objects --bucket "$BUCKET_NAME" --query "Contents[].{Key: Key}" --output text > /var/www/html/object-keys.txt

# Move each object to Glacier
while read -r key; do
    if [ -n "$key" ]; then  # Check if the key is not empty
        echo "Copying $key to Glacier..."
        aws s3api copy-object --bucket "$BUCKET_NAME" --copy-source "$BUCKET_NAME/$key" --key "$key" --storage-class GLACIER
    fi
done < /var/www/html/object-keys.txt

echo "All objects have been copied to Glacier."

##################################################################

# Variables
INSTANCE_ID="i-0ae050c9ac579b05a"  # Replace with your instance ID
S3_BUCKET="$BUCKET_NAME"  # Replace with your S3 bucket name
S3_FOLDER="server_backup"  # Replace with your desired folder in S3
DESCRIPTION="My Backup Snapshot"

# Retrieve the EBS Volume ID attached to the instance
VOLUME_ID=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId" --output text)

# Check if VOLUME_ID retrieval was successful
if [[ "$VOLUME_ID" == "None" || -z "$VOLUME_ID" ]]; then
    echo "No EBS volume found for instance $INSTANCE_ID"
    exit 1
fi

echo "Using volume ID: $VOLUME_ID"

# Create EBS Snapshot
SNAPSHOT_ID=$(aws ec2 create-snapshot --volume-id "$VOLUME_ID" --description "$DESCRIPTION" --query "SnapshotId" --output text)

# Check if snapshot creation was successful
if [[ $? -ne 0 || -z "$SNAPSHOT_ID" ]]; then
    echo "Error creating snapshot"
    exit 1
fi

echo "Created snapshot: $SNAPSHOT_ID"

# Wait for the snapshot to complete
echo "Waiting for snapshot to complete..."
aws ec2 wait snapshot-completed --snapshot-ids "$SNAPSHOT_ID"

