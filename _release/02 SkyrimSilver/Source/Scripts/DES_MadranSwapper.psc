Scriptname DES_MadranSwapper extends ReferenceAlias

Import SEA_BarterFunctions 

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Actor Property PlayerRef auto
Formlist Property DES_UlfricLocations auto
MiscObject Property DES_Ulfric auto
Perk Property DES_WindhelmPriceAdjustmentPerk auto

bool locationInList

;--------------------------------------------------
;UTILITY FUNCTIONS
;--------------------------------------------------

Function CheckLocation(formlist akSwapLocations)
	
	locationInList = false
	Location current = PlayerRef.GetCurrentLocation()
	locationInList = akSwapLocations.HasForm(current)
	WHILE(!locationInList && current.GetParent())
		current = current.GetParent()
		locationInList = akSwapLocations.HasForm(current)
	ENDWHILE

endFunction

;--------------------------------------------------
;EVENTS
;--------------------------------------------------

EVENT OnActivate(ObjectReference akActionRef)
	CheckLocation(DES_UlfricLocations)
	IF locationInList
		SuppressGoldNotifications(false)
		ResetCurrency()
	ENDIF
	RegisterForMenu("Dialogue Menu")
ENDEVENT

;--------------------------------------------------

EVENT OnMenuClose(String MenuName)
	CheckLocation(DES_UlfricLocations)
	IF MenuName == "Dialogue Menu" && locationInList
		CurrencyFunctions.SwapCurrency(DES_UlfricLocations, DES_WindhelmPriceAdjustmentPerk, DES_Ulfric)
	ENDIF
	UnregisterForMenu("Dialogue Menu")
ENDEVENT