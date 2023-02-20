-- 2016-08-10
-- http://keshon.ru

macroScript ChamferBevel category:"keshon83" tooltip:"Chamfer or Bevel" 
(
	local curObj = $

	if (classof (curObj) == Editable_Poly) then (
		max modify mode
		case subObjectLevel of
		(
			2: (
					macros.run "Ribbon - Modeling" "EPoly_ChamferOptions"
				)
			4: (
					macros.run "Ribbon - Modeling" "EPoly_BevelOptions"
					--curObj.bevelHeight = 5
					--curObj.bevelOutline = -5
				)
		)
	) else if curObj.modifiers[#Edit_Poly] != undefined then (
		max modify mode
		case subObjectLevel of
		(
			2: (
					macros.run "Ribbon - Modeling" "EPoly_ChamferOptions"
				)
			4: (
					macros.run "Ribbon - Modeling" "EPoly_BevelOptions"
				)
		)
	)
)



