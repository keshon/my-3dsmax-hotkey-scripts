-- 2016-07-12
-- http://keshon.ru

macroScript ObjectToggle category:"keshon83" tooltip:"Object Toggle"
(
	curObj = $
	max modify mode
	max select

	if (numSubObjectLevels == 5) do (
		subObjectLevel = 0
		actionMan.executeAction 0 "59232"-- Rectangle Selection
	)
	if (numSubObjectLevels == 3) do (
		subObjectLevel = 0 
		actionMan.executeAction 0 "59232"-- Rectangle Selection
	)
)