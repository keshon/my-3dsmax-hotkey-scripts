-- 2016-08-03
-- http://keshon.ru

macroScript SelectPolygon category:"keshon83" tooltip:"Select Sub-Object 4(2) Polygon" 
(
	curObj = $
	max modify mode
	max select

	if (numSubObjectLevels == 5) do (
		subObjectLevel = 4
		if (classof (curObj) == Editable_Poly) then (
				if (viewport.isWire() == true) then (
					$.ignoreBackfacing = false
					actionMan.executeAction 0 "59232"-- Rectangle Selection
				)
				else (
					$.ignoreBackfacing = true
					actionMan.executeAction 0 "59236" -- Spray Selection
				)
		) else if (classof (curObj) == PolyMeshObject) then (
			if (viewport.isWire() == true) then (
				$.modifiers[#Edit_Poly].ignoreBackfacing = false
				actionMan.executeAction 0 "59232"-- Rectangle Selection
			)
			else (
				$.modifiers[#Edit_Poly].ignoreBackfacing = true
				actionMan.executeAction 0 "59236"-- Spray Selection
			)
		)
	)
	
	if (numSubObjectLevels == 3) do (
		subObjectLevel = 2  
	)
)