Scriptname DES_CurrencyFramework_RegisterEvents   extends ReferenceAlias
{Registers all custom Currency Swapper events.}

import SEA_BarterFunctions

Event OnInit()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
endevent

Event OnPlayerGameLoad()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
(GetOwningQuest() as DES_CurrencyFramework_Functions).CheckModuleQuests()
endevent
