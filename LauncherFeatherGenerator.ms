macroScript FeatherGenerator
category:"keshon83"
toolTip:"Ext LauncherFeatherGenerator"
buttonText:"FeatherGen"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\ct-feather-generator.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
