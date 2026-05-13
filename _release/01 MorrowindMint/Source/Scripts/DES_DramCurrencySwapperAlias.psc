Scriptname DES_DramCurrencySwapperAlias extends ReferenceAlias  

EVENT OnPlayerLoadGame()
	(GetOwningQuest() as DES_DramCurrencySwapper).OnPlayerLoadGame_Alias()
ENDEVENT

EVENT OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as DES_DramCurrencySwapper).OnLocationChange_Alias()
ENDEVENT
