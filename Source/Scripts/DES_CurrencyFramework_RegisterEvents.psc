Scriptname DES_CurrencyFramework_RegisterEvents   extends ReferenceAlias   

import SEA_BarterFunctions

Event OnInit()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
endevent

Event OnPlayerGameLoad()
	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())
endevent