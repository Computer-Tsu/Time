function Test-NtpServer {
    param (
        [Parameter(Mandatory = $true)]
        [string]$NtpServer
    )

    Write-Host "`n⏱️ Querying NTP server: $NtpServer (UDP 123)...`n"

    $ntpData = New-Object byte[] 48
    $ntpData[0] = 0x1B  # LI = 0, VN = 3, Mode = 3 (client)

    $localSystemTime = [DateTime]::UtcNow
    Write-Host "📅 Local System Time (UTC): $($localSystemTime.ToString("u"))"

    try {
        $ip = [System.Net.Dns]::GetHostAddresses($NtpServer)[0]
    } catch {
        Write-Warning "❌ Host not resolvable: $NtpServer"
        return
    }

    $remoteEP = New-Object System.Net.IPEndPoint($ip, 123)
    $udp = New-Object System.Net.Sockets.UdpClient
    $udp.Client.ReceiveTimeout = 3000

    $sendTime = [DateTime]::UtcNow
    try {
        [void]$udp.Send($ntpData, $ntpData.Length, $remoteEP)
    } catch {
        Write-Warning "❌ Failed to send UDP packet (firewall or unreachable network)."
        return
    }

    try {
        $remoteRef = $null
        $recvData = $udp.Receive([ref]$remoteRef)
        $recvTime = [DateTime]::UtcNow
    } catch {
        Write-Warning "❌ No response received (timeout or UDP 123 blocked)."
        return
    } finally {
        $udp.Close()
    }

    Write-Host "`n✅ Response received from $($remoteRef.Address):"
    Write-Host "🔹 Raw Response (Hex Dump):"
    ($recvData | ForEach-Object { "{0:X2}" -f $_ }) -join ' ' | Write-Host

    function Convert-NtpTime ($bytes) {
        $int = [BitConverter]::ToUInt32($bytes[0..3], 0)
        $frac = [BitConverter]::ToUInt32($bytes[4..7], 0)
        $ms = $int * 1000 + ($frac * 1000 / 0x100000000)
        (Get-Date "1900-01-01Z").AddMilliseconds($ms)
    }

    # Extract key fields
    $stratum    = $recvData[1]
    $refTime    = Convert-NtpTime $recvData[16..23]
    $originate  = Convert-NtpTime $recvData[24..31]
    $receive    = Convert-NtpTime $recvData[32..39]
    $transmit   = Convert-NtpTime $recvData[40..47]

    # Offset and delay calculation
    $roundTrip = ($recvTime - $sendTime) - ($transmit - $receive)
    $offset = (($receive - $sendTime) + ($transmit - $recvTime)) / 2

    # Output as object
    [PSCustomObject]@{
        Server              = $NtpServer
        IPAddress           = $ip.IPAddressToString
        Stratum             = $stratum
        NtpTime_UTC         = $transmit.ToString("u")
        LocalTime_UTC       = $recvTime.ToString("u")
        LocalSystemTime_UTC = $localSystemTime.ToString("u")
        Offset_vs_Local_ms  = "{0:N2}" -f $offset.TotalMilliseconds
        RoundTrip_ms        = "{0:N2}" -f $roundTrip.TotalMilliseconds
        RawBytes_Hex        = ($recvData | ForEach-Object { "{0:X2}" -f $_ }) -join ' '
    }
}
