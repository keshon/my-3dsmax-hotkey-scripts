macroScript RockGenerator
category:"keshon83"
toolTip:"Ext RockGenerator"
buttonText:"RockGen"
(
	scriptFile = (GetDir #scripts) + "\\keshon83-ext\\aaRockGen.mse"
	if (doesFileExist scriptFile) then
		fileIn scriptFile
	else
		messageBox "Unable to locate the script." title:"Error!"
)
