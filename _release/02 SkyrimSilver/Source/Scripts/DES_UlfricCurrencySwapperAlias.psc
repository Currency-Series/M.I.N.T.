Scriptname DES_UlfricCurrencySwapperAlias extends ReferenceAlias  

EVENT OnPlayerLoadGame()
	(GetOwningQuest() as DES_UlfricCurrencySwapper).OnPlayerLoadGame_Alias()
ENDEVENT

EVENT OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as DES_UlfricCurrencySwapper).OnLocationChange_Alias()
ENDEVENT