macroScript PolyFlow_v10
category:"keshon83"
toolTip:"Ext PolyFlow"
buttonText:"P-Flow"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\PolyFlow.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
