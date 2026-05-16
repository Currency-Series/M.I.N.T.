Scriptname DES_CurrencyFramework_RegisterEvents   extends ReferenceAlias
{Registers all custom Currency Swapper events. Place on Alias.}

import SEA_BarterFunctions

Event OnInit()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
endevent

Event OnPlayerLoadGame()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
endevent
