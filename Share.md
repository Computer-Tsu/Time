# Sharing and Getting Time data

## NTP

 - time.windows.com
 - time.nist.gov (https://tf.nist.gov/tf-cgi/servers.cgi)
 - pool.ntp.org (https://www.ntppool.org/zone/@)
 - time.google.com
 - time.cloudflare.com
 - time.aws.com
 - Apple _


## SNTP

## Microsoft Windows

* w32tm.exe: Windows CLI tool for W32Time management (/resync, /config, /query)
* NTPsec
* Meinberg NTP

SET PROMPT=$T$h$h$h$s$P$G

SET DateString=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

```
echo %DATE%
echo %TIME%
```

w32tm /config /update /manualpeerlist:us.pool.ntp.org /syncfromflags:manual /reliable:yes
w32tm /query /computer:\\adc01 /status

To Do: third party NTP time apps
- Dimension 4
- _

Alternate secondary clock on Windows Taskbar for UTC (or other time zone)

Reference: cross reference https://github.com/Computer-Tsu/Windows-Files-and-Folders for more Windows time-related commands

### CLI

### AD

## DHCP options
42

## Hardware

### GPS

NMEA

PPS

