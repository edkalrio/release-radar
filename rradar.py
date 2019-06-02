#!/usr/bin env python3

from pprint import pprint
import sys
import datetime

import spotipy
import spotipy.util as util
from spotipy.oauth2 import SpotifyClientCredentials

import json

client_id = ''
client_secret = ''
redirect_uri = 'http://localhost/'

now = datetime.datetime.utcnow().isoformat() + "Z"
year = str(datetime.date.today().year)

if len(sys.argv) > 1:
    username = sys.argv[1]
else:
    print("Usage: %s username" % (sys.argv[0],))
    sys.exit()

scope = 'user-follow-read'
token = util.prompt_for_user_token(username, scope, client_id=client_id, 
                                    client_secret=client_secret, 
                                    redirect_uri=redirect_uri)

# print(token)
if token:
    bands = []
    sp = spotipy.Spotify(auth=token)
    sp.trace = False
    results = sp.current_user_followed_artists()
    bands.extend(results['artists']['items'])
    
    while results['artists']['next']:
        results = sp.next(results['artists'])
        bands.extend(results['artists']['items'])

    print(f"""<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="spotify.xsl"?>
<feed xmlns="http://www.w3.org/2005/Atom">

    <title>Spotify</title>
    <link rel="self" href="https://copype.ga/spotify.xml/"/>
    <link rel="next" href="https://copype.ga/MY2017.xml/"/>
    <updated>{now}</updated>
    <id>https://copype.ga/spotify.xml/</id>""")

    for i, item in enumerate(bands):
        albums = []
        results = sp.artist_albums(item['id'], album_type='album')
        albums.extend(results['items'])
        while results['next']:
            results = sp.next(results)
            albums.extend(results['items'])
        seen = set() # to avoid dups
        albums.sort(key=lambda album: album['name'].lower())

        for album in albums:
            name = album['name']
            if name not in seen:
                seen.add(name)
                album_result = sp.album(album['id'])
                if year in album_result['release_date']:                  
                    print(f"""
    <entry>
        <id>{album['uri']}</id>
        <author>
            <name><![CDATA[{item['name']}]]></name>
            <uri>{item['external_urls']['spotify']}</uri>
        </author>
        <updated>{album_result['release_date']}T00:00:00Z</updated>
        <title><![CDATA[{album['name']}]]></title>
        <link rel="alternate" href="{album['external_urls']['spotify']}"/>
        <content type="html"><![CDATA[<img src="{album['images'][0]['url']}">]]></content>
    </entry>""")
    print("</feed>")                
else:
    print("Can't get token for", username)
