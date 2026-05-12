Scriptname DES_CurrencyFramework_Functions extends DES_CurrencyFramework_UtilityInt
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
int Truncated
string[] ModuleFilenames
int[] ModuleFormIDs

;--------------------------------------------------
;CURRENCY FUNCTIOINS
;--------------------------------------------------

Bool Property CurrencyIsSwapping auto
Formlist Property DES_CustomCurrencyLocations auto

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)
;Swaps currency from Gold to the relevant currency. Best placed on a Player ReferenceAlias that checks when the Player changes locations.

	CurrencyIsSwapping = true
	CheckLocation(akSwapLocations)
	IF locationInList && akCurrency != GetCurrency()
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
	ENDIF
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
	ENDIF
	PlayerRef.RemovePerk(akPriceMod)
	CurrencyIsSwapping = 0

EndFunction

;--------------------------------------------------

Keyword Property DES_ConverterExclusion auto
GlobalVariable Property DES_ConvertCoins auto
Sound Property ITMGoldUp auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
;Converts all script-added Gold to custom currency while in swapped locations. Useful to ensuring that quest rewards are given in the correct currency.

	IF akSourceContainer || DES_ConvertCoins.GetValue() <= 0
		return
	ELSE
		CheckLocation(akSwapLocations)
		IF locationInList
			IF !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) && !PlayerRef.GetCurrentLocation().HasKeyword(DES_ConverterExclusion)
				float count = aiItemCount*aiCoinWorth.GetValue()
				PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
				PlayerRef.addItem(akNewCoin, count as int)
			ELSEIF (Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) || PlayerRef.GetCurrentLocation().HasKeyword(DES_ConverterExclusion)
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
	Truncate(newcount)
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

Function Truncate(float accurateValue)

Truncated = accurateValue * 10.0
Truncated = Truncated / 10
If (Truncated < accurateValue)
  Truncated -= 1
EndIf

endFunction

;--------------------------------------------------

function RegisterModuleQuest(string filename, int formid)
;Builds an array to check the Player's installed M.I.N.T. modules.

	int i = 0
	while (i < ModuleFilenames.length && ModuleFilenames[i] != "")
		IF ModuleFilenames[i] == filename
			return
		ENDIF
		i += 1
	endWhile
	
	ModuleFilenames[i] = filename
	ModuleFormIds[i] = formid

endFunction

;--------------------------------------------------

function CheckModuleQuests()
;Checks arrays to see if the Player uninstalled any M.I.N.T. modules.

	bool ShouldRevertList

	ShouldRevertList = false
	int i = 0
	while(i < ModuleFilenames.Length)
		string mfile = ModuleFilenames[i]
		if (mfile != "" && !Game.IsPluginInstalled(mfile))
			ModuleFilenames[i] = ""
			ModuleFormIds[i] = 0
			ShouldRevertList = true
		endIf
		i += 1
	endWhile
	if ShouldRevertList
		;find bounding indices
		int firstBlankIndex = ModuleFilenames.length
		int lastFullIndex = -1
		i = 0
		while(ModuleFilenames[i] != "" && i < ModuleFilenames.length)
			i += 1
		endWhile
		firstBlankIndex = i
		i = ModuleFilenames.length - 1
		while(ModuleFilenames[i] == "" && i > firstBlankIndex)
			i -= 1
		endWhile
		lastFullIndex = i
		;compact array
		while(firstBlankIndex < lastFullIndex)
			ModuleFilenames[firstBlankIndex] = ModuleFilenames[lastFullIndex]
			ModuleFormIds[firstBlankIndex] = ModuleFormIds[lastFullIndex]
			ModuleFilenames[lastFullIndex] = ""
			ModuleFormIds[lastFullIndex] = 0
			while(ModuleFilenames[firstBlankIndex] != "" && firstBlankIndex < ModuleFilenames.length)
				firstBlankIndex  += 1
			endWhile
			while(ModuleFilenames[lastFullIndex] == "" && lastFullIndex > firstBlankIndex)
				lastFullIndex -= 1
				endWhile
		endWhile
		;revert
		DES_CustomCurrencyLocations.Revert()
		;re-register
		i = 0
		while(i < ModuleFilenames.Length)
			if ModuleFilenames[i] != "" && Game.IsPluginInstalled(ModuleFilenames[i])
				(Game.GetFormFromFile(ModuleFormIds[i], ModuleFilenames[i]) as DES_CurrencyFramework_UtilityInt).Initialize()
			endIf
			i += 1
		endWhile
	endIf

endFunction

;--------------------------------------------------
;EVENTS
;--------------------------------------------------

Event OnInit()

	ModuleFilenames = new string[128]
 	ModuleFormIDs = new int[128]

endEvent

;--------------------------------------------------

function OnPlayerLoadGame_Alias()

	CheckModuleQuests()

endFunction
