macroScript SmoothEdges_v10
category:"keshon83"
toolTip:"Ext SmoothEdges"
buttonText:"SmoothEdges"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\SmoothEdges.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
