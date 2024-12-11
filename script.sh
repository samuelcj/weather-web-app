#!/bin/bash

# All our Varriables
#Top Temperatures varrying between 21 - 27oC
Lagos_top=$((RANDOM % 8 + 20))
Abuja_top=$((RANDOM % 8 + 20))
PortHacourt_top=$((RANDOM % 8 + 20))
Anambara_top=$((RANDOM % 8 + 20))
Kaduna_top=$((RANDOM % 8 + 20))
Ibadan_top=$((RANDOM % 8 + 20))

#Low Temperatures varrying between 16 - 21oC
Lagos_low=$((RANDOM % 7 + 15))
Abuja_low=$((RANDOM % 7 + 15))
PortHacourt_low=$((RANDOM % 7 + 15))
Anambara_low=$((RANDOM % 7 + 15))
Kaduna_low=$((RANDOM % 7 + 15))
Ibadan_low=$((RANDOM % 7 + 15))

#Nig Temperatures (average)
total_top_temp=$((Lagos_top + Abuja_top + PortHacourt_top + Anambara_top + Kaduna_top + Ibadan_top))
total_low_temp=$((Lagos_low + Abuja_low + PortHacourt_low + Anambara_low + Kaduna_low + Ibadan_low))
Nig_top_temp=$((total_top_temp / 6))
Nig_low_temp=$((total_low_temp / 6))

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
mkdir -p "/var/www/html/weather_data"
mkdir -p "/var/www/html/weather_data/$file_directory"

# Create a filename based on the current date and time
weather_forecast="/var/www/html/weather_data/$file_directory/$(date +'%d_%m_%Y_%H_%M')_weather_forecast.txt"

# Send the output of all the recorded weather forcast to the file for data keeping.
cat <<EOL > "$weather_forecast"
As at $time on $day, $date_month.
These were the recorded Weather forecast for the following cities in Nigeria.
For Lagos the High Temperature was $Lagos_top oC and the Low Temperature was $Lagos_low oC.
For Abuja the High Temperature was $Abuja_top oC and the Low Temperature was $Abuja_low oC.
For PortHacourt the High Temperature was $PortHacourt_top oC and the Low Temperature was $PortHacourt_low oC.
For Anambara the High Temperature was $Anambara_top oC and the Low Temperature was $Anambara_low oC.
For Kaduna the High Temperature was $Kaduna_top oC and the Low Temperature was $Kaduna_low oC.
For Ibadan the High Temperature was $Ibadan_top oC and the Low Temperature was $Ibadan_low oC.
EOL

# Updating the weather forecast website when the values .
sed -i "69s|<div changesclass=\"day\">.*|<div class=\"day\">$day</div>|" /var/www/html/index.html
sed -i "70s|<div class=\"date\">.*|<div class=\"date\">$date_month</div>|" /var/www/html/index.html
sed -i "75s|<div class=\"num\">.*|<div class=\"num\">$Nig_top_temp<sup>o</sup>C</div>|" /var/www/html/index.html

sed -i "80s|<span><img src=\"images/icon-umberella.png\" alt=\"\">.*|<span><img src=\"images/icon-umberella.png\" alt=\"\">$Nig_low_temp%</span>|" /var/www/html/index.html
sed -i "81s|<span><img src=\"images/icon-wind.png\" alt=\"\">.*|<span><img src=\"images/icon-wind.png\" alt=\"\">$speed km/h</span>|" /var/www/html/index.html
sed -i "82s|<span><img src=\"images/icon-compass.png\" alt=\"\">.*|<span><img src=\"images/icon-compass.png\" alt=\"\">$direction</span>|" /var/www/html/index.html

sed -i "93s|<div class=\"degree\">.*|<div class=\"degree\">$Lagos_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "94s|<small>.*|<small>$Lagos_low<sup>o</sup></small>|" /var/www/html/index.html
sed -i "105s|<div class=\"degree\">.*|<div class=\"degree\">$Abuja_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "106s|<small>.*|<small>$Abuja_low<sup>o</sup></small>|" /var/www/html/index.html
sed -i "117s|<div class=\"degree\">.*|<div class=\"degree\">$PortHacourt_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "118s|<small>.*|<small>$PortHacourt_low<sup>o</sup></small>|" /var/www/html/index.html
sed -i "129s|<div class=\"degree\">.*|<div class=\"degree\">$Anambara_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "130s|<small>.*|<small>$Anambara_low<sup>o</sup></small>|" /var/www/html/index.html
sed -i "141s|<div class=\"degree\">.*|<div class=\"degree\">$Kaduna_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "142s|<small>.*|<small>$Kaduna_low<sup>o</sup></small>|" /var/www/html/index.html
sed -i "153s|<div class=\"degree\">.*|<div class=\"degree\">$Ibadan_top<sup>o</sup>C</div>|" /var/www/html/index.html
sed -i "154s|<small>.*|<small>$Ibadan_low<sup>o</sup></small>|" /var/www/html/index.html

sed -i "169s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" /var/www/html/index.html
sed -i "176s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" /var/www/html/index.html
sed -i "183s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" /var/www/html/index.html
sed -i "190s|<small class=\"date\">.*|<small class=\"date\">$date_month, $time$ampm</small>|" /var/www/html/index.html

sed -i "202s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" /var/www/html/index.html
sed -i "209s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" /var/www/html/index.html
sed -i "216s|<div class=\"date\">.*|<div class=\"date\">$time</div>|" /var/www/html/index.html


