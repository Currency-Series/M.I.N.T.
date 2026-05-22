Scriptname DES_CurrencyFramework_BarterExclusion extends ReferenceAlias  
{Excludes a specific actor from bartering in the current custom currency. Place on Alias.}

Import SEA_BarterFunctions 

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Actor Property PlayerRef auto
Formlist Property akSwapLocations auto
MiscObject Property akCurrency auto
Perk Property akPriceMod auto

bool locationInList
;bool ShouldRevertCurrency
;form LastCurrency

;--------------------------------------------------
;UTILITY FUNCTIONS
;--------------------------------------------------

Function CheckLocation(formlist akSwapLocations)
{Utility function to check to see if the Player is in a swapped location.}
	
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
	CheckLocation(akSwapLocations)
	IF locationInList
		SuppressGoldNotifications(false)
		ResetCurrency()
	ENDIF
	RegisterForMenu("Dialogue Menu")
ENDEVENT

;--------------------------------------------------

EVENT OnMenuClose(String MenuName)
	CheckLocation(akSwapLocations)
	IF MenuName == "Dialogue Menu" && locationInList
		CurrencyFunctions.SwapCurrency(akSwapLocations, akPriceMod, akCurrency)
	ENDIF
	UnregisterForMenu("Dialogue Menu")
ENDEVENT

;EVENT OnActivate(ObjectReference akActionRef)
;	IF akActionRef == PlayerRef
;		UnregisterForMenu("BarterMenu")
;		RegisterForMenu("BarterMenu")
;	ENDIF
;ENDEVENT
;
;--------------------------------------------------
;
;EVENT OnMenuOpen(String MenuName)
;	CurrencyFunctions.CurrencyIsSwapping = true
;	CheckLocation(akSwapLocations)
;	IF MenuName == "BarterMenu" && locationInList
;
;		LastCurrency = GetCurrency()
;		ShouldRevertCurrency = False
;		IF (!LastCurrency)
;			ShouldRevertCurrency = True
;		ENDIF
;		ResetCurrency()
;		SuppressGoldNotifications(false)
;	ENDIF
;	CurrencyFunctions.CurrencyIsSwapping = false
;ENDEVENT
;
;--------------------------------------------------
;
;EVENT OnMenuClose(String MenuName)
;	CurrencyFunctions.CurrencyIsSwapping = true
;	CheckLocation(akSwapLocations)
;	IF MenuName == "BarterMenu" && locationInList
;		IF (ShouldRevertCurrency)
;			return
;		ELSE
;			IF (PlayerRef.HasPerk(akPriceMod))
;				PlayerRef.RemovePerk(akPriceMod)
;			ENDIF
;			PlayerRef.AddPerk(akPriceMod)
;			SetCurrency(LastCurrency)
;			SuppressGoldNotifications(true)
;		ENDIF
;	ENDIF
;	CurrencyFunctions.CurrencyIsSwapping = false
;ENDEVENT
