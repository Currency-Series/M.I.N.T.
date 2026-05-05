Scriptname DES_CurrencyFramework_Functions extends Quest conditional
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

Bool locationInList

;--------------------------------------------------
;CURRENCY FUNCTIOINS
;--------------------------------------------------

Formlist Property DES_CustomCurrencyLocationExclusions auto

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)
;Swaps currency from Gold to the relevant currency. Best placed on a Player ReferenceAlias that checks when the Player changes locations.

	CheckLocation(akSwapLocations)
	IF locationInList
		IF (PlayerREF.HasPerk(akPriceMod))
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
		PlayerREF.AddPerk(akPriceMod)
		SetCurrency(akCurrency)
		SuppressGoldNotifications(true)
	ELSE
		CheckLocation(DES_CustomCurrencyLocationExclusions)
		IF !locationInList
			SuppressGoldNotifications(false)
			ResetCurrency()
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
	ENDIF

endFunction

;--------------------------------------------------

Function BarterCustomCurrency(Actor akVendor, Form akCurrency, Perk akPriceMod)
;Swaps currency for a single barter menu. Useful if you only want to swap currency for a single vendor. Place the TIF__CurrencyFramework_Barter script on the sale dialogue line to properly call this function. 

Bool ShouldRevertCurrency
Form LastCurrency

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
Sound Property ITMGoldUp auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
;Converts all script-added Gold to custom currency while in swapped locations. Useful to ensuring that quest rewards are given in the correct currency.

	IF akSourceContainer != NONE
		RETURN
	ELSE
		CheckLocation(akSwapLocations)
		IF locationInList && DES_ConvertCoins.GetValue() > 0
			IF !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion)
				if akBaseItem == Gold001
					float count = aiItemCount*aiCoinWorth.GetValue()
					PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
					PlayerRef.addItem(akNewCoin, count as int)
				endif
			ELSEIF (Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) 
				if akBaseItem == Gold001
					ITMGoldUp.Play(PlayerRef)
					debug.notification(akBaseItem.GetName() + " (" + aiItemCount + ") Added")
				endif
			ENDIF
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
	PlayerRef.RemoveItem(akOldCoin, count)
	PlayerRef.AddItem(akNewCoin, newcount as int)

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

;--------------------------------------------------
;INT VARIABLES
;--------------------------------------------------

int property InJail auto conditional