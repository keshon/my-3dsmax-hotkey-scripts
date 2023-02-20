-- 2016-07-14
-- http://keshon.ru

macroScript QuickCopy category:"keshon83" tooltip:"Quick Copy" 
(
-- function Select Last Created Object (got it here http://snipplr.com/view/66170/select-last-created-object/)
fn selectLastCreatedObj = 
(
	objID = amax (for o in objects collect o.inode.handle) 
	select (maxOps.getNodeByHandle objID)
)

local curObj = $

if (classof (curObj) == Editable_Poly) then (
	max modify mode
	case subObjectLevel of
	(
		4: (
				-- get selected faces
				local polyList = #{}
				polyList = polyOp.getFaceSelection curObj
				
				-- copy them as a separate object
				polyOp.detachFaces curObj polyList delete:false asNode:true
				
				-- select newly created object
				selectLastCreatedObj()
				
				-- center pivot and activate move tool
				macros.run "PolyTools" "CenterPivot"
				subObjectLevel = 4
				max move
			)
		5: (
				-- get selected faces
				local polyList = #{}
				polyList = polyOp.getFaceSelection curObj
				
				-- copy them as a separate object
				polyOp.detachFaces curObj polyList delete:false asNode:true
				
				-- select newly created object
				selectLastCreatedObj()
				
				-- center pivot and activate move tool
				macros.run "PolyTools" "CenterPivot"
				subObjectLevel = 4
				max move
			)
	)
) else if curObj.modifiers[#Edit_Poly] != undefined then (
	max modify mode
	case subObjectLevel of
	(
		4: (
				curObj.modifiers[#Edit_Poly].ButtonOp #DetachFace
				curObj.modifiers[#Edit_Poly].DetachToObject "Object"
				
				selectLastCreatedObj()
				
				macros.run "PolyTools" "CenterPivot"
				subObjectLevel = 4
				max move
			)
		5: (
				curObj.modifiers[#Edit_Poly].ButtonOp #DetachFace
				curObj.modifiers[#Edit_Poly].DetachToObject "Object"
				
				selectLastCreatedObj()
				
				macros.run "PolyTools" "CenterPivot"
				subObjectLevel = 4
				max move
			)
	)
)
)