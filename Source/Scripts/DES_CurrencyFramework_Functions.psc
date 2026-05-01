Scriptname DES_CurrencyFramework_Functions extends Quest
{Shared functions for implementing Currency Swapper mods.}

Import SEA_BarterFunctions 

;--------------------------------------------------
;SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto
MiscObject Property Gold001 auto

;--------------------------------------------------
;SHARED VALUES
;--------------------------------------------------

Bool ShouldRevertCurrency
Form LastCurrency
Bool locationInList

;--------------------------------------------------
;CURRENCY FUNCTIOINS
;--------------------------------------------------

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)
;Swaps currency from Gold to the relevant currency. Best placed on a Player ReferenceAlias that checks when the Player changes locations.

	LastCurrency = GetCurrency()
	ShouldRevertCurrency = False
	If (!LastCurrency)
		ShouldRevertCurrency = True
	EndIf
	CheckLocation(akSwapLocations)
	IF locationInList
		IF (PlayerREF.HasPerk(akPriceMod))
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
		PlayerREF.AddPerk(akPriceMod)
		SetCurrency(akCurrency)
		SuppressGoldNotifications(true)
	ELSE
		IF GetCurrency() == akCurrency
			If (ShouldRevertCurrency)
				SuppressGoldNotifications(false)
				ResetCurrency()
			Else
				IF LastCurrency == Gold001
					SuppressGoldNotifications(false)
				ENDIF
				SetCurrency(LastCurrency)
			EndIf
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
	ENDIF

endFunction

;--------------------------------------------------

Function BarterCustomCurrency(Actor akVendor, Form akCurrency, Perk akPriceMod)
;Swaps currency for a single barter menu. Useful if you only want to swap currency for a single vendor. Place the TIF__CurrencyFramework_Barter script on the sale dialogue line to properly call this function. 

	LastCurrency = GetCurrency()
	ShouldRevertCurrency = False
	If (!LastCurrency)
		ShouldRevertCurrency = True
	EndIf
	If (PlayerRef.HasPerk(akPriceMod))
		PlayerRef.RemovePerk(akPriceMod)
	EndIf
	PlayerRef.AddPerk(akPriceMod)
	SetCurrency(akCurrency)
	akVendor.ShowBarterMenu()
	;Skyrim Souls compatibility
	While (Utility.IsInMenuMode())
		Utility.Wait(0.1)
	EndWhile
	;Skyrim Souls compatibility
	If (ShouldRevertCurrency)
		ResetCurrency()
	Else
		SetCurrency(LastCurrency)
	EndIf
	PlayerRef.RemovePerk(akPriceMod)

EndFunction

;--------------------------------------------------

Keyword Property DES_JobExchanger auto
Keyword Property DES_ConverterExclusion auto
GlobalVariable Property DES_ConvertCoins auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
;Converts all script-added Gold to custom currency while in swapped locations. Useful to ensuring that quest rewards are given in the correct currency.
	
	CheckLocation(akSwapLocations)
	IF locationInList
		IF !aksourceContainer && !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_JobExchanger) && !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) && DES_ConvertCoins.GetValue() > 0
			if akBaseItem == Gold001
				float count = aiItemCount*aiCoinWorth.GetValue()
				PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
				PlayerRef.addItem(akNewCoin, count as int)
			endif
		ENDIF
	ENDIF

endfunction

;--------------------------------------------------

Function ExchangeCoins(Form akOldCoin, int count, Form akNewCoin, GlobalVariable aiCoinWorth, bool divide = false)
;Shared exchange function for use when implementing a currency exchanger. Place the TIF__CurrencyFramework_Exchange, TIF__CurrencyFramework_ExchangeAll, or TIF__CurrencyFramework_ExchangeRoom script on the exchange dialogue line to properly call this function.

	float worth = aiCoinWorth.GetValue()
	float newcount

	if divide
		newcount = count/worth
	else
		newcount = count*worth
	endif
	SuppressGoldNotifications(false)
	PlayerRef.RemoveItem(akOldCoin, count)
	PlayerRef.AddItem(akNewCoin, newcount as int)
	SuppressGoldNotifications(true)

endfunction

;--------------------------------------------------
;UTILITY FUNCTIONS
;--------------------------------------------------

Function CheckLocation(formlist akSwapLocations)
;Utility function to check to see if the Player is in a swapped location.
	
	locationInList = false
	Location current = PlayerRef.GetCurrentLocation()
	locationInList = akSwapLocations.HasForm(current)
	while(!locationInList && current.GetParent())
		current = current.GetParent()
		locationInList = akSwapLocations.HasForm(current)
	endWhile

endFunction

;--------------------------------------------------
;TUTORIAL
;--------------------------------------------------

Message Property DES_CurrencySwapperTutorialMessage auto

Event OnCustomBarterMenu(Actor a_kSeller)
;Triggers a one-time tutorial pop-up explaining how alternative currencies work.
	ShowTutorialMessage(DES_CurrencySwapperTutorialMessage)
endEvent
