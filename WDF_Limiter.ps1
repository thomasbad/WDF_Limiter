#Create WinForm
#Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)


#-----[functions area]------

#Enable Windows Denfender lower
function ENWDL {
            Set-MpPreference -ScanAvgCPULoadFactor 25
            Set-MpPreference -DisableCpuThrottleOnIdleScans 0
            if($?)
            {
            $SuccssMsg                    = [System.Windows.MessageBox]::Show($SuccessMsgbody,$SuccessMsgTitle,$ButtonOK,$SuccessMsgIcon)
            }
            else
            {
            $FailMsg                      = [System.Windows.MessageBox]::Show($FailMsgbody,$FailMsgTitle,$ButtonOK,$FailMsgIcon)
            }
 
   }

#Enable all
function DISWDL { 
            Set-MpPreference -ScanAvgCPULoadFactor 50
            Set-MpPreference -DisableCpuThrottleOnIdleScans 1
            if($?)
            {
            $SuccssMsg                    = [System.Windows.MessageBox]::Show($SuccessMsgbody,$SuccessMsgTitle,$ButtonOK,$SuccessMsgIcon)
            }
            else
            {
            $FailMsg                      = [System.Windows.MessageBox]::Show($FailMsgbody,$FailMsgTitle,$ButtonOK,$FailMsgIcon)
            }

}

#How To Use display
function htuDisplay {
    $htuMsg = [System.Windows.MessageBox]::Show($htuBody,$htuTitle,$ButtonOK,$htuIcon)
}


# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
# Create a new form
$Form                    = New-Object system.Windows.Forms.Form
# Define the size, title and background color
$Form.ClientSize         = '500,330'
$Form.text               = "Windows Defender Limiter for old CPU"
$Form.BackColor          = "#ffffff"

#GUI Start Here

$Titel                           = New-Object system.Windows.Forms.Label
$Titel.text                      = "Windows Defender Limiter for old CPU`nWindows Denfender限速器"
$Titel.AutoSize                  = $true
$Titel.width                     = 25
$Titel.height                    = 10
$Titel.location                  = New-Object System.Drawing.Point(20,10)
$Titel.Font                      = 'Microsoft Sans Serif,13'
$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "Please ensure this program needs to run as administrator`n請確保此程式以管理員權限運行"
$Description.ForeColor           = "#D0021B"
$Description.AutoSize            = $false
$Description.width               = 450
$Description.height              = 30
$Description.location            = New-Object System.Drawing.Point(20,60)
$Description.Font                = 'Microsoft Sans Serif,10'

#-----------------[ Buttons ]------------------

#Add Buttons
#Disable All Button
$DisableAllBtn                   = New-Object system.Windows.Forms.Button
$DisableAllBtn.BackColor         = "#E32D4E"
$DisableAllBtn.text              = "Limit WD CPU usage`n把WD限速"
$DisableAllBtn.width             = 150
$DisableAllBtn.height            = 50
$DisableAllBtn.location          = New-Object System.Drawing.Point(80,130)
$DisableAllBtn.Font              = 'Microsoft Sans Serif,10'
$DisableAllBtn.ForeColor         = "#ffffff"
$DisableAllBtn.Add_Click({ ENWDL })
$Form.Controls.Add($DisableAllBtn)


#Enable All Button
$EnableAllBtn                    = New-Object system.Windows.Forms.Button
$EnableAllBtn.BackColor          = "#54BF26"
$EnableAllBtn.text               = "Return default setting`n還原原廠設置"
$EnableAllBtn.width              = 150
$EnableAllBtn.height             = 50
$EnableAllBtn.location           = New-Object System.Drawing.Point(260,130)
$EnableAllBtn.Font               = 'Microsoft Sans Serif,10'
$EnableAllBtn.ForeColor          = "#ffffff"
$EnableAllBtn.Add_Click({ DISWDL })
$Form.Controls.Add($EnableAllBtn)

#How to Use Button
$htuBtn                    = New-Object system.Windows.Forms.Button
$htuBtn.BackColor          = "#4438D2"
$htuBtn.text               = "What is this tool`n這是甚麼工具？"
$htuBtn.width              = 150
$htuBtn.height             = 50
$htuBtn.location           = New-Object System.Drawing.Point(160,200)
$htuBtn.Font               = 'Microsoft Sans Serif,10'
$htuBtn.ForeColor          = "#ffffff"
$htuBtn.Add_Click({ htuDisplay })
$Form.Controls.Add($htuBtn)

#Licensing
$Licensing                     = New-Object system.Windows.Forms.Label
$Licensing.text                = "Licensing with GNU Lesser General Public License v2.1"
$Licensing.AutoSize            = $false
$Licensing.width               = 450
$Licensing.height              = 50
$Licensing.location            = New-Object System.Drawing.Point(20,300)
$Licensing.Font                = 'Microsoft Sans Serif,7'
$Licensing.ForeColor                = 'Gray'
$Form.Controls.Add($Licensing)


# ---------------[ Message Box ] ------------------
Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonBool                   = [System.Windows.MessageBoxButton]::YesNo
$ButtonOK                     = [System.Windows.MessageBoxButton]::OK

#Config Success

$SuccessMsgTitle              = "Done"
$SuccessMsgbody               = "Configuration Success`n設置完成"
$SuccessMsgIcon               = [System.Windows.MessageBoxImage]::Information


#Config Fail
$FailMsgTitle                 = "Fail"
$FailMsgbody                  = "Configuration Failed !`nPlease check if you have Admin Right or use Run as Admin to run this program.`n`n設置失敗，請檢查此程式是否以管理員身份運行"
$FailMsgIcon                  = [System.Windows.MessageBoxImage]::Error

#How to Use
$htuTitle                     = "What is this Tools"
$htuBody                      = "After the new update, Windows Denfender become more resource consumable, causing slowness and CPU usage always up to 100% problem on some computer with old CPU with Windows 10/11 installed`n`nThis Tool will limited the Windows Defender can use the CPU up to 25% only.`n`nThanks to Ken Tsoi remind for this problem.`n`n於更新後，有些CPU較老舊的Windows 10/11會因為Windows Denfender的資源使用量變得更進取，電腦會經常遇到CPU使用率到100%的問題。`n`n這個工具會把Windows Defender對CPU的使用上限限速到25%。`n`n感謝Ken Tsoi提醒這個問題。"
$htuIcon                      = [System.Windows.MessageBoxImage]::Information


# ADD OTHER ELEMENTS ABOVE THIS LINE IF NEEDED
# Add the elements to the form
$Form.controls.AddRange(@($Titel,$Description))


# Display the form
[void]$Form.ShowDialog()