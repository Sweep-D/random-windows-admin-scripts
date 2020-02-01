#Update the userPhotos.csv File with the username of each photo. Upload the original photo as a jpg to E:\Intranet on edge-syd-01.

$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/?proxyMethod=RPS -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber -WarningAction SilentlyContinue -ErrorAction SilentlyContinue

#Get CSV store into variable.
$csvFile = "C:\tmp\usersPhotos.csv"

#import the contents of the csvfile into a variable
$table = get-content $csvFile

#This function will reset the permissions for each user in the csv file and then set the permissions to readonly.
function changeUserPhotos {
foreach ($line in $table)
    {
        Write-Host "Updating Picture for $line ..."
        $user1 = ([Byte[]] $(Get-Content -Path E:\Intranet\$line.jpg -Encoding Byte -ReadCount 0))
        set-userphoto -identity "$line" -picturedata $user1 -confirm:$false
    }
}

changeUserPhotos