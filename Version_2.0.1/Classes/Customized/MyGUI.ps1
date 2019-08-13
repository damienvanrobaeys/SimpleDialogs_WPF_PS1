[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\SimpleDialogs.dll')       				| out-null

# [System.Reflection.Assembly]::LoadFrom('C:\Users\damien.van robaeys\Downloads\SimpleDialogs_WPF_PS1-master2\SimpleDialogs_WPF_PS1-master\Customized\assembly\SimpleDialogs.dll')       				| out-null


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
$input = $form.findname("input") 
$progress = $form.findname("progress") 


[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")


$Information.Add_Click({	
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	# $Dialog2 = [SimpleDialogs.Controls.InputDialog]::new()		
	# $Dialog = [SimpleDialogs.Controls.ProgressDialog]::new()		
	
	# $Dialog.SecondsToAutoClose = 10
	
	# $Dialog.MessageSeverity = "Information"
	# $Dialog.MessageSeverity = "Warning"
	# $Dialog.MessageSeverity = "Error"
	# $Dialog.MessageSeverity = "Critical"
	# $Dialog.MessageSeverity = "Success"
	
	$Dialog.Title = "test"
	$Dialog.ShowFirstButton  = $True
	$Dialog.ShowSecondButton = $True
	# $Dialog.ShowThirdButton = $True
	$Dialog.TitleForeground = "White"		
	$Dialog.Message = "bla bla"		
	
	# $DialogContainer = [SimpleDialogs.Controls.DialogContainer]::new()
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)

	$Dialog.Add_ButtonClicked({
		$Button_Args  = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1]	
		$Button_Value = $Button_Args.Button
		If($Button_Value -eq "FirstButton")
			{
				[System.Windows.Forms.MessageBox]::Show("OK")				
			}
		ElseIf($Button_Value -eq "SecondButton")
			{
				[System.Windows.Forms.MessageBox]::Show("Cancel")				
			}				
	})	
})



$Success.Add_Click({
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	$Dialog.MessageSeverity = "Success"
	$Dialog.Title = "test"
	$Dialog.TitleForeground = "White"	
	
	$Dialog.Message = "bla bla"			
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
})






$input.Add_Click({
	$Script:Dialog = [SimpleDialogs.Controls.InputDialog]::new()		
	
	# $Dialog.SecondsToAutoClose = 10
	
	# $Dialog.Text = "Votre texte"
	$Dialog.Description = "Saisissez votre texte batard"
	
	$Dialog.Title = "test"
	$Dialog.Watermark = "ddddddddd" # texte en fond
	# $Dialog.ShowFirstButton  = $True
	# $Dialog.ShowSecondButton = $True
	# $Dialog.ShowThirdButton = $True
	$Dialog.TitleForeground = "White"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Dialog)

	$Dialog.Add_ButtonClicked({
		$Button_Args  = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1]			
		$Button_Value = $Dialog.Text
		[System.Windows.Forms.MessageBox]::Show("$Button_Value")					
	})					
})




$progress.Add_Click({	
	$Dialog = [SimpleDialogs.Controls.ProgressDialog]::new()		
	
	# $Dialog.SecondsToAutoClose = 10
	
	# $Dialog.MessageSeverity = "Information"
	# $Dialog.MessageSeverity = "Warning"
	# $Dialog.MessageSeverity = "Error"
	# $Dialog.MessageSeverity = "Critical"
	# $Dialog.MessageSeverity = "Success"
	
	$Dialog.IsUndefined = $false
	$Dialog.Progress = 20
	# $Dialog.Foreground = "red"
	
	$Dialog.Title = "test"
	$Dialog.ShowFirstButton  = $True
	$Dialog.ShowSecondButton = $True
	# $Dialog.ShowThirdButton = $True
	# $Dialog.TitleForeground = "White"		
	$Dialog.Message = "bla bla"		
	
	# $DialogContainer = [SimpleDialogs.Controls.DialogContainer]::new()
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)

	# $Dialog.Add_ButtonClicked({
		# $Button_Args  = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1]	
		# $Button_Value = $Button_Args.Button
		# If($Button_Value -eq "FirstButton")
			# {
				# [System.Windows.Forms.MessageBox]::Show("OK")				
			# }
		# ElseIf($Button_Value -eq "SecondButton")
			# {
				# [System.Windows.Forms.MessageBox]::Show("Cancel")				
			# }				
	# })	
})

# $progress.Add_Click({
	# $New_Progress = [SimpleDialogs.Controls.ProgressDialog]::new()
	# $Dialog = [SimpleDialogs.Controls.ProgressDialog]::new()

	# $New_Progress.Progress = 45
	# $New_Progress.CanCancel = "true"
	# $New_Progress.CancelButtonContent = "Cancel"
	# $New_Progress.IsUndefined = $false

	# $Dialog.Title = "this is a progress dialog"
	# $Dialog.TitleForeground = "White"
	# $Dialog.Message = "this is a progress dialog"
	# $Dialog.DialogWidth = "600"
	# $Dialog.DialogHeight = "200"
	# $Dialog.BorderBrush = "Blue"
	# $Dialog.BorderThickness = "1"
	# $Dialog.FontSize = "12"
	# $Dialog.FontWeight = "Normal"	
	
	# [SimpleDialogs.DialogManager]::ShowDialog($New_Progress)
# })



# $critical.Add_Click({

	# $New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	# $Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	# $Dialog.AlertLevel = "critical"
	# $Dialog_Type = "critical"

	# Get_Progress_Properties
		
	# $Dialog.FontSize = $Change_Font.value
	# $Dialog.ButtonsStyle = $Button_Value
	# $Dialog.ShowCopyToClipboardButton = $AddCopyToClipboard_Value		
	# $Dialog.TitleForeground = "White"

	# [SimpleDialogs.DialogManager]::ShowDialog($Dialog)

# })

$Form.ShowDialog() | Out-Null