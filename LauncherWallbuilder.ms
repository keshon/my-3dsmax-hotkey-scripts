macroScript Wallbuilder
category:"keshon83"
toolTip:"Ext Wallbuilder"
buttonText:"Wallbuilder"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\wallbuilder.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
