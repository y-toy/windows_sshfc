# windows_sshfc
A simple powershell script to list the hosts in .ssh /config file. You are also able to ssh to select the number of the list shown.

## install
```
New-Item ($HOME + "\bin") -ItemType Directory
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";%USERPROFILE%\bin", "User")

git clone https://github.com/y-toy/windows_sshfc.git
cd windows_sshfc
Move-Item ./sshfc.ps1 ($HOME + "\bin")
```

## How to use

command: sshfc [Part of the host name]

## Note
Try running the following command if you are unable to run the script. This will loosen the restrictions of the script execution.
```
Set-ExecutionPolicy Unrestricted -scope CurrentUser
```
If you don't want to loosen your windows security with above command, try to open, edit (like adding blank line) and close (re-write) the sshfc.ps1. 
