#Show All Power Options
Get-ChildItem -path hklm:\SYSTEM\ControlSet001\Control\Power\PowerSettings -recurse -ErrorAction SilentlyContinue | 
    Get-ItemProperty -Name "Attributes" -ErrorAction SilentlyContinue | Set-ItemProperty -Name "Attributes" -Value 2
