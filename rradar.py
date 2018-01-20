#! /usr/bin/python3

from selenium import webdriver
from bands import *

url = 'https://www.metal-archives.com/release/upcoming'

browser = webdriver.Chrome('/usr/lib/chromium-browser/chromedriver')
browser.get(url)
upcoming = browser.find_elements_by_css_selector('td:first-child>a')

for i in range(len(upcoming)):
   	if upcoming[i].text in bands:
   		print(upcoming[i].text)
