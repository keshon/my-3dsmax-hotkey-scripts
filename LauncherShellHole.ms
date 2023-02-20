macroScript ShellHole
category:"keshon83"
toolTip:"Ext ShellHole"
buttonText:"ShellHole"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\shellhole.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
