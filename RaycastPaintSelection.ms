macroScript RaycastPaintSelection category:"keshon83" tooltip:"Raycast Paint Selection" 
(
/********************************************************************************************/
/*																							*/
/* PaintSelector v.0.97a	   	(c) 2006 by Serg (drFlash) Khatenkov						*/
/*																							*/
/* Options:																					*/
/*																							*/
/* "PaintSelector" : Start/Stop Painting													*/
/* "CTRL" : add to selection																*/
/* "ALT" : remove from selection															*/
/* "SHIFT+CTRL" : change brush size															*/
/*																							*/
/* You can map the "PaintSelector" button to a hotkey										*/
/*																							*/
/* Use at your own risk!																	*/
/*																							*/
/* mailto:drflash@mail.ru																	*/
/*******************************************************************************************/
-- original file name was drFlashTools-PaintSelection.mcr

local curObj = undefined
local curVertSel = #{}
local curEdgeSel = #{}
local curFaceSel = #{}
local firstpoint = undefined
local oldvert = undefined
local newVerts = #{}
local oldHitList = #{}
local SS = undefined
local GS = undefined
local GV = undefined
local gVuE = undefined
local gVuF = undefined
local gEuV = undefined
local gFuV = undefined
local GetClosestPoint = undefined
local GNE = undefined
local oldpface = 0
local VertextoEdge = undefined

fn VertextoEdge_editablepoly vertsel = (
	edgesel = gEuV curObj vertsel
	esel = #{}
	for i=1 to edgesel.numberset do (
		edgeverts = polyOp.getEdgeVerts curObj (edgesel as array)[i]
		if vertsel[edgeverts[1]] and vertsel[edgeverts[2]] then esel[((edgesel as array)[i])] = true
	)
	esel
)

fn VertextoEdge_edit_poly vertsel = (
	edgesel = gEuV curObj vertsel
	esel = #{}
	for i=1 to edgesel.numberset do (
		edgevert1 = curObj.Edit_poly.GetEdgeVertex (edgesel as array)[i] 1
		edgevert2 = curObj.Edit_poly.GetEdgeVertex (edgesel as array)[i] 2
		if vertsel[edgevert1] and vertsel[edgevert2] then esel[((edgesel as array)[i])] = true
	)
	esel
)
	
fn GetClosestPoint_Edit_Poly faceverts localhit worldhit radius &newvert &newvertindex = (
	b = radius
	tmp = undefined
	newvert = undefined
	for i = 1 to faceVerts.numberset do (
		tmp = GV ((faceVerts as array)[i])
		c = (distance localHit tmp)
		if (c <= radius) and (c <= b) then (
			newVert = tmp
			newVertindex = (faceVerts as array)[i]
			b = c
		)
	)
)

fn GetClosestPoint_Editable_Poly faceverts localhit worldhit radius &newvert &newvertindex = (
	b = radius
	tmp = undefined
	newvert = undefined
	for i = 1 to faceVerts.numberset do (
		tmp = GV ((faceVerts as array)[i])
		c = (distance worldHit tmp)
		if (c <= radius) and (c <= b) then (
			newVert = tmp
			newVertindex = (faceVerts as array)[i]
			b = c
		)
	)
)

fn SS_editable_poly sellevel selection = (
	case sellevel of
	(   
		#Vertex: polyop.SetVertSelection curObj selection
		#Edge: polyop.SetEdgeSelection curObj selection
		#Face: polyop.SetFaceSelection curObj selection
	)
)

fn GS_editable_poly sellevel = (
	case sellevel of
	(   
		#Vertex: polyop.GetVertSelection curObj
		#Edge: polyop.GetEdgeSelection curObj
		#Face: polyop.GetFaceSelection curObj
	)
)

fn gVuE_edit_poly obj edgesel = (
	a = #{} 
	for i = 1 to edgesel.numberset do(
		a[obj.Edit_Poly.GetEdgeVertex (edgesel as array)[i] 1]= true
		a[obj.Edit_Poly.GetEdgeVertex (edgesel as array)[i] 2]= true
	)
	a
)

fn gVuF_edit_poly obj facesel =
(
	a = #{} 
	for y = 1 to facesel.numberset do (
		b = curObj.Edit_Poly.GetFaceDegree (facesel as array)[y]
		for i = 1 to b do a[obj.Edit_Poly.GetFaceVertex (facesel as array)[y] i]= true
	)
	a
)

fn gEuV_edit_poly obj vertsel = (
	a = #{} 
	for i = 1 to vertsel.numberset do (
		for y = 1 to obj.Edit_Poly.GetVertexEdgeCount (vertsel as array)[i] do
		a[obj.Edit_Poly.GetVertexEdge (vertsel as array)[i] y]= true
	)
	a
)

fn gFuV_edit_poly obj vertsel = (
	a = #{} 
	for i = 1 to vertsel.numberset do (
		for y = 1 to obj.Edit_Poly.GetVertexFaceCount (vertsel as array)[i] do 
		a[obj.Edit_Poly.GetVertexFace (vertsel as array)[i] y] = true
	)
	a
)


fn GV_editable_poly vertind = (
	polyOp.getVert curObj vertind
)

fn GEV_edit_poly curobj edgeID= 
(
	a = curObj.Edit_Poly.GetEdgeVertex edgeId 1
	b = curObj.Edit_Poly.GetEdgeVertex edgeId 2
	c = #(a,b) 
	d = c as bitarray
)

fn initcomm =
(
	if ClassOf curObj == Editable_Poly then
	(
		SS = SS_editable_poly
		GS = GS_editable_poly
		GV = GV_editable_poly
		gVuE = polyOp.getVertsUsingEdge
		gVuF = polyOp.getVertsUsingFace
		gEuV = polyOp.getEdgesUsingVert
		gFuV = polyOp.getFacesUsingVert
		GetClosestPoint = GetClosestPoint_Editable_Poly
		GNE = (polyop.GetNumEdges curObj)
		VertextoEdge = VertextoEdge_editablepoly
	 )
	 else if curObj.modifiers[#Edit_Poly] != undefined do  (
		SS = curObj.Edit_Poly.SetSelection
		GS = curObj.Edit_Poly.GetSelection
		GV = curObj.Edit_Poly.GetVertex
		gVuE = gVuE_edit_poly
		gVuF = gVuF_edit_poly
		gEuV = gEuV_edit_poly
		gFuV = gFuV_edit_poly
		GetClosestPoint = GetClosestPoint_Edit_Poly
		GNE = (polyop.GetNumEdges curObj)
		VertextoEdge = VertextoEdge_edit_poly
	)
)

fn fastway &edges startP endP =(
	curPoint = #{startP}
	curVerts = curPoint
	tcur = GV startP
	do (
		b = 520
		testPoints = gVuE curObj (gEuV curObj curPoint)
		testPoints = testPoints- curPoint
		tcur = GV (curPoint as array)[1]
		d = distance tcur endP
		for i = 1 to testPoints.numberset do (
			temp = GV (testPoints as array)[i]
			V1 = normalize(endP - tcur)
			V2 = normalize(temp - tcur)
			a = distance endP temp
			theAngle = acos (dot v1 v2)
			if theAngle <= b and a <= d then (
				curPoint = #{(testPoints as array)[i]}
				b = theAngle
			)
		)

		curVerts[(curPoint as array)[1]] = true
	) while b != 520
	edges = Vertextoedge curVerts
)


function startStroke = (
	thePainterInterface.undoStart()
	firstPoint = undefined
	oldvert = undefined
	oldpface = 0
	oldHitList = #{}
	curVertSel = (GS #Vertex)
	curEdgeSel = (GS #Edge)
	curFaceSel = (GS #Face)
	if keyboard.altPressed != true and keyboard.shiftPressed != true and keyboard.controlPressed != true then 
	case subobjectLevel of
	(
		1: curVertSel = #{}
		2: curEdgeSel = #{}
		4: curFaceSel = #{}
	)
	SS #Vertex curVertSel
	SS #Edge curEdgeSel
	SS #Face curFaceSel
)
		
function paintStroke = (
		/*if subobjectLevel == 4 do if keyboard.shiftPressed then 
		( 
			hitList = thePainterInterface.GetPointGatherHits curObj
			if oldhitlist.numberset != hitlist.numberset then ( 
				a = hitlist-oldhitlist
				newFaceSel = gFuV curObj a
				curFaceSel= curFaceSel + newFaceSel
				SS #Face curFaceSel
				oldhitlist = hitList
			) 
		)	
		else ( 
			hit = thePainterInterface.getTestHit mouse.pos
			if hit do
			( 
				bcoords = [0,0,0]
				pface = 0
				thePainterInterface.getCustomHitFaceData &bcoords &pface curObj
				if oldpface != pface then (
					oldpface = pface
					faceVerts = meshop.getVertsUsingFace curObj.mesh #{pface}
					a = gFuV curObj #{(faceverts as array)[1]}
					aa = gFuV curObj #{(faceverts as array)[2]}
					aaa = gFuV curObj #{(faceverts as array)[3]}
					newFaces = (a * aa) * aaa
					if keyboard.altPressed then	curFaceSel = curFaceSel - newFaces else curFaceSel = curFaceSel + newFaces
					if oldhitlist.numberset != curfacesel.numberset then (
						oldhitlist = curfacesel
						SS #Face curFaceSel
					)
				)
			)
		)*/
		if subobjectLevel == 4 do ( 
			hit = thePainterInterface.getTestHit mouse.pos
			if hit do
			( 
				bcoords = [0,0,0]
				pface = 0
				thePainterInterface.getCustomHitFaceData &bcoords &pface curObj
				if oldpface != pface then (
					oldpface = pface
					faceVerts = meshop.getVertsUsingFace curObj.mesh #{pface}
					a = gFuV curObj #{(faceverts as array)[1]}
					aa = gFuV curObj #{(faceverts as array)[2]}
					aaa = gFuV curObj #{(faceverts as array)[3]}
					newFaces = (a * aa) * aaa
					if keyboard.controlPressed then	curFaceSel = curFaceSel - newFaces else curFaceSel = curFaceSel + newFaces
					if oldhitlist.numberset != curfacesel.numberset then (
						oldhitlist = curfacesel
						SS #Face curFaceSel
					)
				)
			)
		)
		if subobjectLevel == 1 do
		(
			hitList = thePainterInterface.GetPointGatherHits curObj
			if keyboard.controlPressed then	curVertSel = curVertSel - hitList else curVertSel = curVertSel + hitList
			if oldhitlist.numberset != curvertsel.numberset then (
				SS #Vertex curVertSel
				oldhitlist = curvertsel
			)
		)
		if subobjectLevel == 2 do 
		(
			hit = thePainterInterface.getTestHit mouse.pos
			if hit do
			(
				bcoords = [0,0,0]
				pface = 0
				localHit = [0,0,0]
				localNormal = [0,0,0]
				worldHit = [0,0,0]
				worldNormal = [0,0,0]
				radius = 0
				str= 0
				newVerts = #{}
				thePainterInterface.getCustomHitFaceData &bcoords &pface curObj
				thePainterInterface.getHitPointData &localHit &localNormal &worldHit &worldNormal &radius &str 0
				faceVerts = meshop.getVertsUsingFace curObj.mesh #{pface}
				GetClosestPoint faceverts localHit worldHit radius &newvert &newvertindex
				if keyboard.shiftPressed then (
					if newVert != undefined then (
						if firstPoint == undefined then firstPoint = newVertindex else if newVert != oldVert then (
							oldVert = newVert
							fastway &edges firstPoint newVert 
							if edges != undefined then (
								tEdgeSel= curEdgeSel+ edges
								SS #Edge tEdgeSel
							)
						)
					)
				)
				else (
					if newVert != undefined then if firstpoint == undefined then firstPoint = newVertindex else if firstpoint != newvertindex then (
						toopoint = #{firstpoint,newVertindex}
						firstpoint = newVertindex
						newVert = undefined
						newEdgeSel = Vertextoedge toopoint
						if keyboard.altPressed then	curEdgeSel = curEdgeSel - newEdgeSel else
						curEdgeSel = curEdgeSel + newEdgeSel
						if curedgesel.numberset != oldhitlist.numberset then
						oldhitlist = curedgesel
						SS #Edge curEdgeSel
					)
				)
			)
	)
)

function endStroke = (
	thePainterInterface.undoAccept()
)

function systemEnd = (
thePainterInterface.endPaintSession()
)

function cancelStroke = (
	thePainterInterface.undoCancel()
)


on isChecked return thepainterinterface.inPaintMode()
on execute do
(
	curObj = $
	if (curObj != undefined) then (
		if (subobjectLevel == 4 or subobjectLevel == 2 or subobjectLevel == 1) then (
			if (thepainterinterface.inPaintMode() != true) then (
				--curObj = $
				initcomm ()
				max modify mode
				curFaceSel = GS #Face
				curVertSel = GS #Vertex
				curEdgeSel = GS #Edge
				oldHitList = #{}
				thePainterInterface.ScriptFunctions startStroke paintStroke endStroke cancelStroke systemEnd
				thePainterInterface.initializeNodes 0 curObj
				thePainterInterface.updateonMouseUp = false
				thePainterInterface.pointGatherEnable = true
				thePainterInterface.drawRing = true
				thePainterInterface.drawNormal = false
				thePainterInterface.drawTrace = false
				thePainterInterface.markerEnable = false
				thePainterInterface.maxsize = 5
				thePainterInterface.maxstr = 1
				thePainterInterface.treeDepth = 2
				thePainterInterface.PressureEnable = false
				thePainterInterface.MirrorEnable = false
				thePainterInterface.StartPaintSession()
			)
			else (
				thePainterInterface.endPaintSession()
			)
		)
	)
)
)
