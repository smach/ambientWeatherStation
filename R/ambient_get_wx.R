#' Get data from an Ambient weather station
#'
#' @param n numeric Integer for how many observations you want returned. Defaults to 1.
#' @param device_mac_address character string for device MAC address.
#' @param app_key character string with your Ambient application key.
#' @param api_key character string with your Ambient API key.
#' @param time_zone character string of a TZ database name, such as America/New_York. Defaults to your system's time zone.
#' @param the_date Date or character string in yyyy-mm-dd format if you want historical data. Defaults to empty string for most recent data.
#'
#' @return data frame
#' @export
#'
#' @examples
#' \dontrun{
#' ambient_get_wx(6) #for most recent 6 observations
#' }
ambient_get_wx <- function(n=1, device_mac_address = Sys.getenv("AMBIENT_MAC_ADDRESS"), app_key = Sys.getenv("AMBIENT_APP_KEY"), api_key = Sys.getenv("AMBIENT_API_KEY"), time_zone = Sys.timezone(), the_date = ""){
  if(nchar(device_mac_address) < 2) {
    warning("You need your weather station's MAC address to use this package. See the Setup vignette for more details.")
  } else if(nchar(app_key) < 2){
    warning("You need an Ambient app key to use this package. See the Setup vignette for more details.")
  } else if (nchar(api_key) < 2) {
    warning("You need an Ambient API key to use this package. See the Setup vignette for more details.")
  }  else {
    if(the_date == ""){
      url <- paste0("https://api.ambientweather.net/v1/devices/", device_mac_address, "?apiKey=", api_key, "&applicationKey=", app_key, "&limit=",n)
    } else {
    url <- paste0("https://api.ambientweather.net/v1/devices/", device_mac_address, "?apiKey=", api_key, "&applicationKey=", app_key, "&limit=",n, "&endDate=", the_date)
    }

    resp <- httr::GET(url)
    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }

    parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"), simplifyVector = TRUE)
    parsed$dateutc <- lubridate::as_datetime(parsed$dateutc / 1000, tz = time_zone)
    names(parsed)[1] <- "datelocal"
    names(parsed)[names(parsed) == "date"] <- "dateutc"
    return(parsed)
  }

}


