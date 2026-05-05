Scriptname DES_CurrencyFramework_RegisterEvents   extends ReferenceAlias
{Registers all custom Currency Swapper events.}

import SEA_BarterFunctions

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Formlist Property DES_CustomCurrencyLocations auto

Event OnInit()

	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())

	CurrencyFunctions.RevertingList = 1
		DES_CustomCurrencyLocations.Revert()
	CurrencyFunctions.RevertingList = 0

endevent

Event OnPlayerGameLoad()

	SEA_BarterFunctions.RegisterFormForAllEvents(getowningquest())

	CurrencyFunctions.RevertingList = 1
		DES_CustomCurrencyLocations.Revert()
	CurrencyFunctions.RevertingList = 0

endevent
