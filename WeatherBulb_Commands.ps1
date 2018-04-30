function Get-HotWeatherColor {
	param([int]$temp)

	[string]$color = ''

	$hotTempLo = 80
	If ($temp -ge $hotTempLo) {
		$hotTempHi = 100
		$hotHueHi = 0
		$hotHueLo = 50
		$hotHueScaleFactor = 1.1

		$hotHueDiff = $hotHueLo - $hotHueHi
		$powTemp = [math]::Pow($hotHueScaleFactor, $temp - $hotTempLo)
		$powMax = [math]::Pow($hotHueScaleFactor, ($hotTempHi - $hotTempLo))
		$hotHueCalc = $hotHueDiff - [math]::Round($hotHueDiff*($powTemp/$powMax),0)

		$color = "hue:$hotHueCalc"
	} Else {
		$color = 'kelvin:2500'
	}
	
	return $color
}
