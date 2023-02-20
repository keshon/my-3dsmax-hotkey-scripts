macroScript NitrousSetTextureSize
category:"keshon83"
toolTip:"Ext NitrousSetTextureSize"
buttonText:"NitroTexRes"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\NitrousSetTextureSize.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
