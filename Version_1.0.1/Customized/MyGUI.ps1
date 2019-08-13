[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\SimpleDialogs.dll')       				| out-null

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml("MyGUI.xaml")

$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)


$Information = $form.findname("Information") 
$Success = $form.findname("Success") 
$Progress = $form.findname("Progress") 
$Warning  = $form.findname("Warning") 
$Error  = $form.findname("Error") 
$critical  = $form.findname("critical") 

$Title_TXT  = $form.findname("Title_TXT") 
$Message_TXT  = $form.findname("Message_TXT") 
$Width_TXT  = $form.findname("Width_TXT") 
$Height_TXT  = $form.findname("Height_TXT") 
$Picker  = $form.findname("Picker") 
$Color_Overview  = $form.findname("Color_Overview") 
$Color_Text  = $form.findname("Color_Text") 
$ButtonType  = $form.findname("ButtonType") 
$AddCopyToClipboard  = $form.findname("AddCopyToClipboard") 
$Change_Font  = $form.findname("Change_Font") 

$Title_Picker  = $form.findname("Title_Picker") 
$Title_Color_Overview  = $form.findname("Title_Color_Overview") 
$Color_Title_Text  = $form.findname("Color_Title_Text") 


$Picker.Add_Click({
    $MyColor = new-object System.Windows.Forms.ColorDialog 
    $MyColor.AllowFullOpen = $true
    $MyColor.ShowDialog()
	
	$Global:Color_Name = $MyColor.Color.Name
	If ($Color_Name -like "ff*")
		{
			$Global:Color_Name = "#$Color_Name"
		}

	$Color_Text.Text = $Color_Name
	$Color_Overview.Background = $Color_Name
})



$Title_Picker.Add_Click({
    $MyTitleColor = new-object System.Windows.Forms.ColorDialog 
    $MyTitleColor.AllowFullOpen = $true
    $MyTitleColor.ShowDialog()
	
	$Global:Title_Color_Name = $MyTitleColor.Color.Name
	If ($Title_Color_Name -like "ff*")
		{
			$Global:Title_Color_Name = "#$Title_Color_Name"
		}

	$Color_Title_Text.Text = $Title_Color_Name
	$Title_Color_Overview.Background = $Title_Color_Name
})



Function Get_Progress_Properties
	{
		$Font_Size_Value = $FontSize.value
		
		If (($ButtonType.IsChecked) -eq $True)
			{
				$Global:Button_Value = "YesNo"
			}
		Else
			{
				$Global:Button_Value = "Ok"			
			}	
			
		If (($AddCopyToClipboard.IsChecked) -eq $True)
			{
				$Global:AddCopyToClipboard_Value = $True
			}
		Else
			{
				$Global:AddCopyToClipboard_Value = $False			
			}				
		
		$Global:Title_Value = $Title_TXT.Text.ToString()			
		$Global:Message_Value = $Message_TXT.Text.ToString()
		$Global:Width_Value = $Width_TXT.Text.ToString()
		$Global:Height_Value = $Height_TXT.Text.ToString()
		$Global:Color_Value = $Color_Name
		$Global:Title_Color_Value = $Title_Color_Name
	}


$Information.Add_Click({

	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()	
	$Dialog.AlertLevel = "information"
	$Dialog_Type = "information"
		
		
	Get_Progress_Properties
		
	$Dialog.FontSize = $Change_Font.value
	$Dialog.ButtonsStyle = $Button_Value
	$Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	$Dialog.TitleForeground = "White"
		
	If ($Title_Value -ne "")
		{
			$Dialog.Title = $Title_Value	
		}
	Else
		{
			$Dialog.Title = "This is an $Dialog_Type dialog"
		}	
			
	If ($Message_Value -ne "")
		{
			$Dialog.Message = $Message_Value	
		}
	Else
		{
			$Dialog.Message = "This is an $Dialog_Type dialog"
		}					
		
	If ($Width_Value -ne "")
		{
			$Dialog.DialogWidth = $Width_Value	
		}
	Else
		{
			$Dialog.DialogWidth = "600"
		}		

	If ($Height_Value -ne "")
		{
			$Dialog.DialogHeight = $Height_Value	
		}
	Else
		{
			$Dialog.DialogHeight = "200"
		}		

	If ($Color_Value -ne $null)
		{
			$Dialog.Foreground = $Color_Value	
		}
		
	If ($Title_Color_Value -ne $null)
		{
			$Dialog.TitleForeground = $Title_Color_Value	
		}	
	Else
		{
			$Dialog.TitleForeground = "White"			
		}
		
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)

})




$Success.Add_Click({

	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "Success"
	$Dialog_Type = "Success"

	Get_Progress_Properties
		
	$Dialog.FontSize = $Change_Font.value
	$Dialog.ButtonsStyle = $Button_Value
	$Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	$Dialog.TitleForeground = "White"
		
	If ($Title_Value -ne "")
		{
			$Dialog.Title = $Title_Value	
		}
	Else
		{
			$Dialog.Title = "This is an $Dialog_Type dialog"
		}	
			
	If ($Message_Value -ne "")
		{
			$Dialog.Message = $Message_Value	
		}
	Else
		{
			$Dialog.Message = "This is an $Dialog_Type dialog"
		}					
		
	If ($Width_Value -ne "")
		{
			$Dialog.DialogWidth = $Width_Value	
		}
	Else
		{
			$Dialog.DialogWidth = "600"
		}		

	If ($Height_Value -ne "")
		{
			$Dialog.DialogHeight = $Height_Value	
		}
	Else
		{
			$Dialog.DialogHeight = "200"
		}		

	If ($Color_Value -ne $null)
		{
			$Dialog.Foreground = $Color_Value	
		}
		
	If ($Title_Color_Value -ne $null)
		{
			$Dialog.TitleForeground = $Title_Color_Value	
		}	
	Else
		{
			$Dialog.TitleForeground = "White"			
		}	

	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)

})




