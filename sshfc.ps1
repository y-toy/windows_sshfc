using namespace Microsoft.VisualBasic

# paramater
Param($targetHost)
if(-not ([string]::IsNullOrEmpty($targetHost))){
	$targetHost = ([string]$targetHost).trim().ToLower()
}else{
	$targetHost = ""
}

# config file path
$configFile = $HOME + "\.ssh\config"
if( $(test-path $configFile) -ne $True ){
	echo "the .sshconfig file doesn't exist..."
	exit 1
}

# read the config file
$hostNames = @()
$lines = get-content $configFile
foreach($line in $lines){
	$command, $hostname = $line.trim() -split '\s+|\t+'
	# if ($command -eq "host" -Or $command -eq "hostname"){
	if ($command -eq "host"){
		if ($targetHost -eq ""){
			$hostNames += $hostname
		}else{
			if ($hostname.ToLower().Contains($targetHost)){
				$hostNames += $hostname
			}
		}
	}
}

$lenHostNames = $hostNames.Count
if ($lenHostNames -eq 0){
	if ($targetHost -eq ""){
		write-host("didn't find any hosts in the config file.")
	}else{
		write-host("didn't find any hosts including [" + $targetHost + "].")
	}
	exit 1
}

for ( $index = 0; $index -lt $lenHostNames; $index++){
	write-host ( ([string]($index+1)) + ") " + $hostNames[$index] )
}

$strInput = 'Press the number of the host to ssh. Press [c] if you want to cancel.'

Add-Type -AssemblyName "Microsoft.VisualBasic"

# loop until valid data comming or 10 times mistake
$bOKInput = $FALSE;
$input = ""
for ($index = 0; $index -lt 10; $index++){
	$input = Read-Host($strInput);
	$input = [Strings]::StrConv($input, [VbStrConv]::Narrow)
	if ($input.ToLower() -eq "c"){
		exit 1
	}
	if ($input -match "[0-9]+"){
		$input = [int]$input
		if ($input -le 0 -Or $input -gt $lenHostNames){
			$strInput = 'Failed to get the number. Press the number again. '
			continue
		}else{
			$bOKInput = $TRUE
			break;
		}
	}
}
if ($bOKInput){
	write-host("ssh " + $hostNames[$input-1])
	ssh $hostNames[$input-1]
}

exit 0
