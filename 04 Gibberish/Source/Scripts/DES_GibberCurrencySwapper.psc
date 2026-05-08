Scriptname DES_GibberCurrencySwapper extends Quest conditional

;--------------------------------------------------
;SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto
MiscObject Property DES_Gibber auto
MiscObject Property DES_GibberBack auto
MiscObject Property DES_GibberFront auto

;--------------------------------------------------
;FUNCTIONS
;--------------------------------------------------

GlobalVariable Property EC_SS_GoldChanceNone auto
GlobalVariable Property EC_SS_GibberChanceNone auto

float value

function Initialize()
	IF EC_SS_GoldChanceNone.getValue() != 100
		EC_SS_GoldChanceNone.setValue(100.0)
	ENDIF
	IF EC_SS_GibberChanceNone.getValue() != 0
		EC_SS_GibberChanceNone.setValue(0.0)
	ENDIF
	PlayerRef.RemoveAllInventoryEventFilters()
	PlayerRef.AddInventoryEventFilter(DES_GibberBack)
	PlayerRef.AddInventoryEventFilter(DES_GibberFront)
	RegisterForMenu("TweenMenu")
	IF PlayerRef.GetItemCount(DES_GibberBack) > 0
		ConvertDementiaGibber(DES_GibberBack)
	ENDIF
	IF PlayerRef.GetItemCount(DES_GibberFront) > 0
		ConvertManiaGibber(DES_GibberFront)
	ENDIF
	IF InDementia == 1
		DES_Gibber.SetWorldModelPath("COIN/GibberBack.nif")
		DES_Gibber.SetGoldValue(DES_GibberBack.GetGoldValue())
	ELSEIF InMania == 1
		DES_Gibber.SetWorldModelPath("COIN/GibberFront.nif")
		DES_Gibber.SetGoldValue(DES_GibberFront.GetGoldValue())
	ENDIF
	IF (Quest.GetQuest("DES_CoinHandler") as DES_DefaultCoins).GibberFrontValue != 1.61803
		Utility.Wait(5)
		(Quest.GetQuest("DES_CoinHandler") as DES_DefaultCoins).GibberFrontValue = 1.61803
	ENDIF
	IF (Quest.GetQuest("DES_CoinHandler") as DES_DefaultCoins).GibberBackValue != 0.99965
		Utility.Wait(5)
		(Quest.GetQuest("DES_CoinHandler") as DES_DefaultCoins).GibberBackValue = 0.99965
	ENDIF
endFunction

;--------------------------------------------------

function ConvertDementiaGibber(Form akBaseItem)
	MiscObject coin = akBaseItem as MiscObject
	int count = PlayerRef.getItemCount(akBaseItem)
	PlayerRef.removeItem(akBaseItem, count, true)
	PlayerRef.addItem(DES_Gibber, count, true)
	DES_Gibber.SetGoldValue(akBaseItem.GetGoldValue())
endfunction

;--------------------------------------------------

function ConvertManiaGibber(Form akBaseItem)
	MiscObject coin = akBaseItem as MiscObject
	int count = PlayerRef.getItemCount(akBaseItem)
	PlayerRef.removeItem(akBaseItem, count, true)
	PlayerRef.addItem(DES_Gibber, count, true)
	DES_Gibber.SetGoldValue(akBaseItem.GetGoldValue())
endFunction

;--------------------------------------------------
;EVENTS
;--------------------------------------------------

Event OnInit()
	Initialize()
endEvent

;--------------------------------------------------

bool defaultPath = true

Event OnMenuOpen(String MenuName)
	IF InMania == 0 && InDementia == 0
		IF MenuName == "TweenMenu"
			IF defaultPath == true
				DES_Gibber.SetWorldModelPath("COIN/GibberBack.nif")
				DES_Gibber.SetGoldValue(DES_GibberBack.GetGoldValue())
				defaultPath = false
			ELSEIF defaultPath == false
				DES_Gibber.SetWorldModelPath("COIN/GibberFront.nif")
				DES_Gibber.SetGoldValue(DES_GibberFront.GetGoldValue())
				defaultPath = true
			ENDIF
		ENDIF
	ENDIF
EndEvent

;--------------------------------------------------

Function OnPlayerLoadGame_Alias()
	Initialize()
endFunction

;--------------------------------------------------

Function OnItemAdded_Alias(form akBaseItem)
	if akBaseItem == DES_GibberBack
		ConvertDementiaGibber(akBaseItem)
	elseif akBaseItem == DES_GibberFront
		ConvertManiaGibber(akBaseItem)
	endIf
endFunction

;--------------------------------------------------
;QUEST VARIABLES
;--------------------------------------------------

Int Property InMania Auto Conditional
Int Property InDementia Auto Conditional