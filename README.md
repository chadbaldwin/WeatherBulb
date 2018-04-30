# WeatherBulb
Display weather info using a LIFX Color bulb using Powershell

Originally created for myself since I commute on motorcycle, it's nice to know as soon as I wake up if I should expect rain, cold or hot weather.

Work in progress. Learning Powershell as I go.

Basically it works like this:
Pulls weather forecast data for the next 12 hours (by the hour) using the AccuWeather API for a specific City.

Using AccuWeathers Icon descriptions, the 12 hours are grouped/filtered into 3 categories:
- Bad - Rain, Sleet, Snow, Ice, Hail
- Hot - >80F
- Cold - <50F

Bad weather shows the bulb as purple

Hot weather uses an exponential curve to set the color between yellow and red

Cold weather shows as blue

Nice (else case) shows as warm white

Future goals:
- Figure out a more fluid way to set the colors for hot/cold/nice weather
- Make the temp ranges configurable
- Add support for multiple cities
