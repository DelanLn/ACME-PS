function Export-AcmeObject {
    param(
        [Parameter(Mandatory=$true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter(Mandatory=$true, ValueFromPipeline = $true)]
        [ValidateNotNull()]
        $InputObject,

        [Parameter()]
        [switch]
        $Force
    )

    process {
        $ErrorActionPreference = 'Stop'

        if((Test-Path $Path) -and -not $Force) {
            throw "$Path already exists."
        }

        Write-Debug "Exporting $($InputObject.GetType()) to $Path"
        if($Path -like "*.json") {
            Write-Verbose "Exporting object to JSON file $Path"
            $InputObject | ConvertTo-Json | Out-File -FilePath $Path -Encoding utf8 -Force:$Force;
        } else {
            Write-Verbose "Exporting object to CLIXML file $Path"
            Export-Clixml $Path -InputObject $InputObject -Force:$Force;
        }
    }
}