$progress.Add_Click({
	$New_Progress = [SimpleDialogs.Controls.ProgressDialog]::new()
	$Dialog = [SimpleDialogs.Controls.ProgressDialog]::new()

	$New_Progress.Progress = 45
	$New_Progress.CanCancel = "true"
	$New_Progress.CancelButtonContent = "Cancel"
	$New_Progress.IsUndefined = $false

	$Dialog.Title = "this is a progress dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "this is a progress dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderBrush = "Blue"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"	
	
	[SimpleDialogs.DialogManager]::ShowDialog($New_Progress)
})


$warning.Add_Click({

	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "warning"
	$Dialog_Type = "error"

	Get_Progress_Properties
		
	$Dialog.FontSize = $Change_Font.value
	$Dialog.ButtonsStyle = $Button_Value
	$Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	$Dialog.TitleForeground = "White"
		
	If ($Title_Value -ne "")
		{
			$Dialog.Title = $Title_Value	
		}
	Else
		{
			$Dialog.Title = "This is an $Dialog_Type dialog"
		}	
			
	If ($Message_Value -ne "")
		{
			$Dialog.Message = $Message_Value	
		}
	Else
		{
			$Dialog.Message = "This is an $Dialog_Type dialog"
		}					
		
	If ($Width_Value -ne "")
		{
			$Dialog.DialogWidth = $Width_Value	
		}
	Else
		{
			$Dialog.DialogWidth = "600"
		}		

	If ($Height_Value -ne "")
		{
			$Dialog.DialogHeight = $Height_Value	
		}
	Else
		{
			$Dialog.DialogHeight = "200"
		}		

	If ($Color_Value -ne $null)
		{
			$Dialog.Foreground = $Color_Value	
		}
		
	If ($Title_Color_Value -ne $null)
		{
			$Dialog.TitleForeground = $Title_Color_Value	
		}	
	Else
		{
			$Dialog.TitleForeground = "White"			
		}	

	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})


$error.Add_Click({

	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "error"
	$Dialog_Type = "error"

	Get_Progress_Properties
		
	$Dialog.FontSize = $Change_Font.value
	$Dialog.ButtonsStyle = $Button_Value
	$Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	$Dialog.TitleForeground = "White"
		
	If ($Title_Value -ne "")
		{
			$Dialog.Title = $Title_Value	
		}
	Else
		{
			$Dialog.Title = "This is an $Dialog_Type dialog"
		}	
			
	If ($Message_Value -ne "")
		{
			$Dialog.Message = $Message_Value	
		}
	Else
		{
			$Dialog.Message = "This is an $Dialog_Type dialog"
		}					
		
	If ($Width_Value -ne "")
		{
			$Dialog.DialogWidth = $Width_Value	
		}
	Else
		{
			$Dialog.DialogWidth = "600"
		}		

	If ($Height_Value -ne "")
		{
			$Dialog.DialogHeight = $Height_Value	
		}
	Else
		{
			$Dialog.DialogHeight = "200"
		}		

	If ($Color_Value -ne $null)
		{
			$Dialog.Foreground = $Color_Value	
		}
		
	If ($Title_Color_Value -ne $null)
		{
			$Dialog.TitleForeground = $Title_Color_Value	
		}	
	Else
		{
			$Dialog.TitleForeground = "White"			
		}	
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})




$critical.Add_Click({

	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "critical"
	$Dialog_Type = "critical"

	Get_Progress_Properties
		
	$Dialog.FontSize = $Change_Font.value
	$Dialog.ButtonsStyle = $Button_Value
	$Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	$Dialog.TitleForeground = "White"
		
	If ($Title_Value -ne "")
		{
			$Dialog.Title = $Title_Value	
		}
	Else
		{
			$Dialog.Title = "This is an $Dialog_Type dialog"
		}	
			
	If ($Message_Value -ne "")
		{
			$Dialog.Message = $Message_Value	
		}
	Else
		{
			$Dialog.Message = "This is an $Dialog_Type dialog"
		}					
		
	If ($Width_Value -ne "")
		{
			$Dialog.DialogWidth = $Width_Value	
		}
	Else
		{
			$Dialog.DialogWidth = "600"
		}		

	If ($Height_Value -ne "")
		{
			$Dialog.DialogHeight = $Height_Value	
		}
	Else
		{
			$Dialog.DialogHeight = "200"
		}		

	If ($Color_Value -ne $null)
		{
			$Dialog.Foreground = $Color_Value	
		}
		
	If ($Title_Color_Value -ne $null)
		{
			$Dialog.TitleForeground = $Title_Color_Value	
		}	
	Else
		{
			$Dialog.TitleForeground = "White"			
		}	
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)

})

$Form.ShowDialog() | Out-Null