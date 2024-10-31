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
total_top_temp=$((London_top + Manchester_top + Birmingham_top + Newcastle_top + Liverpool_top + Nottingham_top))
total_low_temp=$((London_low + Manchester_low + Birmingham_low + Newcastle_low + Liverpool_low + Nottingham_low))
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
current_hour=$(date +'%d%m%Y_%H') 
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

# Updating the weather forecast website when the values .
sed -i "69s|<div changesclass=\"day\">.*|<div class=\"day\">$day</div>|" ./web/index.html
sed -i "70s|<div class=\"date\">.*|<div class=\"date\">$date_month</div>|" ./web/index.html
sed -i "75s|<div class=\"num\">.*|<div class=\"num\">$uk_top_temp<sup>o</sup>C</div>|" ./web/index.html

sed -i "80s|<span><img src=\"images/icon-umberella.png\" alt=\"\">.*|<span><img src=\"images/icon-umberella.png\" alt=\"\">$uk_low_temp%</span>|" ./web/index.html
sed -i "81s|<span><img src=\"images/icon-wind.png\" alt=\"\">.*|<span><img src=\"images/icon-wind.png\" alt=\"\">$speed km/h</span>|" ./web/index.html
sed -i "82s|<span><img src=\"images/icon-compass.png\" alt=\"\">.*|<span><img src=\"images/icon-compass.png\" alt=\"\">$direction</span>|" ./web/index.html

sed -i "93s|<div class=\"degree\">.*|<div class=\"degree\">$London_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "94s|<small>.*|<small>$London_low<sup>o</sup></small>|" ./web/index.html
sed -i "105s|<div class=\"degree\">.*|<div class=\"degree\">$Manchester_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "106s|<small>.*|<small>$Manchester_low<sup>o</sup></small>|" ./web/index.html
sed -i "117s|<div class=\"degree\">.*|<div class=\"degree\">$Birmingham_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "118s|<small>.*|<small>$Birmingham_low<sup>o</sup></small>|" ./web/index.html
sed -i "129s|<div class=\"degree\">.*|<div class=\"degree\">$Newcastle_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "130s|<small>.*|<small>$Newcastle_low<sup>o</sup></small>|" ./web/index.html
sed -i "141s|<div class=\"degree\">.*|<div class=\"degree\">$Liverpool_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "142s|<small>.*|<small>$Liverpool_low<sup>o</sup></small>|" ./web/index.html
sed -i "153s|<div class=\"degree\">.*|<div class=\"degree\">$Nottingham_top<sup>o</sup>C</div>|" ./web/index.html
sed -i "154s|<small>.*|<small>$Nottingham_low<sup>o</sup></small>|" ./web/index.html

sed -i "169s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" ./web/index.html
sed -i "176s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" ./web/index.html
sed -i "183s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" ./web/index.html
sed -i "190s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" ./web/index.html

sed -i "202s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" ./web/index.html
sed -i "209s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" ./web/index.html
sed -i "216s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" ./web/index.html




