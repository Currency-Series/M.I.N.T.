Scriptname DES_CurrencyFramework_BarterExclusion extends ReferenceAlias  
{Excludes a specific actor from bartering in the current custom currency. Place on Alias.}

Import SEA_BarterFunctions 

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Actor Property PlayerRef auto
Formlist Property akSwapLocations auto
MiscObject Property akCurrency auto
Perk Property akPriceMod auto

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
	CheckLocation(akSwapLocations )
	IF locationInList
		SuppressGoldNotifications(false)
		ResetCurrency()
	ENDIF
	RegisterForMenu("Dialogue Menu")
ENDEVENT

;--------------------------------------------------

EVENT OnMenuClose(String MenuName)
	CheckLocation(akSwapLocations )
	IF MenuName == "Dialogue Menu" && locationInList
		CurrencyFunctions.SwapCurrency(akSwapLocations , akPriceMod, akCurrency)
	ENDIF
	UnregisterForMenu("Dialogue Menu")
ENDEVENT