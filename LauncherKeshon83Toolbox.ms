macroScript Keshon83Toolbox
category:"keshon83"
toolTip:"Ext Keshon83 Toolbox"
buttonText:"Keshon83"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\keshon83_toolbox.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
