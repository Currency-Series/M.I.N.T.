Scriptname DES_UlfricCurrencySwapper extends DES_CurrencyFramework_UtilityInt

DES_CurrencyFramework_Functions Property CurrencyFunctions auto

;--------------------------------------------------
;SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto
MiscObject Property DES_Ulfric Auto 

;--------------------------------------------------
;FUNCTIONS
;--------------------------------------------------

Formlist Property DES_CustomCurrencyLocations auto
float goldValue

Function Initialize()

	IF !DES_CustomCurrencyLocations.HasForm(WindhelmLocation)
		DES_CustomCurrencyLocations.AddForm(WindhelmLocation)
	ENDIF

	Int FormID = GetFormID()
	Int HighBytes = Math.LogicalAnd(FormID, 0xFF000000)
	If(HighBytes == 0xFE000000)
		FormID = Math.LogicalAnd(FormID, 0x000FFFFF)
	EndIf
	FormID = Math.LogicalAnd(FormID, 0x00FFFFFF)
	CurrencyFunctions.RegisterModuleQuest("WindhelmUsesUlfrics.esp", FormID)

	goldValue = 1/DES_UlfricWorth.GetValue() as float
	DES_Ulfric.SetGoldValue(goldValue as int)

endFunction

;--------------------------------------------------

Keyword Property CWOwner auto
Location Property WindhelmLocation auto
Location Property SolitudeLocation auto
GlobalVariable Property CWSons auto
GlobalVariable Property CWImperial auto

GlobalVariable Property DES_UlfricWorth auto
GlobalVariable[] Property CostsToUpdate auto
int[] property defaultCosts auto
GlobalVariable Property RoomCost auto
GlobalVariable Property DES_UlfricRoomCost auto
GlobalVariable Property HorseCost auto
GlobalVariable Property DES_UlfricHorseCost auto
Quest property HousePurchase auto

Int Truncated

Function UpdateCosts()

	IF WindhelmLocation.GetKeywordData(CWOwner) == CWImperial.GetValue() as int
		DES_UlfricWorth.SetValue(2)
		goldValue = 1/DES_UlfricWorth.GetValue() as float
		DES_Ulfric.SetGoldValue(goldValue as int)
	ELSEIF SolitudeLocation.GetKeywordData(CWOwner) == CWSons.GetValue() as int
		DES_UlfricWorth.SetValue(1.0)
		goldValue = 1/DES_UlfricWorth.GetValue() as float 
		DES_Ulfric.SetGoldValue(goldValue as int)
	ELSE
		DES_UlfricWorth.SetValue(1.25)
		goldValue = 1/DES_UlfricWorth.GetValue() as float
		DES_Ulfric.SetGoldValue(goldValue as int)
	ENDIF

	int i = 0
	while i < CostsToUpdate.Length
		float UlfricHouseCosts = (defaultCosts[i])*(DES_UlfricWorth.GetValue())
		Truncated = UlfricHouseCosts as int
		If (Truncated < UlfricHouseCosts)
			Truncated += 1
		EndIf
		CostsToUpdate[i].SetValue(Truncated)
		HousePurchase.UpdateCurrentInstanceGlobal(CostsToUpdate[i])
		i += 1
	endwhile

	float UlfricRoomCost = RoomCost.GetValue()*DES_UlfricWorth.GetValue()
	Truncated = UlfricRoomCost as int
	If (Truncated < UlfricRoomCost)
		Truncated += 1
	EndIf
	DES_UlfricRoomCost.SetValue(roomTruncated)
	UpdateCurrentInstanceGlobal(DES_UlfricRoomCost)

	float UlfricHorseCost = HorseCost.GetValue()*DES_UlfricWorth.GetValue()
	Truncated = UlfricHorseCost as int
	If (Truncated < UlfricHorseCost)
		Truncated += 1
	EndIf
	DES_UlfricHorseCost.SetValue(horseTruncated)
	UpdateCurrentInstanceGlobal(DES_UlfricHorseCost)

endFunction

;--------------------------------------------------
;EVENTS
;--------------------------------------------------

Event OnInit()
	Utility.Wait(1)
	Initialize()
EndEvent

;--------------------------------------------------

Function OnPlayerLoadGame_Alias()

	goldValue = 1/DES_UlfricWorth.GetValue() as float
	DES_Ulfric.SetGoldValue(goldValue as int)

endFunction

;--------------------------------------------------

Formlist Property DES_UlfricLocations auto
Perk Property DES_WindhelmPriceAdjustmentPerk auto

Function OnLocationChange_Alias()

	While CurrencyFunctions.CurrencyIsSwapping
		Utility.Wait(0.1)
	endWhile
	UpdateCosts()
	CurrencyFunctions.SwapCurrency(DES_UlfricLocations, DES_WindhelmPriceAdjustmentPerk, DES_Ulfric)

endFunction
