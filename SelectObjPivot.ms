-- 2016-08-10
-- http://keshon.ru

macroScript SelectObjPivot category:"keshon83" tooltip:"Select Object Pivot"
(
	if (classof ($) != UndefinedClass) then (
		macros.run "Tools" "PivotMode_Toggle"
		max move
		move $ [0,0,0]
	)
)