#!/bin/bash

# Generate a random number between 50 and 100
random_number=$((RANDOM % 51 + 50))

# Get the current date and time in the desired format
current_time=$(date +'%d/%m/%Y %H:%M:%S')

# Get the current hour and date for folder naming
current_hour=$(date +'%Y%m%d_%H')  # Format: YYYYMMDD_HH
output_directory="output_$current_hour"

# Create the directory if it doesn't exist
mkdir -p "$output_directory"

# Create a filename based on the current date and time
filename="$output_directory/random_output_$(date +'%d_%m_%Y_%H_%M_%S').txt"

# Print the time and random number to the file
echo "Time: $current_time, Random Number: $random_number" > "$filename"

