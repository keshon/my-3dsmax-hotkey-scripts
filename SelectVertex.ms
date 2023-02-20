-- Sub-object one-way toggle selection (like Maya & Softimage and etc.)
-- Vertex selection (works with 5 sub-objects (poly,mesh etc.) and 3 sub-objects (splines)
-- 2016-07-08
-- http://keshon.ru

macroScript SelectVertex category:"keshon83" tooltip:"Select Sub-Object 1 Vertex"
(
	curObj = $
	max modify mode
	max select

	if (numSubObjectLevels == 5) do (
		subObjectLevel = 1
		if (classof (curObj) == Editable_Poly) then (
				if (viewport.isWire() == true) then (
					$.ignoreBackfacing = false
					actionMan.executeAction 0 "59232"-- Rectangle Selection
				)
				else (
					$.ignoreBackfacing = true
					actionMan.executeAction 0 "59232" -- Spray Selection
				)
		)
		else if curObj.modifiers[#Edit_Poly] != undefined then (
			if (viewport.isWire() == true) then (
				$.modifiers[#Edit_Poly].ignoreBackfacing = false
				actionMan.executeAction 0 "59232"-- Rectangle Selection
			)
			else (
				$.modifiers[#Edit_Poly].ignoreBackfacing = true
				actionMan.executeAction 0 "59232"-- Spray Selection
			)
		)
	)
	
	if (numSubObjectLevels == 3) do (
		subObjectLevel = 1 
	)
)