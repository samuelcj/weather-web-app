#!/bin/bash

# All our Varriables
#Top Temperatures varrying between 21 - 27oC
London_top=$((RANDOM % 8 + 20))
Manchester_top=$((RANDOM % 8 + 20))
Birmingham_top=$((RANDOM % 8 + 20))
Newcastle_top=$((RANDOM % 8 + 20))
Liverpool_top=$((RANDOM % 8 + 20))
Nottingham_top=$((RANDOM % 8 + 20))

#Low Temperatures varrying between 16 - 21oC
London_low=$((RANDOM % 7 + 15))
Manchester_low=$((RANDOM % 7 + 15))
Birmingham_low=$((RANDOM % 7 + 15))
Newcastle_low=$((RANDOM % 7 + 15))
Liverpool_low=$((RANDOM % 7 + 15))
Nottingham_low=$((RANDOM % 7 + 15))

#UK Temperatures (average)
total_top_temp=$((London_top + Manchester_top + Birmigham_top + Newcastle_top + Liverpool_top + Nottingham_top))
total_low_temp=$((London_low + Manchester_low + Birmigham_low + Newcastle_low + Liverpool_low + Nottingham_low))
uk_top_temp=$((total_top_temp / 6))
uk_low_temp=$((total_low_temp / 6))

#Speed and Direction
speed=$((RANDOM % 8 + 15))
cardinals=("East" "West" "North" "South")
direction=${cardinals[RANDOM % ${#cardinals[@]}]}


#Date and Time
day=$(date +%A)
date_month=$(date +"%d %B")
time=$(date +'%H:%M')
ampm=$(date +%p)

#File Management
# Get the current date and time
current_time=$(date +'%d/%m/%Y %H:%M:%S')

# Get the current hour and date for folder naming
current_hour=$(date +'%Y%m%d_%H') 
file_directory="$current_hour"

# Create the weather forcast directory if it doesn't exist
mkdir -p "weather_data"
mkdir -p "./weather_data/$file_directory"

# Create a filename based on the current date and time
weather_forecast="./weather_data/$file_directory/$(date +'%d_%m_%Y_%H_%M_%S')_weather_forecast.txt"

# Send the output of all the recorded weather forcast to the file for data keeping.
cat <<EOL > "$weather_forecast"
As at $time on $day, $date_month.
These were the recorded Weather forecast for the following cities in the United Kingdom.
For London the High Temperature was $London_top oC and the Low Temperature was $London_low oC.
For Manchester the High Temperature was $Manchester_top oC and the Low Temperature was $Manchester_low oC.
For Birmingham the High Temperature was $Birmingham_top oC and the Low Temperature was $Birmingham_low oC.
For Newcastle the High Temperature was $Newcastle_top oC and the Low Temperature was $Newcastle_low oC.
For Liverpool the High Temperature was $Liverpool_top oC and the Low Temperature was $Liverpool_low oC.
For Nottingham the High Temperature was $Nottingham_top oC and the Low Temperature was $Nottingham_low oC.
EOL

echo "Weather data has been written to '$(date +'%d_%m_%Y_%H_%M_%S')_weather_forecast.txt file'."

