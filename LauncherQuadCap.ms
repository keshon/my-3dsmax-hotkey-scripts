macroScript Quad_Cap_v101
category:"keshon83"
toolTip:"Ext QuadCap"
buttonText:"Q-Cap"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\QuadCap.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"ERROR!!!"
)
