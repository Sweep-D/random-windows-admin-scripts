reg delete HKLM\System\CurrentControlSet\Control\LSA /f /v LsaCfgFlags
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Device Guard" /v EnableVirtualizationBasedSecurity /d 0 /f /t REG_DWORD
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeviceGuard /f /v LsaCfgFlags
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeviceGuard /f /v EnableVirtualizationBasedSecurity
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeviceGuard /f /v RequirePlatformSecurityFeatures

mountvol X: /s
copy %WINDIR%\System32\SecConfig.efi X:\EFI\Microsoft\Boot\SecConfig.efi /Y
bcdedit /create {0cb3b571-2f2e-4343-a879-d86a476d7215} /d "DebugTool" /application osloader
bcdedit /set {0cb3b571-2f2e-4343-a879-d86a476d7215} path "\EFI\Microsoft\Boot\SecConfig.efi"
bcdedit /set {bootmgr} bootsequence {0cb3b571-2f2e-4343-a879-d86a476d7215}
bcdedit /set {0cb3b571-2f2e-4343-a879-d86a476d7215} loadoptions DISABLE-LSA-ISO
bcdedit /set {0cb3b571-2f2e-4343-a879-d86a476d7215} device partition=X:
mountvol X: /d

bcdedit /set {0cb3b571-2f2e-4343-a879-d86a476d7215} loadoptions DISABLE-LSA-ISO,DISABLE-VBS
bcdedit /set vsmlaunchtype off
bcdedit /set hypervisorlaunchtype off