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

$Information.Add_Click({
	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "information"
	$Dialog.ShowCopyToClipboardButton = $false
	$Dialog.ButtonsStyle = "YesNo"	
	$Dialog.CopyToClipboardButtonContent = "rrrrr"	
	$Dialog.Title = "This is an information dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is an information dialog"
	$Dialog.MaxWidth = "600"
	$Dialog.MaxHeight = "200"	

	$New_Alert.BorderBrush = "Red"
	$New_Alert.BorderThickness = "5"
	
	$Dialog.HasAnimatedProperties  = $true      
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})


$Success.Add_Click({
	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "Success"
	$Dialog.Title = "This is a success dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a success dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderBrush = "Blue"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})


$progress.Add_Click({
	$New_Progress = [SimpleDialogs.Controls.ProgressDialog]::new()
	$New_Progress.CanCancel = $True
	$New_Progress.IsUndefined = $False
	$New_Progress.Message = "Please wait..."
	$New_Progress.Title = "Working..."
	[SimpleDialogs.DialogManager]::ShowDialog($New_Progress)
})



$warning.Add_Click({
	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "warning"
	$Dialog.Title = "This is an warning dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is an error dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderBrush = "Blue"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})

$error.Add_Click({
	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "error"
	$Dialog.Title = "This is an error dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is an error dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderBrush = "Blue"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})




$critical.Add_Click({
	$New_Alert = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog = [SimpleDialogs.Controls.AlertDialog]::new()
	$Dialog.AlertLevel = "critical"
	$Dialog.Title = "This is a critical dialog"
	$Dialog.TitleForeground = "White"
	$Dialog.Message = "This is a critical dialog"
	$Dialog.DialogWidth = "600"
	$Dialog.DialogHeight = "200"
	$Dialog.BorderBrush = "Blue"
	$Dialog.BorderThickness = "1"
	$Dialog.FontSize = "12"
	$Dialog.FontWeight = "Normal"
	[SimpleDialogs.DialogManager]::ShowDialog($Dialog)
})


$Form.ShowDialog() | Out-Null
