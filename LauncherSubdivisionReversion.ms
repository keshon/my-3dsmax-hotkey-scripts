macroScript SubdivisionReversion
category:"keshon83"
toolTip:"Ext SubdivisionReversion"
buttonText:"SubdReverse"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\SubdivisionReversion.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
