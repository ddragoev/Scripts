#Configure PC To Manage with PDQ (Non-Domain/Workgroup)
#https://help.pdq.com/hc/en-us/articles/360058301191-Working-with-Non-Domain-Workgroup-Machines
$IP = "XXX.XXX.XXX.XXX" #IP of PDQ Server

Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
winrm quickconfig -quiet
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name LocalAccountTokenFilterPolicy -Value 1  -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\" -Name "Microsoft" -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsFirewall" -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\" -Name "StandardProfile" -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "IcmpSettings" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowOutboundDestinationUnreachable   -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowOutboundSourceQuench			    -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowRedirect						    -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowInboundEchoRequest			    -Value 1 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowInboundRouterRequest			    -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowOutboundTimeExceeded			    -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowOutboundParameterProblem		    -Value 0 -ErrorAction SilentlyContinue         	
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowInboundTimestampRequest		    -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowInboundMaskRequest			    -Value 1 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\IcmpSettings" -Name AllowOutboundPacketTooBig	            -Value 0 -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "Services" -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\Services" -Name "FileAndPrint" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\Services\FileAndPrint" -Name Enabled		                -Value 1 -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile\Services\FileAndPrint" -Name RemoteAddresses              -Value $IP
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\" -Name "FirewallRules" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\" -Name WINRM-HTTP-In-TCP-PUBLIC -Value "v2.31|Action=Allow|Active=TRUE|Dir=In|Protocol=6|Profile=Public|LPort=5985|RA4=LocalSubnet|RA6=LocalSubnet|App=System|Name=@FirewallAPI.dll,-30253|Desc=@FirewallAPI.dll,-30256|EmbedCtxt=@FirewallAPI.dll,-30267|"  -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\" -Name WINRM-HTTP-In-TCP -Value "v2.31|Action=Allow|Active=TRUE|Dir=In|Protocol=6|Profile=Domain|Profile=Private|LPort=5985|App=System|Name=@FirewallAPI.dll,-30253|Desc=@FirewallAPI.dll,-30256|EmbedCtxt=@FirewallAPI.dll,-30267|"  -ErrorAction SilentlyContinue
Restart-Computer -ComputerName localhost
