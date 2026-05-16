Scriptname DES_CurrencyFramework_Tutorial extends Quest  
{Prompts a one-time tutorial pop-up explaining how alternative currencies work the first time the Player vends with them. Place on Quest,}

Import SEA_BarterFunctions 

MiscObject Property akCurrency auto
Message Property akTutorialMsg auto

Event OnCustomBarterMenu(Actor a_kSeller)
	IF GetCurrency() == akCurrency
		ShowTutorialMessage(akTutorialMsg)
	ENDIF
endEvent