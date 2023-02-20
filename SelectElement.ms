-- Sub-object one-way toggle selection (like Maya & Softimage and etc.)
-- Hull selection (works with 5 sub-objects (poly,mesh etc.) and 3 sub-objects (splines)
-- 2016-07-08
-- http://keshon.ru

macroScript SelectElement category:"keshon83" tooltip:"Select Sub-Object 5(3) Element"
(
	curObj = $
	max modify mode
	max select

	if (numSubObjectLevels == 5) do (
		subObjectLevel = 5
		if (classof (curObj) == Editable_Poly) then (
				if (viewport.isWire() == true) then (
					$.ignoreBackfacing = false
					actionMan.executeAction 0 "59232"-- Rectangle Selection
				)
				else (
					$.ignoreBackfacing = true
					actionMan.executeAction 0 "59232" -- Rectangle Selection
				)
		)
		else if curObj.modifiers[#Edit_Poly] != undefined then (
			if (viewport.isWire() == true) then (
				$.modifiers[#Edit_Poly].ignoreBackfacing = false
				actionMan.executeAction 0 "59232"-- Rectangle Selection
			)
			else (
				$.modifiers[#Edit_Poly].ignoreBackfacing = true
				actionMan.executeAction 0 "59232"-- Rectangle Selection
			)
		)
	)
	
	if (numSubObjectLevels == 3) do (
		subObjectLevel = 3
	)
)