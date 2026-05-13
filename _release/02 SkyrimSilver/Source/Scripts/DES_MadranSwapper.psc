Scriptname DES_MadranSwapper extends ReferenceAlias

Import SEA_BarterFunctions 

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Formlist Property DES_UlfricLocations auto
MiscObject Property DES_Ulfric auto
Perk Property DES_WindhelmPriceAdjustmentPerk auto

Bool locationInList

EVENT OnActivate(ObjectReference akActionRef)
	CurrencyFunctions.CheckLocation(DES_UlfricLocations)
	IF locationInList
		SuppressGoldNotifications(false)
		ResetCurrency()
	ENDIF
	RegisterForMenu("Dialogue Menu")
ENDEVENT

EVENT OnMenuClose(String MenuName)
	CurrencyFunctions.CheckLocation(DES_UlfricLocations)
	IF MenuName == "Dialogue Menu" && locationInList
		CurrencyFunctions.SwapCurrency(DES_UlfricLocations, DES_WindhelmPriceAdjustmentPerk, DES_Ulfric)
	ENDIF
	UnregisterForMenu("Dialogue Menu")
ENDEVENT
