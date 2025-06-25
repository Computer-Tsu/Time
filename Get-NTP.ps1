function Get-NtpTime {
    param (
        [Parameter(Mandatory=$true)]
        [string]$NtpServer
    )

    $ntpData = New-Object byte[] 48
    $ntpData[0] = 0x1B  # LI = 0, VN = 3, Mode = 3 (client)

    $ntpEpoch = Get-Date -Date "1900-01-01T00:00:00Z" -AsUTC
    $localSendTime = [DateTime]::UtcNow

    $serverIp = [System.Net.Dns]::GetHostAddresses($NtpServer)[0]
    $endPoint = New-Object System.Net.IPEndPoint($serverIp, 123)
    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Client.ReceiveTimeout = 3000

    try {
        $udpClient.Send($ntpData, $ntpData.Length, $endPoint) | Out-Null
        $remoteIp = $null
        $recvBytes = $udpClient.Receive([ref]$remoteIp)
        $localRecvTime = [DateTime]::UtcNow

        # Helper: Convert 4 bytes to UInt32 and then to seconds
        function Get-NtpSeconds ($bytes) {
            [BitConverter]::ToUInt32($bytes, 0)
        }

        # Helper: Convert 64-bit NTP timestamp to DateTime
        function Convert-NtpTimestamp ($bytes) {
            $intPart = [BitConverter]::ToUInt32($bytes[0..3], 0)
            $fracPart = [BitConverter]::ToUInt32($bytes[4..7], 0)
            $ms = $intPart * 1000 + ($fracPart * 1000 / 0x100000000)
            $ntpEpoch.AddMilliseconds($ms)
        }

        $stratum = $recvBytes[1]
        $rootDelay = [BitConverter]::ToUInt32($recvBytes[4..7], 0) / 65536
        $rootDispersion = [BitConverter]::ToUInt32($recvBytes[8..11], 0) / 65536

        $refTime = Convert-NtpTimestamp $recvBytes[16..23]
        $origTime = Convert-NtpTimestamp $recvBytes[24..31]
        $recvTime = Convert-NtpTimestamp $recvBytes[32..39]
        $xmitTime = Convert-NtpTimestamp $recvBytes[40..47]

        # Round trip delay (d) and local clock offset (t)
        $delay = ($localRecvTime - $localSendTime) - ($xmitTime - $recvTime)
        $offset = ( ($recvTime - $localSendTime) + ($xmitTime - $localRecvTime) ) / 2

        [PSCustomObject]@{
            Server             = $NtpServer
            IPAddress          = $serverIp.IPAddressToString
            Stratum            = $stratum
            RootDelay_ms       = "{0:N2}" -f ($rootDelay * 1000)
            RootDispersion_ms  = "{0:N2}" -f ($rootDispersion * 1000)
            NtpTime_UTC        = $xmitTime
            LocalTime_UTC      = $localRecvTime
            Offset_ms          = "{0:N2}" -f $offset.TotalMilliseconds
            RoundTrip_ms       = "{0:N2}" -f $delay.TotalMilliseconds
        }
    }
    catch {
        Write-Warning "Failed to query $NtpServer: $_"
        return $null
    }
    finally {
        $udpClient.Close()
    }
}
