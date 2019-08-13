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
$Input = $form.findname("Input") 
$Warning  = $form.findname("Warning") 
$Error  = $form.findname("Error") 
$critical  = $form.findname("critical") 



$Information.Add_Click({	
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	
	# $Dialog.SecondsToAutoClose = 10
	
	$Dialog.MessageSeverity = "Information"
	# $Dialog.MessageSeverity = "Warning"
	# $Dialog.MessageSeverity = "Error"
	# $Dialog.MessageSeverity = "Critical"
	# $Dialog.MessageSeverity = "Success"
	
	$Dialog.Title = "This is my title"
	$Dialog.ShowFirstButton  = $True
	$Dialog.ShowSecondButton = $True
	$Dialog.TitleForeground = "White"		
	$Dialog.Message = "This is my message"		
	
	$Dialog.Title = "This is an information dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is an information dialog"
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Dialog)

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






$Success.Add_Click({
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	$Dialog.MessageSeverity = "Success"
	
	$Dialog.Title = "This is a success dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a success dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
})



# $progress.Add_Click({
	# $New_Progress = [SimpleDialogs.Controls.ProgressDialog]::new()
	# $New_Progress.CanCancel = $True
	# $New_Progress.IsUndefined = $False
	# $New_Progress.Message = "Please wait..."
	# $New_Progress.Title = "Working..."
	# [SimpleDialogs.DialogManager]::ShowDialog($New_Progress)
# })




$warning.Add_Click({
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	$Dialog.MessageSeverity = "warning"
	
	$Dialog.Title = "This is a warning dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a warning dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
})



$error.Add_Click({
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	$Dialog.MessageSeverity = "error"
	
	$Dialog.Title = "This is a error dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a error dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
})




$critical.Add_Click({
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()		
	$Dialog.MessageSeverity = "critical"
	
	$Dialog.Title = "This is a critical dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a critical dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync("ee", $Dialog)	
})





$input.Add_Click({
	$Script:Dialog = [SimpleDialogs.Controls.InputDialog]::new()		
	$Dialog.MessageSeverity = "warning"		
	$Dialog.Watermark = "Type youor text here " 
	$Dialog.Title = "This is an input dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Description = "Type your name"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Dialog)

	# $Dialog.Add_ButtonClicked({
		# $Button_Args  = [SimpleDialogs.Controls.DialogButtonClickedEventArgs]$args[1]			
		# $Button_Value = $Dialog.Text
		# [System.Windows.Forms.MessageBox]::Show("$Button_Value")					
	# })					
})


$Form.ShowDialog() | Out-Null
