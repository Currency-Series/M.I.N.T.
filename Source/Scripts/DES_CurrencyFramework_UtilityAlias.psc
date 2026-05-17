Scriptname DES_CurrencyFramework_UtilityAlias extends ReferenceAlias  
{Utility script to kick DES_CurrencyFramework_Functions. Not for use elsewhere}

Event OnPlayerLoadGame()
	(GetOwningQuest() as DES_CurrencyFramework_Functions).OnPlayerLoadGame_Alias()
endEvent
