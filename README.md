# release-radar

This web crawler gathers all new albums for a known user with Spotify Web API and parses them into a well formatted, XSL styled ATOM feed.

### Warning
Bring your own `client_id` and  `client_secret`. Follow this [guide](https://developer.spotify.com/documentation/general/guides/authorization-guide/).

### Usage
	python3 rradar.py [USER] > spotify.xml

### Example
https://copype.ga/spotify.xml