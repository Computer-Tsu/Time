# Time
PC Computer Time

Information about time sources

Creating a Date timestamp environmental variable for file names and logs.<br>
Windows: `SET DateString=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%`

NTP

Time conversions
 - unix epoch
 - seconds / milliseconds




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
Every day has two midnights and midnight is between two days and doesn't belong to either. So the correct description is 'the midnight between Monday and Tuesday', or 'the 25th - 26th midnight' alternatively use 23:59:59 or 0:00:01 instead.

-----

Show the time on prompt (Windows/DOS)
https://gist.github.com/Computer-Tsu/e4d673bf61573b8d6ea1bc50a71003cd

-----

EST = UTC -5, EDT = UTC -4<br>
CST = UTC -6, CDT = UTC -5<br>
MST = UTC -7, MDT = UTC -6<br>
PST = UTC -8, PDT = UTC -7<br>

New Windows installs default to Pacific time.<br>
New Apple Mac default to Cupertino Washington, Pacific time.<br>
You can add a second clock to Windows system tray and it can be Universal Coordinated Time.<br>
When an app or OS (Google Android) doesn't provide UTC or GMT as a choice, choose Reykjavik for UTC.<br>

Very Old devices may use different daylight savings effective date range due to changes in 1986 and 2005.
