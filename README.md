# ambientWeatherStation
## Import Data From Your Ambient Weather Station Into R

This package lets you import current or historical data from an Internet-enabled Ambient Weather station into R. It requires:

* An Internet-enabled Ambient Weather Station
* The MAC address for that weather station
* An API key from Ambient Weather
* An application key from Ambient Weather

To install the package, you can use any R package that allows easy installation via GitHub, such as devtools, remotes, or githubinstall. If using devtools, run

`devtools::install_github("smach/ambientWeatherStation", build_vignettes = TRUE)`

You can get Ambient application and API keys from the [settings page in your AmbientWeather.net account](https://dashboard.ambientweather.net/account).

You may have already located your station's MAC address in order to connect it to the Internet. If not, AmbientWeather.net has instructions for various models. For example, [here are the instructions for the WS-1000 serues](https://ambientweather.net/help/how-do-i-find-my-mac-address-ws-1000-series/).

### Using your MAC address and keys

The `ambient_get_wx()` function needs your MAC address, app key, and API key each time it's called. You can input them all manually as arguments every time. However, an easier way is to store them all in your R environment. The usethis package and RStudio make this easy. Run `edit_r_environ()` and then add the following lines to your .Renviron file:

```
AMBIENT_MAC_ADDRESS="your device's MAC address"
AMBIENT_APP_KEY="your application key"
AMBIENT_API_KEY="your API key"
```

Save the .Renviron file. You will need to restart your R session for those new values to be available. 

You should now be ready to run `ambient_get_wx()`!
