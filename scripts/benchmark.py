#!/usr/bin/env python

"""This script runs a series of tests using selenium and Chrome, both
on mobile and desktop.


To run it on desktop devices, you need to download Selenium's
ChromeDriver and put it somewhere in your PATH.

To run it in an android device, you need to:

Download Android SDK
export ANDROID_HOME=~/Android/Sdk
export PATH=~/Android/Sdk/platform-tools:$PATH
export JAVA_HOME=/usr/lib/jvm/default-java

Download Chromedriver
export CHROMEDRIVER_PATH=[choose your chromedriver path]

Enable USB debugging in your phone, plug it via USB and make sure  adb devices shows it
Change network settings if you want (eg. 3g, 4g, 2g)
npm install appium; appium
Disable screen lock on device
Run this script
"""
import sys
import os
import numpy as np
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

def load_page(browser, url, times):
    """Load a page multiple times and show the load time gathered via the Navigation timing API"""
    # let the browser adjust after initial load.
    browser.get('http://example.com')
    load_times = []
    for idx in range(times):
        browser.get(url)
        load_time = browser.execute_script('''return new Date().getTime() - performance.timing.connectStart''')
        print('{}/{}: {}'.format(idx, times, load_time))
        load_times.append(load_time)

        print('  Median load time for {}: {:.2f}'.format(url, np.percentile(load_times, 50)))
        print('  95th percentile for {}: {:.2f}'.format(url, np.percentile(load_times, 95)))
        print('  99th percentile for {}: {:.2f}'.format(url, np.percentile(load_times, 99)))

if __name__ == '__main__':
    USAGE = 'Usage: {} <mobile|desktop> <ntimes>'.format(sys.argv[0])
    if len(sys.argv) != 3:
        sys.exit(USAGE)
    if not sys.argv[2].isdigit():
        sys.exit(USAGE)
    ntimes = int(sys.argv[2])
    if sys.argv[1] == 'mobile':
        browser = webdriver.Remote(
            command_executor='http://localhost:4723/wd/hub',
            desired_capabilities={
                "platformName":"Android",
                "browserName":"Chrome",
                "javascriptEnabled":True,
                "chromeOptions":{"args":["--disable-translate"]},
                "version":"",
                "deviceName":""
            }
        )
    elif sys.argv[1] == 'desktop':
        browser = webdriver.Chrome(os.environ.get('CHROMEDRIVER_PATH'))
        browser.maximize_window()
    else:
        sys.exit(USAGE)

    load_page(browser, 'https://giuseppeciotta.net/h2mosaic/', ntimes)
    load_page(browser, 'http://h1.giuseppeciotta.net/h2mosaic/', ntimes)
    browser.quit()
