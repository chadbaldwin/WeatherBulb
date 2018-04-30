################################################
# Includes
################################################
. .\Weather_Commands.ps1
. .\LIFX_Commands.ps1
. .\WeatherBulb_Commands.ps1
################################################

$locationName = 'Cerritos, CA'
$lifxBulbName = 'LC-1'

################################################

$locationID = Get-WeatherLocationIDByName -searchString $locationName
$lifxBulbID = Get-LifxBulbIDByName -name $lifxBulbName
$lifxBulbSelector = "id:$lifxBulbID"

$weatherData = Get-WeatherByLocationID -locationID $locationID

#Bad Weather
$hrBadWeather = $weatherData | ? {($_.WeatherIcon -ge 12 -and $_.WeatherIcon -le 29) -or ($_.WeatherIcon -ge 39 -and $_.WeatherIcon -le 44) -or $_.PrecipitationProbability -gt 50}
#Hot Weather
$hrHotWeather = $weatherData | ? {$_.WeatherIcon -eq 30 -or $_.Temperature.Value -gt 80}
#Cold Weather
$hrColdWeather = $weatherData | ? {$_.WeatherIcon -eq 31 -or $_.Temperature.Value -lt 50}

$hiTemp = $hours.Temperature.Value | sort -Descending | select -First 1
$loTemp = $hours.Temperature.Value | sort | select -First 1

[string]$color = ''

If ($hrBadWeather) {
	$color = 'purple'
} ElseIf ($hrHotWeather) {
	$color = Get-HotWeatherColor -temp $hiTemp
} ElseIf ($hrColdWeather) {
	$color = 'blue'
} Else {
	$color = 'kelvin:4000'
}

Set-LifxState -selector $lifxBulbSelector -power 'on' -color $color -brightness 100
