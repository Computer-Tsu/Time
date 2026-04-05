# Acceptable Tolerances

Windows Active Directory, AD (kerberos) ±5 min<br>
SSL/TLS/HTTPS Certificate validity window is checked. Browsers check the certificate's "Not Before" and "Not After" timestamps against your system clock (converted to UTC). example `ERR_CERT_DATE_INVALID`

## Radio

e.g. digital modes (WSJT-X)<br>
FT4 & FT8 +/- 1-2 sec<br> *(add detail)*
JT65 1-2<br>
JS8Call +/- 5 sec<br>
PSK31 N/A<br>
RTTY N/A<br>

Mode  | Tolerance
----- | -----
FT8   | 
FT4   | 
JT65  | 


### OS Corrective Behavior

When Windows detects a time update of greater than _, it will _

Registry Keys: `MaxPosPhaseCorrection` and `MaxNegPhaseCorrection` <br>
And `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`

≤ MaxAllowedPhaseOffset (default ~54,000s/15hrs for clients)<br>
Gradual adjustment via clock rate slewing

\> MaxAllowedPhaseOffset but ≤ 48hrs (DCs) or unlimited (clients)<br>
Logs event, may step clock or reject sample

Huge offsets (>48hrs on DCs)<br>
Rejects sample, requires manual config to accept

Sources:
 - https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/configure-w32ime-against-huge-time-offset
 - https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings
