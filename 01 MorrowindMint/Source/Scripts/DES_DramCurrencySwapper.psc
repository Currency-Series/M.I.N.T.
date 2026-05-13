Scriptname DES_DramCurrencySwapper  extends DES_CurrencyFramework_UtilityInt Conditional

DES_CurrencyFramework_Functions Property CurrencyFunctions auto

;--------------------------------------------------
;SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto
MiscObject Property DES_Dram Auto 

;--------------------------------------------------
;FUNCTIONS
;--------------------------------------------------

FormList Property DES_CustomCurrencyLocations Auto
Location Property DLC2RavenRockLocation auto
Location Property DLC2TelMithrynLocation auto

Function Initialize()

	IF !DES_CustomCurrencyLocations.HasForm(DLC2RavenRockLocation)
		DES_CustomCurrencyLocations.AddForm(DLC2RavenRockLocation)
	ENDIF

	IF !DES_CustomCurrencyLocations.HasForm(DLC2TelMithrynLocation)
		DES_CustomCurrencyLocations.AddForm(DLC2TelMithrynLocation)
	ENDIF

	Int FormID = GetFormID()
	Int HighBytes = Math.LogicalAnd(FormID, 0xFF000000)
	If(HighBytes == 0xFE000000)
		FormID = Math.LogicalAnd(FormID, 0x000FFFFF)
	EndIf
	FormID = Math.LogicalAnd(FormID, 0x00FFFFFF)
	CurrencyFunctions.RegisterModuleQuest("MorrowindUsesDrams.esp", formid)

	IF Game.IsPluginInstalled("WindhelmUsesUlfrics.esp")
		DES_UlfricChanceNone.SetValue(0)
	ENDIF

endFunction

;--------------------------------------------------

GlobalVariable Property RoomCost auto  
GlobalVariable Property DES_DramRoomCost auto  
GlobalVariable Property DES_UlfricChanceNone auto  
globalvariable property DES_DramWorth auto

Function UpdateCosts()
	float DramRoomCost = RoomCost.GetValue()*DES_DramWorth.GetValue()
	Int roomTruncated = DramRoomCost as int
	If (roomTruncated < DramRoomCost)
		roomTruncated += 1
	EndIf
	DES_DramRoomCost.SetValue(roomTruncated)
	UpdateCurrentInstanceGlobal(DES_DramRoomCost)
	Ulfric = (Quest.GetQuest("DES_UlfricWindhelmServices")).GetStage()
endFunction

;--------------------------------------------------
;EVENTS
;--------------------------------------------------

EVENT OnInit()
	Utility.Wait(1)
	Initialize()
ENDEVENT

;--------------------------------------------------

Function OnPlayerLoadGame_Alias()

	IF Game.IsPluginInstalled("WindhelmUsesUlfrics.esp")
		DES_UlfricChanceNone.SetValue(0)
	ENDIF

endFunction

;--------------------------------------------------

Formlist Property DES_DramLocations auto
Perk Property DES_MorrowindPriceAdjustmentPerk auto

Function OnLocationChange_Alias()

	While CurrencyFunctions.CurrencyIsSwapping
		Utility.Wait(0.1)
	endWhile
	UpdateCosts()
	CurrencyFunctions.SwapCurrency(DES_DramLocations, DES_MorrowindPriceAdjustmentPerk, DES_Dram)

	if IsStageDone(0)
		if !PlayerRef.IsInLocation(DLC2RavenRockLocation)
			SetStage(6)
		endif
	endif

endFunction

;--------------------------------------------------
;QUEST VARIABLES
;--------------------------------------------------

Int Property Trespassing Auto Conditional
Int Property Ulfric Auto Conditional