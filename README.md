# Time
PC Computer Time

Information about time sources

Creating a Date timestamp environmental variable for file names and logs.<br>
Windows: `SET DateString=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%`

NTP
(https://en.wikipedia.org/wiki/Network_Time_Protocol)

ISO-8601 Standards use YYYY-MM-DD ...

Time conversions
 - unix epoch
 - seconds / milliseconds


```
Function Get-EpochDate ($epochDate) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($epochDate)) }
```

The Unix `time_t` data type that represents a point in time is, on many platforms, a [signed integer](https://en.wikipedia.org/wiki/Integer_%28computer_science%29 "Integer (computer science)"), traditionally of 32 [bits](https://en.wikipedia.org/wiki/Bit "Bit") (but [see below](https://en.wikipedia.org/wiki/Unix_time#Range_of_representable_times)), directly encoding the Unix time number as described in the preceding section. A signed 32-bit value covers about 68 years before and after the 1970-01-01 epoch. The minimum representable date is Friday 1901-12-13, and the maximum representable date is Tuesday 2038-01-19. One second after 2038-01-19T03:14:07Z this representation will [overflow](https://en.wikipedia.org/wiki/Arithmetic_overflow "Arithmetic overflow") in what is known as the [year 2038 problem](https://en.wikipedia.org/wiki/Year_2038_problem "Year 2038 problem").<br>Source: (https://en.wikipedia.org/wiki/Unix_time)
<br>

Seconds | Minutes
------- | -------
120     | 2
300     | 5
600     | 10
900     | 15
1200    | 20
1800    | 30
3600    | 60 (1 hr)
28,800  | 480 (8 hr)
43,200  | 720 (12 hr)
86,400  | 1440 (24 hr)

999 Seconds = 16.65 Minutes<br>
999 Minutes = 16.65 Hours<br>
604,800 Seconds = 10,080 Minutes =  168 Hours = 1 Week<br>
<br>
9999 sec = 2 hr 46 min 39 sec
-----

https://time.gov

Fix the abbreviation when writing the time, EST (Eastern Standard Time, Central, Mountain, Pacific Standard Time) should not be used during Daylight Savings Time, instead use EDT or ET (or CDT, MDT, PDT).

DST Ends in November.

### At present, daylight saving time in the United States

 - begins at 2:00 a.m. on the second Sunday of March (at 2 a.m. the local time time skips ahead to 3 a.m. so there is one less hour in the day)

 - ends at 2:00 a.m. on the first Sunday of November (at 2 a.m. the local time becomes 1 a.m. and that hour is repeated, so there is an extra hour in the day)​

### Non-US terms

International users frequently use summer time and winter time as equivilant to US daylight time.

-----

0:00 is midnight (or 12:00 A.M.)<br>
12:00 is noon (or 12:00 P.M.)<br>

Every day has two midnights and midnight is between two days and doesn't belong to either. So the correct description is 'the midnight between Monday and Tuesday', or 'the 25th - 26th midnight' alternatively use 23:59:59 or 0:00:01 instead.<br>
Leap seconds are added as 24:00:00

(https://en.wikipedia.org/wiki/Midnight)

-----

Show the time on prompt (Windows/DOS)
https://gist.github.com/Computer-Tsu/e4d673bf61573b8d6ea1bc50a71003cd

-----

EST = UTC -5, EDT = UTC -4<br>
CST = UTC -6, CDT = UTC -5<br>
MST = UTC -7, MDT = UTC -6<br>
PST = UTC -8, PDT = UTC -7<br>
Alaska AKST = UTC -9, AKDT = UTC -8<br>
(The western [Aleutian Islands](https://en.wikipedia.org/wiki/Aleutian_Islands "Aleutian Islands") (HAST) observe [Hawaii–Aleutian Time](https://en.wikipedia.org/wiki/Hawaii%E2%80%93Aleutian_Time_Zone "Hawaii–Aleutian Time Zone"), one hour behind the remainder of the state.)
Hawaii HST UTC -10 (HST or HAST, no daylight saving time change)

TZ | Offset
 ------- | -------
EDT      | UTC-04:00
EST, CDT | UTC-05:00
CST, MDT | UTC-06:00
MST, PDT | UTC-07:00
PST      | UTC-08:00

New Windows installs default to Pacific time.<br>
New Apple Mac default to Cupertino Washington, Pacific time.<br>
You can add a second clock to Windows system tray and it can be Universal Coordinated Time.<br>
When an app or OS (Google Android) doesn't provide UTC or GMT as a choice, choose Reykjavik for UTC.<br>

Very Old devices may use different daylight savings effective date range due to changes in 1986 and 2005.

-----

Sources:
1. (https://en.wikipedia.org/wiki/System_time)
2. (https://en.wikipedia.org/wiki/Unix_time)
3. (https://en.wikipedia.org/wiki/Epoch_(computing))


Leap year

Feb 29th occurs each year that if the year is evenly divisible by 4 except years ending 00. But keep the leap day when year is evenly divisible by 400. <br>
This Gregorian calendar pattern of correction was credited to Aloysius "Luigi" Lilius and pushed by Pope Greg 1582.
