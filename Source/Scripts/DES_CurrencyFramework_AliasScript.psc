Scriptname DES_CurrencyFramework_AliasScript extends ReferenceAlias  
{Utility script to kick DES_CurrencyFramework_Functions. Not to use elsewhere}

Event OnPlayerGameLoad()
	(GetOwningQuest() as DES_CurrencyFramework_Functions).CheckModuleQuests()
endEvent