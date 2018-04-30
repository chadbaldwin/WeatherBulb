$configParams = Get-Content .\Integrations_Config.ps1 | ConvertFrom-Json

function Send-LifxCommand {
	param([string]$path, [string]$method, [string]$data)

	[uri]$uri = $configParams.LIFXAPI.BaseURL + '/' + $path
	$auth = $configParams.LIFXAPI.APIKey
	
	If ($method -eq 'GET') {
		$response = Invoke-RestMethod -Uri $uri -Method $method -Headers @{Authorization="Bearer $auth"}
	} ElseIf ($method -eq 'PUT') {
		$response = Invoke-RestMethod -Uri $uri -Method $method -Headers @{Authorization="Bearer $auth"} -Body $data
	}
	
	return $response
}

function Set-LifxState {
	param([string]$selector, [string]$power, [string]$color, [int]$brightness, [int]$duration)

	$lightCmd = @{}

	If ($power)      { $lightCmd += @{power      = $power}      }
	If ($color)      { $lightCmd += @{color      = $color}      }
	If ($brightness) { $lightCmd += @{brightness = $brightness} }
	If ($duration)   { $lightCmd += @{duration   = $duration}   }

	$lightCmd = $lightCmd | ConvertTo-Json

	$response = Send-LifxCommand -path "$selector/state" -method 'PUT' -data $lightCmd
	
	return $response
}

function Get-LifxBulbIDByName {
	param([string]$name)
	
	$response = Send-LifxCommand -method 'GET'
	
	$targetBulb = $response | ? label -eq $name
	
	return $targetBulb.Id
}
