# SmartberryWidget
Garmin connectiq widget for Domoticz
Used to call Domoticz url to control Switches (/json.htm?type=command&param=switchlight&idx=[my_id]&switchcmd=[On|Off])

Configuration needed in SmartberryWidget\resources\properties.xml : 
* Server url : your Domoticz server url (with scheme and port)
* Authorization header : your basic auth credentials (base64)
* Devices list : semi-colon separated values for the actions to be displayed in widget (Label / domoticz idx / switchcmd On or Off)

Configuration is available in Garmin preferences once you have it published on the Garmin ConnectIQ store

