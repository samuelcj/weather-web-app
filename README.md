# weather-web-app
A weather forecast website that gets updated in real time. This is powered by a shell script and cron job

The Bash script generates a weather forecast for six cities in Nigeria, computes averages, and updates a weather forecast website. The script also logs the data in a structured directory for archival purposes.

## Features

1. **Random Temperature Generation**
   - High temperatures (21°C - 27°C) and low temperatures (16°C - 21°C) are generated for the following cities:
     - Lagos
     - Abuja
     - Port Harcourt
     - Anambra
     - Kaduna
     - Ibadan

2. **Average Temperature Calculation**
   - Computes the national average for high and low temperatures.

3. **Wind Speed and Direction**
   - Random wind speed (15-22 km/h) and direction (East, West, North, South).

4. **Date and Time Handling**
   - Retrieves current date and time for forecast generation and directory/file naming.

5. **File Management**
   - Organizes weather data in time-stamped directories.
   - Saves forecasts in text files with detailed weather information.

6. **Website Update**
   - Updates an HTML weather forecast webpage with:
     - Current date and time.
     - Latest forecast data for each city.
     - National average temperatures.
     - Wind speed and direction.

## Prerequisites

Ensure the following requirements are met before running the script:

- Linux environment with Bash installed.
- Write permissions for `/var/www/html/`.
- `sed` command-line tool for editing HTML files.
- Existing HTML template for weather forecast at `/var/www/html/index.html`.

## Usage

1. Clone this repository or copy the script to your desired location.
2. Make the script executable:
   ```bash
   chmod +x weather_forecast.sh
   ```
3. Run the script:
   ```bash
   ./weather_forecast.sh
   ```
4. Verify the following:
   - Weather forecast text files are saved in `/var/www/html/weather_data`.
   - HTML forecast page (`/var/www/html/index.html`) is updated with the latest data.

## Output

### Example Text File Output

```
As at 14:30 on Wednesday, 11 December.
These were the recorded Weather forecast for the following cities in Nigeria.
For Lagos the High Temperature was 25°C and the Low Temperature was 18°C.
For Abuja the High Temperature was 26°C and the Low Temperature was 20°C.
...
```

### Example Website Update

- Updated day, date, and time.
- Updated high and low temperatures for all cities.
- Updated national averages, wind speed, and direction.

## File Structure

```
/var/www/html/weather_data/
├── <date_time>_weather_forecast.txt  # Weather forecast files
/var/www/html/index.html               # Updated HTML weather page
```

## Customization

- Modify temperature ranges or city names directly in the script.
- Adjust file paths if your server directory structure differs.

## Disclaimer

This script simulates weather data and is not connected to real-time weather APIs. For actual weather updates, consider integrating APIs like OpenWeatherMap.
