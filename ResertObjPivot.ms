-- 2016-08-10
-- http://keshon.ru

macroScript ResetObjPivot category:"keshon83" tooltip:"Reset Object Pivot"
(
	if (classof ($) != UndefinedClass) then (
		ResetPivot($)
	)
)