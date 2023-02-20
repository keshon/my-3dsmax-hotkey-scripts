-- similar to CTRL+D in Softimage
-- 2016-07-14
-- http://keshon.ru

macroScript QuickExtrude category:"keshon83" tooltip:"Quick Extrude" 
(
local curObj = $

if (classof (curObj) == Editable_Poly) then (
	max modify mode
	case subObjectLevel of
	(
		2: (
				-- extrude edge with minimal height offset possible
				curObj.edgeExtrudeHeight = 0.00001
				curObj.edgeExtrudeWidth = 0
				curObj.buttonOp #extrude

				-- convert to vertex selection and grow it two times to select all participated vertices
				macros.run "Ribbon - Modeling" "SubobjectConvertVertex"
				curObj.EditablePoly.GrowSelection ()
				curObj.EditablePoly.GrowSelection ()

				-- weld all overlapped verticies (except those with offset)
				curObj.weldThreshold = 0
				curObj.EditablePoly.weldFlaggedVertices ()

				--get back to edge selection to move new extruded edge
				subObjectLevel = 2
			
				max move
			)
		4: (
				curObj.faceExtrudeHeight = 0.0
				curObj.EditablePoly.buttonOp #extrude
				
				max move
				if (viewport.isWire() == true) then (
					toolMode.coordsys #view
				)else(
					toolMode.coordsys #local
				)
			)
	)
) else if curObj.modifiers[#Edit_Poly] != undefined then (
	max modify mode
	case subObjectLevel of
	(
		2: (
				curObj.modifiers[#Edit_Poly].SetOperation #ExtrudeEdge
				curObj.modifiers[#Edit_Poly].extrudeEdgeHeight = 0.00001
				curObj.modifiers[#Edit_Poly].Commit ()

				curObj.modifiers[#Edit_Poly].ConvertSelection #Edge #Vertex
				subobjectLevel = 1
				curObj.modifiers[#Edit_Poly].ButtonOp #GrowSelection

				curObj.modifiers[#Edit_Poly].SetOperation #WeldVertex
				curObj.modifiers[#Edit_Poly].weldVertexThreshold = 0
				curObj.modifiers[#Edit_Poly].Commit ()
			
				curObj.modifiers[#Edit_Poly].ConvertSelection #Vertex #Edge
				subobjectLevel = 2
				curObj.modifiers[#Edit_Poly].ButtonOp #ShrinkSelection
				curObj.modifiers[#Edit_Poly].ButtonOp #ShrinkSelection
			
				max move
			)
		4: (
				curObj.modifiers[#Edit_Poly].SetOperation #ExtrudeFace
				curObj.modifiers[#Edit_Poly].extrudeFaceHeight = 0
				curObj.modifiers[#Edit_Poly].Commit ()
				
				max move
				if (viewport.isWire() == true) then (
					toolMode.coordsys #view
				)else(
					toolMode.coordsys #local
				)
			)
	)
)
)



