macroScript Fracture
category:"keshon83"
toolTip:"Ext Fracture"
buttonText:"Fracture"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\Fracture.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
