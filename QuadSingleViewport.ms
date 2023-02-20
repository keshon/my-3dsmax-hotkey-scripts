-- 2016-07-13
-- http://keshon.ru

macroScript QuadSingleViewport category:"keshon83" tooltip:"Quad/Single Viewport"
(
	fn activateVPUnderMouse =
	(
		nv = viewport.numViews
		for i in 1 to nv do
		(
			viewport.activeViewport = i
			mp = mouse.pos
			sz = getViewSize()
			if (mp.x > 0) and (mp.x < sz.x) and (mp.y > 0) and (mp.y < sz.y) do return true
		)
	)
	if viewport.numViews > 1 do
	(
		activateVPUnderMouse()
	)
	
	max tool maximize
	
	local curObj = modPanel.getCurrentObject()
	
	if (classof (curObj) == Editable_Poly) then -- Editable Poly object
	(
		max modify mode
		if (viewport.isWire() == true) then
		(
			$.ignoreBackfacing = false
			actionMan.executeAction 0 "59232" -- rect
		)
		else
		(
			case subObjectLevel of
			(
				1: (
						curObj.ignoreBackfacing = true
						actionMan.executeAction 0 "59232" -- rect
					)
				2: (
						curObj.ignoreBackfacing = true
						actionMan.executeAction 0 "59232" -- rect
					)
				4: (
						curObj.ignoreBackfacing = true
						actionMan.executeAction 0 "59236" -- paint
					)
			)
		)
	)
	else if (classof (curObj) == Edit_Poly) then (
		if (viewport.isWire() == true) then (
			$.modifiers[#Edit_Poly].ignoreBackfacing = false
			actionMan.executeAction 0 "59232" -- rect
		)
		else (
			case subObjectLevel of
			(
				1: (
						$.modifiers[#Edit_Poly].ignoreBackfacing = true
						actionMan.executeAction 0 "59232" -- rect
					)
				2: (
						$.modifiers[#Edit_Poly].ignoreBackfacing = true
						actionMan.executeAction 0 "59232" -- rect
					)
				4: (
						$.modifiers[#Edit_Poly].ignoreBackfacing = true
						actionMan.executeAction 0 "59236" -- paint
					)
			)
		)
	)
)



