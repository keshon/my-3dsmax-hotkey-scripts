macroScript AntStitchFREE_v101
category:"keshon83"
toolTip:"Ext AntStitch"
buttonText:"AntStitch"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\AntStitchFREE.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
