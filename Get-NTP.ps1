function Get-NtpTime {
    param (
        [Parameter(Mandatory=$true)]
        [string]$NtpServer
    )

    # Create a UDP client
    $ntpData = New-Object byte[] 48
    $ntpData[0] = 0x1B  # NTP client request header

    $ntpServerEndpoint = New-Object System.Net.IPEndPoint ([System.Net.Dns]::GetHostAddresses($NtpServer)[0], 123)
    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Client.ReceiveTimeout = 3000  # milliseconds

    try {
        $udpClient.Send($ntpData, $ntpData.Length, $ntpServerEndpoint) | Out-Null
        $remoteIp = $null
        $response = $udpClient.Receive([ref]$remoteIp)

        # Extract the integer and fractional part of the timestamp (starting at byte 40)
        $intPart = [BitConverter]::ToUInt32($response[43..40], 0)
        $fracPart = [BitConverter]::ToUInt32($response[47..44], 0)

        # Convert to milliseconds
        $ntpEpoch = (Get-Date "1900-01-01T00:00:00Z")
        $milliseconds = $intPart * 1000 + ($fracPart * 1000 / 0x100000000)
        $dateTime = $ntpEpoch.AddMilliseconds($milliseconds)

        return $dateTime.ToLocalTime()
    }
    catch {
        Write-Warning "Failed to query $NtpServer: $_"
        return $null
    }
    finally {
        $udpClient.Close()
    }
}
