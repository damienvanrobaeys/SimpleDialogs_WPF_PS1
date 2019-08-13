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


$Message = $form.findname("Message") 
$Input = $form.findname("Input") 
$Progress = $form.findname("Progress") 


$Message.Add_Click({	
	$Dialog = [SimpleDialogs.Controls.MessageDialog]::new()			
	# $Dialog.SecondsToAutoClose = 10
	
	$Dialog.MessageSeverity = "Information"
	# $Dialog.MessageSeverity = "Warning"
	# $Dialog.MessageSeverity = "Error"
	# $Dialog.MessageSeverity = "Critical"
	# $Dialog.MessageSeverity = "Success"
	
	$Dialog.Title = "Let's test a little title"
	$Dialog.ShowFirstButton  = $True
	$Dialog.ShowSecondButton = $True
	$Dialog.TitleForeground = "White"		
	$Dialog.Message = "Let's test a little message"		
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Dialog)

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



$input.Add_Click({
	$Script:Dialog = [SimpleDialogs.Controls.InputDialog]::new()		
	$Dialog.MessageSeverity = "warning"
	# $Dialog.SecondsToAutoClose = 10	
	# $Dialog.Text = "Votre texte"
	$Dialog.Description = "Type your name"	
	$Dialog.Title = "This is my title"
	$Dialog.Watermark = "Type your text" 
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
	$Dialog.Progress = 50
	$Dialog.CanCancel = $True
	$Dialog.IsUndefined = $False
	$Dialog.Message = "Please wait..."
	# $Dialog.Title = "Working..."
	$Dialog.TitleForeground = "White"		
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Dialog)
})








$Form.ShowDialog() | Out-Null
