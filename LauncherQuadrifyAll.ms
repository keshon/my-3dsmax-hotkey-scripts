macroScript QuadrifyAll
category:"keshon83"
toolTip:"Ext QuadrifyAll"
buttonText:"QuadrifyAll"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\QuadrifyAll.ms"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
