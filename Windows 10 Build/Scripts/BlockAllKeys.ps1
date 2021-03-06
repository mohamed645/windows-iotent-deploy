
$COMPUTER = "localhost"
$NAMESPACE = "root\standardcimv2\embedded"

function Block-PredefinedKey($Id) {
    <#
    .Synopsis
        Block a Predefined Key Filter
    .Description
        This function sets a predefined key to be blocked by Keyboard Filter. To view the 
        predefined key combination names, enumerate the WEKF_CustomKey class. Changes 
        take place immediately.
    .Parameter Id
        A string that represents the predefined key combination to be blocked.
    .Example
        Block-Predefined-Key "Ctrl+Alt+Del"
    #>
    $predefined = Get-WMIObject -class WEKF_PredefinedKey –namespace $NAMESPACE –computer $COMPUTER |
        where {
            $_.Id -eq "$Id"
        };

    if ($predefined) {
        $predefined.Enabled = 1;
        $predefined.Put() | Out-Null;
        Write-Host "Blocking $Id"
    } else {
        Write-Error "$Id is not a valid predefined key"
    }
}

function Get-KeyboardFilterSetting([String] $Name) {
    <#
    .Synopsis
        Retrieve a specific Keyboard Filter setting WMIObject.
    .Parameter Name
        A string that represents the name of the Keyboard Filter setting to retrieve.
    #>
    $Entry = Get-WMIObject -class WEKF_Settings –namespace $NAMESPACE –computer $COMPUTER |
        where {
            $_.Name -eq $Name
        }

    return $Entry
}

function Set-DisableKeyboardFilterForAdministrators([Bool] $Value) {
    <#
    .Synopsis
        Set the DisableKeyboardFilterForAdministrators setting to true or false.
    .Description
        Enables or disables Keyboard Filter from blocking keys when a user is logged 
        in on an Administrator account.
    .Parameter Value
        A boolean value that represents the new DisableKeyboardFilterForAdministrators setting value.
    #>

    $Setting = Get-KeyboardFilterSetting("DisableKeyboardFilterForAdministrators")
    if ($Setting) {
        if ($Value) {
            $Setting.Value = "true" 
        } else {
            $Setting.Value = "false"
        }
        $Setting.Put() | Out-Null;
        Write-Host ("Set DisableKeyboardFilterForAdministrators to {0}" -f $Value)
    } else {
        Write-Error "Unable to find DisableKeyboardFilterForAdministrators setting";
    }
}

$HomeKeyScanCode = 16

$BreakoutMode = get-wmiobject -class wekf_settings -namespace "root/standardcimv2/embedded" | where {$_.name -eq "BreakoutKeyScanCode"}
$BreakoutMode.value = $HomeKeyScanCode
$BreakoutMode.put()

#Add all the PreFinedKeys listed here: https://msdn.microsoft.com/en-us/library/windows/hardware/mt633812(v=vs.85).aspx 

#Accessibility keys
Block-PredefinedKey "LShift+LAlt+PrintScrn"
Block-PredefinedKey "LShift+LAlt+NumLock"
Block-PredefinedKey "Win+U"

#Application keys
Block-PredefinedKey "Alt+F4"
Block-PredefinedKey "Ctrl+F4"
Block-PredefinedKey "Win+F1"

#Shell keys
Block-PredefinedKey "Alt+Space"
Block-PredefinedKey "Ctrl+Esc"
Block-PredefinedKey "Ctrl+Win+F"
Block-PredefinedKey "Win+Break"
Block-PredefinedKey "Win+E"
Block-PredefinedKey "Win+F"
Block-PredefinedKey "Win+P"
Block-PredefinedKey "Win+R"
Block-PredefinedKey "Alt+Tab"
Block-PredefinedKey "Ctrl+Tab"
Block-PredefinedKey "Win+Tab"
Block-PredefinedKey "Win+D"
Block-PredefinedKey "Win+M"
Block-PredefinedKey "Win+Home"
Block-PredefinedKey "Win+T"
Block-PredefinedKey "Win+B"
Block-PredefinedKey "Win+-"
Block-PredefinedKey "Win++"
Block-PredefinedKey "Win+Esc"
Block-PredefinedKey "Win+Up"
Block-PredefinedKey "Win+Down"
Block-PredefinedKey "Win+Left"
Block-PredefinedKey "Win+Right"
Block-PredefinedKey "Win+Shift+Up"
Block-PredefinedKey "Win+Shift+Down"
Block-PredefinedKey "Win+Shift+Left"
Block-PredefinedKey "Win+Shift+Right"
Block-PredefinedKey "Win+Space"
Block-PredefinedKey "Win+O"
Block-PredefinedKey "Win+Enter"
Block-PredefinedKey "Win+PageUp"
Block-PredefinedKey "Win+PageDown"
Block-PredefinedKey "Win+."
Block-PredefinedKey "Win+C"
Block-PredefinedKey "Win+I"
Block-PredefinedKey "Win+K"
Block-PredefinedKey "Win+H"
Block-PredefinedKey "Win+Q"
Block-PredefinedKey "Win+W"
Block-PredefinedKey "Win+Z"
Block-PredefinedKey "Win+/"
Block-PredefinedKey "Win+J"
Block-PredefinedKey "Win+,"
Block-PredefinedKey "Win+V"

#Modifier keys
Block-PredefinedKey "Alt"
Block-PredefinedKey "Application"
Block-PredefinedKey "Ctrl"
Block-PredefinedKey "Shift"
Block-PredefinedKey "Windows"

#Security keys
Block-PredefinedKey "Ctrl+Alt+Del"
Block-PredefinedKey "Shift+Ctrl+Esc"
Block-PredefinedKey "Win+L"

#Extended shell keys
Block-PredefinedKey "LaunchMail"
Block-PredefinedKey "LaunchMediaSelect"
Block-PredefinedKey "LaunchApp1"
Block-PredefinedKey "LaunchApp2"

#Browser keys
Block-PredefinedKey "BrowserBack"
Block-PredefinedKey "BrowserForward"
Block-PredefinedKey "BrowserRefresh"
Block-PredefinedKey "BrowserStop"
Block-PredefinedKey "BrowserSearch"
Block-PredefinedKey "BrowserFavorites"
Block-PredefinedKey "BrowserHome"

#Media keys
Block-PredefinedKey "VolumeMute"
Block-PredefinedKey "VolumeDown"
Block-PredefinedKey "VolumeUp"
Block-PredefinedKey "MediaNext"
Block-PredefinedKey "MediaPrev"
Block-PredefinedKey "MediaStop"
Block-PredefinedKey "MediaPlayPause"

#Microsoft Surface keyboard keys
Block-PredefinedKey "AltWin"
Block-PredefinedKey "CtrlWin"
Block-PredefinedKey "ShiftWin"
Block-PredefinedKey "F21"
