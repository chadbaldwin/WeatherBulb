$configParams = Get-Content .\Integrations_Config.ps1 | ConvertFrom-Json

function Send-WeatherCommand {
	param([string]$path, [string[]]$parameters)

	$auth = 'apikey='+$configParams.AccuWeatherApi.APIKey
	[string]$uri = $configParams.AccuWeatherAPI.BaseURL + '/' + $path + '?' + $auth
	If ($parameters) { $uri += '&'+$parameters -join '&' }

	$response = Invoke-RestMethod -Uri $uri

	return $response
}

function Get-WeatherByLocationID {
	param([int]$locationID)

	$forecastUri = "forecasts/v1/hourly/12hour/$locationID"

	$response = Send-WeatherCommand -path $forecastUri
	
	return $response
}

function Get-WeatherLocationIDByName {
	param([string]$searchString)
	
	$locationUri = "locations/v1/cities/search"

	$query = 'q='+[System.Web.HttpUtility]::UrlEncode($searchString)

	$response = Send-WeatherCommand -path $locationUri -parameters $query

	return $response.Key
}
