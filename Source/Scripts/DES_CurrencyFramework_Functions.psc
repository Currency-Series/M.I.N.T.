Scriptname DES_CurrencyFramework_Functions extends Quest
{Shared functions for implementing Currency Swapper mods.}

Import SEA_BarterFunctions 

;--------------------------------------------------
;SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto

;--------------------------------------------------
;SHARED VALUES
;--------------------------------------------------

Bool locationInList

;--------------------------------------------------
;CURRENCY FUNCTIOINS
;--------------------------------------------------

Bool CurrencyIsSwapping
Formlist Property DES_CustomCurrencyLocations auto

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)
;Swaps currency from Gold to the relevant currency. Best placed on a Player ReferenceAlias that checks when the Player changes locations.

	CurrencyIsSwapping = true
	CheckLocation(akSwapLocations)
	IF locationInList
		IF (PlayerREF.HasPerk(akPriceMod))
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
		PlayerREF.AddPerk(akPriceMod)
		SetCurrency(akCurrency)
		SuppressGoldNotifications(true)
	ELSE
		CheckLocation(DES_CustomCurrencyLocations)
		IF !locationInList
			SuppressGoldNotifications(false)
			ResetCurrency()
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
	ENDIF
	CurrencyIsSwapping = false

endFunction

;--------------------------------------------------

Function BarterCustomCurrency(Actor akVendor, Form akCurrency, Perk akPriceMod)
;Swaps currency for a single barter menu. Useful if you only want to swap currency for a single vendor. Place the TIF__CurrencyFramework_Barter script on the sale dialogue line to properly call this function. 

Bool ShouldRevertCurrency
Form LastCurrency

	CurrencyIsSwapping = 1
	LastCurrency = GetCurrency()
	ShouldRevertCurrency = False
	IF (!LastCurrency)
		ShouldRevertCurrency = True
	ELSEIF
	IF (PlayerRef.HasPerk(akPriceMod))
		PlayerRef.RemovePerk(akPriceMod)
	ENDIF
	PlayerRef.AddPerk(akPriceMod)
	SetCurrency(akCurrency)
	akVendor.ShowBarterMenu()
	;Skyrim Souls compatibility
	WHILE (Utility.IsInMenuMode())
		Utility.Wait(0.1)
	ENDWHILE
	;Skyrim Souls compatibility
	IF (ShouldRevertCurrency)
		ResetCurrency()
	ELSE
		SetCurrency(LastCurrency)
	ELSEIF
	PlayerRef.RemovePerk(akPriceMod)
	CurrencyIsSwapping = 0

EndFunction

;--------------------------------------------------

Keyword Property DES_JobExchanger auto
Keyword Property DES_ConverterExclusion auto
GlobalVariable Property DES_ConvertCoins auto
Sound Property ITMGoldUp auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
;Converts all script-added Gold to custom currency while in swapped locations. Useful to ensuring that quest rewards are given in the correct currency.

	IF !akSourceContainer || DES_ConvertCoins.GetValue() > 0
		return
	ELSE
		CheckLocation(akSwapLocations)
		IF locationInList
			IF !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) || Player.GetCurrentLocation().HasKeyword(DES_ConverterExclusion)
				float count = aiItemCount*aiCoinWorth.GetValue()
				PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
				PlayerRef.addItem(akNewCoin, count as int)
			ELSEIF (Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) || Player.GetCurrentLocation().HasKeyword(DES_ConverterExclusion)
				ITMGoldUp.Play(PlayerRef)
				debug.notification(akBaseItem.GetName() + " (" + aiItemCount + ") Added")
			ENDIF
		ENDIF
	ENDIF

endfunction

;--------------------------------------------------

Function ExchangeCoins(Form akOldCoin, int count, Form akNewCoin, GlobalVariable aiCoinWorth, bool divide = false)
;Shared exchange function for use when implementing a currency exchanger. Place the TIF__CurrencyFramework_Exchange, TIF__CurrencyFramework_ExchangeAll, or TIF__CurrencyFramework_ExchangeRoom script on the exchange dialogue line to properly call this function.

	float worth = aiCoinWorth.GetValue()
	float newcount

	IF divide
		newcount = count/worth
	ELSE
		newcount = count*worth
	ENDIF
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
	WHILE(!locationInList && current.GetParent())
		current = current.GetParent()
		locationInList = akSwapLocations.HasForm(current)
	ENDWHILE

endFunction

;--------------------------------------------------
;TUTORIAL
;--------------------------------------------------

Message Property DES_CurrencySwapperTutorialMessage auto

Event OnCustomBarterMenu(Actor a_kSeller)
;Triggers a one-time tutorial pop-up explaining how alternative currencies work.
	ShowTutorialMessage(DES_CurrencySwapperTutorialMessage)
endEvent
