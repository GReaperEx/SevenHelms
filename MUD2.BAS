'IF YOU WANT TO TAKE A SECTION OF NUMBERS PLACE PURPOSE IN PLACE OF ?
'0-20 BATTLE
'21-25 Character creation
'26 EqArmour
'27-199 ?
'200-390 Act 1 - Encampment, labyrinth Lvl 1
'400-499 Equip LH, Equip RH, Equip Armour, PurchaseSamael
'500-699 Act 1 -labyrinth Lvl 2, labyrinth Lvl 3
'700-899 ?
'900-1999 ?
'2000+ BATTLE

#Lang "qb"

'$DYNAMIC

CONST FALSE = 0
CONST TRUE = 1

DECLARE SUB XanathusWorldFlee ()
DECLARE SUB XanathusAI ()
DECLARE SUB XanathusFlee ()
DECLARE SUB XanathusTaunt ()
DECLARE SUB XanathusBattle ()
DECLARE SUB Act1Pt2 ()
DECLARE SUB GetSaveLoadPos ()
DECLARE SUB SaveToSavegame ()
DECLARE FUNCTION ENEMYHPSBONUS% ()
DECLARE SUB RANDOMSTRING ()
DECLARE SUB displayequip ()
DECLARE SUB displayinventory ()
DECLARE SUB displaystats ()
DECLARE SUB EQlh ()
DECLARE SUB EQrh ()
DECLARE SUB EqArmour ()
DECLARE SUB HELP ()
DECLARE SUB ACT1 ()
DECLARE SUB BATTLE ()
DECLARE SUB EXPERIENCE2000 ()
DECLARE SUB ACTSELECT ()
DECLARE SUB CHARCREATE ()
DECLARE SUB PurchaseSamael ()
DECLARE SUB WorldHelp ()
DECLARE SUB Credits ()
DECLARE SUB EXPERIENCE1000 ()
DECLARE SUB JACOB1000 ()
DECLARE SUB AIProtocols ()
DECLARE SUB combat ()
DECLARE SUB PreSave ()
DECLARE SUB Preload ()
DECLARE SUB LoadGame ()
DECLARE SUB MainMenu ()
DECLARE SUB SaveGame ()
DECLARE SUB jacobstats ()
DECLARE SUB JACOB2000 ()
DECLARE SUB EqHead ()
DECLARE SUB USEOWLSPELL ()
DECLARE SUB CLASSBONUS ()
DECLARE SUB OWLSPELL ()
DECLARE SUB AI ()
DECLARE SUB Runes ()
DECLARE SUB RANDOMRUNEDROP ()
DECLARE SUB MAGIC ()
Declare SUB EXPERIENCELVLUP ()
DECLARE SUB A56GetHint ()
DECLARE SUB ExamineSymbol ()
DECLARE SUB BATTLE2 ()
DECLARE SUB NecrotaliaFight ()
DECLARE SUB NecrotaliaBattle ()
DECLARE SUB NecrotaliaAI ()
Declare SUB EndGameCutscene ()
DECLARE SUB EndGame ()
DECLARE SUB GemPuzzle ()
DECLARE SUB SoundTest ()
DECLARE SUB GameIntro ()
DECLARE SUB CheckRunes (rune$)
DECLARE SUB ClearFlags ()
DECLARE SUB Options ()
DECLARE SUB BardMusic ()
DECLARE SUB Steal ()
DECLARE SUB ReturnWeapon ()
DECLARE SUB FamiliarCall ()
DECLARE SUB ToadSteal ()
DECLARE SUB CallFamiliar ()

DECLARE SUB VampireBeaten ()
DECLARE FUNCTION EnemyKilled () AS INTEGER
DECLARE SUB ColorPrint (outputColor%, outputStr$)
DECLARE SUB InitGlobals ()

'Game Required
DIM SHARED Operation$
DIM SHARED SavePos%
DIM SHARED SavedGame%
DIM SHARED LoadedGame%
DIM SHARED GameOn%
DIM SHARED Protocol%
DIM SHARED WillsSoundEffectVolume%
DIM SHARED WillsMusicVolume%
DIM SHARED Diff%

TYPE SaveInfo
    playerName  AS STRING
    playerClass AS STRING
    savePoint   AS INTEGER
END TYPE

DIM SHARED SaveSlots(0 TO 9) AS SaveInfo
DIM SHARED slotsInUse%

' SHARING CHARACTER VALUES
DIM SHARED JustLoaded%
DIM SHARED Name$
DIM SHARED VIT%
DIM SHARED STR%
DIM SHARED ENG%
DIM SHARED DEX%
DIM SHARED HPS%
DIM SHARED Gold&
DIM SHARED EXPR%
DIM SHARED LH$
DIM SHARED RH$
DIM SHARED Armour$
DIM SHARED DAMAGEADDED%
DIM SHARED Sex$
DIM SHARED DamageLostArmour%
DIM SHARED DamageLostHelm%
DIM SHARED ShieldSave%

DIM SHARED Expertise%

DIM SHARED Helm$
DIM SHARED STRO%
DIM SHARED DEXO%
DIM SHARED VITO%
DIM SHARED ENGO%
DIM SHARED LHO$

CONST CLASS_MAGE    = 1
CONST CLASS_FIGHTER = 2
CONST CLASS_ROGUE   = 3
CONST CLASS_THIEF   = 4
CONST CLASS_BARD    = 5

'Familiar Stuff
DIM SHARED Familiar$
DIM SHARED FAMILIARHP%
DIM SHARED FamiliarHPS%
DIM SHARED FAMILIARDAMAGE%
DIM SHARED Owl%
DIM SHARED OWLSPELLE$
DIM SHARED LEARNOWLSPELL$
DIM SHARED ALE%
DIM SHARED PlayerReflect%
DIM SHARED FamiliarCalled%
DIM SHARED MP%
DIM SHARED MPS%

'USED FOR STATS DO NOT REMOVE
DIM SHARED Lvl%
DIM SHARED HP%
DIM SHARED Class$

' RUNE STUFF
DIM SHARED RANDOMRUNE$
DIM SHARED RUNE$
DIM SHARED RUNE1$
DIM SHARED RUNE2$
DIM SHARED RUNE3$
DIM SHARED RuneError%

' ENEMY STUFF
DIM SHARED ENEMYPTS%
DIM SHARED ENEMY$
DIM SHARED Ethereal%
DIM SHARED Undead%

' SHARING CHARACTER INVENTORY (DO NOT REMOVE)

TYPE InventoryItem
    name AS STRING
    value AS SINGLE

    buyPrice AS INTEGER
    sellPrice AS INTEGER

    amount AS INTEGER
    itemType AS INTEGER
    equipType AS INTEGER
END TYPE

CONST ITEM_TYPE_SWORD       = 0
CONST ITEM_TYPE_SWORD_PLUS  = 1
CONST ITEM_TYPE_STAFF       = 2
CONST ITEM_TYPE_SHIELD      = 3
CONST ITEM_TYPE_ARMOUR      = 4
CONST ITEM_TYPE_POTION      = 5
CONST ITEM_TYPE_HELM        = 6
CONST ITEM_TYPE_RUNE        = 7
CONST ITEM_TYPE_QITEM       = 8

CONST EQUIP_WEAPON  = 1
CONST EQUIP_SHIELD = 2
CONST EQUIP_ARMOUR = 3
CONST EQUIP_HELM   = 4

DIM SHARED Equipment(0 TO 4) AS STRING

DIM SHARED Inventory(0 TO 90) AS InventoryItem
'Swords
CONST ITEM_SHORT_SWORD              = 0
CONST ITEM_LONG_SWORD               = 1
CONST ITEM_BASTARD_SWORD            = 2
CONST ITEM_BATTLE_BLADE             = 3
CONST ITEM_GREAT_SWORD              = 4
CONST ITEM_GREAT_BATTLE_BLADE       = 5
CONST ITEM_HOLY_SWORD               = 6
CONST ITEM_SWORD_PLUS_ONE           = 7
CONST ITEM_SWORD_PLUS_TWO           = 8
CONST ITEM_SWORD_PLUS_THREE         = 9
CONST ITEM_SWORD_PLUS_FOUR          = 10
CONST ITEM_SWORD_PLUS_FIVE          = 11
CONST ITEM_AVENGER_SWORD_PLUS_SEVEN = 12
'Staves
CONST ITEM_SHORT_STAFF = 13
CONST ITEM_LONG_STAFF  = 14
'Shields
CONST ITEM_BUCKLER           = 15
CONST ITEM_SMALL_SHIELD      = 16
CONST ITEM_LARGE_SHIELD      = 17
CONST ITEM_HOLY_SHIELD       = 18
CONST ITEM_SHIELD_PLUS_ONE   = 19
CONST ITEM_SHIELD_PLUS_TWO   = 20
CONST ITEM_SHIELD_PLUS_THREE = 21
CONST ITEM_SHIELD_PLUS_FOUR  = 22
CONST ITEM_SHIELD_PLUS_FIVE  = 23
'Armour
CONST ITEM_RAGS                = 24
CONST ITEM_SURCOAT             = 25
CONST ITEM_ROBES_UPPER         = 26
CONST ITEM_ROBES_LOWER         = 27
CONST ITEM_QUILTED_ARMOUR      = 28
CONST ITEM_LEATHER_ARMOUR      = 29
CONST ITEM_HARD_LEATHER_ARMOUR = 30
CONST ITEM_STUDDED_LEATHER     = 31
CONST ITEM_RING_MAIL           = 32
CONST ITEM_CHAIN_MAIL          = 33
CONST ITEM_SCALE_MAIL          = 34
CONST ITEM_BANDED_MAIL         = 35
CONST ITEM_BREAST_PLATE        = 36
CONST ITEM_BANDED_PLATE_MAIL   = 37
CONST ITEM_FIELD_PLATE_MAIL    = 38
CONST ITEM_FIELD_PLATE         = 39
CONST ITEM_LIGHT_PLATE_MAIL    = 40
CONST ITEM_LIGHT_PLATE         = 41
CONST ITEM_GOTHIC_PLATE_MAIL   = 42
CONST ITEM_GOTHIC_PLATE        = 43
CONST ITEM_HEAVY_PLATE_MAIL    = 44
CONST ITEM_HEAVY_PLATE         = 45
CONST ITEM_ANCIENT_ARMOUR      = 46
CONST ITEM_MYTHRIL_MAIL        = 47
'Potions
CONST ITEM_POTION = 48
'Helms
CONST ITEM_CAP                  = 49
CONST ITEM_SKULL_CAP            = 50
CONST ITEM_HELM                 = 51
CONST ITEM_FULL_HELM            = 52
CONST ITEM_GREAT_HELM           = 53
CONST ITEM_GREAT_HELM_HORNED    = 54
CONST ITEM_MYTHRIL_DWARVEN_HELM = 55
'Runes
CONST RUNE_KEN  = 56
CONST RUNE_WAK  = 57
CONST RUNE_YOO  = 58
CONST RUNE_TOG  = 59
CONST RUNE_WIR  = 60
CONST RUNE_GNU  = 61
CONST RUNE_POA  = 62
CONST RUNE_RER  = 63
CONST RUNE_COZ  = 64
CONST RUNE_ARP  = 65
CONST RUNE_OJE  = 66
CONST RUNE_TIL  = 67
CONST RUNE_ROC  = 68
CONST RUNE_WOD  = 69
CONST RUNE_SHO  = 70
CONST RUNE_VAS  = 71
CONST RUNE_DOP  = 72
CONST RUNE_ROF  = 73
CONST RUNE_POS  = 74
CONST RUNE_UCH  = 75
CONST RUNE_DIRE = 76
CONST RUNE_FLA  = 77
CONST RUNE_PUD  = 78
CONST RUNE_CAL  = 79
CONST RUNE_DAS  = 80
CONST RUNE_USS  = 81
'ACT 1 Quest Items
CONST QITEM_STRANGE_PENDANT = 82
CONST QITEM_BURNING_SPHERE  = 83
CONST QITEM_GOLDEN_SKULL    = 84
CONST QITEM_JADE_SKULL      = 85
CONST QITEM_CHAOS_STAR      = 86
CONST QITEM_KEY1            = 87
CONST QITEM_KEY2            = 88
CONST QITEM_FAMILIAR_FLUTE  = 89
CONST QITEM_GATE_KEY        = 90

'END OF INVENTORY SHARING

'HELMSBURG TRIGGER SHARING
DIM SHARED HelmsburgBttl%

'ACT 1 TRIGGER SHARING
DIM SHARED LadderUp%
DIM SHARED LadderDown%
DIM SHARED ToHall%
DIM SHARED BottomLift%
DIM SHARED A0CutsceneDone%
DIM SHARED A1ShopEnter%
DIM SHARED A1ShopPotion%
DIM SHARED A1EnterPit%
DIM SHARED Quest%
DIM SHARED A3LS%
DIM SHARED A3Corpse%
DIM SHARED ThroneSwitch%
DIM SHARED A12Potions%
DIM SHARED A12ShieldPlusTwo%
DIM SHARED A12SwordPlusTwo%
DIM SHARED GoldenSkullTaken%
DIM SHARED A14Key1%
DIM SHARED ChaosStarInsert%
DIM SHARED StrangePendantTaken%
DIM SHARED A19Lvl1Door%
DIM SHARED A19Lvl2Door%
DIM SHARED A20Lvl1Door%
DIM SHARED A23FamiliarFlute%
DIM SHARED A26ChaosStar%
DIM SHARED A27GoldenSocket%
DIM SHARED A27JadeSocket%
DIM SHARED A27AvengerSword%
DIM SHARED A28ChaosStarSocket%
DIM SHARED A29StarSocket%
DIM SHARED A34Cutscene%
DIM SHARED A34CutsceneDone%
DIM SHARED A34SecretDoor%
DIM SHARED A42Cutscene%
DIM SHARED A42LockedGate%
DIM SHARED XanathusDead%
DIM SHARED XanathusArea$
DIM SHARED XanathusHP%
DIM SHARED StunTime%
DIM SHARED XanathusFleeTime%
DIM SHARED A48BSphere%
DIM SHARED A56VampFight%
DIM SHARED Hint%

DIM SHARED GemClicks(0 TO 7) AS INTEGER
CONST GEM_ORANGE = 0
CONST GEM_BLACK  = 1
CONST GEM_GREEN  = 2
CONST GEM_BLOOD  = 3
CONST GEM_BLUE   = 4
CONST GEM_WHITE  = 5
CONST GEM_RED    = 6
CONST GEM_JADE   = 7

DIM SHARED GemNum%
DIM SHARED GemPuzzleDone%

DIM SHARED AEncampmentUsePillar%
DIM SHARED A67PillarUse%
DIM SHARED A67PillarOn%
DIM SHARED WightLord%

TYPE SpellProps
    hasIt AS INTEGER

    name AS STRING
    dmg AS INTEGER
    heal AS INTEGER

    special AS INTEGER
END TYPE
DIM SHARED OwlSpells(0 TO 11) AS SpellProps

SCREEN 12
    PRINT "Loading...Please Wait"
    RANDOMIZE TIMER
    InitGlobals

    WillsSoundEffectVolume% = 50
    WillsMusicVolume% = 75

    MainMenu
END

REM $STATIC
SUB A56GetHint
    COLOR 14
    PRINT "So...the puzzle baffles you?"
    PRINT "We'll I don't betray my lady for free you know."
    PRINT "I'll give you a hint for 50 gold coins each."
    COLOR 15
    PRINT "Your collected hints:"
    IF Hint% > 0 THEN
        PRINT "If I we're you I'd examine that text carefully, those who made it would"
        PRINT "never make such grammatical errors for no reason."
        PRINT ""
    END IF
    IF Hint% > 1 THEN
        PRINT "Doesn't it seem odd to you how this whole area's design seems to reflect"
        PRINT "that symbol...the numerals might have something to do with that..."
        PRINT ""
    END IF
    IF Hint% > 2 THEN
        PRINT "Did you notice that gem on the ground on your way in? something to"
        PRINT "take a closer look at I think..."
    END IF
  998
    PRINT "Vampire> So do you wan't another hint? (50 gold) <Y/N>"
    INPUT ">", HintChoice$
    IF HintChoice$ = "y" THEN
        IF Hint% >= 3 THEN
            PRINT "Vampire> I think you've had enough hints..."
            PRINT "the vampire returns your gold"
        ELSEIF Gold& >= 50 THEN
            SELECT CASE Hint%
                CASE 0
                    Gold& = Gold& - 50
                    Hint% = 1
                    PRINT "If I we're you I'd examine that text carefully, those who made it would"
                    PRINT "never make such grammatical errors for no reason."
                CASE 1
                    Gold& = Gold& - 50
                    Hint% = 2
                    PRINT "Doesn't it seem odd to you how this whole area's design seems to reflect"
                    PRINT "that symbol...the numerals might have something to do with that..."
                CASE 2
                    Gold& = Gold& - 50
                    Hint% = 3
                    PRINT "Did you notice that gem on the ground on your way in? something to"
                    PRINT "take a closer look at I think..."
            END SELECT
        ELSE
            ColorPrint 14, "Vampire> What's this? this isn't 50 gold, NO DEAL!"
        END IF
        GOTO 998
    END IF
    IF HintChoice$ = "n" GOTO 999
    ColorPrint 5, "Huh?"
    GOTO 998
  999
END SUB

REM $DYNAMIC
SUB ACT1
    GameOn% = 1

    IF LadderUp% = 1 GOTO 350
    IF BottomLift% = 1 GOTO 650
    IF A67PillarUse% = 1 GOTO 230
    IF JustLoaded% = 1 THEN
        IF SavePos% = 0 THEN
            CLS

            PRINT "You have re-entered the world of Fargaia, good luck on your quest."
            SLEEP 4
            GOTO 230
        END IF
        IF SavePos% = 1 THEN
            CLS

            PRINT "You have re-entered the world of Fargaia, good luck on your quest."
            SLEEP 4
            Act1Pt2
        END IF

        IF SavePos% = 3 THEN
            CLS

            PRINT "You have re-entered the world of Fargaia, good luck on your quest."
            SLEEP 4
            HPS% = HP%
            GOTO 230
        END IF
    END IF
    GameIntro
    'This is the beginning spot, once a player leaves the area this area will
    'never be able to be accessed again.
    209 CLS

    SLEEP 1
    PRINT "You sit in front of the campfire.  The dark city is quiet for now, you begin to look at your surroundings.  An old shop is off to the northeast.  There is a set of pillars surrounding a chaos star carved into the ground nearby.  The fiery pit lies to the northwest.  Sir Jacob is standing beside the abandoned shop."

    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "  The old shop: northeast"
    PRINT "  The fiery pit: northwest"
    COLOR 15
    210 INPUT ">", A$
        IF A$ = "northeast" GOTO 220
        IF A$ = "northwest" GOTO 240
        IF A$ = "NorthEast" GOTO 220
        IF A$ = "NorthWest" GOTO 240

        IF A$ = "menu" THEN MainMenu
        IF A$ = "menu" GOTO 210

        IF A$ = "help" THEN WorldHelp
        IF A$ = "help" GOTO 210

        IF A$ = "describe" GOTO 209

        IF A$ = "stats" THEN displaystats
        IF A$ = "stats" GOTO 210

        IF A$ = "inventory" THEN displayinventory
        IF A$ = "inventory" GOTO 210

        IF A$ = "equipment" THEN displayequip
        IF A$ = "equipment" GOTO 210

        IF A$ = "equip LH" THEN EQlh
        IF A$ = "equip LH" GOTO 210

        IF A$ = "equip RH" THEN EQrh
        IF A$ = "equip RH" GOTO 210

        IF A$ = "equip ARMOUR" THEN EqArmour
        IF A$ = "equip ARMOUR" GOTO 210

        IF A$ = "equip HEAD" THEN EqHead
        IF A$ = "equip HEAD" GOTO 210

        IF A$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                COLOR 5
                PRINT "Used potion"
                GOTO 210
                COLOR 15
            END IF
        END IF

        IF A$ = "talk to sir jacob" THEN
            PRINT "Sir Jacob casts a spell of healing on you."
            PRINT "Your familiar is healed."
            HPS% = HP%
            FAMILIARHP% = FamiliarHPS%
            COLOR 5
            PRINT "Sir Jacob>We should check out that shop first."
    215             PRINT "Do you wish to save <Y/N>?"
            COLOR 15
            INPUT ">", Save$
                IF Save$ = "y" THEN
                    SavePos% = 0
                    SaveGame
                    ColorPrint 5, "Game Saved"
                    GOTO 210
                END IF

                IF Save$ = "n" GOTO 210
            ColorPrint 5, "Huh?"
            GOTO 215
        END IF
    ColorPrint 5, "huh?"
    GOTO 210

    220 CLS
    PRINT " You step into the abandoned shop, there are several cracks in the floor"
    PRINT "the shelves are ransacked.  Several broken jars that once contained "
    PRINT "potions now lie on the floor.  Other than that the shop seems empty."
    IF A1ShopEnter% = 1 THEN
        ColorPrint 5, "Samael is standing behind the counter"
        END IF

    IF A1ShopEnter% = 0 THEN
        IF A0CutsceneDone% = 0 THEN
            COLOR 14
                PRINT ""
                PRINT "You hear a creaking noise from the back of the shop, Sir Jacob moves"
                PRINT "towards the rear of the shop and steps back in surprise as a dwarf"
                PRINT "turns the corner."
                PRINT " "
            SLEEP 2
                PRINT "Sir Jacob> Just who are you?"
            SLEEP 2
                PRINT "Dwarf> That should be the question I should be asking you, human"
            SLEEP 2
                PRINT "Sir Jacob> I am Sir Jacob, a paladin, this is my friend, "; Name$
            SLEEP 2
                PRINT "Dwarf> They call me Samael in this god forsaken town. As one of the"
                PRINT "few survivors of this assault on my fair town I have appointed"
                PRINT "myself as the shopkeeper, and just what may ye be doin here?"
            SLEEP 2
                PRINT Name$; "> We came here in search of Necrotalia, a daemon. We were told"
                PRINT "to come by an Archangel, who appeared to us...quite a while ago."
            SLEEP 2
                PRINT "Samael> I see.  Well as one of the last survivors of this town I bid ye"
                PRINT "welcome and I shall sell to ye just about anything ye see here, or buy"
                PRINT "items as well."
            SLEEP 2
            A0CutsceneDone% = 1
            COLOR 15
        END IF
    END IF
    COLOR 5
    IF A1ShopPotion% = 0 THEN PRINT "There is one usable potion on the ground"
    PRINT "There is one obvious exit:"
    PRINT "         The Door: south"
    COLOR 15
    225 INPUT ">", A0$

        IF A0$ = "south" THEN A1ShopEnter% = 1
        IF A0$ = "south" GOTO 230

        IF A0$ = "talk to samael" THEN
            COLOR 5
            PRINT "Samael> What can I do fer ye?"
            PurchaseSamael
            COLOR 15
            GOTO 225
        END IF

        IF A0$ = "talk to sir jacob" THEN
            IF A1ShopEnter% = 0 THEN
                ColorPrint 5, "Sir Jacob> It seems as we can trust this dwarf."
                GOTO 225
                END IF
        END IF

        IF A0$ = "menu" THEN MainMenu
        IF A0$ = "menu" GOTO 225

        IF A0$ = "help" THEN WorldHelp
        IF A0$ = "help" GOTO 225

        IF A0$ = "describe" GOTO 220

        IF A0$ = "stats" THEN displaystats
        IF A0$ = "stats" GOTO 225

        IF A0$ = "inventory" THEN displayinventory
        IF A0$ = "inventory" GOTO 225

        IF A0$ = "equipment" THEN displayequip
        IF A0$ = "equipment" GOTO 225

        IF A0$ = "equip LH" THEN EQlh
        IF A0$ = "equip LH" GOTO 225

        IF A0$ = "equip RH" THEN EQrh
        IF A0$ = "equip RH" GOTO 225

        IF A0$ = "equip ARMOUR" THEN EqArmour
        IF A0$ = "equip ARMOUR" GOTO 225

        IF A0$ = "equip HEAD" THEN EqHead
        IF A0$ = "equip HEAD" GOTO 225

        IF A0$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                COLOR 5
                PRINT "Used potion"
                GOTO 225
                COLOR 15
            END IF
        END IF

        IF A0$ = "get potion" THEN
            IF A1ShopPotion% = 0 THEN
                ColorPrint 5, "Got Potion"
                A1ShopPotion% = 1
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
                GOTO 225
                END IF
            END IF
    ColorPrint 5, "huh?"
    GOTO 225

    230 CLS
    A67PillarUse% = 0
    PRINT "You step into the camp area, the fire is still burning.  Sir Jacob is"
    PRINT "standing next to the abandoned shop.  The chaos star surrounded by "
    PRINT "pillars seems to be burning as if lit on fire."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         northeast: The abandoned shop"
    PRINT "         northwest: The fiery pit"
    235 COLOR 15
    INPUT ">", AEncampment$
        IF AEncampment$ = "northeast" GOTO 220
        IF AEncampment$ = "NorthEast" GOTO 220

        IF AEncampment$ = "northwest" GOTO 240

        IF AEncampment$ = "talk to sir jacob" THEN
            PRINT "Sir Jacob casts a spell of healing on you."
            PRINT "Your familiar is healed."
            HPS% = HP%
            FAMILIARHP% = FamiliarHPS%
            COLOR 5
            PRINT "Sir Jacob> No time to waste, let's go down into the fiery pits."
            PRINT "Would you like to save your game? <Y/N>"
            COLOR 15
    236             INPUT ">", SirJacobA1$
                IF SirJacobA1$ = "y" THEN
                    SavePos% = 0
                    SaveGame
                    ColorPrint 5, "Game Saved"
                    GOTO 235
                END IF

                IF SirJacobA1$ = "n" GOTO 235

            ColorPrint 5, "Huh?"
            GOTO 236
        END IF
        IF AEncampment$ = "help" THEN WorldHelp
        IF AEncampment$ = "help" GOTO 235

        IF AEncampment$ = "menu" THEN MainMenu
        IF AEncampment$ = "menu" GOTO 235

        IF AEncampment$ = "describe" GOTO 230
        IF AEncampment$ = "describe" GOTO 235

        IF AEncampment$ = "stats" THEN displaystats
        IF AEncampment$ = "stats" GOTO 235

        IF AEncampment$ = "inventory" THEN displayinventory
        IF AEncampment$ = "inventory" GOTO 235

        IF AEncampment$ = "equipment" THEN displayequip
        IF AEncampment$ = "equipment" GOTO 235

        IF AEncampment$ = "equip LH" THEN EQlh
        IF AEncampment$ = "equip LH" GOTO 235

        IF AEncampment$ = "equip RH" THEN EQrh
        IF AEncampment$ = "equip RH" GOTO 235

        IF AEncampment$ = "equip ARMOUR" THEN EqArmour
        IF AEncampment$ = "equip ARMOUR" GOTO 235

        IF AEncampment$ = "equip HEAD" THEN EqHead
        IF AEncampment$ = "equip HEAD" GOTO 235

        IF AEncampment$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 235
            END IF
        END IF

        IF AEncampment$ = "use chaos star" THEN
            IF A67PillarOn% = 1 THEN
                COLOR 5
                AEncampmentUsePillar% = 1

                PRINT "You walk onto the burning chaos star, immediately you feel yourself being pulled to some far place."
                SLEEP 5
                COLOR 15
                Act1Pt2
            END IF
        END IF

    ColorPrint 5, "huh?"
    GOTO 210

    'Area 1
    240 CLS
    PRINT "You slowly make your way down into the fiery pit, when you reach the"
    PRINT "bottom you notice a hidden passageway opening up into a dimly lit room."
    IF A1EnterPit% = 0 THEN
        A1EnterPit% = 1
        SLEEP 4
        COLOR 4
        PRINT "All of a sudden from above a monster jumps on you"

        SLEEP 3
        COLOR 15
        CLS
        BATTLE

        GOTO 241
        END IF
    241 CLS
    PRINT "  You make your way into the fiery pit, all around you flames burn"
    PRINT "unnaturally, above you is a dark starless night but beside you looms"
    PRINT "the dark labrynth."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE

            GOTO 241
        END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         up: The Camp"
    PRINT "         southeast: into the labrynth"
    COLOR 15
    245 INPUT ">", A1$

    IF A1$ = "up" THEN GOTO 230

    IF A1$ = "southeast" THEN GOTO 250

        IF A1$ = "help" THEN WorldHelp
        IF A1$ = "help" GOTO 245

        IF A1$ = "menu" THEN MainMenu
        IF A1$ = "menu" GOTO 245

        IF A1$ = "describe" GOTO 241
        IF A1$ = "describe" GOTO 245

        IF A1$ = "stats" THEN displaystats
        IF A1$ = "stats" GOTO 245

        IF A1$ = "inventory" THEN displayinventory
        IF A1$ = "inventory" GOTO 245

        IF A1$ = "equipment" THEN displayequip
        IF A1$ = "equipment" GOTO 245

        IF A1$ = "equip LH" THEN EQlh
        IF A1$ = "equip LH" GOTO 245

        IF A1$ = "equip RH" THEN EQrh
        IF A1$ = "equip RH" GOTO 245

        IF A1$ = "equip ARMOUR" THEN EqArmour
        IF A1$ = "equip ARMOUR" GOTO 245

        IF A1$ = "equip HEAD" THEN EqHead
        IF A1$ = "equip HEAD" GOTO 245

        IF A1$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
            END IF
        END IF

        ColorPrint 5, "Huh?"

    GOTO 245

    'Area A2

    250 CLS
    PRINT "You enter a small room with two adjoining hallways."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 250
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         east: hallway"
    PRINT "         west: hallway"
    PRINT "         northwest: fiery pit"
    COLOR 15
    255 INPUT ">", A2$
        IF A2$ = "east" GOTO 260
        IF A2$ = "west" GOTO 270
        IF A2$ = "northwest" GOTO 240
        IF A2$ = "help" THEN WorldHelp
        IF A2$ = "help" GOTO 255
        IF A2$ = "menu" THEN MainMenu
        IF A2$ = "menu" GOTO 225
        IF A2$ = "describe" GOTO 250
        IF A2$ = "describe" GOTO 255
        IF A2$ = "stats" THEN displaystats
        IF A2$ = "stats" GOTO 255
        IF A2$ = "inventory" THEN displayinventory
        IF A2$ = "inventory" GOTO 255
        IF A2$ = "equipment" THEN displayequip
        IF A2$ = "equipment" GOTO 255
        IF A2$ = "equip LH" THEN EQlh
        IF A2$ = "equip LH" GOTO 255
        IF A2$ = "equip RH" THEN EQrh
        IF A2$ = "equip RH" GOTO 255
        IF A2$ = "equip ARMOUR" THEN EqArmour
        IF A2$ = "equip ARMOUR" GOTO 255
        IF A2$ = "equip HEAD" THEN EqHead
        IF A2$ = "equip HEAD" GOTO 255
        IF A2$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 255
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 255

    'Area 4
    260 CLS
    PRINT "You are now standing in an intersection.  To the north is a tunnel"
    PRINT "To the east is a long corridor that falls into darkness. To the west"
    PRINT "is a small storage closet. The south hallway opens into a large room."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 260
        END IF
    COLOR 5
    PRINT "There are four obvious paths:"
    PRINT "         north: tunnel"
    PRINT "         east: long corridor"
    PRINT "         west: storage room"
    PRINT "         south: large room"
    COLOR 15
    265 INPUT ">", A4$
        IF A4$ = "north" GOTO 250
        IF A4$ = "east" GOTO 270
        IF A4$ = "west" GOTO 290
        IF A4$ = "south" GOTO 300
        IF A4$ = "help" THEN WorldHelp
        IF A4$ = "help" GOTO 265
        IF A4$ = "describe" GOTO 260
        IF A4$ = "describe" GOTO 265
        IF A4$ = "stats" THEN displaystats
        IF A4$ = "stats" GOTO 265
        IF A4$ = "inventory" THEN displayinventory
        IF A4$ = "inventory" GOTO 265
        IF A4$ = "menu" THEN MainMenu
        IF A4$ = "menu" GOTO 265
        IF A4$ = "equipment" THEN displayequip
        IF A4$ = "equipment" GOTO 265
        IF A4$ = "equip LH" THEN EQlh
        IF A4$ = "equip LH" GOTO 265
        IF A4$ = "equip RH" THEN EQrh
        IF A4$ = "equip RH" GOTO 265
        IF A4$ = "equip ARMOUR" THEN EqArmour
        IF A4$ = "equip ARMOUR" GOTO 265
        IF A4$ = "equip HEAD" THEN EqHead
        IF A4$ = "equip HEAD" GOTO 265
        IF A4$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 265
            END IF
        END IF
    ColorPrint 5, "huh?"
    GOTO 265

    'Area 5
    270 CLS
    PRINT "You look around.  This is an intersection of four paths.  To the north"
    PRINT "is a small bending tunnel.  To the east and west is a dark corridor. The"
    PRINT "south hallway leads into a large room."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 270
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         north: bending hallway"
    PRINT "         east: long corridor"
    PRINT "         south: large room"
    PRINT "         west: long corridor"
    COLOR 15
    275 INPUT ">", A5$
        IF A5$ = "north" GOTO 250
        IF A5$ = "east" GOTO 280
        IF A5$ = "south" GOTO 310
        IF A5$ = "west" GOTO 260

        IF A5$ = "help" THEN WorldHelp
        IF A5$ = "help" GOTO 275

        IF A5$ = "menu" THEN MainMenu
        IF A5$ = "menu" GOTO 275

        IF A5$ = "describe" GOTO 270
        IF A5$ = "describe" GOTO 275

        IF A5$ = "stats" THEN displaystats
        IF A5$ = "stats" GOTO 275

        IF A5$ = "inventory" THEN displayinventory
        IF A5$ = "inventory" GOTO 275

        IF A5$ = "equipment" THEN displayequip
        IF A5$ = "equipment" GOTO 275

        IF A5$ = "equip LH" THEN EQlh
        IF A5$ = "equip LH" GOTO 275

        IF A5$ = "equip RH" THEN EQrh
        IF A5$ = "equip RH" GOTO 275

        IF A5$ = "equip ARMOUR" THEN EqArmour
        IF A5$ = "equip ARMOUR" GOTO 275
        IF A5$ = "equip HEAD" THEN EqHead
        IF A5$ = "equip HEAD" GOTO 225
        IF A5$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 275
            END IF
        END IF
    ColorPrint 5, "huh?"
    GOTO 275

    'Area 6
    280 CLS
    PRINT "This is a small junction of two hallways.  To the west is a long dark"
    PRINT "tunnel.  To the east is the entrance to a large hall."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 270
        END IF
    COLOR 5
    PRINT ""
    PRINT "There are two obvious exits:"
    PRINT "         west: long tunnel"
    PRINT "         south: large hall"
    COLOR 15
    PRINT ""
    285 INPUT ">", A6$
        IF A6$ = "west" GOTO 270
        IF A6$ = "south" GOTO 320

        IF A6$ = "help" THEN WorldHelp
        IF A6$ = "help" GOTO 285

        IF A6$ = "menu" THEN MainMenu
        IF A6$ = "menu" GOTO 285

        IF A6$ = "describe" GOTO 280
        IF A6$ = "describe" GOTO 285

        IF A6$ = "stats" THEN displaystats
        IF A6$ = "stats" GOTO 285

        IF A6$ = "inventory" THEN displayinventory
        IF A6$ = "inventory" GOTO 285

        IF A6$ = "equipment" THEN displayequip
        IF A6$ = "equipment" GOTO 285

        IF A6$ = "equip LH" THEN EQlh
        IF A6$ = "equip LH" GOTO 285

        IF A6$ = "equip RH" THEN EQrh
        IF A6$ = "equip RH" GOTO 285

        IF A6$ = "equip ARMOUR" THEN EqArmour
        IF A6$ = "equip ARMOUR" GOTO 285

        IF A6$ = "equip HEAD" THEN EqHead
        IF A6$ = "equip HEAD" GOTO 285

        IF A6$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 285
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 285

    'Area 3
    290 CLS
    PRINT "You have entered the storage room, it seems as it should except for the"
    PRINT "corpse lying propped against a wall.  On the shelves are several broken"
    PRINT "bottles possibly containing potions at one time."
    IF A3LS% = 0 THEN
        ColorPrint 5, "There is a long sword sitting on a shelf"
        END IF
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 290
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         East: The corridor"
    COLOR 15
    295 INPUT ">", A3$
        IF A3$ = "east" GOTO 260

        IF A3$ = "get long sword" THEN
            IF A3LS% = 0 THEN
                A3LS% = 1
                Inventory(ITEM_LONG_SWORD).amount = Inventory(ITEM_LONG_SWORD).amount + 1
                ColorPrint 5, "Got long sword"
                GOTO 295
                END IF
        END IF

        IF A3$ = "examine corpse" THEN
            IF A3Corpse% = 0 THEN
                A3Corpse% = 1
                COLOR 5
                PRINT "You examine the corpse and find 50 gold coins"
                Gold& = Gold& + 50
                ColorPrint 3, "All of a sudden the corpse lunges towards you!"
                SLEEP 4
                BATTLE

                GOTO 290
                END IF
            END IF

        IF A3$ = "help" THEN WorldHelp
        IF A3$ = "help" GOTO 295

        IF A3$ = "menu" THEN MainMenu
        IF A3$ = "menu" GOTO 295

        IF A3$ = "describe" GOTO 290
        IF A3$ = "describe" GOTO 295

        IF A3$ = "stats" THEN displaystats
        IF A3$ = "stats" GOTO 295

        IF A3$ = "inventory" THEN displayinventory
        IF A3$ = "inventory" GOTO 295

        IF A3$ = "equipment" THEN displayequip
        IF A3$ = "equipment" GOTO 295

        IF A3$ = "equip LH" THEN EQlh
        IF A3$ = "equip LH" GOTO 295

        IF A3$ = "equip RH" THEN EQrh
        IF A3$ = "equip RH" GOTO 295

        IF A3$ = "equip ARMOUR" THEN EqArmour
        IF A3$ = "equip ARMOUR" GOTO 295

        IF A3$ = "equip HEAD" THEN EqHead
        IF A3$ = "equip HEAD" GOTO 295

        IF A3$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 295
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 295

    'Area 8
    300 CLS
    PRINT "    You are now standing...in a hall of horror.  Littered all around"
    PRINT "are corpses of dwarfs and humans.  Some lay on tables with cut marks"
    PRINT "on their bodies.  Some are fresh and still leak blood. You turn your"
    PRINT "head away from this horror to any possible exits you can find. To the"
    PRINT "north is a small corridor.  To the west lies a small room which appears"
    PRINT "to be a spiral staircase, and to the east remains the rest of this"
    PRINT "great hall of horror."
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 30 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 300
        END IF
    PRINT ""
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Small corridor"
    PRINT "         East: Mid section of hall"
    PRINT "         West: Spiral Staircase"
    COLOR 15
    305 INPUT ">", A8$
        IF A8$ = "north" GOTO 260
        IF A8$ = "east" GOTO 310
        IF A8$ = "west" GOTO 330
        IF A8$ = "help" THEN WorldHelp
        IF A8$ = "help" GOTO 305
        IF A8$ = "menu" THEN MainMenu
        IF A8$ = "menu" GOTO 305
        IF A8$ = "describe" GOTO 300
        IF A8$ = "stats" THEN displaystats
        IF A8$ = "stats" GOTO 305
        IF A8$ = "inventory" THEN displayinventory
        IF A8$ = "inventory" GOTO 305
        IF A8$ = "equipment" THEN displayequip
        IF A8$ = "equipment" GOTO 305
        IF A8$ = "equip LH" THEN EQlh
        IF A8$ = "equip LH" GOTO 305
        IF A8$ = "equip RH" THEN EQrh
        IF A8$ = "equip RH" GOTO 305
        IF A8$ = "equip ARMOUR" THEN EqArmour
        IF A8$ = "equip ARMOUR" GOTO 305
        IF A8$ = "equip HEAD" THEN EqHead
        IF A8$ = "equip HEAD" GOTO 305
        IF A8$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 305
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 305

    'Area 7
    310 CLS
    PRINT "  This room is dominated by corpses and blood.  You begin to feel an urge"
    PRINT "to leave this evil hall and quickly search for exits. To the north lies"
    PRINT "a small corridor.  To the east and west lie the rest of the hall. To the"
    PRINT "south is a small dark passageway."
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 30 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 310
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: small corridor"
    PRINT "         East: Grand Hall"
    PRINT "         West: Grand Hall"
    PRINT "         South: Small passageway"
    COLOR 15
    315 INPUT ">", A7$
        IF A7$ = "north" GOTO 270
        IF A7$ = "east" GOTO 320
        IF A7$ = "west" GOTO 300
        IF A7$ = "south" GOTO 360

        IF A7$ = "help" THEN WorldHelp
        IF A7$ = "help" GOTO 315

        IF A7$ = "menu" THEN MainMenu
        IF A7$ = "menu" GOTO 225

        IF A7$ = "describe" GOTO 310
        IF A7$ = "describe" GOTO 315

        IF A7$ = "stats" THEN displaystats
        IF A7$ = "stats" GOTO 315

        IF A7$ = "inventory" THEN displayinventory
        IF A7$ = "inventory" GOTO 315

        IF A7$ = "equipment" THEN displayequip
        IF A7$ = "equipment" GOTO 315

        IF A7$ = "equip LH" THEN EQlh
        IF A7$ = "equip LH" GOTO 315

        IF A7$ = "equip RH" THEN EQrh
        IF A7$ = "equip RH" GOTO 315

        IF A7$ = "equip ARMOUR" THEN EqArmour
        IF A7$ = "equip ARMOUR" GOTO 315
        IF A7$ = "equip HEAD" THEN EqHead
        IF A7$ = "equip HEAD" GOTO 315
        IF A7$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 315
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 315

    'Area 9
    320 CLS
    PRINT "    You are standing at the head of this hallway dominated by corpses."
    PRINT "You hear the scuttering of undead minions nearby and decide to move"
    PRINT "away from this hallway quickly.  To the north is a small corridor. To"
    PRINT "the west is the rest of the hall.  To the east lies a stage with a "
    PRINT "large throne on top."
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 30 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 320
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Small corridor"
    PRINT "         West: Hall"
    PRINT "         East: Stage"
    COLOR 15
    325 INPUT ">", A9$
        IF A9$ = "north" GOTO 280
        IF A9$ = "west" GOTO 310
        IF A9$ = "east" GOTO 340

        IF A9$ = "help" THEN WorldHelp
        IF A9$ = "help" GOTO 325

        IF A9$ = "menu" THEN MainMenu
        IF A9$ = "menu" GOTO 325

        IF A9$ = "describe" GOTO 320
        IF A9$ = "describe" GOTO 325

        IF A9$ = "stats" THEN displaystats
        IF A9$ = "stats" GOTO 325

        IF A9$ = "inventory" THEN displayinventory
        IF A9$ = "inventory" GOTO 325

        IF A9$ = "equipment" THEN displayequip
        IF A9$ = "equipment" GOTO 325

        IF A9$ = "equip LH" THEN EQlh
        IF A9$ = "equip LH" GOTO 325

        IF A9$ = "equip RH" THEN EQrh
        IF A9$ = "equip RH" GOTO 325

        IF A9$ = "equip ARMOUR" THEN EqArmour
        IF A9$ = "equip ARMOUR" GOTO 325
        IF A9$ = "equip HEAD" THEN EqHead
        IF A9$ = "equip HEAD" GOTO 325
        IF A9$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 325
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 325

    'Area 10
    330 CLS
    PRINT "You have entered the room which contains a spiral staircase.  Other"
    PRINT "than the staircase the room seems blank."
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 330
        END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         East: The great hall"
    PRINT "         Down: The spiral staircase"
    COLOR 15
    335 INPUT ">", A10$
        IF A10$ = "down" GOTO 500
        IF A10$ = "east" GOTO 300

        IF A10$ = "help" THEN WorldHelp
        IF A10$ = "help" GOTO 335

        IF A10$ = "menu" THEN MainMenu
        IF A10$ = "menu" GOTO 335

        IF A10$ = "describe" GOTO 330
        IF A10$ = "describe" GOTO 335

        IF A10$ = "stats" THEN displaystats
        IF A10$ = "stats" GOTO 335

        IF A10$ = "inventory" THEN displayinventory
        IF A10$ = "inventory" GOTO 335

        IF A10$ = "equipment" THEN displayequip
        IF A10$ = "equipment" GOTO 335

        IF A10$ = "equip LH" THEN EQlh
        IF A10$ = "equip LH" GOTO 335

        IF A10$ = "equip RH" THEN EQrh
        IF A10$ = "equip RH" GOTO 335

        IF A10$ = "equip ARMOUR" THEN EqArmour
        IF A10$ = "equip ARMOUR" GOTO 335
        IF A10$ = "equip HEAD" THEN EqHead
        IF A10$ = "equip HEAD" GOTO 335
        IF A10$ = "use potion" THEN
               IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 335
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 335

    'Area 11
    340 CLS
    PRINT "   You are now standing on the stage, corpses here appear to be crucified"
    PRINT "There is a large throne sitting in the middle of the stage."
    IF GoldenSkullTaken% = 0 THEN
        ColorPrint 5, "There is a golden skull sitting in the middle of the throne"
    END IF

        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 340
        END IF
    COLOR 5
    IF ThroneSwitch% = 1 THEN PRINT "There are two obvious exits:"
    IF ThroneSwitch% = 1 THEN PRINT "       West: The Great Hall"
    IF ThroneSwitch% = 1 THEN PRINT "       East: The hidden passageway"

    IF ThroneSwitch% = 0 THEN PRINT "There is one obvious exit:"
    IF ThroneSwitch% = 0 THEN PRINT "        West: The Great Hall"
    COLOR 15
    345 INPUT ">", A11$
        IF A11$ = "west" GOTO 320

        IF A11$ = "east" THEN
            IF ThroneSwitch% = 1 GOTO 350
        END IF

        IF A11$ = "get golden skull" THEN
            IF GoldenSkullTaken% = 0 THEN
                Inventory(QITEM_GOLDEN_SKULL).amount = 1
                ColorPrint 5, "Got golden skull"
                GoldenSkullTaken% = 1
                GOTO 345
            END IF
        END IF

        IF A11$ = "examine throne" THEN
            IF ThroneSwitch% = 0 THEN
                COLOR 3
                PRINT "You take a close look at the throne, you reveal a switch and decide to"
                PRINT "press it, at the EAST end of the stage a wall section moves aside"
                PRINT "revealing a hidden passageway"
                ThroneSwitch% = 1
                COLOR 15
                GOTO 345
            END IF

            IF ThroneSwitch% = 1 THEN
                ColorPrint 5, "There's no need to examine it again."
                GOTO 345
            END IF
        END IF

        IF A11$ = "help" THEN WorldHelp
        IF A11$ = "help" GOTO 345

        IF A11$ = "menu" THEN MainMenu
        IF A11$ = "menu" GOTO 345

        IF A11$ = "describe" GOTO 340
        IF A11$ = "describe" GOTO 345

        IF A11$ = "stats" THEN displaystats
        IF A11$ = "stats" GOTO 345

        IF A11$ = "inventory" THEN displayinventory
        IF A11$ = "inventory" GOTO 345

        IF A11$ = "equipment" THEN displayequip
        IF A11$ = "equipment" GOTO 345

        IF A11$ = "equip LH" THEN EQlh
        IF A11$ = "equip LH" GOTO 345

        IF A11$ = "equip RH" THEN EQrh
        IF A11$ = "equip RH" GOTO 345

        IF A11$ = "equip ARMOUR" THEN EqArmour
        IF A11$ = "equip ARMOUR" GOTO 345
        IF A11$ = "equip HEAD" THEN EqHead
        IF A11$ = "equip HEAD" GOTO 345
        IF A11$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 345
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 345

    'Area 12
    350 CLS
    LadderUp% = 0
    PRINT "   You enter the secret room behind the throne. The room seems bare"
    PRINT "except for the table in the middle and the ladder in the southeast"
    PRINT "corner."
    IF A12Potions% >= 1 THEN
        COLOR 5
        PRINT "You see "; A12Potions%; " potion(s) lying on the ground"
        COLOR 15
        END IF

    IF A12ShieldPlusTwo% = 0 THEN
        ColorPrint 5, "You see a special shield lying on the table"
        END IF

    IF A12SwordPlusTwo% = 0 THEN
        ColorPrint 5, "You see a special sword mounted on the wall"
        END IF

    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         West: The Stage"
    PRINT "         Down: The Ladder"
    COLOR 15
    355 INPUT ">", A12$
        IF A12$ = "west" GOTO 340
        IF A12$ = "down" THEN
            LadderDown% = 1
            Act1Pt2
        END IF

        IF A12$ = "get potion" THEN
            IF A12Potions% >= 1 THEN
                A12Potions% = A12Potions% - 1
                ColorPrint 5, "Got one Potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
                GOTO 355
            END IF
        END IF

        IF A12$ = "get special sword" THEN
            IF A12SwordPlusTwo% = 0 THEN
                A12SwordPlusTwo% = 1
                ColorPrint 5, "You pick up the sword and realize it is a Sword +2, rare."
                Inventory(ITEM_SWORD_PLUS_TWO).amount = Inventory(ITEM_SWORD_PLUS_TWO).amount + 1
                GOTO 355
            END IF
        END IF

        IF A12$ = "get special shield" THEN
            IF A12ShieldPlusTwo% = 0 THEN
                A12ShieldPlusTwo% = 1
                ColorPrint 5, "You picked up the shield, it is a Shield +2"
                Inventory(ITEM_SHIELD_PLUS_TWO).amount = Inventory(ITEM_SHIELD_PLUS_TWO).amount + 1
                GOTO 355
            END IF
        END IF

        IF A12$ = "help" THEN WorldHelp
        IF A12$ = "help" GOTO 355

        IF A12$ = "menu" THEN MainMenu
        IF A12$ = "menu" GOTO 355

        IF A12$ = "describe" GOTO 350
        IF A12$ = "describe" GOTO 355

        IF A12$ = "stats" THEN displaystats
        IF A12$ = "stats" GOTO 355

        IF A12$ = "inventory" THEN displayinventory
        IF A12$ = "inventory" GOTO 355

        IF A12$ = "equipment" THEN displayequip
        IF A12$ = "equipment" GOTO 355

        IF A12$ = "equip LH" THEN EQlh
        IF A12$ = "equip LH" GOTO 355

        IF A12$ = "equip RH" THEN EQrh
        IF A12$ = "equip RH" GOTO 355

        IF A12$ = "equip ARMOUR" THEN EqArmour
        IF A12$ = "equip ARMOUR" GOTO 355
        IF A12$ = "equip HEAD" THEN EqHead
        IF A12$ = "equip HEAD" GOTO 355
        IF A12$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 355
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 355

    'Area 13
    360 CLS
    PRINT "    You enter the dark hallway, the surrounding area appears to be"
    PRINT "jail cells, skeletons seem to inhabit these once empty rooms. There"
    PRINT "are a total of three jail cells to the east, west and south."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 360
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: The Great Hall"
    PRINT "         East: Jail Cell"
    PRINT "         South: Jail Cell"
    PRINT "         West: Jail Cell"
    COLOR 15
    365 INPUT ">", A13$
        IF A13$ = "north" GOTO 310
        IF A13$ = "east" GOTO 370
        IF A13$ = "south" GOTO 380
        IF A13$ = "west" GOTO 390

        IF A13$ = "help" THEN WorldHelp
        IF A13$ = "help" GOTO 365

        IF A13$ = "menu" THEN MainMenu
        IF A13$ = "menu" GOTO 365

        IF A13$ = "describe" GOTO 300
        IF A13$ = "describe" GOTO 365

        IF A13$ = "stats" THEN displaystats
        IF A13$ = "stats" GOTO 365

        IF A13$ = "inventory" THEN displayinventory
        IF A13$ = "inventory" GOTO 365

        IF A13$ = "equipment" THEN displayequip
        IF A13$ = "equipment" GOTO 365

        IF A13$ = "equip LH" THEN EQlh
        IF A13$ = "equip LH" GOTO 365

        IF A13$ = "equip RH" THEN EQrh
        IF A13$ = "equip RH" GOTO 365

        IF A13$ = "equip ARMOUR" THEN EqArmour
        IF A13$ = "equip ARMOUR" GOTO 365
        IF A13$ = "equip HEAD" THEN EqHead
        IF A13$ = "equip HEAD" GOTO 365

        IF A13$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 365
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 365

    'Area 14
    370 CLS
    PRINT "   You enter a jail cell inhabited by one skeleton."
    IF A14Key1% = 0 THEN
        ColorPrint 5, "The skeleton seems to have some kind of key in its mouth"
    END IF
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 370
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         West: The hallway"
    COLOR 15
    375 INPUT ">", A14$
        IF A14$ = "west" GOTO 360

        IF A14$ = "get key" THEN
            IF A14Key1% = 0 THEN
                ColorPrint 5, "Got a key, type 1"
                Inventory(QITEM_KEY1).amount = Inventory(QITEM_KEY1).amount + 1
                A14Key1% = 1
                GOTO 375
            END IF
        END IF

        IF A14$ = "help" THEN WorldHelp
        IF A14$ = "help" GOTO 375

        IF A14$ = "menu" THEN MainMenu
        IF A14$ = "menu" GOTO 375

        IF A14$ = "describe" GOTO 370
        IF A14$ = "describe" GOTO 375

        IF A14$ = "stats" THEN displaystats
        IF A14$ = "stats" GOTO 375

        IF A14$ = "inventory" THEN displayinventory
        IF A14$ = "inventory" GOTO 375

        IF A14$ = "equipment" THEN displayequip
        IF A14$ = "equipment" GOTO 375

        IF A14$ = "equip LH" THEN EQlh
        IF A14$ = "equip LH" GOTO 375

        IF A14$ = "equip RH" THEN EQrh
        IF A14$ = "equip RH" GOTO 375

        IF A14$ = "equip ARMOUR" THEN EqArmour
        IF A14$ = "equip ARMOUR" GOTO 375
        IF A14$ = "equip HEAD" THEN EqHead
        IF A14$ = "equip HEAD" GOTO 375

        IF A14$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 375
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 375

    'Area 15
    380 CLS
    PRINT "You enter this cell which, except for a few skeletons, seems to be bare."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 380
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         North: The Hallway"
    COLOR 15
    385 INPUT ">", A15$
        IF A15$ = "north" GOTO 360

        IF A15$ = "help" THEN WorldHelp
        IF A15$ = "help" GOTO 385

        IF A15$ = "menu" THEN MainMenu
        IF A15$ = "menu" GOTO 385

        IF A15$ = "describe" GOTO 380
        IF A15$ = "describe" GOTO 385

        IF A15$ = "stats" THEN displaystats
        IF A15$ = "stats" GOTO 385

        IF A15$ = "inventory" THEN displayinventory
        IF A15$ = "inventory" GOTO 385

        IF A15$ = "equipment" THEN displayequip
        IF A15$ = "equipment" GOTO 385

        IF A15$ = "equip LH" THEN EQlh
        IF A15$ = "equip LH" GOTO 385

        IF A15$ = "equip RH" THEN EQrh
        IF A15$ = "equip RH" GOTO 385

        IF A15$ = "equip ARMOUR" THEN EqArmour
        IF A15$ = "equip ARMOUR" GOTO 385
        IF A15$ = "equip HEAD" THEN EqHead
        IF A15$ = "equip HEAD" GOTO 385

        IF A15$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 385
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 385

    'Area 16
    390 CLS
    PRINT "The western jail cell is completely bare and devoid of any objects."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 390
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         East: The Hallway"
    COLOR 15
    395 INPUT ">", A16$
        IF A16$ = "east" GOTO 360

        IF A16$ = "help" THEN WorldHelp
        IF A16$ = "help" GOTO 395

        IF A16$ = "menu" THEN MainMenu
        IF A16$ = "menu" GOTO 395

        IF A16$ = "describe" GOTO 390
        IF A16$ = "describe" GOTO 395

        IF A16$ = "stats" THEN displaystats
        IF A16$ = "stats" GOTO 395

        IF A16$ = "inventory" THEN displayinventory
        IF A16$ = "inventory" GOTO 395

        IF A16$ = "equipment" THEN displayequip
        IF A16$ = "equipment" GOTO 395

        IF A16$ = "equip LH" THEN EQlh
        IF A16$ = "equip LH" GOTO 395

        IF A16$ = "equip RH" THEN EQrh
        IF A16$ = "equip RH" GOTO 395

        IF A16$ = "equip ARMOUR" THEN EqArmour
        IF A16$ = "equip ARMOUR" GOTO 395
        IF A16$ = "equip HEAD" THEN EqHead
        IF A16$ = "equip HEAD" GOTO 395

        IF A16$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 395
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 395

    'Area 17
    500 CLS
    PRINT "   You are now at the bottom of the spiral staircase.  A small hallway"
    PRINT "to the east opens up into a large spacious room with a burning fire in"
    PRINT "the middle of this room."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 500
        END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         Up: The Spiral Staircase"
    PRINT "         East: The large room"
    COLOR 15
    505 INPUT ">", A17$
        IF A17$ = "up" GOTO 330
        IF A17$ = "east" GOTO 510

        IF A17$ = "help" THEN WorldHelp
        IF A17$ = "help" GOTO 505

        IF A17$ = "menu" THEN MainMenu
        IF A17$ = "menu" GOTO 500

        IF A17$ = "describe" GOTO 500

        IF A17$ = "stats" THEN displaystats
        IF A17$ = "stats" GOTO 505

        IF A17$ = "inventory" THEN displayinventory
        IF A17$ = "inventory" GOTO 505

        IF A17$ = "equipment" THEN displayequip
        IF A17$ = "equipment" GOTO 505

        IF A17$ = "equip LH" THEN EQlh
        IF A17$ = "equip LH" GOTO 505

        IF A17$ = "equip RH" THEN EQrh
        IF A17$ = "equip RH" GOTO 505

        IF A17$ = "equip ARMOUR" THEN EqArmour
        IF A17$ = "equip ARMOUR" GOTO 505
        IF A17$ = "equip HEAD" THEN EqHead
        IF A17$ = "equip HEAD" GOTO 505

        IF A17$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 505
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 505

    'Area 18
    510 CLS
    PRINT "You have entered a large room with stone walls.  Several pillars dominate"
    PRINT "the area.";
    IF ChaosStarInsert% = 0 THEN
    PRINT "There is a large burning fire in the center of the room, which "
    PRINT "appears to have the form of a chaos star."
    END IF

    IF ChaosStarInsert% = 1 THEN
    PRINT "The large burning fire in the center of the room seems to be"
    PRINT "small enough for you to pass.  In the center of the flames you can see a"
    PRINT "table with a dead corpse."
        IF StrangePendantTaken% = 0 THEN
            ColorPrint 5, "As you lean closer you see the corpse is grasping a strange pendant."
        END IF
    END IF
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 510
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         West: The spiral staircase."
    PRINT "         North: Tunnel"
    PRINT "         East: Tunnel"
    PRINT "         South: Tunnel"
    COLOR 15
    515 INPUT ">", A18$
        IF A18$ = "west" GOTO 500
        IF A18$ = "north" GOTO 520
        IF A18$ = "east" GOTO 530
        IF A18$ = "south" GOTO 540

        IF A18$ = "help" THEN WorldHelp
        IF A18$ = "help" GOTO 515

        IF A18$ = "menu" THEN MainMenu
        IF A18$ = "menu" GOTO 510

        IF A18$ = "describe" GOTO 510

        IF A18$ = "stats" THEN displaystats
        IF A18$ = "stats" GOTO 515

        IF A18$ = "inventory" THEN displayinventory
        IF A18$ = "inventory" GOTO 515

        IF A18$ = "equipment" THEN displayequip
        IF A18$ = "equipment" GOTO 515

        IF A18$ = "equip LH" THEN EQlh
        IF A18$ = "equip LH" GOTO 515

        IF A18$ = "equip RH" THEN EQrh
        IF A18$ = "equip RH" GOTO 515

        IF A18$ = "equip ARMOUR" THEN EqArmour
        IF A18$ = "equip ARMOUR" GOTO 515

        IF A18$ = "equip HEAD" THEN EqHead
        IF A18$ = "equip HEAD" GOTO 515

        IF A18$ = "get strange pendant" THEN
            IF ChaosStarInsert% = 1 THEN
                IF StrangePendantTaken% = 0 THEN
                    StrangePendantTaken% = 1
                    COLOR 5
                    PRINT "Got Strange Pendant"
                    Inventory(QITEM_STRANGE_PENDANT).amount = Inventory(QITEM_STRANGE_PENDANT).amount + 1
                    COLOR 15
                    GOTO 515
                END IF
            END IF
        END IF

        IF A18$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 515
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 515

    'Area 19
    520 CLS
    PRINT "You have entered a small intersection with four exits."
    IF A19Lvl2Door% = 0 THEN PRINT "There is a door to the north which you can't seem to open without a key."
    IF A19Lvl2Door% = 1 THEN PRINT "The unlocked northern door leads to a sort of lift."
    IF A19Lvl1Door% = 0 THEN PRINT "There is a door to the east that can not be opened without a key."
    IF A19Lvl1Door% = 1 THEN PRINT "The eastern door leads into a well lit room with several corpses inside."
    PRINT "To the south is another long passageway.  To the west is a passage that"
    PRINT "bends south."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 520
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    IF A19Lvl2Door% = 0 THEN PRINT "         North: Locked Door"
    IF A19Lvl2Door% = 1 THEN PRINT "         North: Lift"
    IF A19Lvl1Door% = 0 THEN PRINT "         East: Locked Door"
    IF A19Lvl1Door% = 1 THEN PRINT "         East: Corpse filled room"
    PRINT "         South: Long passage"
    PRINT "         West: Long passage"
    COLOR 15
    525 INPUT ">", A19$
        IF A19$ = "north" THEN
            IF A19Lvl2Door% = 0 THEN
                ColorPrint 5, "A locked door blocks your way."
                GOTO 525
            END IF
            IF A19Lvl2Door% = 1 GOTO 620
        END IF

        IF A19$ = "east" THEN
            IF A19Lvl1Door% = 0 THEN
                ColorPrint 5, "A locked door blocks your way."
                GOTO 525
            END IF
            IF A19Lvl1Door% = 1 GOTO 570
        END IF
    IF A19$ = "use key 1" THEN
        IF Inventory(QITEM_KEY1).amount >= 1 THEN
            Inventory(QITEM_KEY1).amount = Inventory(QITEM_KEY1).amount - 1
            A19Lvl1Door% = 1
            COLOR 5
            PRINT "You use the key on the east door, the door opens easily."
            PRINT "The key turns into dust in your hand."
            COLOR 15
            GOTO 525
        END IF
    END IF

    IF A19$ = "use key 2" THEN
        IF Inventory(QITEM_KEY2).amount >= 1 THEN
            Inventory(QITEM_KEY2).amount = Inventory(QITEM_KEY2).amount - 1
            A19Lvl2Door% = 1
            COLOR 5
            PRINT "You use the key on the north door, the door opens."
            PRINT "The key turns to dust in your hand."
            COLOR 15
            GOTO 525
        END IF
    END IF
        IF A19$ = "south" GOTO 530
        IF A19$ = "west" GOTO 510

        IF A19$ = "help" THEN WorldHelp
        IF A19$ = "help" GOTO 525

        IF A19$ = "menu" THEN MainMenu
        IF A19$ = "menu" GOTO 520

        IF A19$ = "describe" GOTO 520

        IF A19$ = "stats" THEN displaystats
        IF A19$ = "stats" GOTO 525

        IF A19$ = "inventory" THEN displayinventory
        IF A19$ = "inventory" GOTO 525

        IF A19$ = "equipment" THEN displayequip
        IF A19$ = "equipment" GOTO 525

        IF A19$ = "equip LH" THEN EQlh
        IF A19$ = "equip LH" GOTO 525

        IF A19$ = "equip RH" THEN EQrh
        IF A19$ = "equip RH" GOTO 525

        IF A19$ = "equip ARMOUR" THEN EqArmour
        IF A19$ = "equip ARMOUR" GOTO 525
        IF A19$ = "equip HEAD" THEN EqHead
        IF A19$ = "equip HEAD" GOTO 525

        IF A19$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 525
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 525

    'Area 20
    530 CLS
    PRINT "You have entered an intersection. There are exits to all directions."
    PRINT "To the north is a long tunnel.  To the west is a large hall.  To the"
    PRINT "south is another long tunnel.";
    IF A20Lvl1Door% = 0 THEN PRINT "  To the east is a locked door."
    IF A20Lvl1Door% = 1 THEN PRINT "  To the east is a small hall."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 530
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: Tunnel"
    IF A20Lvl1Door% = 0 THEN PRINT "         East: Locked Door"
    IF A20Lvl1Door% = 1 THEN PRINT "         East: Corpse filled room"
    PRINT "         South: Tunnel"
    PRINT "         West: Hall"
    COLOR 15
    535 INPUT ">", A20$
        IF A20$ = "north" GOTO 520
        IF A20$ = "south" GOTO 550
        IF A20$ = "west" GOTO 510
        IF A20$ = "use key 1" THEN
        IF Inventory(QITEM_KEY1).amount >= 1 THEN
            Inventory(QITEM_KEY1).amount = Inventory(QITEM_KEY1).amount - 1
            A20Lvl1Door% = 1
            COLOR 5
            PRINT "You use the key on the locked door, the door opens."
            PRINT "The key turns to dust in your hand."
            COLOR 15
            GOTO 535
        END IF
    END IF

        IF A20$ = "south" GOTO 530
        IF A20$ = "east" THEN
            IF A20Lvl1Door% = 0 THEN
                ColorPrint 5, "A locked door blocks your path"
                GOTO 535
            END IF
            IF A20Lvl1Door% = 1 THEN GOTO 570
        END IF

        IF A20$ = "help" THEN WorldHelp
        IF A20$ = "help" GOTO 535

        IF A20$ = "menu" THEN MainMenu
        IF A20$ = "menu" GOTO 530

        IF A20$ = "describe" GOTO 530

        IF A20$ = "stats" THEN displaystats
        IF A20$ = "stats" GOTO 535

        IF A20$ = "inventory" THEN displayinventory
        IF A20$ = "inventory" GOTO 535

        IF A20$ = "equipment" THEN displayequip
        IF A20$ = "equipment" GOTO 535

        IF A20$ = "equip LH" THEN EQlh
        IF A20$ = "equip LH" GOTO 535

        IF A20$ = "equip RH" THEN EQrh
        IF A20$ = "equip RH" GOTO 535

        IF A20$ = "equip ARMOUR" THEN EqArmour
        IF A20$ = "equip ARMOUR" GOTO 535

        IF A20$ = "equip HEAD" THEN EqHead
        IF A20$ = "equip HEAD" GOTO 535

        IF A20$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 535
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 535

    'Area 21
    540 CLS
    PRINT "You have entered a 3-Way intersection.  To the north is the large hall."
    PRINT "To the east is a long tunel.  The southern exit leads to an open area"
    PRINT "which appears to be a chasm."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 540
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Hall"
    PRINT "         East: Tunnel"
    PRINT "         South: Chasm"
    COLOR 15
    545 INPUT ">", A21$
        IF A21$ = "north" GOTO 510
        IF A21$ = "east" GOTO 550
        IF A21$ = "south" GOTO 630

        IF A21$ = "help" THEN WorldHelp
        IF A21$ = "help" GOTO 545

        IF A21$ = "menu" THEN MainMenu
        IF A21$ = "menu" GOTO 540

        IF A21$ = "describe" GOTO 540

        IF A21$ = "stats" THEN displaystats
        IF A21$ = "stats" GOTO 545

        IF A21$ = "inventory" THEN displayinventory
        IF A21$ = "inventory" GOTO 545

        IF A21$ = "equipment" THEN displayequip
        IF A21$ = "equipment" GOTO 545

        IF A21$ = "equip LH" THEN EQlh
        IF A21$ = "equip LH" GOTO 545

        IF A21$ = "equip RH" THEN EQrh
        IF A21$ = "equip RH" GOTO 545

        IF A21$ = "equip ARMOUR" THEN EqArmour
        IF A21$ = "equip ARMOUR" GOTO 545

        IF A21$ = "equip HEAD" THEN EqHead
        IF A21$ = "equip HEAD" GOTO 545

        IF A21$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 545
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 545

    'Area 22
    550 CLS
    PRINT "This area is yet another intersection.  This particular intersection "
    PRINT "splits four ways.  To the north is a long tunnel.  To the east is a"
    PRINT "small room which you can't identify from this distance.  To the south"
    PRINT "is a large open room which seems to be a chasm. The western exit leads"
    PRINT "down a long hallway."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 550
        END IF
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: Tunnel"
    PRINT "         East: Small Room"
    PRINT "         South: Chasm"
    PRINT "         West: Tunnel"
    COLOR 15
    555 INPUT ">", A22$
        IF A22$ = "north" GOTO 530
        IF A22$ = "east" GOTO 560
        IF A22$ = "south" GOTO 640
        IF A22$ = "west" GOTO 540

        IF A22$ = "help" THEN WorldHelp
        IF A22$ = "help" GOTO 555

        IF A22$ = "menu" THEN MainMenu
        IF A22$ = "menu" GOTO 550

        IF A22$ = "describe" GOTO 550

        IF A22$ = "stats" THEN displaystats
        IF A22$ = "stats" GOTO 555

        IF A22$ = "inventory" THEN displayinventory
        IF A22$ = "inventory" GOTO 555

        IF A22$ = "equipment" THEN displayequip
        IF A22$ = "equipment" GOTO 555

        IF A22$ = "equip LH" THEN EQlh
        IF A22$ = "equip LH" GOTO 555

        IF A22$ = "equip RH" THEN EQrh
        IF A22$ = "equip RH" GOTO 555

        IF A22$ = "equip ARMOUR" THEN EqArmour
        IF A22$ = "equip ARMOUR" GOTO 555

        IF A22$ = "equip HEAD" THEN EqHead
        IF A22$ = "equip HEAD" GOTO 555

        IF A22$ = "use potion" THEN
              IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 555
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 555

    'Area 23
    560 CLS
    PRINT "You have entered the dark room. Before you is a deep pit which leads off"
    PRINT "into the darkness.  There is a walkway forming a U in the room.  In the"
    PRINT "middle of the room is a small platform with a skeleton in the middle."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 560
        END IF
    COLOR 5
    IF A23FamiliarFlute% = 0 THEN
    PRINT "The skeleton seems to be holding some kind of flute."
    END IF
    PRINT "There is one obvious exit:"
    PRINT "         West: Intersection"
    COLOR 15
    565 INPUT ">", A23$
        IF A23$ = "west" GOTO 550

        IF A23$ = "help" THEN WorldHelp
        IF A23$ = "help" GOTO 565

        IF A23$ = "menu" THEN MainMenu
        IF A23$ = "menu" GOTO 560

        IF A23$ = "describe" GOTO 560

        IF A23$ = "stats" THEN displaystats
        IF A23$ = "stats" GOTO 565

        IF A23$ = "inventory" THEN displayinventory
        IF A23$ = "inventory" GOTO 565

        IF A23$ = "equipment" THEN displayequip
        IF A23$ = "equipment" GOTO 565

        IF A23$ = "equip LH" THEN EQlh
        IF A23$ = "equip LH" GOTO 565

        IF A23$ = "equip RH" THEN EQrh
        IF A23$ = "equip RH" GOTO 565

        IF A23$ = "equip ARMOUR" THEN EqArmour
        IF A23$ = "equip ARMOUR" GOTO 565

        IF A23$ = "equip HEAD" THEN EqHead
        IF A23$ = "equip HEAD" GOTO 565

        IF A23$ = "use potion" THEN
              IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 565
            END IF
        END IF

        IF A23$ = "get flute" THEN
            IF A23FamiliarFlute% = 0 THEN
                A23FamiliarFlute% = 1
                Inventory(QITEM_FAMILIAR_FLUTE).amount = Inventory(QITEM_FAMILIAR_FLUTE).amount + 1
                ColorPrint 5, "You got the flute, it appears to call familiars."
                GOTO 565
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 565

    'Area 24
    570 CLS
    PRINT "You have entered a large dimly lit room filled with corpses. You stare"
    PRINT "in disgust as you see that their blood seems to be draining into a small"
    PRINT "pool.  As much as you hate to look at the pool you can make out the edge"
    PRINT "of a underwater tunnel."
    RANDOMSTRING
        BATTLECHANCE% = INT(RND * 100)
            IF BATTLECHANCE% <= 15 THEN
            COLOR 4
            SLEEP 4
            PRINT "BATTLE!"

            COLOR 15
            SLEEP 2
            BATTLE

            GOTO 570
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         NorthWest: Intersection"
    PRINT "         SouthWest: Intersection"
    PRINT "         Down: The Pool of Blood"
    COLOR 15
    575 INPUT ">", A24$
        IF A24$ = "northwest" GOTO 520
            A19Lvl1Door% = 1
        IF A24$ = "southwest" THEN
            A20Lvl1Door% = 1
            GOTO 530
        END IF

        IF A24$ = "down" GOTO 580

        IF A24$ = "help" THEN WorldHelp
        IF A24$ = "help" GOTO 575

        IF A24$ = "menu" THEN MainMenu
        IF A24$ = "menu" GOTO 570

        IF A24$ = "describe" GOTO 570

        IF A24$ = "stats" THEN displaystats
        IF A24$ = "stats" GOTO 575

        IF A24$ = "inventory" THEN displayinventory
        IF A24$ = "inventory" GOTO 575

        IF A24$ = "equipment" THEN displayequip
        IF A24$ = "equipment" GOTO 575

        IF A24$ = "equip LH" THEN EQlh
        IF A24$ = "equip LH" GOTO 575

        IF A24$ = "equip RH" THEN EQrh
        IF A24$ = "equip RH" GOTO 575

        IF A24$ = "equip ARMOUR" THEN EqArmour
        IF A24$ = "equip ARMOUR" GOTO 575

        IF A24$ = "equip HEAD" THEN EqHead
        IF A24$ = "equip HEAD" GOTO 575

        IF A24$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 575
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 575

    'Area 25
    'Areas 25, 26, 27, 28, 29, 30 and 31 are no-battle areas and no string areas
    580 CLS
    PRINT "You have entered a small pool of blood with a large raised platform in"
    PRINT "the middle.  There is a small passageway in the pool of blood back to"
    PRINT "the corpse filled room.  The platform leads to a small shrine."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         Down: passageway"
    PRINT "         East: small shrine"
    COLOR 15
    585 INPUT ">", A25$
        IF A25$ = "down" GOTO 570
        IF A25$ = "east" GOTO 590

        IF A25$ = "help" THEN WorldHelp
        IF A25$ = "help" GOTO 585

        IF A25$ = "menu" THEN MainMenu
        IF A25$ = "menu" GOTO 580

        IF A25$ = "describe" GOTO 580

        IF A25$ = "stats" THEN displaystats
        IF A25$ = "stats" GOTO 585

        IF A25$ = "inventory" THEN displayinventory
        IF A25$ = "inventory" GOTO 585

        IF A25$ = "equipment" THEN displayequip
        IF A25$ = "equipment" GOTO 585

        IF A25$ = "equip LH" THEN EQlh
        IF A25$ = "equip LH" GOTO 585

        IF A25$ = "equip RH" THEN EQrh
        IF A25$ = "equip RH" GOTO 585

        IF A25$ = "equip ARMOUR" THEN EqArmour
        IF A25$ = "equip ARMOUR" GOTO 585

        IF A25$ = "equip HEAD" THEN EqHead
        IF A25$ = "equip HEAD" GOTO 585

        IF A25$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 585
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 585

    'Area 26
    590 CLS
    PRINT "You have entered a small intersection with a chaos shrine placed in"
    PRINT "one of the walls.  There are exits to the north, south and west. To"
    PRINT "the north is a tunnel emerging into a small room. The south passage"
    PRINT "also leads to a small room.  To the east is the pool of blood."
    COLOR 5
    IF A26ChaosStar% = 0 THEN
    PRINT "You hear a humming sound coming from the shrine, a pendant in the"
    PRINT "shape of a chaos star is embedded in the shrine."
    END IF
    IF A26ChaosStar% = 1 THEN
    PRINT "You approach the shrine and no longer hear the humming sound."
    PRINT "A chaos star pendant is embedded in the shrine."
    END IF
    PRINT "There are three obvious exits:"
    PRINT "         North: Small Room"
    PRINT "         South: Small Room"
    PRINT "         West: Pool of Blood"
    COLOR 15
    595 INPUT ">", A26$
        IF A26$ = "north" GOTO 610
        IF A26$ = "south" GOTO 600
        IF A26$ = "west" GOTO 580

        IF A26$ = "help" THEN WorldHelp
        IF A26$ = "help" GOTO 595

        IF A26$ = "menu" THEN MainMenu
        IF A26$ = "menu" GOTO 590

        IF A26$ = "describe" GOTO 590

        IF A26$ = "stats" THEN displaystats
        IF A26$ = "stats" GOTO 595

        IF A26$ = "inventory" THEN displayinventory
        IF A26$ = "inventory" GOTO 595

        IF A26$ = "equipment" THEN displayequip
        IF A26$ = "equipment" GOTO 595

        IF A26$ = "equip LH" THEN EQlh
        IF A26$ = "equip LH" GOTO 595

        IF A26$ = "equip RH" THEN EQrh
        IF A26$ = "equip RH" GOTO 595

        IF A26$ = "equip ARMOUR" THEN EqArmour
        IF A26$ = "equip ARMOUR" GOTO 595

        IF A26$ = "equip HEAD" THEN EqHead
        IF A26$ = "equip HEAD" GOTO 595

        IF A26$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 595
            END IF
        END IF

        IF A26$ = "get chaos star pendant" THEN
            IF A26ChaosStar% = 0 THEN
                COLOR 5
                PRINT "You lean forward to grab the chaos star pendant, suddenly you are thrown"
                PRINT "against a nearby wall by a repelling magic field."
                COLOR 15
                GOTO 595
            END IF

            IF A26ChaosStar% = 1 THEN
                ColorPrint 5, "You got the chaos star pendant"
                A26ChaosStar% = 2
                Inventory(QITEM_CHAOS_STAR).amount = 1
                GOTO 595
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 595

    'Area 27
    600 CLS
    IF A27GoldenSocket% = 0 THEN
        IF A27JadeSocket% = 0 THEN
            PRINT "You have entered a small room with many skulls embedded into the wall."
            PRINT "as you gaze around the room you realize that two skulls are missing, there"
            PRINT "are coloured sockets in their place.  One is gold, the other is jade."
        END IF
        IF A27JadeSocket% = 1 THEN
            PRINT "You have entered a small room with many skulls embedded into the wall."
            PRINT "as you gaze around the room you realize that one skull is missing, there"
            PRINT "is a gold coloured socket in it's place."
        END IF
    END IF

    IF A27JadeSocket% = 0 THEN
        IF A27GoldSocket% = 1 THEN
            PRINT "You have entered a small room with many skulls embedded into the wall."
            PRINT "as you gaze around the room you realize that one skull is missing, there"
            PRINT "is a jade coloured socket in it's place."
        END IF
    END IF
    IF A27AvengerSword% = 1 THEN
        ColorPrint 5, "There is a very special looking sword lying on the ground next to the wight lord."
    END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         North: Small Shrine"
    COLOR 15
    605 INPUT ">", A27$
        IF A27$ = "north" GOTO 590

        IF A27$ = "help" THEN WorldHelp
        IF A27$ = "help" GOTO 605

        IF A27$ = "menu" THEN MainMenu
        IF A27$ = "menu" GOTO 600

        IF A27$ = "describe" GOTO 600

        IF A27$ = "stats" THEN displaystats
        IF A27$ = "stats" GOTO 605

        IF A27$ = "inventory" THEN displayinventory
        IF A27$ = "inventory" GOTO 605

        IF A27$ = "equipment" THEN displayequip
        IF A27$ = "equipment" GOTO 605

        IF A27$ = "equip LH" THEN EQlh
        IF A27$ = "equip LH" GOTO 605

        IF A27$ = "equip RH" THEN EQrh
        IF A27$ = "equip RH" GOTO 605

        IF A27$ = "equip ARMOUR" THEN EqArmour
        IF A27$ = "equip ARMOUR" GOTO 605

        IF A27$ = "equip HEAD" THEN EqHead
        IF A27$ = "equip HEAD" GOTO 605

        IF A27$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 605
            END IF
        END IF

        IF A27$ = "use golden skull" THEN
            IF Inventory(QITEM_GOLDEN_SKULL).amount >= 1 THEN
                Inventory(QITEM_GOLDEN_SKULL).amount = 0
                A26ChaosStar% = 1
                A27GoldSocket% = 1
                Inventory(QITEM_KEY2).amount = Inventory(QITEM_KEY2).amount + 1
                COLOR 5
                PRINT "You inserted the gold skull into the gold socket, the skull locks in place."
                PRINT "a key, type 2 falls out of the skull's eye, you take it."
                COLOR 15
                GOTO 605
            END IF
        END IF

        IF A27$ = "use jade skull" THEN
            IF Inventory(QITEM_JADE_SKULL).amount >= 1 THEN
                Inventory(QITEM_JADE_SKULL).amount = 0
                A27JadeSocket% = 1
                COLOR 5
                PRINT "You have inserted the jade skull into the jade socket, the skull locks in place."
                PRINT "suddenly the wall starts sliding down into the floor revealing a laughing skeleton."
                PRINT "decked out in black armour."
                COLOR 15
                SLEEP 7
                WightLord% = 1
                BATTLE
                WightLord% = 2
                A27JadeSocket% = 3
                GOTO 600
            END IF
        END IF

        IF A27$ = "get special sword" THEN
            IF A27AvengerSword% = 0 THEN
                IF A27JadeSocket% = 1 THEN
                    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).amount = Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).amount + 1
                    A27AvengerSword% = 1
                    ColorPrint 5, "You got the sword, it is an Avenger Sword +7"
                    GOTO 605
                END IF
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 605

    'Area 28
    610 CLS
    PRINT "You have entered a room with a raised platform in the middle.  On the"
    PRINT "raised platform is a stand.";
    IF A28ChaosStarSocket% = 0 THEN
        PRINT "  On the stand is an empty socket in the"
        PRINT "shape of a chaos star."
        END IF
    IF A28ChaosStarSocket% = 1 THEN
        PRINT "  On the stand is your socketed chaos star"
        PRINT "pendant."
    END IF

    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         South: Small Shrine"
    COLOR 15
    615 INPUT ">", A28$
        IF A28$ = "south" GOTO 590

        IF A28$ = "help" THEN WorldHelp
        IF A28$ = "help" GOTO 615

        IF A28$ = "menu" THEN MainMenu
        IF A28$ = "menu" GOTO 610

        IF A28$ = "describe" GOTO 610

        IF A28$ = "stats" THEN displaystats
        IF A28$ = "stats" GOTO 615

        IF A28$ = "inventory" THEN displayinventory
        IF A28$ = "inventory" GOTO 615

        IF A28$ = "equipment" THEN displayequip
        IF A28$ = "equipment" GOTO 615

        IF A28$ = "equip LH" THEN EQlh
        IF A28$ = "equip LH" GOTO 615

        IF A28$ = "equip RH" THEN EQrh
        IF A28$ = "equip RH" GOTO 615

        IF A28$ = "equip ARMOUR" THEN EqArmour
        IF A28$ = "equip ARMOUR" GOTO 615

        IF A28$ = "equip HEAD" THEN EqHead
        IF A28$ = "equip HEAD" GOTO 615

        IF A28$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 615
            END IF
        END IF

        IF A28$ = "use chaos star pendant" THEN
            IF Inventory(QITEM_CHAOS_STAR).amount >= 1 THEN
                ColorPrint 5, "You inserted the chaos star pendant into the socket."
                ChaosStarInsert% = 1
                A28ChaosStarSocket% = 1
                Inventory(QITEM_CHAOS_STAR).amount = Inventory(QITEM_CHAOS_STAR).amount - 1
                GOTO 615
            END IF
        END IF

        IF A28$ = "get chaos star pendant" THEN
            IF A28ChaosStarSocket% = 1 THEN
                ColorPrint 5, "Got chaos star pendant from the socket."
                ChaosStarInsert% = 0
                A28ChaosStarSocket% = 0
                Inventory(QITEM_CHAOS_STAR).amount = Inventory(QITEM_CHAOS_STAR).amount + 1
                GOTO 615
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 615

    'Area 29
    620 CLS
    PRINT "You are now standing in some kind of lift.  The room is bare except for"
    PRINT "a large chaos star burned into the middle.";
    IF A29StarSocket% = 0 THEN
        PRINT "  In the middle of the lift"
        PRINT "is a socket in the shape of a chaos star."
    END IF

    IF A29StarSocket% = 1 THEN
        PRINT "  Your chaos star pendant lies"
        PRINT "inside the socket in the middle of the lift."
    END IF

    IF A29StarSocket% = 2 THEN
        PRINT "  Your chaos star pendant lies"
        PRINT "locked inside the socket.  You can't get it."
    END IF

    COLOR 5
    IF A29StarSocket% = 0 THEN
        PRINT "There is one obvious exit:"
        PRINT "         South: Intersection"
    END IF

    IF A29StarSocket% = 1 THEN
        PRINT "There are two obvious exits:"
        PRINT "         South: Intersection"
        PRINT "         Down: Underground Level 3"
    END IF

    IF A29StarSocket% = 2 THEN
        PRINT "There are two obvious exits:"
        PRINT "         South: Intersection"
        PRINT "         Down: Underground Level 3"
    END IF

    COLOR 15
    625 INPUT ">", A29$
        IF A29$ = "south" GOTO 520
        IF A29$ = "down" THEN
            IF A29StarSocket% = 1 GOTO 650
            IF A29StarSocket% = 2 GOTO 650
        END IF

        IF A29$ = "help" THEN WorldHelp
        IF A29$ = "help" GOTO 625

        IF A29$ = "menu" THEN MainMenu
        IF A29$ = "menu" GOTO 620

        IF A29$ = "describe" GOTO 620

        IF A29$ = "stats" THEN displaystats
        IF A29$ = "stats" GOTO 625

        IF A29$ = "inventory" THEN displayinventory
        IF A29$ = "inventory" GOTO 625

        IF A29$ = "equipment" THEN displayequip
        IF A29$ = "equipment" GOTO 625

        IF A29$ = "equip LH" THEN EQlh
        IF A29$ = "equip LH" GOTO 625

        IF A29$ = "equip RH" THEN EQrh
        IF A29$ = "equip RH" GOTO 625

        IF A29$ = "equip ARMOUR" THEN EqArmour
        IF A29$ = "equip ARMOUR" GOTO 625

        IF A29$ = "equip HEAD" THEN EqHead
        IF A29$ = "equip HEAD" GOTO 625

        IF A29$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 625
            END IF
        END IF

        IF A29$ = "use chaos star pendant" THEN
            IF Inventory(QITEM_CHAOS_STAR).amount >= 1 THEN
                ColorPrint 5, "You inserted the chaos star pendant into the socket."
                A29StarSocket% = 1
                Inventory(QITEM_CHAOS_STAR).amount = Inventory(QITEM_CHAOS_STAR).amount - 1
                GOTO 625
            END IF
        END IF

        IF A29$ = "get chaos star pendant" THEN
            IF A29StarSocket% = 1 THEN
                A29StarSocket% = 0
                Inventory(QITEM_CHAOS_STAR).amount = Inventory(QITEM_CHAOS_STAR).amount + 1
                ColorPrint 5, "Got chaos star pendant"
                GOTO 625
            END IF
            IF A29StarSocket% = 2 THEN
                COLOR 5
                PRINT "The chaos star pendant is locked in place."
                PRINT "you can't get it."
                GOTO 625
                COLOR 15
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 625

    'Area 30
    630 CLS
    PRINT "You have entered a large open space with a chasm in the middle. You can't"
    PRINT "see the bottom of the chasm.  Other than that the area is plain."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: Intersection"
    PRINT "         East: Chasm"
    COLOR 15
    635 INPUT ">", A30$
        IF A30$ = "north" GOTO 540
        IF A30$ = "east" GOTO 640

        IF A30$ = "help" THEN WorldHelp
        IF A30$ = "help" GOTO 635

        IF A30$ = "menu" THEN MainMenu
        IF A30$ = "menu" GOTO 630

        IF A30$ = "describe" GOTO 630

        IF A30$ = "stats" THEN displaystats
        IF A30$ = "stats" GOTO 635

        IF A30$ = "inventory" THEN displayinventory
        IF A30$ = "inventory" GOTO 635

        IF A30$ = "equipment" THEN displayequip
        IF A30$ = "equipment" GOTO 635

        IF A30$ = "equip LH" THEN EQlh
        IF A30$ = "equip LH" GOTO 635

        IF A30$ = "equip RH" THEN EQrh
        IF A30$ = "equip RH" GOTO 635

        IF A30$ = "equip ARMOUR" THEN EqArmour
        IF A30$ = "equip ARMOUR" GOTO 635

        IF A30$ = "equip HEAD" THEN EqHead
        IF A30$ = "equip HEAD" GOTO 635

        IF A30$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 635
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 635

    'Area 31
    640 CLS
    PRINT "You have arrived at the eastern edge of the chasm.  The area around you"
    PRINT "is very open, but plain.  You can see no enemies in the area."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: Intersection"
    PRINT "         West: Chasm"
    COLOR 15
    645 INPUT ">", A31$
        IF A31$ = "north" GOTO 550
        IF A31$ = "west" GOTO 630

        IF A31$ = "help" THEN WorldHelp
        IF A31$ = "help" GOTO 645

        IF A31$ = "menu" THEN MainMenu
        IF A31$ = "menu" GOTO 640

        IF A31$ = "describe" GOTO 640

        IF A31$ = "stats" THEN displaystats
        IF A31$ = "stats" GOTO 645

        IF A31$ = "inventory" THEN displayinventory
        IF A31$ = "inventory" GOTO 645

        IF A31$ = "equipment" THEN displayequip
        IF A31$ = "equipment" GOTO 645

        IF A31$ = "equip LH" THEN EQlh
        IF A31$ = "equip LH" GOTO 645

        IF A31$ = "equip RH" THEN EQrh
        IF A31$ = "equip RH" GOTO 645

        IF A31$ = "equip ARMOUR" THEN EqArmour
        IF A31$ = "equip ARMOUR" GOTO 645

        IF A31$ = "equip HEAD" THEN EqHead
        IF A31$ = "equip HEAD" GOTO 645

        IF A31$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 645
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 645

    'Area 32
    650 CLS
    BottomLift% = 0
    XanathusHP% = 150

    PRINT "The lift has stopped at level 3.  This appears to be the lowest level"
    PRINT "the lift can go to.";
    IF A29StarSocket% = 1 THEN
        IF StrangePendantTaken% = 1 THEN
            A29StarSocket% = 2
            PRINT "  Your chaos pendant suddenly locks into the socket,"
            PRINT "you can't get it."
        END IF
    END IF
    IF A29StarSocket% = 2 THEN PRINT "  Your chaos star pendant lies locked in place."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         Up: Underground, level 2"
    PRINT "         South: lift's exit"
    COLOR 15
    655 INPUT ">", A32$
        IF A32$ = "up" THEN
            IF A29StarSocket% = 0 THEN
                ColorPrint 5, "The lift doesn't seem to move"
                GOTO 655
            END IF

            GOTO 620
        END IF

        IF A32$ = "south" THEN
            ToHall% = 1
            Act1Pt2
        END IF

        IF A32$ = "help" THEN WorldHelp
        IF A32$ = "help" GOTO 655

        IF A32$ = "menu" THEN MainMenu
        IF A32$ = "menu" GOTO 650

        IF A32$ = "describe" GOTO 650

        IF A32$ = "stats" THEN displaystats
        IF A32$ = "stats" GOTO 655

        IF A32$ = "inventory" THEN displayinventory
        IF A32$ = "inventory" GOTO 655

        IF A32$ = "equipment" THEN displayequip
        IF A32$ = "equipment" GOTO 655

        IF A32$ = "equip LH" THEN EQlh
        IF A32$ = "equip LH" GOTO 655

        IF A32$ = "equip RH" THEN EQrh
        IF A32$ = "equip RH" GOTO 655

        IF A32$ = "equip ARMOUR" THEN EqArmour
        IF A32$ = "equip ARMOUR" GOTO 655

        IF A32$ = "equip HEAD" THEN EqHead
        IF A32$ = "equip HEAD" GOTO 655

        IF A32$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 655
            END IF
        END IF

        IF A32$ = "get chaos star pendant" THEN
            IF A29StarSocket% = 1 THEN
                A29StarSocket% = 0
                Inventory(QITEM_CHAOS_STAR).amount = Inventory(QITEM_CHAOS_STAR).amount + 1
                ColorPrint 5, "Got chaos star pendant"
                GOTO 655
            END IF
            IF A29StarSocket% = 2 THEN
                COLOR 5
                PRINT "The chaos star pendant is locked in place."
                PRINT "you can't get it."
                COLOR 15
                GOTO 655
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 655
END SUB

REM $STATIC
SUB Act1Pt2
    GameOn% = 1

    IF LadderDown% = 1 GOTO 660
    IF ToHall% = 1 GOTO 670
    IF AEncampmentUsePillar% = 1 GOTO 990
    IF JustLoaded% = 1 THEN
        IF SavePos% = 1 THEN
            CLS

            XanathusHP% = 150
            PRINT "You have re-entered the world of Fargaia, good luck on your quest."
            SLEEP 4
            GOTO 670
        END IF

        IF SavePos% = 2 THEN
            CLS

            PRINT "You have re-entered the world of Fargaia, good luck on your quest."
            SLEEP 4
            GOTO 990
        END IF
    END IF

    ''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''
    '''''START OF Necrotalia's labrynth LEVEL 1'''''
    ''''''''''''''''''NO BATTLES''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''
    'Area 33
    660 CLS
    XanathusHP% = 150
    LadderDown% = 0
    PRINT "You have entered a small chamber with a hidden door and a ladder."
    PRINT "The ladder seems to go far up to level 1."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         West: hidden door"
    PRINT "         Up: Underground level 1"
    COLOR 15
    665 INPUT ">", A33$
        IF A33$ = "up" THEN
            LadderUp% = 1
            ACT1
        END IF

        IF A33$ = "west" THEN
            A34SecretDoor% = 1
            GOTO 670
        END IF

        IF A33$ = "help" THEN WorldHelp
        IF A33$ = "help" GOTO 665

        IF A33$ = "menu" THEN MainMenu
        IF A33$ = "menu" GOTO 660

        IF A33$ = "describe" GOTO 660

        IF A33$ = "stats" THEN displaystats
        IF A33$ = "stats" GOTO 665

        IF A33$ = "inventory" THEN displayinventory
        IF A33$ = "inventory" GOTO 665

        IF A33$ = "equipment" THEN displayequip
        IF A33$ = "equipment" GOTO 665

        IF A33$ = "equip LH" THEN EQlh
        IF A33$ = "equip LH" GOTO 665

        IF A33$ = "equip RH" THEN EQrh
        IF A33$ = "equip RH" GOTO 665

        IF A33$ = "equip ARMOUR" THEN EqArmour
        IF A33$ = "equip ARMOUR" GOTO 665

        IF A33$ = "equip HEAD" THEN EqHead
        IF A33$ = "equip HEAD" GOTO 665

        IF A33$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 665
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 665

    'Area 34
    670 CLS
    ToHall% = 0
    XanathusArea$ = "N"
    PRINT "You have entered a small hallway with walls on all sides, to the southern"
    PRINT "end of this hallway is a large open area, it appears that this is another"
    PRINT "area of the city.  Faintly in the distance however you see what looks like"
    PRINT "watch towers.  Sir Jacob is standing to your left."
    PRINT ""
    IF A34Cutscene% = 0 THEN
        IF A34CutsceneDone% = 0 THEN
            COLOR 14
            PRINT "Sir Jacob> Well, the night air is refreshing, no?"
            SLEEP 3
            PRINT Name$; "> It certainly is..."
            SLEEP 1
            PRINT "Sir Jacob> I believe we are standing near the entrance to Necrotalia's"
            PRINT "           labrynth. Be on your guard, I expect this area to be well "
            PRINT "           protected."
            SLEEP 3
            COLOR 15
            A34CutsceneDone% = 1
        END IF
    END IF
    COLOR 5
    IF A34SecretDoor% = 0 THEN
        PRINT "There are two obvious exits:"
        PRINT "         North: Lift"
        PRINT "         South: Open area"
    END IF
    IF A34SecretDoor% = 1 THEN
        PRINT "There are three obvious exits:"
        PRINT "         North: Lift"
        PRINT "         East: Secret door"
        PRINT "         South: Open area"
    END IF
    COLOR 15
    675 INPUT ">", A34$
        IF A34$ = "north" THEN
            BottomLift% = 1
            ACT1
        END IF

        IF A34$ = "south" GOTO 750
        IF A34$ = "east" THEN
            IF A34SecretDoor% = 1 GOTO 660
        END IF

        IF A34$ = "help" THEN WorldHelp
        IF A34$ = "help" GOTO 675

        IF A34$ = "menu" THEN MainMenu
        IF A34$ = "menu" GOTO 670

        IF A34$ = "describe" GOTO 670

        IF A34$ = "stats" THEN displaystats
        IF A34$ = "stats" GOTO 675

        IF A34$ = "inventory" THEN displayinventory
        IF A34$ = "inventory" GOTO 675

        IF A34$ = "equipment" THEN displayequip
        IF A34$ = "equipment" GOTO 675

        IF A34$ = "equip LH" THEN EQlh
        IF A34$ = "equip LH" GOTO 675

        IF A34$ = "equip RH" THEN EQrh
        IF A34$ = "equip RH" GOTO 675

        IF A34$ = "equip ARMOUR" THEN EqArmour
        IF A34$ = "equip ARMOUR" GOTO 675

        IF A34$ = "equip HEAD" THEN EqHead
        IF A34$ = "equip HEAD" GOTO 675

        IF A34$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 675
            END IF
        END IF

        IF A34$ = "talk to sir jacob" THEN
            PRINT "Sir Jacob casts a spell of healing on you."
            PRINT "Your familiar is healed."
            HPS% = HP%
            FAMILIARHP% = FamiliarHPS%
            COLOR 5
            PRINT "Sir Jacob>Be sure you are prepared."
    677             PRINT "Do you wish to save <Y/N>?"
            COLOR 15
            INPUT ">", Save$
                IF Save$ = "y" THEN
                    SavePos% = 1
                    SaveGame
                    ColorPrint 5, "Game Saved"
                    GOTO 675
                END IF

                IF Save$ = "n" GOTO 675
            ColorPrint 5, "Huh?"
            GOTO 677
        END IF

    ColorPrint 5, "Huh?"
    GOTO 675

    'Area 35
    680 CLS
    PRINT "You are now standing in the north western area of the encampment."
    PRINT "it is possible to climb the watch tower from here."
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "NW" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         East: northern area"
    PRINT "         South: western area"
    PRINT "         Up: Watch tower"
    COLOR 15
    685 INPUT ">", A35$
        IF A35$ = "east" GOTO 750
        IF A35$ = "south" GOTO 690
        IF A35$ = "up" GOTO 760

        IF A35$ = "help" THEN WorldHelp
        IF A35$ = "help" GOTO 685

        IF A35$ = "menu" THEN MainMenu
        IF A35$ = "menu" GOTO 680

        IF A35$ = "describe" GOTO 680

        IF A35$ = "stats" THEN displaystats
        IF A35$ = "stats" GOTO 685

        IF A35$ = "inventory" THEN displayinventory
        IF A35$ = "inventory" GOTO 685

        IF A35$ = "equipment" THEN displayequip
        IF A35$ = "equipment" GOTO 685

        IF A35$ = "equip LH" THEN EQlh
        IF A35$ = "equip LH" GOTO 685

        IF A35$ = "equip RH" THEN EQrh
        IF A35$ = "equip RH" GOTO 685

        IF A35$ = "equip ARMOUR" THEN EqArmour
        IF A35$ = "equip ARMOUR" GOTO 685

        IF A35$ = "equip HEAD" THEN EqHead
        IF A35$ = "equip HEAD" GOTO 685

        IF A35$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 685
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 685

    'Area 36
    690 CLS
    PRINT "You are now standing in the western area of the encampment."
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "W" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: northwestern area"
    PRINT "         South: southwestern area"
    COLOR 15
    695 INPUT ">", A36$
        IF A36$ = "north" GOTO 680
        IF A36$ = "south" GOTO 700

        IF A36$ = "help" THEN WorldHelp
        IF A36$ = "help" GOTO 695

        IF A36$ = "menu" THEN MainMenu
        IF A36$ = "menu" GOTO 690

        IF A36$ = "describe" GOTO 690

        IF A36$ = "stats" THEN displaystats
        IF A36$ = "stats" GOTO 695

        IF A36$ = "inventory" THEN displayinventory
        IF A36$ = "inventory" GOTO 695

        IF A36$ = "equipment" THEN displayequip
        IF A36$ = "equipment" GOTO 695

        IF A36$ = "equip LH" THEN EQlh
        IF A36$ = "equip LH" GOTO 695

        IF A36$ = "equip RH" THEN EQrh
        IF A36$ = "equip RH" GOTO 695

        IF A36$ = "equip ARMOUR" THEN EqArmour
        IF A36$ = "equip ARMOUR" GOTO 695

        IF A36$ = "equip HEAD" THEN EqHead
        IF A36$ = "equip HEAD" GOTO 695

        IF A36$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 695
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 695

    'Area 37
    700 CLS
    PRINT "You are now standing in the southwestern area of the encampment."
    PRINT "It is possible to enter the watch tower from here."
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "SW" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Western area"
    PRINT "         East: Southern area"
    PRINT "         Up: Watch tower"
    COLOR 15
    705 INPUT ">", A37$
        IF A37$ = "north" GOTO 690
        IF A37$ = "east" GOTO 710
        IF A37$ = "up" GOTO 770

        IF A37$ = "help" THEN WorldHelp
        IF A37$ = "help" GOTO 705

        IF A37$ = "menu" THEN MainMenu
        IF A37$ = "menu" GOTO 700

        IF A37$ = "describe" GOTO 700

        IF A37$ = "stats" THEN displaystats
        IF A37$ = "stats" GOTO 705

        IF A37$ = "inventory" THEN displayinventory
        IF A37$ = "inventory" GOTO 705

        IF A37$ = "equipment" THEN displayequip
        IF A37$ = "equipment" GOTO 705

        IF A37$ = "equip LH" THEN EQlh
        IF A37$ = "equip LH" GOTO 705

        IF A37$ = "equip RH" THEN EQrh
        IF A37$ = "equip RH" GOTO 705

        IF A37$ = "equip ARMOUR" THEN EqArmour
        IF A37$ = "equip ARMOUR" GOTO 705

        IF A37$ = "equip HEAD" THEN EqHead
        IF A37$ = "equip HEAD" GOTO 705

        IF A37$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 705
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 705

    'Area 38
    710 CLS
    PRINT "You are now standing in the southern area"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "S" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         East: Southeastern area"
    PRINT "         West: Southwestern area"
    COLOR 15
    715 INPUT ">", A38$
        IF A38$ = "east" GOTO 720
        IF A38$ = "west" GOTO 700

        IF A38$ = "help" THEN WorldHelp
        IF A38$ = "help" GOTO 715

        IF A38$ = "menu" THEN MainMenu
        IF A38$ = "menu" GOTO 710

        IF A38$ = "describe" GOTO 710

        IF A38$ = "stats" THEN displaystats
        IF A38$ = "stats" GOTO 715

        IF A38$ = "inventory" THEN displayinventory
        IF A38$ = "inventory" GOTO 715

        IF A38$ = "equipment" THEN displayequip
        IF A38$ = "equipment" GOTO 715

        IF A38$ = "equip LH" THEN EQlh
        IF A38$ = "equip LH" GOTO 715

        IF A38$ = "equip RH" THEN EQrh
        IF A38$ = "equip RH" GOTO 715

        IF A38$ = "equip ARMOUR" THEN EqArmour
        IF A38$ = "equip ARMOUR" GOTO 715

        IF A38$ = "equip HEAD" THEN EqHead
        IF A38$ = "equip HEAD" GOTO 715

        IF A38$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 715
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 715

    'Area 39
    720 CLS
    PRINT "You are now standing in the southeastern area."
    PRINT "It is possible to climb the watchtower from here."
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "SE" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Eastern area"
    PRINT "         West: Southern area"
    PRINT "         Up: Watch tower"
    COLOR 15
    725 INPUT ">", A39$
        IF A39$ = "north" GOTO 730
        IF A39$ = "west" GOTO 710
        IF A39$ = "up" GOTO 780

        IF A39$ = "help" THEN WorldHelp
        IF A39$ = "help" GOTO 725

        IF A39$ = "menu" THEN MainMenu
        IF A39$ = "menu" GOTO 720

        IF A39$ = "describe" GOTO 720

        IF A39$ = "stats" THEN displaystats
        IF A39$ = "stats" GOTO 725

        IF A39$ = "inventory" THEN displayinventory
        IF A39$ = "inventory" GOTO 725

        IF A39$ = "equipment" THEN displayequip
        IF A39$ = "equipment" GOTO 725

        IF A39$ = "equip LH" THEN EQlh
        IF A39$ = "equip LH" GOTO 725

        IF A39$ = "equip RH" THEN EQrh
        IF A39$ = "equip RH" GOTO 725

        IF A39$ = "equip ARMOUR" THEN EqArmour
        IF A39$ = "equip ARMOUR" GOTO 725

        IF A39$ = "equip HEAD" THEN EqHead
        IF A39$ = "equip HEAD" GOTO 725

        IF A39$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 725
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 725

    'Area 40
    730 CLS
    PRINT "You are now standing in the eastern area"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "E" THEN
        COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: NorthEastern area"
    PRINT "         South: SouthEastern area"
    COLOR 15
    735 INPUT ">", A40$
        IF A40$ = "north" GOTO 740
        IF A40$ = "south" GOTO 720

        IF A40$ = "help" THEN WorldHelp
        IF A40$ = "help" GOTO 735

        IF A40$ = "menu" THEN MainMenu
        IF A40$ = "menu" GOTO 730

        IF A40$ = "describe" GOTO 730

        IF A40$ = "stats" THEN displaystats
        IF A40$ = "stats" GOTO 735

        IF A40$ = "inventory" THEN displayinventory
        IF A40$ = "inventory" GOTO 735

        IF A40$ = "equipment" THEN displayequip
        IF A40$ = "equipment" GOTO 735

        IF A40$ = "equip LH" THEN EQlh
        IF A40$ = "equip LH" GOTO 735

        IF A40$ = "equip RH" THEN EQrh
        IF A40$ = "equip RH" GOTO 735

        IF A40$ = "equip ARMOUR" THEN EqArmour
        IF A40$ = "equip ARMOUR" GOTO 735

        IF A40$ = "equip HEAD" THEN EqHead
        IF A40$ = "equip HEAD" GOTO 735

        IF A40$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 735
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 735

    'Area 41
    740 CLS
    PRINT "You are now standing in the northeastern area"
    PRINT "it is possible to access the watch tower from here"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "NE" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         West: Northern area"
    PRINT "         South: Eastern area"
    PRINT "         Up: Watch tower"
    COLOR 15
    745 INPUT ">", A41$
        IF A41$ = "west" GOTO 750
        IF A41$ = "south" GOTO 730
        IF A41$ = "up" GOTO 790

        IF A41$ = "help" THEN WorldHelp
        IF A41$ = "help" GOTO 745

        IF A41$ = "menu" THEN MainMenu
        IF A41$ = "menu" GOTO 740

        IF A41$ = "describe" GOTO 740

        IF A41$ = "stats" THEN displaystats
        IF A41$ = "stats" GOTO 745

        IF A41$ = "inventory" THEN displayinventory
        IF A41$ = "inventory" GOTO 745

        IF A41$ = "equipment" THEN displayequip
        IF A41$ = "equipment" GOTO 745

        IF A41$ = "equip LH" THEN EQlh
        IF A41$ = "equip LH" GOTO 745

        IF A41$ = "equip RH" THEN EQrh
        IF A41$ = "equip RH" GOTO 745

        IF A41$ = "equip ARMOUR" THEN EqArmour
        IF A41$ = "equip ARMOUR" GOTO 745

        IF A41$ = "equip HEAD" THEN EqHead
        IF A41$ = "equip HEAD" GOTO 745

        IF A41$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 745
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 745

    'Area 42
    750 CLS
    PRINT "You have entered the northern area of this encampment."
    IF A42Cutscene% = 0 THEN
        PRINT "You make out the form of a watch tower.  Suddenly an arrow whizzes"
        PRINT "by your head.  Up on the tower you notice several skeletons with "
        PRINT "long bows."
        COLOR 14
        PRINT ""
        PRINT "Sir Jacob> Run!"
        SLEEP 4
        PRINT "Sir Jacob casts a spell of excorism on the skeletons, immediately after"
        PRINT "they shatter into seperate bones."
        PRINT ""
        PRINT "Unknown Voice> ha! ha! ha! amusing... but you can't defeat the armies"
        PRINT "of the dead which belong to me! the great necromancer Xanathus!"
        SLEEP 4
        PRINT ""
        PRINT "Sir Jacob> perfect....."; Name$; " go and get him! I'll take care of the"
        PRINT "skeletons."
        SLEEP 3
        PRINT ""
        PRINT Name$; ">Right!"
        SLEEP 1
        COLOR 15
        XanathusArea$ = "NW"
    A42Cutscene% = 1
    END IF

    IF XanathusDead% = 0 THEN
        XanathusTaunt
        XanathusWorldFlee
        IF XanathusArea$ = "N" THEN
            COLOR 12
            PRINT "You found Xanathus!"
            SLEEP 3
            XanathusBattle
        END IF
    END IF

    IF A42LockedGate% = 0 THEN
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: Hall"
    PRINT "         East: Northeast area"
    PRINT "         West: Northwest area"
    PRINT "         South: Locked Gate"
    COLOR 15
    END IF
    IF A42LockedGate% = 1 THEN
    COLOR 5
    PRINT "There are four obvious exits:"
    PRINT "         North: Hall"
    PRINT "         East: Northeast area"
    PRINT "         West: Northwest area"
    PRINT "         South: Inside Encampment"
    COLOR 15
    END IF
    755 INPUT ">", A42$
        IF A42$ = "north" GOTO 670
        IF A42$ = "east" GOTO 740
        IF A42$ = "west" GOTO 680
        IF A42$ = "south" THEN
            IF A42LockedGate% = 0 THEN
                ColorPrint 5, "You are blocked by a locked gate"
                GOTO 755
            END IF
            IF A42LockedGate% = 1 GOTO 800
        END IF

        IF A42$ = "help" THEN WorldHelp
        IF A42$ = "help" GOTO 755

        IF A42$ = "menu" THEN MainMenu
        IF A42$ = "menu" GOTO 750

        IF A42$ = "describe" GOTO 750

        IF A42$ = "stats" THEN displaystats
        IF A42$ = "stats" GOTO 755

        IF A42$ = "inventory" THEN displayinventory
        IF A42$ = "inventory" GOTO 755

        IF A42$ = "equipment" THEN displayequip
        IF A42$ = "equipment" GOTO 755

        IF A42$ = "equip LH" THEN EQlh
        IF A42$ = "equip LH" GOTO 755

        IF A42$ = "equip RH" THEN EQrh
        IF A42$ = "equip RH" GOTO 755

        IF A42$ = "equip ARMOUR" THEN EqArmour
        IF A42$ = "equip ARMOUR" GOTO 755

        IF A42$ = "equip HEAD" THEN EqHead
        IF A42$ = "equip HEAD" GOTO 755

        IF A42$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 755
            END IF
        END IF

        IF A42$ = "use gate key" THEN
            IF Inventory(QITEM_GATE_KEY).amount >= 1 THEN
                Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount - 1
                COLOR 5
                PRINT "You have used the gate key, it unlocks the gate."
                PRINT "The key turns to dust in your hand."
                COLOR 15
                A42LockedGate% = 1
                GOTO 755
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 755
    'Area 43
    760 CLS
    PRINT "You are now standing on the northwestern guard tower."
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        COLOR 14
        IF XanathusArea$ = "NW" THEN PRINT "You see Xanathus in the North Western area"
        IF XanathusArea$ = "N" THEN PRINT "You see Xanathus in the Northern area"
        IF XanathusArea$ = "NE" THEN PRINT "You see Xanathus in the North Eastern area"
        IF XanathusArea$ = "E" THEN PRINT "You see Xanathus in the Eastern area"
        IF XanathusArea$ = "SE" THEN PRINT "You see Xanathus in the South Eastern area"
        IF XanathusArea$ = "S" THEN PRINT "You see Xanathus in the Southern area"
        IF XanathusArea$ = "SW" THEN PRINT "You see Xanathus in the South Western area"
        IF XanathusArea$ = "W" THEN PRINT "You see Xanathus in the Western area"
        COLOR 15
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         Down: Northwestern area"
    COLOR 15
    765 INPUT ">", A43$
        IF A43$ = "down" GOTO 680

        IF A43$ = "help" THEN WorldHelp
        IF A43$ = "help" GOTO 765

        IF A43$ = "menu" THEN MainMenu
        IF A43$ = "menu" GOTO 760

        IF A43$ = "describe" GOTO 760

        IF A43$ = "stats" THEN displaystats
        IF A43$ = "stats" GOTO 765

        IF A43$ = "inventory" THEN displayinventory
        IF A43$ = "inventory" GOTO 765

        IF A43$ = "equipment" THEN displayequip
        IF A43$ = "equipment" GOTO 765

        IF A43$ = "equip LH" THEN EQlh
        IF A43$ = "equip LH" GOTO 765

        IF A43$ = "equip RH" THEN EQrh
        IF A43$ = "equip RH" GOTO 765

        IF A43$ = "equip ARMOUR" THEN EqArmour
        IF A43$ = "equip ARMOUR" GOTO 765

        IF A43$ = "equip HEAD" THEN EqHead
        IF A43$ = "equip HEAD" GOTO 765

        IF A43$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 765
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 765

    'Area 44
    770 CLS
    PRINT "You are now standing on the southwestern watch tower"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        COLOR 14
        IF XanathusArea$ = "NW" THEN PRINT "You see Xanathus in the North Western area"
        IF XanathusArea$ = "N" THEN PRINT "You see Xanathus in the Northern area"
        IF XanathusArea$ = "NE" THEN PRINT "You see Xanathus in the North Eastern area"
        IF XanathusArea$ = "E" THEN PRINT "You see Xanathus in the Eastern area"
        IF XanathusArea$ = "SE" THEN PRINT "You see Xanathus in the South Eastern area"
        IF XanathusArea$ = "S" THEN PRINT "You see Xanathus in the Southern area"
        IF XanathusArea$ = "SW" THEN PRINT "You see Xanathus in the South Western area"
        IF XanathusArea$ = "W" THEN PRINT "You see Xanathus in the Western area"
        COLOR 15
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         Down: Southwestern area"
    COLOR 15
    775 INPUT ">", A44$
        IF A44$ = "down" GOTO 700

        IF A44$ = "help" THEN WorldHelp
        IF A44$ = "help" GOTO 775

        IF A44$ = "menu" THEN MainMenu
        IF A44$ = "menu" GOTO 770

        IF A44$ = "describe" GOTO 770

        IF A44$ = "stats" THEN displaystats
        IF A44$ = "stats" GOTO 775

        IF A44$ = "inventory" THEN displayinventory
        IF A44$ = "inventory" GOTO 775

        IF A44$ = "equipment" THEN displayequip
        IF A44$ = "equipment" GOTO 775

        IF A44$ = "equip LH" THEN EQlh
        IF A44$ = "equip LH" GOTO 775

        IF A44$ = "equip RH" THEN EQrh
        IF A44$ = "equip RH" GOTO 775

        IF A44$ = "equip ARMOUR" THEN EqArmour
        IF A44$ = "equip ARMOUR" GOTO 775

        IF A44$ = "equip HEAD" THEN EqHead
        IF A44$ = "equip HEAD" GOTO 775

        IF A44$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                   HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 775
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 775

    'Area 45
    780 CLS
    PRINT "You are now standing on the southeastern watch tower"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        COLOR 14
        IF XanathusArea$ = "NW" THEN PRINT "You see Xanathus in the North Western area"
        IF XanathusArea$ = "N" THEN PRINT "You see Xanathus in the Northern area"
        IF XanathusArea$ = "NE" THEN PRINT "You see Xanathus in the North Eastern area"
        IF XanathusArea$ = "E" THEN PRINT "You see Xanathus in the Eastern area"
        IF XanathusArea$ = "SE" THEN PRINT "You see Xanathus in the South Eastern area"
        IF XanathusArea$ = "S" THEN PRINT "You see Xanathus in the Southern area"
        IF XanathusArea$ = "SW" THEN PRINT "You see Xanathus in the South Western area"
        IF XanathusArea$ = "W" THEN PRINT "You see Xanathus in the Western area"
        COLOR 15
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         Down: Southeastern area"
    COLOR 15
    785 INPUT ">", A45$
        IF A45$ = "down" GOTO 720

        IF A45$ = "help" THEN WorldHelp
        IF A45$ = "help" GOTO 785

        IF A45$ = "menu" THEN MainMenu
        IF A45$ = "menu" GOTO 780

        IF A45$ = "describe" GOTO 780

        IF A45$ = "stats" THEN displaystats
        IF A45$ = "stats" GOTO 785

        IF A45$ = "inventory" THEN displayinventory
        IF A45$ = "inventory" GOTO 785

        IF A45$ = "equipment" THEN displayequip
        IF A45$ = "equipment" GOTO 785

        IF A45$ = "equip LH" THEN EQlh
        IF A45$ = "equip LH" GOTO 785

        IF A45$ = "equip RH" THEN EQrh
        IF A45$ = "equip RH" GOTO 785

        IF A45$ = "equip ARMOUR" THEN EqArmour
        IF A45$ = "equip ARMOUR" GOTO 785

        IF A45$ = "equip HEAD" THEN EqHead
        IF A45$ = "equip HEAD" GOTO 785

        IF A45$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 785
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 785

    'Area 46
    790 CLS
    PRINT "You are now standing on the northeastern watch tower"
    IF XanathusDead% = 0 THEN
        XanathusTaunt
        COLOR 14
        IF XanathusArea$ = "NW" THEN PRINT "You see Xanathus in the North Western area"
        IF XanathusArea$ = "N" THEN PRINT "You see Xanathus in the Northern area"
        IF XanathusArea$ = "NE" THEN PRINT "You see Xanathus in the North Eastern area"
        IF XanathusArea$ = "E" THEN PRINT "You see Xanathus in the Eastern area"
        IF XanathusArea$ = "SE" THEN PRINT "You see Xanathus in the South Eastern area"
        IF XanathusArea$ = "S" THEN PRINT "You see Xanathus in the Southern area"
        IF XanathusArea$ = "SW" THEN PRINT "You see Xanathus in the South Western area"
        IF XanathusArea$ = "W" THEN PRINT "You see Xanathus in the Western area"
        COLOR 15
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         Down: Northeastern area"
    COLOR 15
    795 INPUT ">", A46$
        IF A46$ = "down" GOTO 740

        IF A46$ = "help" THEN WorldHelp
        IF A46$ = "help" GOTO 795

        IF A46$ = "menu" THEN MainMenu
        IF A46$ = "menu" GOTO 790

        IF A46$ = "describe" GOTO 790

        IF A46$ = "stats" THEN displaystats
        IF A46$ = "stats" GOTO 795

        IF A46$ = "inventory" THEN displayinventory
        IF A46$ = "inventory" GOTO 795

        IF A46$ = "equipment" THEN displayequip
        IF A46$ = "equipment" GOTO 795

        IF A46$ = "equip LH" THEN EQlh
        IF A46$ = "equip LH" GOTO 795

        IF A46$ = "equip RH" THEN EQrh
        IF A46$ = "equip RH" GOTO 795

        IF A46$ = "equip ARMOUR" THEN EqArmour
        IF A46$ = "equip ARMOUR" GOTO 795

        IF A46$ = "equip HEAD" THEN EqHead
        IF A46$ = "equip HEAD" GOTO 795

        IF A46$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 795
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 795

    'Area 47
    800 CLS
    PRINT "You are now standing inside the encampment, except for a few tents and the"
    PRINT "campfire you see nothing special,  there is one thing however, a stairway"
    PRINT "leading down into the darkness."
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: Northern area"
    PRINT "         Down: the stairway"
    COLOR 15
    805 INPUT ">", A47$
        IF A47$ = "north" GOTO 750
        IF A47$ = "down" THEN
            GOTO 810
        END IF

        IF A47$ = "help" THEN WorldHelp
        IF A47$ = "help" GOTO 805

        IF A47$ = "menu" THEN MainMenu
        IF A47$ = "menu" GOTO 800

        IF A47$ = "describe" GOTO 800

        IF A47$ = "stats" THEN displaystats
        IF A47$ = "stats" GOTO 805

        IF A47$ = "inventory" THEN displayinventory
        IF A47$ = "inventory" GOTO 805

        IF A47$ = "equipment" THEN displayequip
        IF A47$ = "equipment" GOTO 805

        IF A47$ = "equip LH" THEN EQlh
        IF A47$ = "equip LH" GOTO 805

        IF A47$ = "equip RH" THEN EQrh
        IF A47$ = "equip RH" GOTO 805

        IF A47$ = "equip ARMOUR" THEN EqArmour
        IF A47$ = "equip ARMOUR" GOTO 805

        IF A47$ = "equip HEAD" THEN EqHead
        IF A47$ = "equip HEAD" GOTO 805

        IF A47$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 805
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 805

    ''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''
    '''''START OF Necrotalia's labrynth LEVEL 2'''''
    ''''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''''
    'Area 48
    810 CLS
    PRINT "You have descended down the stairwell into a poorly lit square room."

    IF A48BSphere% = 0 THEN
    PRINT "One wall has several markings on it that interest you.  When you look"
    PRINT "closer you notice a sphere shaped socket with burn marks around it."
    END IF

    IF A48BSphere% = 1 THEN PRINT "There is a passageway that leads to a bright red passage."

    COLOR 5
    IF A48BSphere% = 0 THEN
    PRINT "There is one obvious exit:"
    PRINT "         Up: The encampment"
    END IF
    IF A48BSphere% = 1 THEN
    PRINT "There are two obvious exits:"
    PRINT "         Up: The encampment"
    PRINT "         North: Red passage"
    END IF
    COLOR 15
    813 INPUT ">", A48$
        IF A48$ = "up" THEN
            GOTO 800
        END IF

        IF A48$ = "north" THEN
            IF A48BSphere% = 1 GOTO 815
        END IF

        IF A48$ = "help" THEN WorldHelp
        IF A48$ = "help" GOTO 813

        IF A48$ = "menu" THEN MainMenu
        IF A48$ = "menu" GOTO 810

        IF A48$ = "describe" GOTO 810

        IF A48$ = "stats" THEN displaystats
        IF A48$ = "stats" GOTO 813

        IF A48$ = "inventory" THEN displayinventory
        IF A48$ = "inventory" GOTO 813

        IF A48$ = "equipment" THEN displayequip
        IF A48$ = "equipment" GOTO 813

        IF A48$ = "equip LH" THEN EQlh
        IF A48$ = "equip LH" GOTO 813

        IF A48$ = "equip RH" THEN EQrh
        IF A48$ = "equip RH" GOTO 813

        IF A48$ = "equip ARMOUR" THEN EqArmour
        IF A48$ = "equip ARMOUR" GOTO 813

        IF A48$ = "equip HEAD" THEN EqHead
        IF A48$ = "equip HEAD" GOTO 815

        IF A48$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 813
            END IF
        END IF

        IF A48$ = "use burning sphere" THEN
            IF Inventory(QITEM_BURNING_SPHERE).amount >= 1 THEN
                Inventory(QITEM_BURNING_SPHERE).amount = Inventory(QITEM_BURNING_SPHERE).amount - 1
                A48BSphere% = 1
                COLOR 5
                PRINT "You inserted the burning sphere into the socket, suddenly the wall explodes"
                PRINT "revealing a bright red passage."
                COLOR 15
                GOTO 813
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 813

    'Area 49
    815 CLS
    PRINT "You have entered a bright red-orange passage with many torches burning"
    PRINT "high.  On the floor is a small raised platform with an orange gem"
    PRINT "embedded in it."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 815
        END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: passage"
    PRINT "         South: base of the stairs"
    COLOR 15
    817 INPUT ">", A49$
        IF A49$ = "north" GOTO 820
        IF A49$ = "south" GOTO 810
        IF A49$ = "examine orange gem" THEN
            PRINT "There is a small orange gem insterted into the floor. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Hatred."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    818             INPUT ">", OGEM$
                IF OGEM$ = "y" THEN
                    GemClicks(GEM_ORANGE) = 1
                    GemPuzzle
                    GOTO 817
                END IF
                IF OGEM$ = "n" THEN GOTO 817
                    ColorPrint 5, "Huh?"
                    GOTO 818
        END IF
        IF A49$ = "get orange gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 817
        END IF

        IF A49$ = "help" THEN WorldHelp
        IF A49$ = "help" GOTO 817

        IF A49$ = "menu" THEN MainMenu
        IF A49$ = "menu" GOTO 815

        IF A49$ = "describe" GOTO 815

        IF A49$ = "stats" THEN displaystats
        IF A49$ = "stats" GOTO 817

        IF A49$ = "inventory" THEN displayinventory
        IF A49$ = "inventory" GOTO 817

        IF A49$ = "equipment" THEN displayequip
        IF A49$ = "equipment" GOTO 817

        IF A49$ = "equip LH" THEN EQlh
        IF A49$ = "equip LH" GOTO 817

        IF A49$ = "equip RH" THEN EQrh
        IF A49$ = "equip RH" GOTO 817

        IF A49$ = "equip ARMOUR" THEN EqArmour
        IF A49$ = "equip ARMOUR" GOTO 817

        IF A49$ = "equip HEAD" THEN EqHead
        IF A49$ = "equip HEAD" GOTO 817

        IF A49$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 817
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 817

    'Area 50
    820 CLS
    PRINT "You are now standing in another section of the tunnel.  So far the tunnel"
    PRINT "hasn't shown any bends or turns."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 820
        END IF
    COLOR 5
    PRINT "There are two obvious exits:"
    PRINT "         North: Passageway"
    PRINT "         South: Passageway"
    COLOR 15
    825 INPUT ">", A50$
        IF A50$ = "north" GOTO 830
        IF A50$ = "south" GOTO 815

        IF A50$ = "help" THEN WorldHelp
        IF A50$ = "help" GOTO 820

        IF A50$ = "menu" THEN MainMenu
        IF A50$ = "menu" GOTO 820

        IF A50$ = "describe" GOTO 820

        IF A50$ = "stats" THEN displaystats
        IF A50$ = "stats" GOTO 825

        IF A50$ = "inventory" THEN displayinventory
        IF A50$ = "inventory" GOTO 825

        IF A50$ = "equipment" THEN displayequip
        IF A50$ = "equipment" GOTO 825

        IF A50$ = "equip LH" THEN EQlh
        IF A50$ = "equip LH" GOTO 825

        IF A50$ = "equip RH" THEN EQrh
        IF A50$ = "equip RH" GOTO 825

        IF A50$ = "equip ARMOUR" THEN EqArmour
        IF A50$ = "equip ARMOUR" GOTO 825

        IF A50$ = "equip HEAD" THEN EqHead
        IF A50$ = "equip HEAD" GOTO 825

        IF A50$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 825
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 825

    'Area 51
    830 CLS
    PRINT "You have entered a three way intersection, to the east and west are "
    PRINT "bending passageways.  To the south is the long passageway."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 830
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         East: Bending passage"
    PRINT "         West: Bending passage"
    PRINT "         South: long passageway"
    COLOR 15
    835 INPUT ">", A51$
        IF A51$ = "east" GOTO 850
        IF A51$ = "west" GOTO 840
        IF A51$ = "south" GOTO 820

        IF A51$ = "help" THEN WorldHelp
        IF A51$ = "help" GOTO 835

        IF A51$ = "menu" THEN MainMenu
        IF A51$ = "menu" GOTO 830

        IF A51$ = "describe" GOTO 830

        IF A51$ = "stats" THEN displaystats
        IF A51$ = "stats" GOTO 835

        IF A51$ = "inventory" THEN displayinventory
        IF A51$ = "inventory" GOTO 835

        IF A51$ = "equipment" THEN displayequip
        IF A51$ = "equipment" GOTO 835

        IF A51$ = "equip LH" THEN EQlh
        IF A51$ = "equip LH" GOTO 835

        IF A51$ = "equip RH" THEN EQrh
        IF A51$ = "equip RH" GOTO 835

        IF A51$ = "equip ARMOUR" THEN EqArmour
        IF A51$ = "equip ARMOUR" GOTO 835

        IF A51$ = "equip HEAD" THEN EqHead
        IF A51$ = "equip HEAD" GOTO 835

        IF A51$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 835
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 835

    'Area 52
    840 CLS
    PRINT "You are now standing in the southwestern area of a great hall."
    PRINT "the hall is strangely bare except for the large raised platform"
    PRINT "in the middle of the hall, which has the shape of a chaos star."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 840
        END IF
    COLOR 5
    PRINT "There are six obvious exits:"
    PRINT "         North: Northwestern area of the hall"
    PRINT "         NorthEast: Raised platform"
    PRINT "         East: Southeastern area of the hall"
    PRINT "         South: Bending passageway"
    PRINT "         SouthWest: Straight passageway"
    PRINT "         West: Bending passageway"
    COLOR 15
    845 INPUT ">", A52$
        IF A52$ = "north" GOTO 870
        IF A52$ = "northeast" GOTO 880
        IF A52$ = "east" GOTO 850
        IF A52$ = "south" GOTO 830
        IF A52$ = "southwest" GOTO 970
        IF A52$ = "west" GOTO 950

        IF A52$ = "help" THEN WorldHelp
        IF A52$ = "help" GOTO 845

        IF A52$ = "menu" THEN MainMenu
        IF A52$ = "menu" GOTO 840

        IF A52$ = "describe" GOTO 840

        IF A52$ = "stats" THEN displaystats
        IF A52$ = "stats" GOTO 845

        IF A52$ = "inventory" THEN displayinventory
        IF A52$ = "inventory" GOTO 845

        IF A52$ = "equipment" THEN displayequip
        IF A52$ = "equipment" GOTO 845

        IF A52$ = "equip LH" THEN EQlh
        IF A52$ = "equip LH" GOTO 845

        IF A52$ = "equip RH" THEN EQrh
        IF A52$ = "equip RH" GOTO 845

        IF A52$ = "equip ARMOUR" THEN EqArmour
        IF A52$ = "equip ARMOUR" GOTO 845

        IF A52$ = "equip HEAD" THEN EqHead
        IF A52$ = "equip HEAD" GOTO 845

        IF A52$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 845
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 845

    'Area 53
    850 CLS
    PRINT "You are now standing in the southeastern area of a great hall."
    PRINT "the hall is strangely bare except for the large raised platform"
    PRINT "in the middle of the hall, which has the shape of a chaos star."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 850
        END IF
    COLOR 5
    PRINT "There are six obvious exits:"
    PRINT "         North: NorthEastern area of the Hall"
    PRINT "         East: Bending passageway"
    PRINT "         Southeast: Straight passageway"
    PRINT "         South: Bending passageway"
    PRINT "         West: SouthWestern area of the Hall"
    PRINT "         NorthWest: Raised platform"
    COLOR 15
    855 INPUT ">", A53$
        IF A53$ = "north" GOTO 860
        IF A53$ = "east" GOTO 890
        IF A53$ = "southeast" GOTO 980
        IF A53$ = "south" GOTO 830
        IF A53$ = "west" GOTO 840
        IF A53$ = "northwest" GOTO 880

        IF A53$ = "help" THEN WorldHelp
        IF A53$ = "help" GOTO 855

        IF A50$ = "menu" THEN MainMenu
        IF A50$ = "menu" GOTO 850

        IF A50$ = "describe" GOTO 850

        IF A50$ = "stats" THEN displaystats
        IF A50$ = "stats" GOTO 855

        IF A50$ = "inventory" THEN displayinventory
        IF A50$ = "inventory" GOTO 855

        IF A50$ = "equipment" THEN displayequip
        IF A50$ = "equipment" GOTO 855

        IF A50$ = "equip LH" THEN EQlh
        IF A50$ = "equip LH" GOTO 855

        IF A50$ = "equip RH" THEN EQrh
        IF A50$ = "equip RH" GOTO 855

        IF A50$ = "equip ARMOUR" THEN EqArmour
        IF A50$ = "equip ARMOUR" GOTO 855

        IF A50$ = "equip HEAD" THEN EqHead
        IF A50$ = "equip HEAD" GOTO 855

        IF A50$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 855
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 855

    'Area 54
    860 CLS
    PRINT "You are now standing in the northeastern area of a great hall."
    PRINT "the hall is strangely bare except for the large raised platform"
    PRINT "in the middle of the hall, which has the shape of a chaos star."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 860
        END IF
    COLOR 5
    PRINT "There are six obvious exits:"
    PRINT "         North: Bending passageway"
    PRINT "         Northeast: Straight passageway"
    PRINT "         East: Bending passageway"
    PRINT "         South: SouthEastern section of the Hall"
    PRINT "         SouthWest: Raised platform"
    PRINT "         West: NorthWestern section of the Hall"
    COLOR 15
    865 INPUT ">", A54$
        IF A54$ = "north" GOTO 920
        IF A54$ = "northeast" GOTO 910
        IF A54$ = "east" GOTO 890
        IF A54$ = "south" GOTO 850
        IF A54$ = "southwest" GOTO 880
        IF A54$ = "west" GOTO 870

        IF A54$ = "help" THEN WorldHelp
        IF A54$ = "help" GOTO 865

        IF A54$ = "menu" THEN MainMenu
        IF A54$ = "menu" GOTO 860

        IF A54$ = "describe" GOTO 860

        IF A54$ = "stats" THEN displaystats
        IF A54$ = "stats" GOTO 865

        IF A54$ = "inventory" THEN displayinventory
        IF A54$ = "inventory" GOTO 865

        IF A54$ = "equipment" THEN displayequip
        IF A54$ = "equipment" GOTO 865

        IF A54$ = "equip LH" THEN EQlh
        IF A54$ = "equip LH" GOTO 865

        IF A54$ = "equip RH" THEN EQrh
        IF A54$ = "equip RH" GOTO 865

        IF A54$ = "equip ARMOUR" THEN EqArmour
        IF A54$ = "equip ARMOUR" GOTO 865

        IF A54$ = "equip HEAD" THEN EqHead
        IF A54$ = "equip HEAD" GOTO 865

        IF A54$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 865
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 865

    'Area 55
    870 CLS
    PRINT "You are now standing in the northwestern area of a great hall."
    PRINT "the hall is strangely bare except for the large raised platform"
    PRINT "in the middle of the hall, which has the shape of a chaos star."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 870
        END IF
    COLOR 5
    PRINT "There are six obvious exits:"
    PRINT "         North: Bending passageway"
    PRINT "         East: Northeastern section of the Hall"
    PRINT "         SouthEast: Raised Platform"
    PRINT "         South: Southwestern section of the Hall"
    PRINT "         West: Bending passageway"
    PRINT "         NorthWest: Straight passageway"
    COLOR 15
    875 INPUT ">", A55$
        IF A55$ = "north" GOTO 920
        IF A55$ = "east" GOTO 860
        IF A55$ = "southeast" GOTO 880
        IF A55$ = "south" GOTO 840
        IF A55$ = "west" GOTO 950
        IF A55$ = "northwest" GOTO 940

        IF A55$ = "help" THEN WorldHelp
        IF A55$ = "help" GOTO 875

        IF A55$ = "menu" THEN MainMenu
        IF A55$ = "menu" GOTO 870

        IF A55$ = "describe" GOTO 870

        IF A55$ = "stats" THEN displaystats
        IF A55$ = "stats" GOTO 875

        IF A55$ = "inventory" THEN displayinventory
        IF A55$ = "inventory" GOTO 875

        IF A55$ = "equipment" THEN displayequip
        IF A55$ = "equipment" GOTO 875

        IF A55$ = "equip LH" THEN EQlh
        IF A55$ = "equip LH" GOTO 875

        IF A55$ = "equip RH" THEN EQrh
        IF A55$ = "equip RH" GOTO 875

        IF A55$ = "equip ARMOUR" THEN EqArmour
        IF A55$ = "equip ARMOUR" GOTO 875

        IF A55$ = "equip HEAD" THEN EqHead
        IF A55$ = "equip HEAD" GOTO 875

        IF A55$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 875
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 875

    'Area 56
    880 CLS
    PRINT "You are now standing on the raised platform in the middle of the hall."
    PRINT "Below you is a strange symbol which has markings and text on it."
    IF A56VampFight% = 0 THEN
        A56VampFight% = 1
        COLOR 4
        PRINT "On the symbol stands a vampire!"
        SLEEP 3
        COLOR 15
        BATTLE2
        GOTO 880
    END IF
    IF A56VampFight% = 2 THEN
        ColorPrint 5, "The vampire is standing next to the symbol"
    END IF
    COLOR 5
    IF GemPuzzleDone% = 1 THEN
        COLOR 5
        PRINT "As you stand on the raised platform it begins lowering into the floor."
        SLEEP 5
        COLOR 15
        GOTO 990
    END IF
    PRINT "There are four obvious exits:"
    PRINT "         NorthEast: northeastern section of the hall"
    PRINT "         SouthEast: southeastern section of the hall"
    PRINT "         SouthWest: southwestern section of the hall"
    PRINT "         NorthWest: northwestern section of the hall"
    COLOR 15
    885 INPUT ">", A56$
        IF A56$ = "northeast" GOTO 860
        IF A56$ = "southeast" GOTO 850
        IF A56$ = "southwest" GOTO 840
        IF A56$ = "northwest" GOTO 870

        IF A56$ = "talk to vampire" THEN
            A56GetHint
            GOTO 885
        END IF

        IF A56$ = "examine symbol" THEN
            ExamineSymbol
            GOTO 885
        END IF

        IF A56$ = "help" THEN WorldHelp
        IF A56$ = "help" GOTO 885

        IF A56$ = "menu" THEN MainMenu
        IF A56$ = "menu" GOTO 880

        IF A56$ = "describe" GOTO 880

        IF A56$ = "stats" THEN displaystats
        IF A56$ = "stats" GOTO 885

        IF A56$ = "inventory" THEN displayinventory
        IF A56$ = "inventory" GOTO 885

        IF A56$ = "equipment" THEN displayequip
        IF A56$ = "equipment" GOTO 885

        IF A56$ = "equip LH" THEN EQlh
        IF A56$ = "equip LH" GOTO 885

        IF A56$ = "equip RH" THEN EQrh
        IF A56$ = "equip RH" GOTO 885

        IF A56$ = "equip ARMOUR" THEN EqArmour
        IF A56$ = "equip ARMOUR" GOTO 885

        IF A56$ = "equip HEAD" THEN EqHead
        IF A56$ = "equip HEAD" GOTO 885

        IF A56$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 885
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 885

    'Area 57
    890 CLS
    PRINT "You are now standing in an intersection.  This intersection seems to be"
    PRINT "identical to all the others.  There is a bending hallway to the south and"
    PRINT "north.  There is a short hallway to the east"
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 890
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Bending Hallway"
    PRINT "         South: Bending Hallway"
    PRINT "         East: Short Hallway"
    COLOR 15
    895 INPUT ">", A57$
        IF A57$ = "north" GOTO 860
        IF A57$ = "south" GOTO 850
        IF A57$ = "east" GOTO 900

        IF A57$ = "help" THEN WorldHelp
        IF A57$ = "help" GOTO 895

        IF A57$ = "menu" THEN MainMenu
        IF A57$ = "menu" GOTO 890

        IF A57$ = "describe" GOTO 890

        IF A57$ = "stats" THEN displaystats
        IF A57$ = "stats" GOTO 895

        IF A57$ = "inventory" THEN displayinventory
        IF A57$ = "inventory" GOTO 895

        IF A57$ = "equipment" THEN displayequip
        IF A57$ = "equipment" GOTO 895

        IF A57$ = "equip LH" THEN EQlh
        IF A57$ = "equip LH" GOTO 895

        IF A57$ = "equip RH" THEN EQrh
        IF A57$ = "equip RH" GOTO 895

        IF A57$ = "equip ARMOUR" THEN EqArmour
        IF A57$ = "equip ARMOUR" GOTO 895

        IF A57$ = "equip HEAD" THEN EqHead
        IF A57$ = "equip HEAD" GOTO 895

        IF A57$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 895
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 895

    'Area 58
    900 CLS
    PRINT "You are now standing at a dead end.  The wall here has a shrine built in"
    PRINT "it.  On the shrine a grey gem is displayed."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 900
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         West: Short Hallway"
    COLOR 15
    905 INPUT ">", A58$
        IF A58$ = "west" GOTO 890

        IF A58$ = "examine grey gem" THEN
            PRINT "There is a plain grey gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Death."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    907             INPUT ">", GGEM$
                IF GGEM$ = "y" THEN
                    GemClicks(GEM_GREEN) = 1
                    GemPuzzle
                    GOTO 905
                END IF
                IF GGEM$ = "n" THEN GOTO 905
                    ColorPrint 5, "Huh?"
                    GOTO 907
        END IF
        IF A58$ = "get grey gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 905
        END IF

        IF A58$ = "help" THEN WorldHelp
        IF A58$ = "help" GOTO 905

        IF A58$ = "menu" THEN MainMenu
        IF A58$ = "menu" GOTO 900

        IF A58$ = "describe" GOTO 900

        IF A58$ = "stats" THEN displaystats
        IF A58$ = "stats" GOTO 905

        IF A58$ = "inventory" THEN displayinventory
        IF A58$ = "inventory" GOTO 905

        IF A58$ = "equipment" THEN displayequip
        IF A58$ = "equipment" GOTO 905

        IF A58$ = "equip LH" THEN EQlh
        IF A58$ = "equip LH" GOTO 905

        IF A58$ = "equip RH" THEN EQrh
        IF A58$ = "equip RH" GOTO 905

        IF A58$ = "equip ARMOUR" THEN EqArmour
        IF A58$ = "equip ARMOUR" GOTO 905

        IF A58$ = "equip HEAD" THEN EqHead
        IF A58$ = "equip HEAD" GOTO 905

        IF A58$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 905
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 905

    'Area 59
    910 CLS
    PRINT "You are now standing at a dead end in the short hallway.  Inserted into the"
    PRINT "wall is a shrine with a red gem displayed."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 910
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         SouthWest: Main Hall"
    COLOR 15
    915 INPUT ">", A59$
        IF A59$ = "southwest" GOTO 860

        IF A59$ = "examine red gem" THEN
            PRINT "There is a plain red gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Fire."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    917             INPUT ">", RGEM$
                IF RGEM$ = "y" THEN
                    GemClicks(GEM_RED) = 1
                    GemPuzzle
                    GOTO 915
                END IF
                IF RGEM$ = "n" THEN GOTO 915
                    ColorPrint 5, "Huh?"
                    GOTO 917
        END IF

        IF A59$ = "get red gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 915
        END IF

        IF A59$ = "help" THEN WorldHelp
        IF A59$ = "help" GOTO 915

        IF A59$ = "menu" THEN MainMenu
        IF A59$ = "menu" GOTO 910

        IF A59$ = "describe" GOTO 910

        IF A59$ = "stats" THEN displaystats
        IF A59$ = "stats" GOTO 915

        IF A59$ = "inventory" THEN displayinventory
        IF A59$ = "inventory" GOTO 915

        IF A59$ = "equipment" THEN displayequip
        IF A59$ = "equipment" GOTO 915

        IF A59$ = "equip LH" THEN EQlh
        IF A59$ = "equip LH" GOTO 915

        IF A59$ = "equip RH" THEN EQrh
        IF A59$ = "equip RH" GOTO 915

        IF A59$ = "equip ARMOUR" THEN EqArmour
        IF A59$ = "equip ARMOUR" GOTO 915

        IF A59$ = "equip HEAD" THEN EqHead
        IF A59$ = "equip HEAD" GOTO 915

        IF A59$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 915
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 915

    'Area 60
    920 CLS
    PRINT "You are now standing in an intersection.  This intersection seems to resemble"
    PRINT "all the other intersections.  There is a bending hallway to the east and west."
    PRINT "There is a short hallway to the north."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 920
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Short hallway"
    PRINT "         East: Bending hallway"
    PRINT "         West: Bending hallway"
    COLOR 15
    925 INPUT ">", A60$
        IF A60$ = "north" GOTO 930
        IF A60$ = "east" GOTO 860
        IF A60$ = "west" GOTO 870

        IF A60$ = "help" THEN WorldHelp
        IF A60$ = "help" GOTO 925

        IF A60$ = "menu" THEN MainMenu
        IF A60$ = "menu" GOTO 920

        IF A60$ = "describe" GOTO 920

        IF A60$ = "stats" THEN displaystats
        IF A60$ = "stats" GOTO 925

        IF A60$ = "inventory" THEN displayinventory
        IF A60$ = "inventory" GOTO 925

        IF A60$ = "equipment" THEN displayequip
        IF A60$ = "equipment" GOTO 925

        IF A60$ = "equip LH" THEN EQlh
        IF A60$ = "equip LH" GOTO 925

        IF A60$ = "equip RH" THEN EQrh
        IF A60$ = "equip RH" GOTO 925

        IF A60$ = "equip ARMOUR" THEN EqArmour
        IF A60$ = "equip ARMOUR" GOTO 925

        IF A60$ = "equip HEAD" THEN EqHead
        IF A60$ = "equip HEAD" GOTO 925

        IF A60$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 925
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 925

    'Area 61
    930 CLS
    PRINT "You are now standing at a dead end.  There is a small shrine built into"
    PRINT "the nearby wall, on the shrine lies a black gem."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 930
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         South: Short hallway"
    COLOR 15
    935 INPUT ">", A61$
        IF A61$ = "south" GOTO 920

        IF A61$ = "examine black gem" THEN
            PRINT "There is a plain black gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Darkness."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    937             INPUT ">", BGEM$
                IF BGEM$ = "y" THEN
                    GemClicks(GEM_BLACK) = 1
                    GemPuzzle
                    GOTO 935
                END IF
                IF BGEM$ = "n" THEN GOTO 935
                    ColorPrint 5, "Huh?"
                    GOTO 937
        END IF

        IF A61$ = "get black gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 935
        END IF

        IF A61$ = "help" THEN WorldHelp
        IF A61$ = "help" GOTO 935

        IF A61$ = "menu" THEN MainMenu
        IF A61$ = "menu" GOTO 930

        IF A61$ = "describe" GOTO 930

        IF A61$ = "stats" THEN displaystats
        IF A61$ = "stats" GOTO 935

        IF A61$ = "inventory" THEN displayinventory
        IF A61$ = "inventory" GOTO 935

        IF A61$ = "equipment" THEN displayequip
        IF A61$ = "equipment" GOTO 935

        IF A61$ = "equip LH" THEN EQlh
        IF A61$ = "equip LH" GOTO 935

        IF A61$ = "equip RH" THEN EQrh
        IF A61$ = "equip RH" GOTO 935

        IF A61$ = "equip ARMOUR" THEN EqArmour
        IF A61$ = "equip ARMOUR" GOTO 935

        IF A61$ = "equip HEAD" THEN EqHead
        IF A61$ = "equip HEAD" GOTO 935

        IF A61$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 935
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 935

    'Area 62
    940 CLS
    PRINT "You are now standing at a dead end.  There is a small shrine built into"
    PRINT "the wall, displayed on the shrine is a jade coloured gem."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 940
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         SouthEast: Main Hall"
    COLOR 15
    945 INPUT ">", A62$
        IF A62$ = "southeast" GOTO 870

        IF A62$ = "examine jade gem" THEN
            PRINT "There is a plain jade gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Necrotalia."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    947             INPUT ">", JGEM$
                IF JGEM$ = "y" THEN
                    GemClicks(GEM_JADE) = 1
                    GemPuzzle
                    GOTO 945
                END IF
                IF BGEM$ = "n" THEN GOTO 945
                    ColorPrint 5, "Huh?"
                    GOTO 947
        END IF

        IF A62$ = "get jade gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 945
        END IF

        IF A62$ = "help" THEN WorldHelp
        IF A62$ = "help" GOTO 945

        IF A62$ = "menu" THEN MainMenu
        IF A62$ = "menu" GOTO 940

        IF A62$ = "describe" GOTO 940

        IF A62$ = "stats" THEN displaystats
        IF A62$ = "stats" GOTO 945

        IF A62$ = "inventory" THEN displayinventory
        IF A62$ = "inventory" GOTO 945

        IF A62$ = "equipment" THEN displayequip
        IF A62$ = "equipment" GOTO 945

        IF A62$ = "equip LH" THEN EQlh
        IF A62$ = "equip LH" GOTO 945

        IF A62$ = "equip RH" THEN EQrh
        IF A62$ = "equip RH" GOTO 945

        IF A62$ = "equip ARMOUR" THEN EqArmour
        IF A62$ = "equip ARMOUR" GOTO 945

        IF A62$ = "equip HEAD" THEN EqHead
        IF A62$ = "equip HEAD" GOTO 945

        IF A62$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 945
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 945

    'Area 63
    950 CLS
    PRINT "You are now standing in an intersection.  This intersection resembles"
    PRINT "all the others.  There is a bending hallway to the north and south."
    PRINT "There is a short hallway to the west."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 950
        END IF
    COLOR 5
    PRINT "There are three obvious exits:"
    PRINT "         North: Bending hallway"
    PRINT "         South: Bending hallway"
    PRINT "         West: Short hallway"
    COLOR 15
    955 INPUT ">", A63$
        IF A63$ = "north" GOTO 870
        IF A63$ = "south" GOTO 840
        IF A63$ = "west" GOTO 960

        IF A63$ = "help" THEN WorldHelp
        IF A63$ = "help" GOTO 955

        IF A63$ = "menu" THEN MainMenu
        IF A63$ = "menu" GOTO 950

        IF A63$ = "describe" GOTO 950

        IF A63$ = "stats" THEN displaystats
        IF A63$ = "stats" GOTO 955

        IF A63$ = "inventory" THEN displayinventory
        IF A63$ = "inventory" GOTO 955

        IF A63$ = "equipment" THEN displayequip
        IF A63$ = "equipment" GOTO 955

        IF A63$ = "equip LH" THEN EQlh
        IF A63$ = "equip LH" GOTO 955

        IF A63$ = "equip RH" THEN EQrh
        IF A63$ = "equip RH" GOTO 955

        IF A63$ = "equip ARMOUR" THEN EqArmour
        IF A63$ = "equip ARMOUR" GOTO 955

        IF A63$ = "equip HEAD" THEN EqHead
        IF A63$ = "equip HEAD" GOTO 955

        IF A63$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 955
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 955

    'Area 64
    960 CLS
    PRINT "You are now standing at a dead end.  In the closest wall is a small shrine"
    PRINT "displayed on the shrine is a blood gem."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 960
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         East: Short hallway"
    COLOR 15
    965 INPUT ">", A64$
        IF A64$ = "east" GOTO 950

        IF A64$ = "examine blood gem" THEN
            PRINT "There is a blood coloured gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Evil."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    967             INPUT ">", BLOODGEM$
                IF BLOODGEM$ = "y" THEN
                    GemClicks(GEM_BLOOD) = 1
                    GemPuzzle
                    GOTO 965
                END IF
                IF BGEM$ = "n" THEN GOTO 965
                    ColorPrint 5, "Huh?"
                    GOTO 967
        END IF

        IF A64$ = "get blood gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 965
        END IF

        IF A64$ = "help" THEN WorldHelp
        IF A64$ = "help" GOTO 965

        IF A64$ = "menu" THEN MainMenu
        IF A64$ = "menu" GOTO 960

        IF A64$ = "describe" GOTO 960

        IF A64$ = "stats" THEN displaystats
        IF A64$ = "stats" GOTO 965

        IF A64$ = "inventory" THEN displayinventory
        IF A64$ = "inventory" GOTO 965

        IF A64$ = "equipment" THEN displayequip
        IF A64$ = "equipment" GOTO 965

        IF A64$ = "equip LH" THEN EQlh
        IF A64$ = "equip LH" GOTO 965

        IF A64$ = "equip RH" THEN EQrh
        IF A64$ = "equip RH" GOTO 965

        IF A64$ = "equip ARMOUR" THEN EqArmour
        IF A64$ = "equip ARMOUR" GOTO 965

        IF A64$ = "equip HEAD" THEN EqHead
        IF A64$ = "equip HEAD" GOTO 965

        IF A64$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 965
            END IF
        END IF
    ColorPrint 5, "Huh?"
    GOTO 965

    'Area 65
    970 CLS
    PRINT "You are now standing at a dead end.  Built into the nearest wall is a small"
    PRINT "shrine.  On the shrine a white gem is displayed."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 970
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         NorthEast: Main hall"
    COLOR 15
    975 INPUT ">", A65$
        IF A65$ = "northeast" GOTO 840

        IF A65$ = "examine white gem" THEN
            PRINT "There is a plain white gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Necromancer."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    977             INPUT ">", WGEM$
                IF WGEM$ = "y" THEN
                    GemClicks(GEM_WHITE) = 1
                    GemPuzzle
                    GOTO 975
                END IF
                IF BGEM$ = "n" THEN GOTO 975
                    ColorPrint 5, "Huh?"
                    GOTO 977
        END IF

        IF A65$ = "get white gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 975
        END IF

        IF A65$ = "help" THEN WorldHelp
        IF A65$ = "help" GOTO 975

        IF A65$ = "menu" THEN MainMenu
        IF A65$ = "menu" GOTO 970

        IF A65$ = "describe" GOTO 970

        IF A65$ = "stats" THEN displaystats
        IF A65$ = "stats" GOTO 975

        IF A65$ = "inventory" THEN displayinventory
        IF A65$ = "inventory" GOTO 975

        IF A65$ = "equipment" THEN displayequip
        IF A65$ = "equipment" GOTO 975

        IF A65$ = "equip LH" THEN EQlh
        IF A65$ = "equip LH" GOTO 975

        IF A65$ = "equip RH" THEN EQrh
        IF A65$ = "equip RH" GOTO 975

        IF A65$ = "equip ARMOUR" THEN EqArmour
        IF A65$ = "equip ARMOUR" GOTO 975

        IF A65$ = "equip HEAD" THEN EqHead
        IF A65$ = "equip HEAD" GOTO 975

        IF A65$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 975
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 975

    'Area 66
    980 CLS
    PRINT "You are now standing at a dead end.  In the dead end's wall is a small"
    PRINT "shrine.  Displayed on the shrine is a blue gem."
        BATTLECHANCE% = INT(RND * 100)
        IF BATTLECHANCE% <= 15 THEN
            ColorPrint 4, "BATTLE!"
            SLEEP 2
            BATTLE2
            GOTO 980
        END IF
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         NorthWest: Main Hall"
    COLOR 15
    985 INPUT ">", A66$
        IF A66$ = "northwest" GOTO 850

        IF A66$ = "examine blue gem" THEN
            PRINT "There is a plain blue gem displayed on the shrine. As you lean forward"
            PRINT "you notice that the gem has a word carved into it, the word is Xanathus."
            PRINT "There is a button below do you wish to press it? <Y/N>"
    987             INPUT ">", BlueGEM$
                IF BlueGEM$ = "y" THEN
                    GemClicks(GEM_BLUE) = 1
                    GemPuzzle
                    GOTO 985
                END IF
                IF BlueGEM$ = "n" THEN GOTO 985
                    ColorPrint 5, "Huh?"
                    GOTO 987
        END IF

        IF A66$ = "get blue gem" THEN
                ColorPrint 5, "You can't seem to take the gem out of it's socket"
                GOTO 985
        END IF

        IF A66$ = "help" THEN WorldHelp
        IF A66$ = "help" GOTO 985

        IF A66$ = "menu" THEN MainMenu
        IF A66$ = "menu" GOTO 980

        IF A66$ = "describe" GOTO 980

        IF A66$ = "stats" THEN displaystats
        IF A66$ = "stats" GOTO 985

        IF A66$ = "inventory" THEN displayinventory
        IF A66$ = "inventory" GOTO 985

        IF A66$ = "equipment" THEN displayequip
        IF A66$ = "equipment" GOTO 985

        IF A66$ = "equip LH" THEN EQlh
        IF A66$ = "equip LH" GOTO 985

        IF A66$ = "equip RH" THEN EQrh
        IF A66$ = "equip RH" GOTO 985

        IF A66$ = "equip ARMOUR" THEN EqArmour
        IF A66$ = "equip ARMOUR" GOTO 985

        IF A66$ = "equip HEAD" THEN EqHead
        IF A66$ = "equip HEAD" GOTO 985

        IF A66$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 985
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 985

    ''''''''''''''''''''''''''''''''''''''''''''''
    ''''Start of Necrotalia's labyrinth Level 3''''
    ''''''''''''''''''''''''''''''''''''''''''''''
    ''''''''''''''''''''''''''''''''''''''''''''''

    'Area 67
    990 CLS
    AEncampmentUsePillar% = 0
    PRINT "You are now standing at the base of the lift, above you is a long shaft which"
    PRINT "the lift descended from.  This seems to be the base of the elevator, it seems"
    PRINT "impossible to force the lift to return to the top level.  You can not easily "
    PRINT "see the area around you because it is too dark.  There is a small chaos star "
    PRINT "which seems to be burning in the middle of several pillars."
    IF A67SwordPuzzle% = 1 THEN
        PRINT "To the north"
        PRINT "there is a dark passageway."
        END IF

    IF A67SwordPuzzle% = 0 THEN
        PRINT "You can see some kind of statue in the shape of a crucified archangel."
        PRINT "There is a small hole in the middle of the archangel statue."
        END IF

    IF A67SwordTaken% = 0 THEN
        COLOR 5
        PRINT "The archangel is holding a rusted sword which you seem to be able to "
        PRINT "take. "
        COLOR 15
        END IF
    PRINT ""
    PRINT "Sir jacob is standing beside the statue."
    COLOR 5
    IF A67SwordPuzzle% = 0 THEN PRINT "There are no obvious exits"
    IF A67SwordPuzzle% = 1 THEN
        PRINT "There is one obvious exit:"
        PRINT "         North: Dark tunnel"
    END IF
    COLOR 15
    995 INPUT ">", A67$
        IF A67$ = "north" THEN
            IF A67SwordPuzzle% = 1 THEN NecrotaliaFight
        END IF

        IF A67$ = "get rusted sword" THEN
            IF A67SwordTaken% = 0 THEN
                A67SwordTaken% = 1
                RustedSword% = 1
                COLOR 5
                PRINT "You took the rusted sword, you can't use it as a weapon or it would break in a"
                PRINT "second. "
                COLOR 15
                GOTO 995
            END IF
        END IF

        IF A67$ = "use rusted sword" THEN
            IF RustedSword% = 1 THEN
                RustedSword% = 0
                A67SwordPuzzle% = 1
                COLOR 5
                PRINT "You push the rusted sword into the small hole in the archangel statue."
                PRINT "You hear a click.  The sword clicks in place, the statue opens like a "
                PRINT "door and you see a dark passageway behind it."
                COLOR 15
                GOTO 995
            END IF
        END IF

        IF A67$ = "examine pillars" THEN
            PRINT "There is an inscription on one of them, it reads:"
            COLOR 5
            A67PillarOn% = 1
                PRINT "Once, a long time ago, a great daemon opened a small hole from hell to"
                PRINT "the real world.  It was a gate which could teleport a single thing to "
                PRINT "another point, the hole had the shape of a burning chaos star surrounded"
                PRINT "in pillars.  However the daemon could not use the portal for the forces"
                PRINT "of heaven had interfered and killed the daemon whilst he used the gate."
                PRINT "Afterwards it was said that no daemon would ever use the portal again."
            COLOR 15
            GOTO 995
        END IF

        IF A67$ = "use chaos star" THEN
           IF A67PillarOn% = 1 THEN
            COLOR 5
            A67PillarUse% = 1

            PRINT "You feel a strange pulling sensation."
            SLEEP 4
            COLOR 15
            ACT1
           END IF
        END IF

        IF A67$ = "talk to sir jacob" THEN
            PRINT "Sir Jacob casts a spell of healing on you."
            PRINT "Your familiar is healed."
            HPS% = HP%
            FAMILIARHP% = FamiliarHPS%
    996             COLOR 5
            PRINT "Sir Jacob> Necrotalia should be on this level..."
            PRINT "Would you like to save your game? <Y/N>"
            COLOR 15
    997             INPUT ">", SirJacobA67$
                IF SirJacobA67$ = "y" THEN
                    SavePos% = 2
                    SaveGame
                    ColorPrint 5, "Game Saved"
                    GOTO 995
                END IF

                IF SirJacobA67$ = "n" GOTO 995

            ColorPrint 5, "Huh?"
            GOTO 996
        END IF

        IF A67$ = "help" THEN WorldHelp
        IF A67$ = "help" GOTO 995

        IF A67$ = "menu" THEN MainMenu
        IF A67$ = "menu" GOTO 990

        IF A67$ = "describe" GOTO 990

        IF A67$ = "stats" THEN displaystats
        IF A67$ = "stats" GOTO 995

        IF A67$ = "inventory" THEN displayinventory
        IF A67$ = "inventory" GOTO 995

        IF A67$ = "equipment" THEN displayequip
        IF A67$ = "equipment" GOTO 995

        IF A67$ = "equip LH" THEN EQlh
        IF A67$ = "equip LH" GOTO 995

        IF A67$ = "equip RH" THEN EQrh
        IF A67$ = "equip RH" GOTO 995

        IF A67$ = "equip ARMOUR" THEN EqArmour
        IF A67$ = "equip ARMOUR" GOTO 995

        IF A67$ = "equip HEAD" THEN EqHead
        IF A67$ = "equip HEAD" GOTO 935

        IF A67$ = "use potion" THEN
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
                GOTO 995
            END IF
        END IF

    ColorPrint 5, "Huh?"
    GOTO 995

END SUB

SUB AI
    SELECT CASE INT(RND * 10)
        CASE 0
            PRINT "The "; ENEMY$; " starts circling "; Name$; "."
        CASE 1 TO 6
            PRINT "The "; ENEMY$; " attacks."
            ENEMYDAMAGECHANCE% = INT(RND * 100) + 1
            IF ENEMYDAMAGECHANCE% <= 75 THEN
                ENEMYDAMAGE% = INT(RND * 5) + 1
                IF A27JadeSocket% = 2 THEN ENEMYDAMAGE% = ENEMYDAMAGE% + 20
                PRINT "The "; ENEMY$; " has caused you"; ENEMYDAMAGE%; " damage."
                TotalDamage% = ENEMYDAMAGE% - DamageLostArmour% - DamageLostHelm%
                IF TotalDamage% <= 0 THEN TotalDamage% = 1
                IF FamiliarCalled% = 1 THEN
                    FAMILIARHP% = FAMILIARHP% - (TotalDamage% / 2)
                ELSE
                    HPS% = HPS% - TotalDamage%
                    IF HPS% > HP% THEN
                        HPS% = HP%
                    ELSEIF HPS% <= 0 THEN
                        PRINT "You have died."
                        END
                    END IF
                END IF
            ELSE
                PRINT "The "; ENEMY$; " missed his attack."
            END IF
        CASE 7
            PRINT "The "; ENEMY$; " steps back and seems to consider his options.  Thus, he"
            PRINT "gives "; Name$; " an open attack."
        CASE 8
            PRINT "The "; ENEMY$; " feels disgusted that "; Name$; " would engage him."
            PRINT "He walks away."
          15
            INPUT "Do you wish to run and cut him down"; DECISION$
            SELECT CASE DECISION$
                CASE "yes"
                    PRINT "As you run up to him he challenges you with a roar."
                    ACTION$ = ""
                CASE "no"
                    PRINT "You let him get away."
                CASE ELSE
                    PRINT "Huh?"
                    GOTO 15
            END SELECT
        CASE 9
            PRINT "The "; ENEMY$; " leaps in close and starts swinging."
            PRINT "As he swipes through your flesh, you become angered."
            PRINT "As such, your strength is improved."
            PRINT "Yet you still are injured."
            TotalDamage% = 2 - DamageLostArmour% - DamageLostHelm%
            IF TotalDamage% <= 0 THEN TotalDamage% = 1
            IF FamiliarCalled% = 1 THEN
                FAMILIARHP% = FAMILIARHP% - (TotalDamage% / 2)
                FAMILIARDAMAGE% = FAMILIARDAMAGE% + 5
            ELSE
                HPS% = HPS% - TotalDamage%
                STR% = STR% + 5
                IF HPS% > HP% THEN
                    HPS% = HP%
                ELSEIF HPS% <= 0 THEN
                    PRINT "You have died."
                    END
                END IF
            END IF
    END SELECT
END SUB

SUB BardMusic
    MusicChance% = INT(RND * 100) - VIT%
    IF MusicChance% <= 50 THEN
        PRINT "You start playing your insturment."
        PRINT "You now feel much stronger!"
        STR% = STR% + 5
    ELSE
        PRINT "The music has no effect on you."
    END IF
END SUB

SUB _BATTLE
  1000
    PRINT "What would you like to do?"
    WeaponThrown = -1
    IF Expertise% = CLASS_ROGUE THEN
        IF WeaponThrown% > 0 THEN WeaponThrown% = WeaponThrown% - 1
        IF WeaponThrown% = 0 THEN ReturnWeapon: PRINT "You grab your fallen weapon."
    END IF
    PRINT "Hitpoints: "; HPS%; "/"; HP%
    INPUT ">", ACTION$
    SELECT CASE ACTION$
        CASE "call familiar"
            IF FAMILIARHP% <= 0 THEN
                ColorPrint 5, "Your familiar has fainted."
            ELSEIF Inventory(QITEM_FAMILIAR_FLUTE).amount = 1 THEN
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    AI
                END IF

                FamiliarCall
                IF ENEMYPTS% <= 0 THEN GOTO 102000

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    AI
                END IF
            ELSE
                COLOR 5
                PRINT "You don't have a familiar flute"
            END IF
        CASE "use potion"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            IF Inventory(ITEM_POTION).amount >= 1 THEN
                ColorPrint 5, "used potion"
            ELSE
                ColorPrint 5, "you are out of potions"
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF

            GOTO 1020
        CASE "spit"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT "You spit at the "; ENEMY$; "'s face."
            PRINT "The "; ENEMY$; " is disgusted.  He shakes his head and cries out."

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "help"
            HELP
        CASE "ready weapon"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT "You readied your weapon."

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "run"
            PRINT "You ran away."
            GOTO 102000
        CASE "kick"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT "Aming your foot, you lash out towards his groin."
            KICKCHANCE% = INT(RND * 100) + 1
            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
                GOTO 1000
            ELSEIF KICKCHANCE% >= 50 THEN
                PRINT "You nail the poor guy right in the groin.  He goes down and isn't coming"
                PRINT "back up."
                ENEMYPTS% = 0
                GOTO 102000
            ELSE
                PRINT "The "; ENEMY$; " is rather upset that his crown jewels were threatened."
                PRINT "He is really PISSED."
                GOTO 1020
            END IF
        CASE "punch"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT "You aim your punch at the "; ENEMY$; "'s face."
            PUNCHCHANCE% = INT(RND * 100) + 1
            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
                GOTO 1000
            ELSEIF PUNCHCHANCE% >= 50 THEN
                PRINT "You clock the "; ENEMY$; " in the jaw.  He goes down with a woof."
                ENEMYPTS% = 0
                GOTO 102000
            ELSE
                PRINT "The "; ENEMY$; " is really upset that you dared to try to punch him."
                PRINT "He is really PISSED."
                GOTO 1020
            END IF
        CASE "judge enemy"
            CORRECTJUDGECHANCE% = INT(RND * 100) + 1
            IF CORRECTJUDGECHANCE% <= 35 THEN
                PRINT "The "; ENEMY$; "'s hitpoints appear to be "; ENEMYPTS%; "."
            ELSEIF CORRECTJUDGECHANCE% >= 65 THEN
                PRINT "The "; ENEMY$; "'s hitpoints appear to be "; ENEMYPTS% + 10; "."
            ELSE
                PRINT "The "; ENEMY$; "'s hit points appear to be "; ENEMYPTS% + 5; "."
            END IF
        CASE "use magic"
            IF Expertise% <> CLASS_MAGE THEN
                ColorPrint 5, "Only mages can use magic!"
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    AI
                END IF

                MAGIC
                IF EnemyKilled() THEN GOTO 102000

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    AI
                END IF
            END IF
        CASE "use owl spell"
            IF Owl% = 1 THEN
                USEOWLSPELL
                IF EnemyKilled() THEN GOTO 102000
            ELSE
                PRINT "You don't have an owl."
            END IF
        CASE ELSE
            PRINT "Huh?"
    END SELECT
    GOTO 1000

  1020
    PRINT "What would you like to do?"
    IF Expertise% = CLASS_ROGUE THEN
        IF WeaponThrown% > 0 THEN WeaponThrown% = WeaponThrown% - 1
        IF WeaponThrown% = 0 THEN ReturnWeapon: PRINT "You grab your fallen weapon."
    END IF
    PRINT "Hitpoints: "; HPS%; "/"; HP%
    INPUT ">", ACTIONA$
    SELECT CASE ACTIONA$
        CASE "steal"
            IF Expertise% <> CLASS_THIEF THEN
                ColorPrint 5, "Only thieves can steal."
            ELSE
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    Steal
                    AI
                ELSE
                    AI
                    Steal
                END IF
            END IF
        CASE "throw weapon"
            IF Expertise% <> CLASS_ROGUE THEN
                ColorPrint 5, "Only rogues can throw weapons."
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    AI
                END IF

                LHO$ = LH$
                IF LH$ = "Long Staff" THEN RH$ = ""
                IF LH$ = "Short Staff" THEN RH$ = ""
                LH$ = ""
                WeaponThrown% = 3
                DAMAGEADDED% = DAMAGEADDED% * 3
                PRINT "You throw your weapon at the "; ENEMY$
                DAMAGEDONE% = STR% + DAMAGEADDED%
                ENEMYPTS% = ENEMYPTS% - DAMAGEDONE%
                DAMAGEADDED% = 0
                IF EnemyKilled() THEN GOTO 102000

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    AI
                END IF
            END IF
        CASE "play music"
            IF Expertise% <> CLASS_BARD THEN
                ColorPrint 5, "Only bards can play music."
            ELSE
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    BardMusic
                    AI
                ELSE
                    AI
                    BardMusic
                END IF
            END IF
        CASE "call familiar"
            IF FAMILIARHP% <= 0 THEN
                ColorPrint 5, "Your familiar has fainted."
            ELSEIF Inventory(QITEM_FAMILIAR_FLUTE).amount = 1 THEN
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    FamiliarCall
                    IF ENEMYPTS% <= 0 THEN GOTO 102000
                ELSE
                    AI
                    FamiliarCall
                    IF ENEMYPTS% <= 0 THEN GOTO 102000
                END IF
            ELSE
                ColorPrint 5, "you don't have a familiar flute"
            END IF
        CASE "use potion"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            IF Inventory(ITEM_POTION).amount >= 1 THEN
                ColorPrint 5, "used potion"
            ELSE
                ColorPrint 5, "you are out of potions"
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "use magic"
            IF Expertise% <> CLASS_MAGE THEN
                ColorPrint 5, "Only mages can use magic!"
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    AI
                END IF

                MAGIC
                IF EnemyKilled() THEN GOTO 102000

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    AI
                END IF
            END IF
        CASE "spit"
            PRINT "You spit at the "; ENEMY$; "'s face."
            PRINT "The "; ENEMY$; " is disgusted.  He shakes his head and cries out."
        CASE "help"
            HELP
        CASE "slash"
            IF COMBATSPEED% <= ENEMYSPEED% THEN
                AI
            END IF

            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
            ELSE
                PRINT "You slashed the "; ENEMY$; " in the chest and he doesn't SEEM to LET"
                PRINT "it affect him."
                ENEMYPTS% = ENEMYPTS% - (DAMAGEADDED% + STR% + 2)
                IF EnemyKilled() THEN GOTO 102000
            END IF

            IF COMBATSPEED% > ENEMYSPEED% THEN
                AI
            END IF
        CASE "thrust"
            IF COMBATSPEED% <= ENEMYSPEED% THEN
                AI
            END IF

            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
            ELSE
                PRINT "You lunged forward and skewered the "; ENEMY$; " in the chest and"
                PRINT "splashed blood all over."
                ENEMYPTS% = ENEMYPTS% - (STR% + 5 + DAMAGEADDED%)
                IF EnemyKilled() THEN GOTO 102000
            END IF

            IF COMBATSPEED% > ENEMYSPEED% THEN
                AI
            END IF
        CASE "parry"
            PRINT "You attempt to parry the "; ENEMY$; "'s blow."
            PC% = INT(RND * 100) + 1
            PARRYCHANCE% = PC% + ShieldSave%
            IF PARRYCHANCE% >= 50 THEN
                PRINT "You were successful in parrying the "; ENEMY$; "'s blow."
            ELSE
                PRINT "You failed to parry the "; ENEMY$; "'s blow.  You take 2 damage."
                HPS% = HPS% - 2
            END IF
        CASE "punch"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
            ELSE
                PRINT "You aim your punch at the "; ENEMY$; "'s face."
                PUNCHCHANCE% = INT(RND * 100) + 1
                IF PUNCHCHANCE% >= 50 THEN
                    PRINT "You clock the "; ENEMY$; " in the jaw.  He goes down with a woof."
                    ENEMYPTS% = 0
                    GOTO 102000
                ELSE
                    PRINT "The "; ENEMY$; " is really upset that you dared to try to punch him."
                    PRINT "He is really PISSED."
                END IF
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "kick"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT "Aming your foot, you lash out towards his groin."
            KICKCHANCE% = INT(RND * 100) + 1
            IF Ethereal% = 1 THEN
                PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                ENEMYPTS% = ENEMYPTSO%
            ELSE
                IF KICKCHANCE% >= 50 THEN
                    PRINT "You nail the poor guy right in the groin.  He goes down and isn't coming"
                    PRINT "back up."
                    ENEMYPTS% = 0
                    GOTO 102000
                ELSE
                    PRINT "The "; ENEMY$; " is rather upset that his crown jewels were threatened."
                    PRINT "He is really PISSED."
                END IF
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "dodge"
            PRINT "As the "; ENEMY$; " attacks, you attempt to dodge his attack."
            DC% = INT(RND * 100) + 1
            DODGECHANCE% = DC% - DEX%
            IF DODGECHANCE% >= 45 THEN
                PRINT "You were successfully able to dodge the "; ENEMY$; "'s attack."
            ELSE
                PRINT "You were not successful at dodging the "; ENEMY$; "'s attack. You take 2 damage."
                HPS% = HPS% - 1
            END IF
        CASE "coup de grace"
            IF ENEMYPTS% <= 3 THEN
                IF Ethereal% = 1 THEN
                    PRINT Name$; "> I can't hurt it! it seems like it's ethereal!"
                    ENEMYPTS% = ENEMYPTSO%
                ELSE
                    PRINT "You grasp the victim's head, draw back and lop off the "; ENEMY$; " head."
                    ENEMYPTS% = 0
                    PRINT "The "; ENEMY$; " is dead."
                    GOTO 102000
                END IF
            END IF
        CASE "use owl spell"
            IF Owl% = 1 THEN
                USEOWLSPELL
                IF EnemyKilled() THEN GOTO 102000
            ELSE
                PRINT "You don't have an owl."
            END IF
        CASE "run"
            PRINT "You ran away."
            GOTO 102001
        CASE "judge enemy"
            CORRECTJUDGECHANCE% = INT(RND * 100) + 1
            IF CORRECTJUDGECHANCE% <= 35 THEN
                PRINT "The "; ENEMY$; "'s hitpoints appear to be "; ENEMYPTS%; "."
            ELSEIF CORRECTJUDGECHANCE% >= 65 THEN
                PRINT "The "; ENEMY$; "'s hitpoints appear to be "; ENEMYPTS% + 10; "."
            ELSE
                PRINT "The "; ENEMY$; "'s hit points appear to be "; ENEMYPTS% + 5; "."
            END IF
        CASE ELSE
            PRINT "Huh?"
    END SELECT
    GOTO 1020

  102000
    RANDOMEXPR% = INT(RND * 500) + 1
    PRINT "And you have gained "; RANDOMEXPR%; " experience."
    EXPR% = EXPR% + RANDOMEXPR%
    EXPERIENCELVLUP

    IF Expertise% = CLASS_MAGE THEN
        RANDOMRUNEDROP
        PRINT "You have picked up this rune:"; RANDOMRUNE$
        RUNE$ = RUNE$ + RANDOMRUNE$
    END IF

    GOLDDROP% = INT(RND * 10) + 1
    PRINT "You picked up"; GOLDDROP%; "gold."
    Gold& = Gold& + GOLDDROP%
    IF Owl% = 1 THEN
        OWLSPELL
    END IF
    SLEEP 10
    STR% = STRO%
    DEX% = DEXO%
    ENG% = ENGO%
    VIT% = VITO%

  102001
    PlayerReflect% = 0
    Boss% = 0
    Ethereal% = 0
    Undead% = 0
    Critical% = 0
    ReturnWeapon
END SUB

REM $DYNAMIC
SUB BATTLE
    CLS
    LHO$ = LH$

    SELECT CASE INT(RND * 6)
        CASE 0
            ENEMY$ = "Axe Maiden"
        CASE 1
            ENEMY$ = "Skeleton"
            Undead% = 1
        CASE 2
            ENEMY$ = "Giant Spider"
        CASE 3
            ENEMY$ = "Zombie"
            Undead% = 1
        CASE 4
            ENEMY$ = "Imp"
        CASE 5
            ENEMY$ = "Ghoul"
            Undead% = 1
    END SELECT

    IF HelmsburgBttl% = 1 OR HelmsburgBttl% = 2 THEN
        M% = 100
        PRINT "BATTLE: Type help for battle commands"
        ENEMY$ = "Ork"
    ELSEIF A3Corpse% = 1 THEN
        A3Corpse% = 2
        Undead% = 1
        M% = 100
        PRINT "The lunge damages you"
        HPS% = HPS% - 2
        ENEMY$ = "Corpse"
    END IF

    P% = INT(RND * 6) + 1
    q% = INT(RND * 6) + 1
    ENEMYPTS% = P% + q% + ENEMYHPSBONUS

    IF WightLord% = 1 THEN
        ENEMY$ = "Wight Lord"
        ENEMYPTS% = 2000
    END IF
    PRINT "The "; ENEMY$; " spits at "; Name$; " and readies his weapon."

    ENEMY% = INT(RND * 20) + 1
    SPEED% = INT(RND * 20) + 1
    ENEMYSPEED% = ENEMY% + SPEED%
    IF WightLord% = 1 THEN
        ENEMYSPEED% = 40
    END IF
    cs% = INT(RND * 20) + 1
    COMBATSPEED% = ENG% + cs%

    _BATTLE
END SUB

REM $STATIC
SUB BATTLE2
    CLS
    Ethereal% = 0
    P% = INT(RND * 6) + 1
    q% = INT(RND * 6) + 1
    ENEMYHPB% = P% + q% + ENEMYHPSBONUS

    ENEMY% = INT(RND * 20) + 1
    SPEED% = INT(RND * 20) + 1
    SPDBONUS% = ENEMY% + SPEED%

    SELECT CASE INT(RND * 10)
        CASE 0
            ENEMY$ = "Skeleton"
            ENEMYPTS% = ENEMYHPB% + 5
        CASE 1
            ENEMY$ = "Wight"
            ENEMYPTS% = ENEMYHPB% + 15
        CASE 2
            ENEMY$ = "Fell Bat"
            ENEMYPTS% = ENEMYHPB% + 10
        CASE 3
            ENEMY$ = "Zombie"
            ENEMYPTS% = ENEMYHPB% + 5
        CASE 4
            'Scary!
            ENEMY$ = "Wraith"
            ENEMYPTS% = ENEMYHPB% + 30
            ENEMYPTSO% = ENEMYPTS%
            STRBONUS% = 5
            Ethereal% = 1
        CASE 5
            'very scary!
            ENEMY$ = "Dire Wolf"
            ENEMYPTS% = ENEMYHPB% + 40
            ENEMYSPEED% = SPDBONUS% + 5
        CASE 6
            'Don't hurt meeee!
            ENEMY$ = "Lesser Vampire"
            ENEMYPTS% = ENEMYHPB% + 50
            ENEMYSPEED% = SPDBONUS% + 15
            STRBONUS% = 20
        CASE 7
            'can't be hurt by physical attacks!
            ENEMY$ = "Banshee"
            Ethereal% = 1
            ENEMYPTS% = 5
            ENEMYPTSO% = ENEMYPTS%
            STRBONUS% = 5
        CASE 8
            'can't be hurt by physical attacks!
            ENEMY$ = "Phantom"
            Ethereal% = 1
            ENEMYPTS% = 1
            ENEMYPTSO% = ENEMYPTS%
        CASE 9
            'heeeeeeeeelelllllllllppppppp meeeeeeeee!
            ENEMY$ = "Zombie Dragon"
            ENEMYPTS% = ENEMYHPB% + 100
            STRBONUS% = 20
    END SELECT

    IF A56VampFight% = 1 THEN
        Boss% = 1
        ENEMY$ = "Lesser Vampire"
        ENEMYPTS% = ENEMYHPB% + 25
        ENEMYSPEED% = SPDBONUS% + 15
        STRBONUS% = 20
    END IF

    PRINT "The "; ENEMY$; " spits at "; Name$; " and readies his weapon."

    cs% = INT(RND * 20) + 1
    COMBATSPEED% = ENG% + cs%

    _BATTLE
END SUB

REM $DYNAMIC
SUB CHARCREATE
    ' MAKE THE CHARACTERS HERE
  0
    CLS

    'character creation begins
    PRINT "What is the name of the young warrior?"
    INPUT ">", Name$
    IF Name$ = "" THEN GOTO 0

    PRINT "Is "; Name$; " Male or Female <M/F>?"
  10
    INPUT ">", SexA$
    SELECT CASE LCASE$(SexA$)
        CASE "m" : Sex$ = "his"
        CASE "f" : Sex$ = "her"
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 10
    END SELECT

  21
    PRINT "Please select "; Name$; "'s class."
    PRINT "0-Fighter"
    PRINT "1-Mage"
    PRINT "2-Rogue"
    PRINT "3-Thief"
    PRINT "4-Bard"
    INPUT ">", CLASSDECISION$
    SELECT CASE CLASSDECISION$
        CASE "0"
            Class$ = "Fighter"
            Expertise% = CLASS_FIGHTER
        CASE "1"
            Class$ = "Mage"
            Expertise% = CLASS_MAGE
        CASE "2"
            Class$ = "Rogue"
            Expertise% = CLASS_ROGUE
        CASE "3"
            Class$ = "Thief"
            Expertise% = CLASS_THIEF
        CASE "4"
            Class$ = "Bard"
            Expertise% = CLASS_BARD
        CASE ELSE
            PRINT "Huh?"
            GOTO 21
    END SELECT

  21.5
    PRINT "Choose your familiar:"
    PRINT "C>at"
    PRINT "T>oad"
    PRINT "O>wl"
    INPUT "Decide:", FAMILIARCHOOSE$
    SELECT CASE LCASE$(FAMILIARCHOOSE$)
        CASE "c"
            Familiar$ = "Cat"
            FAMILIARDAMAGE% = 20
            FamiliarHPS% = 10
            FAMILIARHP% = 10
            MP% = 10
            MPS% = 10
        CASE "t"
            Familiar$ = "Toad"
            FAMILIARDAMAGE% = 10
            FamiliarHPS% = 20
            FAMILIARHP% = 20
            MP% = 15
            MP% = 15
        CASE "o"
            Familiar$ = "Owl"
            FAMILIARDAMAGE% = 15
            FamiliarHPS% = 15
            FAMILIARHP% = 15
            MP% = 30
            MPS% = 30
            Owl% = 1
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 21.5
    END SELECT

  22
    STR% = INT(RND * 20) + 1
    DEX% = INT(RND * 20) + 1
    VIT% = INT(RND * 20) + 1
    ENG% = INT(RND * 20) + 1
    HP% = INT(RND * 35) + 1

    IF Diff% = 0 THEN
        STR% = STR% + 5
        DEX% = DEX% + 5
        VIT% = VIT% + 5
        ENG% = ENG% + 5
        HP% = HP% + 10
    ELSEIF Diff% = 3 THEN
        STR% = STR% - 5
        DEX% = DEX% - 5
        VIT% = VIT% - 5
        ENG% = ENG% - 5
        HP% = HP% - 10
        IF STR% <= 0 THEN STR% = 5
        IF DEX% <= 0 THEN DEX% = 5
        IF VIT% <= 0 THEN VIT% = 5
        IF ENG% <= 0 THEN ENG% = 5
        IF HP% <= 0 THEN HP% = 7
    END IF

    HPS% = HP%
    STRO% = STR%
    DEXO% = DEX%
    VITO% = VIT%
    ENGO% = ENG%
    PRINT "Strength ="; STR%;
    PRINT "Dexterity ="; DEX%;
    PRINT "Vitality ="; VIT%;
    PRINT "Energy ="; ENG%;
    PRINT "Hit Points ="; HP%;
    PRINT ""
    PRINT "Are these stats acceptable? <Y/N>"

    INPUT ">", Accept$
    SELECT CASE LCASE$(Accept$)
        CASE "y" : GOTO 24
        CASE "n"
        CASE ELSE
            PRINT "Huh?"
    END SELECT
    GOTO 22

    'Character creation ends

  24
    PRINT "Do you wish to redo the character creation <Y/N>?"
    INPUT ">", Redo$
    SELECT CASE LCASE$(Redo$)
        CASE "y" : GOTO 0
        CASE "n"
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 24
    END SELECT
    CLS
END SUB

REM $STATIC
SUB CheckRunes (rune$)
    RuneError% = 0
    COLOR 5

    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_RUNE AND Inventory(i).amount < 1 THEN
            IF Inventory(i).name = rune$ THEN
                PRINT "You don't have that rune"
                RuneError% = 1
                EXIT FOR
            END IF
        END IF
    NEXT i

    COLOR 15
END SUB

SUB ClearFlags
    A12Potions% = 3
    PlayerReflect% = 0
    LadderDown% = 0
    ToHall% = 0
    BottomLift% = 0
    A0CutsceneDone% = 0
    A1ShopEnter% = 0
    A1ShopPotion% = 0
    A1EnterPit% = 0
    Quest% = 0
    Inventory(ITEM_SWORD_PLUS_ONE).buyPrice = 0
    A3LS% = 0
    A3Corpse% = 0
    ThroneSwitch% = 0
    A12Potions% = 0
    A12ShieldPlusTwo% = 0
    A12SwordPlusTwo% = 0
    GoldenSkullTaken% = 0
    A14Key1% = 0
    ChaosStarInsert% = 0
    StrangePendantTaken% = 0
    A19Lvl1Door% = 0
    A19Lvl2Door% = 0
    A20Lvl1Door% = 0
    A23FamiliarFlute% = 0
    A26ChaosStar% = 0
    A27GoldenSocket% = 0
    A27JadeSocket% = 0
    A27AvengerSword% = 0
    A28ChaosStarSocket% = 0
    A29StarSocket% = 0
    A34Cutscene% = 0
    A34CutsceneDone% = 0
    A34SecretDoor% = 0
    A42Cutscene% = 0
    A42LockedGate% = 0
    XanathusDead% = 0
    XanathusArea$ = ""
    XanathusHP% = 0
    StunTime% = 0
    XanathusFleeTime% = 0
    A48BSphere% = 0
    A56VampFight% = 0
    Hint% = 0
    GemNum% = 0
    GemClicks(GEM_ORANGE) = 0
    GemClicks(GEM_BLACK) = 0
    GemClicks(GEM_GREEN) = 0
    GemClicks(GEM_BLOOD) = 0
    GemClicks(GEM_BLUE) = 0
    GemClicks(GEM_WHITE) = 0
    GemClicks(GEM_RED) = 0
    GemClicks(GEM_JADE) = 0
    GemPuzzleDone% = 0
    AEncampmentUsePillar% = 0
    A67PillarUse% = 0
END SUB

SUB Credits
    ' DISPLAYING CREDITS
    CLS
    PRINT "-------------------------------------------------------------------------------"
    PRINT "Credits"
    PRINT "-------------------------------------------------------------------------------"
    PRINT "Designer : Matt Terry"
    PRINT "Developer : Cybergames"
    PRINT "Layout: Will Howard"
    PRINT "Battle Sequence : Matt Terry"
    PRINT "Technological Developer: Will Howard"
    PRINT "13th Games:"
    PRINT "Will Howard"
    PRINT "Matt Terry"
    PRINT "--------------------------------------------------------------------------------"
    PRINT "Play this game with CAPS LOCK off"
    PRINT "--------------------------------------------------------------------------------"

    SLEEP 10
END SUB

SUB displayequip
    PRINT ""

    PRINT Name$; "'s equipment"

    PRINT "Left Hand: "; LH$
    PRINT "Right Hand: "; RH$
    PRINT "Armour: "; Armour$
    PRINT "Helm: "; Helm$
END SUB

SUB displayinventory
    PRINT Name$; "'s Inventory"
    PRINT ""
    'Act 1 quest items
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_QITEM AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Swords
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_SWORD AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Sword +
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_SWORD_PLUS AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Shields
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_SHIELD AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Armour
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_ARMOUR AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Staves
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_STAFF AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Helms
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_HELM AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Potions
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_POTION AND Inventory(i).amount > 0 THEN
            PRINT Inventory(i).name; ":"; Inventory(i).amount
        END IF
    NEXT i

    'Runes
    IF Expertise% = CLASS_MAGE THEN
        PRINT "Your Runes: ";
        printedFirst% = FALSE
        FOR i = 0 TO UBOUND(Inventory)
            IF Inventory(i).itemType = ITEM_TYPE_RUNE AND Inventory(i).amount > 0 THEN
                IF printedFirst% THEN
                    PRINT ", "; Inventory(i).name;
                ELSE
                    PRINT Inventory(i).name;
                    printedFirst% = TRUE
                END IF
            END IF
        NEXT i
    END IF
    PRINT ""

    'Cash
    PRINT "Your gold:"; Gold&

    'Flutes
    IF Inventory(QITEM_FAMILIAR_FLUTE).amount = 1 THEN PRINT "Familiar Flute:"; Inventory(QITEM_FAMILIAR_FLUTE).amount; "for "; Familiar$
END SUB

SUB displaystats
    PRINT Name$
    PRINT Class$
    PRINT "Level:"; Lvl%
    PRINT "Experience:"; EXPR%
    PRINT "Strength:"; STR%;
    PRINT "Dexterity:"; DEX%;
    PRINT "Vitality:"; VIT%;
    PRINT "Energy:"; ENG%;
    PRINT "Hit Points:"; HPS%; "/"; HP%
    PRINT "Damage added from weapon:"; DAMAGEADDED%
    PRINT "Damage reduction from armour - Armour:"; DamageLostArmour%
    PRINT "                             - Shield Save:"; ShieldSave%
    PRINT "                             - Helm Save:"; DamageLostHelm%
    PRINT "Your familiar: "; Familiar$
    PRINT "Your familiar's damage: "; FAMILIARDAMAGE%
    PRINT "Familiar hit points: "; FAMILIARHP%; "/"; FamiliarHPS%
    PRINT "Familiar mana points: "; MP%; "/"; MPS%
    IF Owl% = 1 THEN
        PRINT "Spells your familiar knows: "; OWLSPELLE$
        FOR i = 0 TO 11
            IF OwlSpells(i).hasIt THEN
                PRINT OwlSpells(i).name; ", ";
            END IF
        NEXT i
        PRINT ""
    END IF
END SUB

REM $STATIC
SUB EndGame
    ClearFlags
    Reflect% = 1
    CLS
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    PRINT ""
    1007 PRINT "Do you want to save? <Y/N>"
    GameOn% = 0
    SavePos% = 3
    INPUT ">", EndAGame$
    IF EndAGame$ = "n" THEN MainMenu
    IF EndAGame$ = "y" THEN
        SaveGame
        MainMenu
    END IF
    ColorPrint 5, "Huh?"
    GOTO 1007
END SUB

SUB EndGameCutscene
    CLS
    COLOR 14
    PRINT "Necrotalia> Is that all that you could do? you have dissapointed me..."
    SLEEP 3
    PRINT "Unknown Voice> NO! that is enough from you!"
    SLEEP 3
    PRINT "Necrotalia> Who?"
    SLEEP 3
    PRINT "Unknown Voice> I am the archangel that will bring an end to you!"
    SLEEP 3
    COLOR 15
    PRINT "The archangel swipes forward and cleaves Necrotalia in two!"
    SLEEP 3
    COLOR 14
    PRINT "Necrotalia> An archangel thinks that it can do such a thing to me?"
    SLEEP 3
    COLOR 15
    PRINT "Necrotalia casts fire!"
    PRINT "The archangel throws his blade!"
    SLEEP 3
    PRINT "The archangel burns to death.  Necrotalia falls to the wound."
    COLOR 14
    PRINT "Archangel> Young one! my wound is mortal, come here before it is too late!"
    SLEEP 3
    PRINT "Archangel> Young one, the daemon Necrotalia is destroyed, but more is to be done."
    PRINT "head to the City of Helmsburg and find the daemon of poison there you wi......."
    PRINT "The archangel falls down and disintegrates into great balls of light."
    SLEEP 10
    PRINT ""
    PRINT "                                    The End"
    SLEEP 3
    COLOR 15
    EndGame
END SUB

REM $DYNAMIC
FUNCTION ENEMYHPSBONUS%
    ENEMYHPSBONUS = (Lvl% - 1)*5
END FUNCTION

SUB UnequipItem (equipType AS INTEGER)
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = equipType AND Inventory(i).name = Equipment(equipType) THEN
            Inventory(i).amount = Inventory(i).amount + 1
            Equipment(equipType) = ""
        END IF
    NEXT i
END SUB

SUB EquipItem (equipType AS INTEGER)
    DIM typeNames(5) AS STRING
    typeNames(1) = "Weapon"
    typeNames(2) = "Shield"
    typeNames(3) = "Armour"
    typeNames(4) = "Helm"

    COLOR 5
    PRINT "Equip what "; typeNames(equipType); "?"
    COLOR 15
    PRINT typeNames(equipType); " Name>";
    INPUT itemName$

    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = equipType AND LCASE$(Inventory(i).name) = LCASE$(itemName$) THEN
            IF Inventory(i).amount >= 1 THEN
                UnequipItem equipType
                IF Inventory(i).itemType = ITEM_TYPE_STAFF THEN
                    UnequipItem EQUIP_SHIELD
                END IF
                Equipment(equipType) = Inventory(i).name

                SELECT CASE equipType
                    CASE EQUIP_WEAPON
                        DAMAGEADDED% = Inventory(i).value
                    CASE EQUIP_SHIELD
                        ShieldSave% = Inventory(i).value
                    CASE EQUIP_ARMOUR
                        DamageLostArmour% = Inventory(i).value
                    CASE EQUIP_HELM
                        DamageLostHelm% = Inventory(i).value
                END SELECT
                Inventory(i).amount = Inventory(i).amount - 1
            ELSE
                ColorPrint 5, "You don't have that"
            END IF
        END IF
    NEXT i
END SUB

SUB EqArmour
    EquipItem EQUIP_ARMOUR
END SUB

SUB EqHead
    EquipItem EQUIP_HELM
END SUB

SUB EQlh
    EquipItem EQUIP_WEAPON
END SUB

SUB EQrh
    EquipItem EQUIP_SHIELD
END SUB

REM $STATIC
SUB ExamineSymbol
    CLS
    PRINT "There is some text below it:"
    PRINT "it came upon one eve in hell that garland, the daemon of Hatred, sought"
    PRINT "out kuja, the daemon of Darkness.  garland soon arrived and found kuja"
    PRINT "plotting against him with Death, the destroyer of life.  angered by"
    PRINT "his deceit, garland fought the other Evil daemon for night and day until"
    PRINT "kuja finally died.  kuja's soul soon after became a parasite among the"
    PRINT "world.  when it entered it's target it brought kuja's powers along with"
    PRINT "it.  one of these targets was Xanathus,  soon after he became a Necromancer."
    PRINT "he left the Fire world of hell and sought out the daemon Necrotalia....."
    PRINT "(the rest of the text is written in some unknown tongue)."
    PRINT ""
    PRINT "                         Press spacebar to continue"
    DO
    LOOP UNTIL INKEY$ = CHR$(32)    '32 is the ASCII code for Spacebar.
    CLS
END SUB

REM $DYNAMIC
SUB EXPERIENCELVLUP
    reqExp% = 0
    IF Lvl% <= 5 THEN
        reqExp% = 1000*(2^(Lvl%-1))
    ELSE
        reqExp% = 18000 + 1000*(Lvl% - 6)
    END IF

    IF EXPR% >= reqExp% THEN
        PRINT "You have gone up one level."
        HP% = HP% + 5
        Lvl% = Lvl% + 1
        SLEEP 4
    END IF
END SUB

REM $STATIC
SUB VampireBeaten
    COLOR 14
    PRINT "Vampire> No! no more! I yield!"
    SLEEP 2
    PRINT Name$; "> Why should I spare you?"
    SLEEP 2
    PRINT "Vampire> because...if you do then I will tell you how to get to Necrotalia."
    SLEEP 4
    COLOR 15
    PRINT "Victory!"
    A56VampFight% = 2
END SUB

FUNCTION EnemyKilled () AS INTEGER
    IF ENEMYPTS <= 0 THEN
        IF A56VampFight% = 1 THEN
            VampireBeaten
        ELSE
            COLOR 14
            PRINT "The "; ENEMY$; " falls to the wound."
            COLOR 15
        END IF
        EnemyKilled = 1
    ELSE
        EnemyKilled = 0
    END IF
END FUNCTION

SUB FamiliarCall
    FamiliarCalled% = 1
    SELECT CASE Familiar$
        CASE "Owl"     : FamiliarSpeed% = 25
        CASE "Toad"    :  FamiliarSpeed% = 33
        CASE "Cat"     :  FamiliarSpeed% = 30
        CASE "Pheonix" : FamiliarSpeed% = 43
    END SELECT
    PRINT Familiar$; " arrives and takes your place"

  1011
    PRINT "What do you want to do?"
    PRINT "Mana points:"; MP%; "/"; MPS%
    PRINT "Hit points: "; FAMILIARHP%; "/"; FamiliarHPS%
    PRINT "----------------"
    PRINT "Familiar Abilities:"
    COLOR 12
    PRINT "      Attack"
    PRINT "      Use Magic"
    SELECT CASE Familiar$
        CASE "Owl"     : PRINT "      Use Owl Magic"
        CASE "Toad"    : PRINT "      Jump"
        CASE "Cat"     : PRINT "      Quick Attack        (MP: 1)"
        CASE "Pheonix" : PRINT "      Use Pheonix Spell"
    END SELECT
    PRINT "      Dismiss"
    COLOR 15
    PRINT "----------------"

  1012
    INPUT "What is your command?>", Fam$
    SELECT CASE Fam$
        CASE "attack"
            IF FamiliarSpeed% < ENEMYSPEED% THEN
                AI
            END IF

            PRINT Familiar$; " leaps forward and wounds the "; ENEMY$
            ENEMYPTS% = ENEMYPTS% - (FAMILIARDAMAGE + 20)
            IF EnemyKilled() GOTO 1013

            IF FamiliarSpeed% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "use magic"
            PRINT Familiar$; "'s basic magic"
            PRINT "-------------------------"
            PRINT "Spell Name:           MP:"
            COLOR 12
            PRINT ""
            PRINT "  Fire                  5"
            PRINT "  Thunder               6"
            PRINT "  Wind                 10"
            PRINT "  Water                 4"
            PRINT "-------------------------"
            COLOR 15
            INPUT ">", MGC$
            SELECT CASE MGC$
                CASE "fire"
                    IF MP% >= 5 THEN
                        IF FamiliarSpeed% < ENEMYSPEED% THEN
                            AI
                        END IF

                        MP% = MP% - 5
                        PRINT Familiar$; " casts fire!"
                        IF Undead% = 1 THEN
                            PRINT "Critical Damage!"
                            Critical% = 20
                        END IF
                        ENEMYPTS% = ENEMYPTS% - 5 - Critical%
                        Critical% = 0
                        IF EnemyKilled() GOTO 1013

                        IF FamiliarSpeed% >= ENEMYSPEED% THEN
                            AI
                        END IF
                    ELSE
                        PRINT "Insufficent MP"
                    END IF
                CASE "thunder"
                    IF MP% >= 6 THEN
                        IF FamiliarSpeed% < ENEMYSPEED% THEN
                            AI
                        END IF

                        MP% = MP% - 6
                        PRINT Familiar$; " casts thunder!"
                        ENEMYPTS% = ENEMYPTS% - 5
                        IF EnemyKilled() GOTO 1013

                        IF FamiliarSpeed% >= ENEMYSPEED% THEN
                            AI
                        END IF
                    ELSE
                        PRINT "Insufficent MP"
                    END IF
                CASE "wind"
                    IF MP% >= 10 THEN
                        IF FamiliarSpeed% < ENEMYSPEED% THEN
                            AI
                        END IF

                        MP% = MP% - 10
                        PRINT Familiar$; " casts wind!"
                        ENEMYPTS% = ENEMYPTS% - 5
                        Tornado% = INT(RND * 20)
                        IF Tornado% <= 7 AND Boss% = 0 THEN
                            IF A56VampFight% = 1 THEN
                                VampireBeaten
                            END IF
                            PRINT "The wind spell throws the "; ENEMY$; " far from the battlefield."
                            ENEMYPTS% = 0
                            GOTO 1013
                        END IF
                        IF EnemyKilled() GOTO 1013

                        IF FamiliarSpeed% >= ENEMYSPEED% THEN
                            AI
                        END IF
                    ELSE
                        PRINT "Insufficent MP"
                    END IF
                CASE "water"
                    IF MP% >= 4 THEN
                        IF FamiliarSpeed% < ENEMYSPEED% THEN
                            AI
                        END IF

                        MP% = MP% - 4
                        PRINT Familiar$; " casts water!"
                        ENEMYPTS% = ENEMYPTS% - 5
                        IF EnemyKilled() GOTO 1013

                        IF FamiliarSpeed% >= ENEMYSPEED% THEN
                            AI
                        END IF
                    ELSE
                        PRINT "Insufficent MP"
                    END IF
            END SELECT
        CASE "use owl magic"
            IF Owl% = 1 THEN USEOWLSPELL
        CASE "jump"
            IF Familiar$ = "Toad" THEN
                IF FamiliarSpeed% < ENEMYSPEED% THEN
                    AI
                END IF

                PRINT "Toad jumps!"
                PRINT "Toad lands on the "; ENEMY$
                ToadSteal

                IF FamiliarSpeed% >= ENEMYSPEED% THEN
                    AI
                END IF
            END IF
        CASE "quick hit"
            IF Familiar$ = "cat" THEN
                IF MP% >= 1 THEN
                    PRINT "Cat attacks!"
                    PRINT "The "; ENEMY$; " didn't know what hit it."
                    ENEMYPTS% = ENEMYPTS% - (FAMILIARDAMAGE% + 20)
                    AI
                ELSE
                    PRINT "Insufficent MP"
                END IF
            END IF

        CASE "use pheonix spell"
            IF Familiar$ = "Pheonix" THEN USEOWLSPELL

        CASE "dismiss"
            COLOR 5
            PRINT Familiar$; " leaves the battle, you step into it's place."
            FamiliarCalled% = 0
            COLOR 15
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 1012
    END SELECT
    GOTO 1011
  1013
END SUB

SUB GameIntro
    Quest% = 1
    Inventory(ITEM_SWORD_PLUS_ONE).buyPrice = 100
    A12Potions% = 3

    Name$ = "young warrior"
    Class$ = "Fighter"
    Expertise% = CLASS_FIGHTER
    LH$ = "Short Sword"
    HP% = 30
    HPS% = 30
    STR% = 25
    VIT% = 25
    ENG% = 25
    DEX% = 6
    EXPR% = 0
    STRO% = 25
    LH$ = "Short Sword"
    DAMAGEADDED% = 1
    Lvl% = 1
    Sex$ = "it's"

    CLS
    PRINT ""
    PRINT "                          Welcome to the world of Forgaia"
    PRINT ""
    PRINT " Land of grass, lakes and great mountains.  Home to the humans and elves this   paradise has seen nothing of war for the past 10 000 years. This land has a     great legend, I shall tell it to you, 10 000 years ago, 4 daemons of hell rose  to power each controlling a sacred element of the planet: Fire, Water, Thunder  and Wind. 10 000 years ago, the daemons broke free of the barrier between hell  and the normal world and soon caused the planet to suffer, losing it's elementalattributes one by one."

    PRINT ""
    PRINT "  First came water, the great oceans of Forgaia began to dissapear.  Thunder    followed as the skies would never rain nor shed a bolt of lightning.  As wind   lost its power the air became damp and heavy.  And finally fire left Forgaia andneither the humans nor elves could warm themselves.  Indeed, the people prayed  to heaven and continued to pray yet there came no reply.  And to add to their   dispair monsters, fiends, beasts whatever you should wish to call them began    appearing on the lands of Forgaia."

    PRINT ""
    PRINT "  They attacked and destroyed many towns all over Forgaia leaving the humans and dwarves on the brink of defeat.  Yet far off in the city of Tol Barad three heroesunited, their names: Sir Terenas, Thor Beckmann and Thernard Vicktor.  Together they united and banished the 4 daemons back to the hell they were spawned in,   returning peace to Fargaia."

    PRINT ""
    PRINT "  Now 10 000 years later, in the mountain city of helmsburg, one boy begins his story..."
    PRINT ""
    PRINT "                         Press Spacebar To Continue"
    DO
    LOOP UNTIL INKEY$ = CHR$(32)    '32 is the ASCII code for Spacebar.

    Cls
    PRINT "   You wake from your sleep this morning to the sounds of the town's"
    PRINT "soldiers training for battle, once again you are reminded of your desire"
    PRINT "to become a great warrior.";
    SLEEP 10
    PRINT "  After a light breakfast you go out to "
    PRINT "the stable and begin grooming the horses in preparation for your journey"
    PRINT "to the capital city, Gazkulon.";
    SLEEP 10
    PRINT "  Suddenly one of the horses starts "
    PRINT "jumping, as if frightened.  You turn your head towards what might be"
    PRINT "frightening it.  And see several dark red eyes in the shadows. Before"
    PRINT "you can react, hundreds of orcs jump from the shadows and start slaying"
    PRINT "the townspeople!  You look around desperately and see your father's sword"
    PRINT "mounted on the wall.  Quickly you grab the weapon and fly into battle."
    SLEEP 23

    HelmsburgBttl% = 1
    BATTLE
    HelmsburgBttl% = 2
    CLS
    PRINT "  `What is this?' you say, `it is as if i have been magically given all"
    PRINT "the knowledge of how to fight.'  From behind a man approaches and says,"
    PRINT "`And so you have, young one.  It is a gift, from the gods, a gift to aid"
    PRINT "you in your upcoming quest.'  `What quest?' you say, `and just who are you?'"
    PRINT "`hehehe, my name is Jacob, young one, one of the king's paladins, and...here"
    PRINT "comes one prepare yourself!'"
    SLEEP 15
    BATTLE
    CLS
    PRINT "  `Well done, young one,' Jacob says, `by the way what is your name?"
    PRINT "`My name?' you say, `well..uh...my name is...uh.....'"
    SLEEP 6
    CHARCREATE
    CLS
    PRINT " `Very well, "; Name$; " if you wish, you can come with me to the town square"
    PRINT "to help me dispense with these orks.'  Though you think it would be best"
    PRINT "to stay here and protect your house, you can't help feeling that you"
    PRINT "go with him.  You agree and leave for the town square."
    SLEEP 9
    CLS
    PRINT " You arrive at the town square with Sir Jacob.  Immediately he plunges into"
    PRINT "battle with an ork."
    SLEEP 5
    BATTLE
    CLS
    PRINT " `There's another!,' Sir Jacob yells. "
    SLEEP 4
    BATTLE
    CLS
    PRINT " `There are too many!,' you say."
    SLEEP 4
    BATTLE
    CLS
    PRINT "    From above a booming voice yells, `That is enough!, begone unclean"
    PRINT "monsters, begone from this peaceful town!'  As you look towards the"
    PRINT "sky in search of the source of this voice, you see a bright shape"
    PRINT "descending towards the ground.  As the bright object nears you can"
    PRINT "make out a basic outline, it has the shape of an Archangel with a"
    PRINT "sword drawn.  Immediately the Archangel starts flying about slaying"
    PRINT "orcs with a mere tap of his sword.  "
    PRINT ""
    PRINT "   Soon afterwards the town square is littered with the corpses of the orcs "
    PRINT "and the single Archangel hovers over the ground.  You begin to approach "
    PRINT "the Archangel when it starts speaking, `Young saviour, these times are dark."
    PRINT "Doesth thou knowst of the legend of the four demons?'  `Indeed I do great"
    PRINT "Archangel, why though is it of importance?' you say. `You know then that"
    PRINT "10 000 years ago the four demons broke free of the confines of hell and that"
    PRINT "they began to destroy all life on this planet?'  `Yes, I do,' you say, `but "
    PRINT "great Archangel what doesth this have to do with these orcs?'  `As it was"
    PRINT "10 000 years ago the four demons have once again been released from hell.'"
    PRINT "`Indeed this is obvious with all the changes our planet has undergone, but"
    PRINT "why are you telling me this?' you say  `For only one reason I am telling you"
    PRINT "this, you are the one, the one who will bring these demons back to their hell,"
    PRINT "I am certain of it.  Young saviour, my time here grows short, go to the"
    PRINT "Dwarf city of Brionne, there search out the daemon Necrotalia."
    PRINT ""
    PRINT "   All of a sudden the angel dissapears into the clouds.  `But, why me?' you say"
    PRINT "`It seems as if you have a difficult journey ahead of you, young "; Name$; " I shall"
    PRINT "accompany you to Brionne,' Sir Jacob says, `We should be on our way.'"
    PRINT "                         Press Spacebar to continue"
    DO
    LOOP UNTIL INKEY$ = CHR$(32)    '32 is the ASCII code for Spacebar.
    HelmsburgBttl% = 3

    CLS
    PRINT "The large, crumbling, city of Brionne lay in front of us."
    SLEEP 2
    PRINT ""
    PRINT "I remember I just stood there in awe, floating above the city was the cursed symbol, the chaos star, it looked like it was burning."
    SLEEP 4
    PRINT ""
    PRINT "Jacob noticed I was staring at it and said `hmph, at least it will give us some light!' as little as he speaks, all his words are valuable."
    SLEEP 4
    PRINT ""
    PRINT "We continued off into the barren city, hearing the howls of fiends, but they never approached us."
    SLEEP 3
    PRINT ""
    PRINT "We came to a less dense area of the city, apparently a gathering area of some kind.  Normally, it wouldn't have interested me except for the large fiery crack in the ground."
    SLEEP 6
    PRINT ""
    PRINT "We gathered some stones and lit a fire.  And now our adventure begins."
    SLEEP 2
    PRINT ""
    PRINT "                         Press Spacebar To Continue"
    DO
    LOOP UNTIL INKEY$ = CHR$(32)    '32 is the ASCII code for Spacebar.
END SUB

SUB GemPuzzle
    COLOR 5

    FOR i = 0 TO UBOUND(GemClicks)
        IF GemClicks(i) = 1 THEN
            IF GemNum% = i THEN
                PRINT "You press the button, it clicks easily."
                GemNum% = GemNum% + 1
                IF GemNum% = 8 THEN
                    PRINT "You hear a grinding noise coming from the main hall."
                END IF
            ELSE
                PRINT "You attempt to press the button, it doesn't seem to be able to be pushed."
            END IF
        END IF
    NEXT i

    COLOR 15
END SUB

SUB GetSaveLoadPos
    OPEN "sgame.sav" FOR INPUT AS #1

    slotsInUse% = 0
    IF LOF(1) <> 0 THEN
        DO
            INPUT #1, SaveSlots(slotsInUse%).playerName, SaveSlots(slotsInUse%).playerClass, SaveSlots(slotsInUse%).savePoint
            IF SaveSlots(slotsInUse%).playerName <> "" THEN
                slotsInUse% = slotsInUse% + 1
            END IF
        LOOP UNTIL EOF(1) OR slotsInUse% > UBOUND(SaveSlots)
    END IF
    CLOSE #1

    CLS
    FOR i = 0 TO slotsInUse% - 1
        PRINT "--------------------------------------------"
        PRINT "Save position #"; LTRIM$(STR$(i + 1))
        PRINT "      "; SaveSlots(i).playerName
        PRINT "      "; SaveSlots(i).playerClass
        PRINT "      ";
        SELECT CASE SaveSlots(i).savePoint
            CASE 0 : PRINT "Act 1: Surface Encampment"
            CASE 1 : PRINT "Act 1: Underground Level 3"
            CASE 2 : PRINT "Act 1: Necrotalia's labyrinth, Level 2"
        END SELECT
    NEXT i

    IF UBOUND(SaveSlots) + 1 - slotsInUse% > 1 THEN
        PRINT "--------------------------------------------"
        PRINT "Save positions #"; LTRIM$(STR$(slotsInUse% + 1)); " to #"; LTRIM$(STR$(UBOUND(SaveSlots) + 1)); " are currently free for use."
    ELSEIF UBOUND(SaveSlots) + 1 - slotsInUse% = 1 THEN
        PRINT "--------------------------------------------"
        PRINT "Save position #"; LTRIM$(STR$(slotsInUse% + 1)); " is currently free for use."
    END IF
    PRINT "--------------------------------------------"

    IF Operation$ = "Save" THEN
  99998
        limit% = slotsInUse% + 1
        IF limit% > UBOUND(SaveSlots) + 1 THEN
            limit% = UBOUND(SaveSlots) + 1
        END IF

        PRINT "Which save position do you want to save to? <1-"; LTRIM$(STR$(limit%)); ">"
        PRINT "NOTE: You will not be prompted to overwrite"
        PRINT "To cancel type `quit'"
        INPUT ">", Save$

        IF Save$ = "quit" THEN
            SavedGame% = UBOUND(SaveSlots) + 2
        ELSE
            SavedGame% = VAL(Save$)
            IF SavedGame% <= 0 OR SavedGame% > limit% THEN
                ColorPrint 5, "Huh?"
                GOTO 99998
            END IF
        END IF
    END IF

    IF Operation$ = "Load" THEN
  99999
        IF slotsInUse% = 0 THEN
            PRINT "There are no saved games."
            INPUT "( Press Enter to continue )"; dummy$
            LoadedGame% = UBOUND(SaveSlots) + 1
            GOTO 100000
        END IF

        PRINT "Which save game do you wish to load? <1-"; LTRIM$(STR$(slotsInUse%)); ">"
        PRINT "To cancel type `quit'"
        INPUT ">", Load$

        IF Load$ = "quit" THEN
            LoadedGame% = UBOUND(SaveSlots) + 2
        ELSE
            LoadedGame% = VAL(Load$)
            IF LoadedGame% <= 0 OR LoadedGame% > slotsInUse% THEN
                ColorPrint 5, "Huh?"
                GOTO 99999
            END IF
        END IF
    END IF
  100000
END SUB

REM $DYNAMIC
SUB HELP
    PRINT "BATTLE COMMANDS"
    PRINT "------------------"
    PRINT "FIRST ROUND MOVES"
    PRINT "help"
    PRINT "ready weapon"
    PRINT "run"
    PRINT "spit"
    PRINT "punch"
    PRINT "kick"
    PRINT "call familiar    (need a familiar flute)"
    PRINT "use magic        (mage only)"
    PRINT "use potion"
    PRINT "------------------"
    PRINT "SECOND ROUND MOVES"
    PRINT "help"
    PRINT "kick"
    PRINT "punch"
    PRINT "spit"
    PRINT "parry"
    PRINT "thrust"
    PRINT "dodge"
    PRINT "slash"
    PRINT "coup de grace"
    PRINT "call familiar    (need a familiar flute)"
    PRINT "use magic        (mage only)"
    PRINT "throw weapon     (rogue only)"
    PRINT "steal            (thief only)"
    PRINT "play music       (bard only)"
    PRINT "use potion"
End SUB

SUB LoadGame
    Operation$ = "Load"
    GetSaveLoadPos

    loadStr$ = "mud"
    IF LoadedGame% > 1 THEN
        loadStr$ = loadStr$ & LTRIM$(STR$(LoadedGame%))
    END IF
    loadStr$ = loadStr$ & ".sav"

    OPEN loadStr$ FOR INPUT AS #2

    'Saving position
    INPUT #2, SavePos%

    'Player Stats
    INPUT #2, Name$, VIT%, STR%, ENG%, DEX%, HPS%, Gold&, EXPR%, STRO%, LH$, RH$, Armour$, DAMAGEADDED%, DamageLostArmour%, ShieldSave%, Sex$, Lvl%, HP%, Class$, MP%, MPS%, Helm$, DamageLostHelm%, STRO%, DEXO%, VITO%, ENGO%

    'Act 1 items, triggers, helmsburg
    INPUT #2, HelmsburgBttl%, Inventory(QITEM_STRANGE_PENDANT).amount, Inventory(QITEM_BURNING_SPHERE).amount, Inventory(QITEM_GOLDEN_SKULL).amount, Inventory(QITEM_CHAOS_STAR).amount, Inventory(QITEM_KEY1).amount, Inventory(QITEM_KEY2).amount, A1ShopEnter%, A1ShopPotion%, A1EnterPit%, Quest%, A3LS%, A3Corpse%, ThroneSwitch%, A12Potions%, A12ShieldPlusTwo%, GoldenSkullTaken%, A14Key2%,  _
    A19Lvl1Door%, A19Lvl2Door%, A20Lvl1Door%, A23FamiliarFlute%, A26ChaosStar%, A27GoldenSocket%, A27JadeSocket%, A29StarSocket%, Inventory(QITEM_FAMILIAR_FLUTE).amount, Inventory(QITEM_CHAOS_STAR).amount, A27AvengerSword, A28ChaosStarSocket%, Inventory(QITEM_JADE_SKULL).amount, WightLord%

    'Weapon Inventory
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_WEAPON THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    'Helms
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_HELM THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    'Shield Inventory
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_SHIELD THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    'Armour Inventory
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_ARMOUR THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    'Potion Inventory
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_POTION THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    'Act1Pt2 SUB Triggers, Quest Items
    INPUT #2, A34Cutscene%, A34CutsceneDone%, A34SecretDoor%, A42Cutscene%, A42LockedGate%, XanathusDead%, XanathusArea$, XanathusHP%, A48BSphere%, A56VampFight, Hint%, GemNum%, GemPuzzleDone%, A67SwordPuzzle%, A67SwordTaken%, RustedSword%, Inventory(QITEM_GATE_KEY).amount, A67PillarOn%

    'Familiar Flute
    INPUT #2, Inventory(QITEM_FAMILIAR_FLUTE).amount

    'Familiar Stuff
    INPUT #2, Familiar$, FAMILIARHP%, FAMILIARDAMAGE%, Owl%, OWLSPELLE$, OwlSpells(0).hasIt, OwlSpells(1).hasIt, OwlSpells(2).hasIt, OwlSpells(3).hasIt, OwlSpells(4).hasIt, OwlSpells(5).hasIt, OwlSpells(6).hasIt, OwlSpells(7).hasIt, OwlSpells(8).hasIt, LEARNOWLSPELL$, AL%, OwlSpells(9).hasIt, OwlSpells(10).hasIt, OwlSpells(11).hasIt, FamiliarHPS%

    'Class stuff
    INPUT #2, Expertise%

    'All The runestuff
    FOR i = 0 TO 26
        INPUT #2, dummy$
    NEXT i
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_RUNE THEN
            INPUT #2, Inventory(i).amount
        END IF
    NEXT i

    CLOSE #2

    JustLoaded% = 1
    SELECT CASE SavePos%
        CASE 0   : ACT1
        CASE 1   : Act1Pt2
        CASE 2   : Act1Pt2
        CASE 3   : ACT1
        CASE 100 : ACT1
        CASE ELSE
            JustLoaded% = 0
    END SELECT
  100002
END SUB

REM $DYNAMIC
SUB MAGIC
  2999
    COLOR 15
    PRINT "Your collected runes are: "; RUNE$
    PRINT "COMBINE YOUR RUNES:"
    INPUT "RUNE 1>", RUNE1$
    CheckRunes RUNE1$
    IF RuneError% = 1 GOTO 3000

    INPUT "RUNE 2>", RUNE2$
    CheckRunes RUNE2$
    IF RuneError% = 1 GOTO 3000

    INPUT "RUNE 3>", RUNE3$
    CheckRunes RUNE3$
    IF RuneError% = 1 GOTO 3000

    IF RUNE1$ = "ken" AND RUNE2$ = "wak" AND RUNE3$ = "yoo" THEN
        PRINT "A fireball leaps from your hand!"
        ENEMYPTS% = ENEMYPTS% - 20
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "wir" AND RUNE3$ = "gnu" THEN
        PRINT "A lightning bolt leaps from your finger tips!"
        ENEMYPTS% = ENEMYPTS% - 10
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "yoo" AND RUNE3$ = "wir" THEN
        PRINT "Some of your wounds have healed!"
        HPS% = HPS% + 2
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "ken" AND RUNE3$ = "wak" THEN
        PRINT "You have gained super strength!!!"
        STR% = STR% + 5
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "rof" AND RUNE3$ = "sho" THEN
        PRINT "A blast of raw magic erupts from your hands causing you to bleed profusely!"
        ENEMYPTS% = ENEMYPTS% - 15
        IF ENEMYPTS% > 0 THEN
            HPS% = HPS% - 4
        END IF
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "ken" AND RUNE3$ = "rof" THEN
        PRINT "Your opponent bursts into flames!"
        ENEMYPTS% = ENEMYPTS% - 50
    ELSEIF RUNE1$ = "poa" AND RUNE2$ = "uch" AND RUNE3$ = "wod" THEN
        PRINT "You have cast healing upon yourself!"
        HPS% = HPS% + 30
    ELSEIF RUNE1$ = "poa" AND RUNE2$ = "wod" AND RUNE3$ = "uch" THEN
        PRINT "You have summoned a greater power of destruction!!!"
        ENEMYPTS% = ENEMYPTS% - 17
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "sho" AND RUNE3$ = "yoo" THEN
        PRINT "A swarm of hornets has attacked your opponent!"
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "sho" AND RUNE3$ = "wak" THEN
        PRINT "The ground starts rumbling from a massive earthquake!!!"
        ENEMYPTS% = ENEMYPTS% - 15
        IF ENEMYPTS% > 0 THEN
            HPS% = HPS% - 15
        END IF
    ELSEIF RUNE1$ = "pud" AND RUNE2$ = "pud" AND RUNE3$ = "pud" THEN
        PRINT "You have cast the spell of equality!"
        HPS% = HPS% / 2
        ENEMYPTS% = HPS%
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "sho" AND RUNE3$ = "tog" THEN
        PRINT "A cobra is attacking your opponent!"
        ENEMYPTS% = ENEMYPTS% - 12
    ELSEIF RUNE1$ = "das" AND RUNE2$ = "coz" AND RUNE3$ = "vas" THEN
        PRINT "There is a huge explosion between you and your opponent!"
        HPS% = HPS% - 11
        ENEMYPTS% = ENEMYPTS% - 11
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "sho" AND RUNE3$ = "fla" THEN
        PRINT "A series of enchanted shruikens appear suddenly and hit your opponent!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "til" AND RUNE3$ = "tog" THEN
        PRINT "A flaming blast of fire erupts from your hands and engulfs the enemy in flames!"
        ENEMYPTS% = ENEMYPTS% - 16
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "sho" AND RUNE3$ = "poa" THEN
        PRINT "You have summoned your familiar to your side!"
        ENEMYPTS% = ENEMYPTS% - 12
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "til" AND RUNE3$ = "wir" THEN
        PRINT "You have summoned Sir Jacob to your side!!!"
        ENEMYPTS% = ENEMYPTS% - 13
    ELSEIF RUNE1$ = "wak" AND RUNE2$ = "ken" AND RUNE3$ = "rof" THEN
        PRINT "Suddenly it begins to rain frogs!"
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "rof" AND RUNE3$ = "oje" THEN
        PRINT "Nothing happens."
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "coz" AND RUNE3$ = "wod" THEN
        PRINT "Raw magic whips out of your body and strangles your opponent."
        ENEMYPTS% = ENEMYPTS% - 13
    ELSEIF RUNE1$ = "til" AND RUNE2$ = "sho" AND RUNE3$ = "pos" THEN
        PRINT "Your body begins to crack and blister while releasing raw pain into your enemy!!"
        ENEMYPTS% = ENEMYPTS% - 18
        HPS% = HPS% - 18
    ELSEIF RUNE1$ = "wak" AND RUNE2$ = "ken" AND RUNE3$ = "wod" THEN
        PRINT "You have poisoned your opponent!!!"
        ENEMYPTS% = ENEMYPTS% - 3
    ELSEIF RUNE1$ = "dir" AND RUNE2$ = "ken" AND RUNE3$ = "wod" THEN
        PRINT "A magical Genie appears..."
        PRINT "What do you get when you cross a sheep with a kangaroo?"
        PRINT "Cast Pos-Coz-Vas for the answer."
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "coz" AND RUNE3$ = "vas" THEN
        PRINT "A wooly jumper!"
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "til" AND RUNE3$ = "vas" THEN
        PRINT "Your opponent is strangled by an invisible entity!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "wod" AND RUNE3$ = "wir" THEN
        PRINT "A spell never includes two or more identical rune words."
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "fla" AND RUNE3$ = "sho" THEN
        PRINT "Suddenly you have very bad cramp!"
        HPS% = HPS% - 1
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "uch" AND RUNE3$ = "wak" THEN
        PRINT "A great, black bat attacks your opponent!"
        ENEMYPTS% = ENEMYPTS% - 4
    ELSEIF RUNE1$ = "rer" AND RUNE2$ = "sho" AND RUNE3$ = "wir" THEN
        PRINT "Elvis is alive!!!"
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "rer" AND RUNE3$ = "sho" THEN
        PRINT "You have killed your opponent!!!"
        ENEMYPTS% = 0
    ELSEIF RUNE1$ = "wak" AND RUNE2$ = "uss" AND RUNE3$ = "wir" THEN
        PRINT "Pulses of electricity run through your opponent's body!"
        ENEMYPTS% = ENEMYPTS% - 13
    ELSEIF RUNE1$ = "roc" AND RUNE2$ = "vas" AND RUNE3$ = "vas" THEN
        PRINT "Your opponent is sucked into the ground!"
        ENEMYPTS% = ENEMYPTS% - 4
    ELSEIF RUNE1$ = "oje" AND RUNE2$ = "coz" AND RUNE3$ = "pos" THEN
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "coz" AND RUNE3$ = "poa" THEN
        PRINT "Rock hard and hard rock!!!"
        ENEMYPTS% = 2
    ELSEIF RUNE1$ = "pud" AND RUNE2$ = "cal" AND RUNE3$ = "das" THEN
        PRINT "You have cast a spell of holding!!!"
    ELSEIF RUNE1$ = "gnu" AND RUNE2$ = "ken" AND RUNE3$ = "wak" THEN
        PRINT "You have entered a time warp!!!"
        ENEMYPTS% = ENEMYPTS% + 10
        HPS% = HP%
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "sho" AND RUNE3$ = "tog" THEN
        PRINT "KABOOM!!!!!!"
        ENEMYPTS% = 1
        HPS% = 1
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "coz" AND RUNE3$ = "pos" THEN
        PRINT "You have cast the spell of speed and may cast another spell!!!"
        GOTO 2999
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "rer" AND RUNE3$ = "vas" THEN
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "sho" AND RUNE3$ = "vas" THEN
        PRINT "You have cast the spell of weakness!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "ken" AND RUNE3$ = "wak" THEN
        PRINT "Your opponent starts drowning on air!!!"
        ENEMYPTS% = ENEMYPTS% - 17
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "sho" AND RUNE3$ = "vas" THEN
        PRINT "Hdgwnconsan;o!!!"
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "sho" AND RUNE3$ = "tog" THEN
        PRINT "I'm sorry but I don't feel like casting that spell."
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "rof" AND RUNE3$ = "yoo" THEN
        PRINT "Sorry. That spell is out of order."
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "rof" AND RUNE3$ = "oje" THEN
        PRINT "Baboom!!!"
        ENEMYPTS% = ENEMYPTS% - 5
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "coz" AND RUNE3$ = "wir" THEN
        PRINT "What?"
    ELSEIF RUNE1$ = "uss" AND RUNE2$ = "cal" AND RUNE3$ = "oje" THEN
        BEEP
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "dir" AND RUNE3$ = "roc" THEN
        PRINT "You have cast the spell of falling!!!"
        BEEP
        BEEP
        BEEP
        BEEP
        BEEP
        BEEP
        PRINT "Ha, ha!!!"
        ENEMYPTS% = ENEMYPTS% - 10
    ELSEIF RUNE1$ = "uch" AND RUNE2$ = "gnu" AND RUNE3$ = "tog" THEN
        PRINT "AAAAAAAAAAAAAAGGGGHHH!!!"
        ENEMYPTS% = ENEMYPTS% - 18
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "uss" AND RUNE3$ = "tog" THEN
        PRINT "Wimp."
        BEEP
        HPS% = 1
    ELSEIF RUNE1$ = "dop" AND RUNE2$ = "fla" AND RUNE3$ = "wir" THEN
        PRINT "Your opponent's blood begins to boil!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "das" AND RUNE2$ = "pud" AND RUNE3$ = "yoo" THEN
        PRINT "Your wounds have healed."
        HPS% = HPS% + 15
    ELSEIF RUNE1$ = "arp" AND RUNE2$ = "oje" AND RUNE3$ = "til" THEN
        CLS
    ELSEIF RUNE1$ = "vas" AND RUNE2$ = "sho" AND RUNE3$ = "coz" THEN
        PRINT "Finish him!!!"
        ENEMYPTS% = 1
        GOTO 2999
    ELSEIF RUNE1$ = "roc" AND RUNE2$ = "wod" AND RUNE3$ = "wak" THEN
        PRINT "You have tilted the scales of Libra!"
        ENEMYPTS% = 1
        HPS% = HPS% + 10
    ELSEIF RUNE1$ = "gnu" AND RUNE2$ = "poa" AND RUNE3$ = "yoo" THEN
        PRINT "You cast the spell of love and have fallen in love"
        PRINT "with your opponent and decided not to try and kill them THIS TIME."
    ELSEIF RUNE1$ = "arp" AND RUNE2$ = "gnu" AND RUNE3$ = "oje" THEN
        PRINT "SYNTAX ERROR: IDIOT ATTEMPTING TO CAST SPELL>"
    ELSEIF RUNE1$ = "uss" AND RUNE2$ = "ken" AND RUNE3$ = "tog" THEN
        PRINT "Your too dumb to be able to cast spell!!!"
    ELSEIF RUNE1$ = "wod" AND RUNE2$ = "coz" AND RUNE3$ = "pos" THEN
        PRINT "What ever your do, don't cast Til-Shi-Pos!"
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "pos" AND RUNE3$ = "cal" THEN
        PRINT "Laser beams flash from your eyes and kill your opponent!!!"
        ENEMYPTS% = 0
    ELSEIF RUNE1$ = "sho" AND RUNE2$ = "ken" AND RUNE3$ = "rof" THEN
        PRINT "A thick poisonous fog surrounds your opponent!"
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "uss" AND RUNE3$ = "arp" THEN
        PRINT "You freeze your opponent!"
        ENEMYPTS% = ENEMYPTS% - 3
    ELSEIF RUNE1$ = "dop" AND RUNE2$ = "wir" AND RUNE3$ = "pos" THEN
        PRINT "Suddenly you are compelled to nut your opponent!"
        ENEMYPTS% = ENEMYPTS% - 2
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "rof" AND RUNE3$ = "cal" THEN
        'TODO: compile error here
        'PLAY VARPTR$(cccd)
    ELSEIF RUNE1$ = "wir" AND RUNE2$ = "pos" AND RUNE3$ = "uch" THEN
        PRINT "A lemming falls from the sky and hits your opponent on the head!"
        ENEMYPTS% = ENEMYPTS% - 8
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "cal" AND RUNE3$ = "coz" THEN
        PRINT "You summon a dragon and try to kill your opponent!!!"
        ENEMYPTS% = ENEMYPTS% - 10
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "uch" AND RUNE3$ = "sho" THEN
        PRINT "You have cast the spell of suicide!!!"
        HPS% = 0
    ELSEIF RUNE1$ = "cal" AND RUNE2$ = "coz" AND RUNE3$ = "vas" THEN
        PRINT "???"
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "tog" AND RUNE3$ = "poa" THEN
        PRINT "???"
    ELSEIF RUNE1$ = "uss" AND RUNE2$ = "gnu" AND RUNE3$ = "rer" THEN
        PRINT "W"
        PRINT "h"
        PRINT "a"
        PRINT "t"
        PRINT "?"
        PRINT "?"
        PRINT "?"
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "poa" AND RUNE3$ = "arp" THEN
        PRINT "h"
        PRINT "a"
        PRINT "t"
        PRINT "?"
        PRINT "?"
        PRINT "?"
    ELSEIF RUNE1$ = "gnu" AND RUNE2$ = "rer" AND RUNE3$ = "oje" THEN
        PRINT "Your opponent is electrocuted!"
        ENEMYPTS% = ENEMYPTS% - 16
    ELSEIF RUNE1$ = "poa" AND RUNE2$ = "arp" AND RUNE3$ = "til" THEN
        PRINT "You have raised an undead warrior!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "das" AND RUNE2$ = "yoo" AND RUNE3$ = "wak" THEN
        PRINT "Babababooom!!!"
        ENEMYPTS% = 2
    ELSEIF RUNE1$ = "pud" AND RUNE2$ = "dir" AND RUNE3$ = "wod" THEN
        PRINT "You have cast the spell of mirror!"
        HPS% = ENEMYPTS%
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "wak" AND RUNE3$ = "roc" THEN
        PRINT "You have created an enchanted weapon!"
        DAMAGEADDED% = DAMAGEADDED% + 10
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "tog" AND RUNE3$ = "uss" THEN
        PRINT "Splat!"
        BEEP
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "coz" AND RUNE3$ = "wak" THEN
        PRINT "Your hair has turned red!"
        PRINT "Don't move buddy!"
    ELSEIF RUNE1$ = "til" AND RUNE2$ = "ken" AND RUNE3$ = "vas" THEN
        PRINT "Don't move buddy!"
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "ken" AND RUNE3$ = "dir" THEN
        PRINT "Ready,"
        PRINT "Steady,"
        PRINT "GO!!!"
        ENEMYPTS% = ENEMYPTS% - 17
    ELSEIF RUNE1$ = "wak" AND RUNE2$ = "roc" AND RUNE3$ = "vas" THEN
        PRINT "The X-Files is rather good."
        ENEMYPTS% = 2
        PRINT "Babylon 5 is great!"
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "ken" AND RUNE3$ = "dir" THEN
        PRINT "Babylon 5 is great!"
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "rer" AND RUNE3$ = "sho" THEN
        PRINT "Zzzzap!"
        ENEMYPTS% = ENEMYPTS% - 15
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "rof" AND RUNE3$ = "coz" THEN
        PRINT "You have turned your opponent into stone!"
        ENEMYPTS% = ENEMYPTS% - 19
    ELSEIF RUNE1$ = "tog" AND RUNE2$ = "sho" AND RUNE3$ = "yoo" THEN
        PRINT "Red lasers flash from your eyes!"
        ENEMYPTS% = ENEMYPTS% - 14
    ELSEIF RUNE1$ = "ken" AND RUNE2$ = "rof" AND RUNE3$ = "pos" THEN
        PRINT "You have built a shield!"
        HPS% = HPS% + 4
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "wir" AND RUNE3$ = "pud" THEN
        PRINT "You have gained magic armour!"
        HPS% = HPS% + 6
    ELSEIF RUNE1$ = "yoo" AND RUNE2$ = "sho" AND RUNE3$ = "tog" THEN
        CLS
    ELSEIF RUNE1$ = "gnu" AND RUNE2$ = "wir" AND RUNE3$ = "tog" THEN
        PRINT "The ground swallows up your opponent!"
        ENEMYPTS% = ENEMYPTS% - 7
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "wir" AND RUNE3$ = "tog" THEN
        PRINT "Lightning never strikes twice!"
    ELSEIF RUNE1$ = "wod" AND RUNE2$ = "uss" AND RUNE3$ = "ken" THEN
        PRINT "Wierd-a-loony-fantastic-eye-boggling-mania!!!"
        ENEMYPTS% = 1
        HPS% = 10
    ELSEIF RUNE1$ = "gnu" AND RUNE2$ = "wak" AND RUNE3$ = "coz" THEN
        PRINT "A tiger forms in the air and attacks your opponent!"
        ENEMYPTS% = ENEMYPTS% - 5
    ELSEIF RUNE1$ = "wod" AND RUNE2$ = "coz" AND RUNE3$ = "ken" THEN
        PRINT "You'll be the death of your opponent one day!"
        ENEMYPTS% = ENENYHPS% - HPS%
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "rer" AND RUNE3$ = "cal" THEN
        PRINT "Fart the day of the right way!!!"
    ELSEIF RUNE1$ = "wod" AND RUNE2$ = "wir" AND RUNE3$ = "pos" THEN
        PRINT
    ELSEIF RUNE1$ = "dop" AND RUNE2$ = "fla" AND RUNE3$ = "wir" THEN
        PRINT
        ENEMYPTS% = ENEMYPTS% - 13
    ELSEIF RUNE1$ = "fla" AND RUNE2$ = "wir" AND RUNE3$ = "rof" THEN
        PRINT "Your opponent comes out in red spots!"
        ENEMYPTS% = ENEMYPTS% - 1
    ELSEIF RUNE1$ = "wir" AND RUNE2$ = "rof" AND RUNE3$ = "pos" THEN
        PRINT "A hideous monster appears and attacks your opponent!"
        ENEMYPTS% = ENEMYPTS% - 18
    ELSEIF RUNE1$ = "rof" AND RUNE2$ = "pos" AND RUNE3$ = "cal" THEN
        PRINT "Happy Birthday!!!"
    ELSEIF RUNE1$ = "pos" AND RUNE2$ = "cal" AND RUNE3$ = "uch" THEN
        PRINT "Do you know that this is the 100th spell?"
        COLOR 7
    ELSE
        PRINT "Not a valid spell."
    END IF

    IF HPS% <= 0 THEN
        PRINT "You have died."
        END
    ELSEIF HPS% > HP THEN
        HPS% = HP%
    END IF
  3000
END SUB

    REM $STATIC
SUB MainMenu
    Diff% = 1
  9998
    CLS
    PRINT "                         THE MUD GAME"
    PRINT ""
    PRINT "                          MAIN MENU"
    PRINT ""
    PRINT "                       0-New Game"
    PRINT "                       1-Load Game"
    PRINT "                       2-Quit"
    PRINT "                       3-Credits"
    PRINT "                       4-Options"
    IF GameOn% = 1 THEN
        PRINT "                       5-Return to current game"
    END IF
  9999
    INPUT ">", Menu$
    SELECT CASE Menu$
        CASE "0"
            GameOn% = 0
            SavePos% = 100
            ClearFlags
            ACT1
        CASE "1"
            LoadGame
        CASE "2"
            END
        CASE "3"
            Credits
            CLS
        CASE "4"
            Options
        CASE "5"
            IF GameOn% = 1 GOTO 10000
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 9999
    END SELECT
    GOTO 9998
  10000
END SUB

SUB NecrotaliaAI
    SELECT CASE INT(RND * 5)
        CASE 0
            PRINT "Necrotalia stands there and laughs"
        CASE 1
            PRINT "Necrotalia casts fire"
            MiscastChance% = INT(RND * 40)
            IF MiscastChance% >= 10 THEN
                PRINT "Necrotalia miscasts!"
            ELSEIF PlayerReflect% = 1 THEN
                COLOR 5
                PRINT "The spell reflects off your magic"
                PRINT "The reflect spell wears off"
                PlayerReflect% = 0
                COLOR 15
            ELSE
                ArrowDamage% = INT(RND * 20)
                PRINT "The fire causes you "; ArrowDamage%; " damage."
                HPS% = HPS% - ArrowDamage%
                IF HPS% <= 0 THEN
                    PRINT "You have died."
                END IF
            END IF
        CASE 2
            PRINT "Necrotalia casts Gaze of Death!"
            MiscastChance% = INT(RND * 11)
            IF MiscastChance% >= 10 THEN
                PRINT "Necrotalia miscasts!"
            ELSEIF PlayerReflect% = 1 THEN
                COLOR 5
                PRINT "The spell reflects off your magic"
                PRINT "The reflect spell wears off"
                PlayerReflect% = 0
                COLOR 15
            ELSE
                HPS% = 0
                SaveChance% = INT(RND * 20)
                IF SaveChance% >= 10 THEN
                    PRINT "You feel a strange magic field forming around you!"
                    PRINT "Necrotalia notices something"
                    SLEEP 4
                    COLOR 14
                    PRINT "Necrotalia>Could it be? The legendary holy guardian Pheonix?"
                    SLEEP 4
                    COLOR 15
                    NecrotaliaHP% = 0
                    PRINT "The spell reflects off of the magic field and wounds Necrotalia!"
                    SLEEP 6
                    COLOR 5
                    PRINT "Your familiar is replaced by Pheonix."
                    Familiar$ = "Pheonix"
                    FAMILIARDAMAGE% = 50
                    FAMILIARHP% = 50
                    FamiliarHPS% = 50
                    MP% = 50
                    MPS% = 50
                    IF NecrotaliaHP% <= 0 THEN
                                COLOR 14
                                PRINT "Necrotalia> Enough!"
                                SLEEP 4
                                COLOR 15
                                PRINT "Necrotalia casts Storm of Death!"
                                SLEEP 4
                                PRINT "You fall to one knee!"
                                SLEEP 4
                                EndGameCutscene
                        END IF
                ELSE
                    PRINT "You have died."
                END IF
            END IF
        CASE 3
            PRINT "Necrotalia jumps forward and slashes you!"
            HPS% = HPS% - 1
            IF HPS% <= 0 THEN
                PRINT "You have died."
            END IF
        CASE 4
            PRINT "Necrotalia casts hand of dust!"
            MiscastChance% = INT(RND * 100)
            IF MiscastChance% >= 10 THEN
                PRINT "Necrotalia miscasts!"
            ELSEIF PlayerReflect% = 1 THEN
                COLOR 5
                PRINT "The spell reflects off your magic"
                PRINT "The reflect spell wears off"
                PlayerReflect% = 0
                COLOR 15
            ELSE
                PRINT "You feel your strength fleeing from you."
                ColorPrint 13, "Your strength is temporarily reduced by 1."
                STR% = STR% - 2
            END IF
    END SELECT
END SUB

SUB NecrotaliaBattle
    CLS
    ENEMY$ = "Necrotalia"
    Boss% = 1
    NecrotaliaHP% = 1000
    PRINT "Necrotalia readies her glowing red sword"

    SPEED% = 15
    ENEMYSPEED% = SPEED%

    cs% = INT(RND * 20) + 1
    COMBATSPEED% = ENG% + cs%

  35000
    PRINT "What would you like to do?"
    IF WeaponThrown% > 0 THEN
        WeaponThrown% = WeaponThrown% - 1
    ELSE
        ReturnWeapon
        PRINT "You grab your fallen weapon."
    END IF

    PRINT "Hitpoints: "; HPS%; "/"; HP%
    INPUT ">", ACTION$
    SELECT CASE ACTION$
        CASE "call familiar"
            PRINT Familiar$; " arrives and takes your place."
            SLEEP 2
            PRINT "Necrotalia casts a banishment!"
            PRINT "you're familiar falls to the ground!"
            FAMILIARHP% = 0
        CASE "use potion"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                AI
            END IF

            IF Inventory(ITEM_POTION).amount >= 1 THEN
                ColorPrint 5, "used potion"
            ELSE
                ColorPrint 5, "you are out of potions"
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                AI
            END IF
        CASE "spit"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                NecrotaliaAI
            END IF

            PRINT "You spit in Necrotalia's face."
            PRINT "Necrotalia wipes it off and laughs"

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                NecrotaliaAI
            END IF
        CASE "help"
            HELP
        CASE "ready weapon"
            IF COMBATSPEED% <= ENEMYSPEED% THEN
                NecrotaliaAI
            END IF

            PRINT "You readied your weapon."
            GOTO 36000

            IF COMBATSPEED% > ENEMYSPEED% THEN
                NecrotaliaAI
            END IF
        CASE "run"
            PRINT "You won't run from Necrotalia!."
        CASE "kick"
            IF COMBATSPEED% >= ENEMYSPEED% THEN
                PRINT "Necrotalia evades the kick."
            END IF
        CASE "punch"
            IF COMBATSPEED% >= ENEMYSPEED% THEN
                PRINT "Necrotalia ignores the punch."
            END IF
        CASE "judge enemy"
            CORRECTJUDGECHANCE% = INT(RND * 100) + 1
            IF CORRECTJUDGECHANCE% <= 35 THEN
                PRINT "Necrotalia's hitpoints appear to be "; NecrotaliaHP%; "."
            ELSEIF CORRECTJUDGECHANCE% >= 65 THEN
                PRINT "Necrotalia's hitpoints appear to be "; NecrotaliaHP% + 10; "."
            ELSE
                PRINT "Necrotalia's hit points appear to be "; NecrotaliaHP% + 5; "."
            END IF
        CASE "use magic"
            IF Expertise% <> CLASS_MAGE THEN
                ColorPrint 5, "Only mages can use magic!"
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF

                MAGIC
                IF NecrotaliaHP% <= 0 THEN
                    COLOR 14
                    PRINT "Necrotalia> Enough!"
                    SLEEP 2
                    COLOR 15
                    PRINT "Necrotalia casts Storm of Death!"
                    PRINT "You fall to one knee!"
                    GOTO 40000
                END IF

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF
            END IF
        CASE ELSE
            PRINT "Huh?"
    END SELECT
    GOTO 35000

  36000
    PRINT "What would you like to do?"
    IF WeaponThrown% > 0 THEN
        WeaponThrown% = WeaponThrown% - 1
    ELSE
        ReturnWeapon
        PRINT "You grab your fallen weapon."
    END IF

    PRINT "Hitpoints: "; HPS%; "/"; HP%
    INPUT ">", ACTIONA$
    SELECT CASE ACTIONA$
        CASE "steal"
            IF Expertise% <> CLASS_THIEF THEN
                ColorPrint 5, "Only thieves can steal."
                GOTO 36000
            ELSE
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    Steal
                    NecrotaliaAI
                ELSE
                    NecrotaliaAI
                    Steal
                END IF
            END IF
        CASE "throw weapon"
            IF Expertise% <> CLASS_ROGUE THEN
                ColorPrint 5, "Only rogues can throw weapons."
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF

                LHO$ = LH$
                IF LH$ = "Long Staff" THEN RH$ = ""
                IF LH$ = "Short Staff" THEN RH$ = ""
                LH$ = ""
                WeaponThrown% = 3
                DAMAGEADDED% = DAMAGEADDED% * 3
                PRINT "You throw your weapon at the "; ENEMY$
                DAMAGEDONE% = STR% + DAMAGEADDED%
                NecrotaliaHP% = NecrotaliaHP% - DAMAGEDONE%
                DAMAGEADDED% = 0
                IF NecrotaliaHP% <= 0 THEN
                    COLOR 14
                    PRINT "Necrotalia> Enough!"
                    SLEEP 2
                    COLOR 15
                    PRINT "Necrotalia casts Storm of Death!"
                    PRINT "You fall to one knee!"
                    GOTO 40000
                 END IF

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF
            END IF
        CASE "play music"
            IF Expertise% <> CLASS_BARD THEN
                ColorPrint 5, "Only bards can play music."
            ELSE
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    BardMusic
                    NecrotaliaAI
                ELSE
                    NecrotaliaAI
                    BardMusic
                END IF
            END IF
        CASE "use potion"
            IF COMBATSPEED% < ENEMYSPEED% THEN
                NecrotaliaAI
            END IF

            IF Inventory(ITEM_POTION).amount >= 1 THEN
                ColorPrint 5, "used potion"
            ELSE
                ColorPrint 5, "you are out of potions"
            END IF

            IF COMBATSPEED% >= ENEMYSPEED% THEN
                NecrotaliaAI
            END IF
        CASE "call familiar"
            PRINT Familiar$; " arrives and takes your place."
            SLEEP 2
            PRINT "Necrotalia casts a banishment!"
            PRINT "you're familiar falls to the ground!"
            FAMILIARHP% = 0
        CASE "use magic"
            IF Expertise% <> CLASS_MAGE THEN
                ColorPrint 5, "Only mages can use magic!"
            ELSE
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF

                MAGIC
                IF NecrotaliaHP% <= 0 THEN
                    COLOR 14
                    PRINT "Necrotalia> Enough!"
                    SLEEP 2
                    COLOR 15
                    PRINT "Necrotalia casts Storm of Death!"
                    PRINT "You fall to one knee!"
                    GOTO 40000
                END IF

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    NecrotaliaAI
                END IF
            END IF
        CASE "spit"
            PRINT "You spit in Necrotalia's face."
            PRINT "Necrotalia wipes it off and laughs."
        CASE "help"
            HELP
        CASE "slash"
            IF COMBATSPEED% <= ENEMYSPEED% THEN
                NecrotaliaAI
            END IF

            PRINT "You slashed Necrotalia in the chest, she staggers back in pain"
            NecrotaliaHP% = NecrotaliaHP% - (DAMAGEADDED% + STR% + 2)
            IF NecrotaliaHP% <= 0 THEN
                COLOR 14
                PRINT "Necrotalia> Enough!"
                SLEEP 2
                COLOR 15
                PRINT "Necrotalia casts Storm of Death!"
                PRINT "You fall to one knee!"
                GOTO 40000
            END IF

            IF COMBATSPEED% > ENEMYSPEED% THEN
                NecrotaliaAI
            END IF
        CASE "thrust"
            IF COMBATSPEED% <= ENEMYSPEED% THEN
                NecrotaliaAI
            END IF

            PRINT "You lunge forward and pierce Necrotalia, she staggers back in pain."
            NecrotaliaHP% = NecrotaliaHP% - (STR% + 5 + DAMAGEADDED%)
            IF NecrotaliaHP% <= 0 THEN
                    COLOR 14
                    PRINT "Necrotalia> Enough!"
                    SLEEP 2
                    COLOR 15
                    PRINT "Necrotalia casts Storm of Death!"
                    PRINT "You fall to one knee!"
                    GOTO 40000
            END IF

            IF COMBATSPEED% > ENEMYSPEED% THEN
                NecrotaliaAI
            END IF
        CASE "parry"
            PRINT "You attempt to parry Necrotalia's blow."
            PC% = INT(RND * 100) + 1
            PARRYCHANCE% = PC% + ShieldSave%
            IF PARRYCHANCE% >= 50 THEN
                PRINT "You were successful in parrying Necrotalia's blow."
            ELSE
                PRINT "You failed to parry Necrotalia's blow.  You take 2 damage."
                HPS% = HPS% - 2
            END IF
        CASE "punch"
            IF COMBATSPEED% >= ENEMYSPEED% THEN
                PRINT "Necrotalia ignores the punch."
            END IF
            NecrotaliaAI
        CASE "kick"
            IF COMBATSPEED% >= ENEMYSPEED% THEN
                PRINT "You aim your foot and strike Necrotalia in the groin."
                PRINT "Necrotalia evades the kick."
            END IF
        CASE "dodge"
            PRINT "As Necrotalia attacks, you attempt to dodge her attack."
            DC% = INT(RND * 100) + 1
            DODGECHANCE% = DC% - DEX%
            IF DODGECHANCE% >= 45 THEN
                PRINT "You were successfully able to dodge Necrotalia's attack."
            ELSE
                PRINT "You were not successful at dodging the Necrotalia's attack. You take 2 damage."
                HPS% = HPS% - 1
            END IF
        CASE "coup de grace"
            IF NecrotaliaHP% <= 30 THEN
                PRINT "You grasp Necrotalia's head, draw back and crush her skull."
                COLOR 14
                PRINT "Necrotalia> Enough!"
                SLEEP 2
                COLOR 15
                PRINT "Necrotalia casts Storm of Death!"
                PRINT "You fall to one knee!"
                GOTO 40000
            END IF
        CASE "use owl spell"
            IF Owl% = 1 THEN
                USEOWLSPELL
                IF NecrotaliaHP% <= 0 THEN
                    COLOR 14
                    PRINT "Necrotalia> Enough!"
                    SLEEP 2
                    COLOR 15
                    PRINT "Necrotalia casts Storm of Death!"
                    PRINT "You fall to one knee!"
                    GOTO 40000
                END IF
            ELSE
                PRINT "You don't have an owl."
            END IF
        CASE "run"
            PRINT "You won't run from Necrotalia!"
        CASE "judge enemy"
            CORRECTJUDGECHANCE% = INT(RND * 100) + 1
            IF CORRECTJUDGECHANCE% <= 35 THEN
                PRINT "Necrotalia's hitpoints appear to be "; NecrotaliaHP%; "."
            ELSEIF CORRECTJUDGECHANCE% >= 65 THEN
                PRINT "Necrotalia's hitpoints appear to be "; NecrotaliaHP% + 10; "."
            ELSE
                PRINT "Necrotalia's hit points appear to be "; NecrotaliaHP% + 5; "."
            END IF
        CASE ELSE
            PRINT "Huh?"
    END SELECT
    GOTO 36000

  40000
    PlayerReflect% = 0
    ReturnWeapon
END SUB

SUB NecrotaliaFight
  1000000
    CLS
    PRINT "You are now standing in a large open room, in the middle of the room is a chaos"
    PRINT "star symbol.  drawn in blood.  On the opposite side of the room is a sort of "
    PRINT "throne, built of bones.  The floor of this room is littered with skeletons, "
    PRINT "the room seems devoid of any life."
    COLOR 5
    PRINT "There is one obvious exit:"
    PRINT "         South: Dark passage"
    COLOR 15
  1000005
    INPUT ">", Necro$
    SELECT CASE Necro$
        CASE "help"         : WorldHelp
        CASE "menu"         : MainMenu
        CASE "stats"        : displaystats
        CASE "inventory"    : displayinventory
        CASE "equipment"    : displayequip
        CASE "equip LH"     : EQlh
        CASE "equip RH"     : EQrh
        CASE "equip ARMOUR" : EqArmour
        CASE "use potion"
            IF Inventory(ITEM_POTION).amount >= 1 THEN
                HPS% = HPS% + 15
                IF HPS% > HP% THEN HPS% = HP%
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount - 1
                ColorPrint 5, "Used potion"
            ELSE
                GOTO 1000010
            END IF
        CASE "south"

            IF Sex$ = "his" THEN SexType$ = "boy"
            IF Sex$ = "her" THEN SexType$ = "girl"
            COLOR 2

            SLEEP 3
            PRINT "As you leave the area the blood behind you ignites, sending flames impossibly"
            PRINT "high.  Turning around you notice that the skeletons on the floor are no longer"
            PRINT "inanimate, they are standing and clutching short swords and bucklers, amongst"
            PRINT "the sounds of the flames you hear laughing."
            SLEEP 10
            COLOR 14
            PRINT "Unknown Voice> You challenge me? you are only a "; SexType$; "."
            SLEEP 2
            PRINT Name$; "> Well if you are so confident then why do you hide?"
            SLEEP 2
            PRINT "Unknown Voice> Good question, I suppose the great Necrotalia has no reason"
            PRINT "               to hide."
            SLEEP 2
            PRINT Name$; "> You are Necrotalia? I thought daemons were supposed "
            PRINT "         to be frightening."
            SLEEP 2
            PRINT "Sir Jacob> Enough, as simple as she appears, daemons are dangerous."
            SLEEP 2
            PRINT "Necrotalia> You attempt to anger me? very well if the only fighting you do is"
            PRINT "            with words, perhaps.  I will show you a better means of fighting."
            PRINT "            Go forth my minions, eliminate this nuisance."
            SLEEP 4
            PRINT "Suddenly the skeletons start marching forward."
            PRINT "Sir Jacob> You send mere warriors of undeath to fight us? are you too cowardly"
            PRINT "to fight us yourself?"
            SLEEP 4
            PRINT "Sir Jacob> Very well, I will turn your minions to dust!"
            SLEEP 2
            PRINT "A blue magical field surrounds Sir Jacob and lashes out towards all the "
            PRINT "minions in the area.  Soon afterwards all the skeletons collapse into "
            PRINT "piles of bones."
            SLEEP 3
            PRINT "Necrotalia> Hah! you annoy me with your pitiful magic!"
            PRINT "A red magic field surrounds Necrotalia and advances on Sir Jacob."
            SLEEP 3
            PRINT "Sir Jacob falls to one knee and says `I can't move!'"
            SLEEP 1
            COLOR 3
            PRINT "Necrotalia> You! you will die now!"
            SLEEP 3
            COLOR 15

            NecrotaliaBattle
            COLOR 15
            EndGameCutscene
            GOTO 1000010
    END SELECT
    GOTO 1000005
  1000010
    ColorPrint 5, "Huh?"
    GOTO 1000005
END SUB

SUB Options
  1.05
    CLS
    PRINT "Options:"
    PRINT "   1-Game Options"
    PRINT "   2-Return to main menu"
    PRINT ""
  1.1
    PRINT "What is your choice? <1-2>"
    INPUT ">", Optionse$
    SELECT CASE Optionse$
        CASE "1"
            CLS
            PRINT "Difficulty level:"
            PRINT "<E>asy"
            PRINT "<M>edium"
            PRINT "<H>ard"
          1.25
            PRINT "What is your choice?"
            INPUT ">", Difficulty$
            SELECT CASE Difficulty$
                CASE "e"
                    Diff% = 0
                CASE "m"
                    Diff% = 1
                CASE "h"
                    Diff% = 2
                CASE ELSE
                    ColorPrint 5, "Huh?"
                    GOTO 1.25
            END SELECT
            GOTO 1.05
        CASE "2"
        CASE ELSE
            ColorPrint 5, "Huh?"
            GOTO 1.1
    END SELECT
END SUB

REM $DYNAMIC
SUB OWLSPELL
    IF ALLE% <> 9 THEN
        OWLSPELLCHANCE% = INT(RND * 100) + 1
        IF OWLSPELLCHANCE% <= 10 THEN
          19999.9
            WHICHOWLSPELL% = INT(RND * 12) + 1

            IF NOT OwlSpells(WHICHOWLSPELL%).hasIt THEN
                LEARNOWLSPELL$ = OwlSpells(WHICHOWLSPELL%).name
                OwlSpells(WHICHOWLSPELL%).hasIt = TRUE
                ALLE% = ALLE% + 1

                PRINT Familiar$; " learned the "; LEARNOWLSPELL$; " spell!"
            ELSE
                GOTO 19999.9
            END IF
        END IF
    END IF
END SUB

REM $DYNAMIC
SUB PurchaseSamael
    IF Inventory(QITEM_STRANGE_PENDANT).amount >= 1 THEN
        COLOR 5
        PRINT "Samael>Oh! you have found my pendant! thank you...here is a gift."
        COLOR 2
        PRINT "Got Holy Sword"
        PRINT "Got Burning Sphere"
        COLOR 15
        Inventory(QITEM_STRANGE_PENDANT).amount = Inventory(QITEM_STRANGE_PENDANT).amount - 1
        Inventory(ITEM_HOLY_SWORD).amount = Inventory(ITEM_HOLY_SWORD).amount + 1
        Inventory(QITEM_BURNING_SPHERE).amount = Inventory(QITEM_BURNING_SPHERE).amount + 1
        Quest% = 0
        Inventory(ITEM_SWORD_PLUS_ONE).buyPrice = 0
    END IF

  430
    COLOR 2
    PRINT "talk"
    PRINT "buy"
    PRINT "sell"
    PRINT "leave"
    COLOR 15
  431
    INPUT ">", A2S$
    SELECT CASE A2S$
        CASE "talk"
            COLOR 5
            IF Quest% = 1 THEN
                PRINT "Samael>Yknow, I went down into that labryinth once before...nearly got myself"
                PRINT "killed doin it too.  Anyways when I was doon there I dropped mi pendant if you"
                PRINT "go down there and find it I will give ye a nice rare sword in exchange. I'll"
                PRINT "tell ye somethin tho, I dropped the pendant somewhere on the second level."
            ELSE
                PRINT "Samael> I see ye haven't gotten yerself killed yet, well good fer ye lad."
            END IF
            COLOR 15
        CASE "buy"
            ColorPrint 5, "Samael>Good, here's what I got fer ya."
            PRINT "Item                 Cost"
            PRINT "-------------------------"
            FOR i = 0 TO UBOUND(Inventory)
                IF Inventory(i).buyPrice <> 0 THEN
                    PRINT Inventory(i).name; SPACE$(20 - LEN(Inventory(i).name));
                    PRINT USING "####"; Inventory(i).buyPrice
                END IF
            NEXT i

            PRINT ""
            PRINT "Gold="; Gold&

            INPUT "item name>", Purchase$

            Purchase$ = LCASE$(Purchase$)
            FOR i = 0 TO UBOUND(Inventory)
                IF Inventory(i).buyPrice <> 0 AND LCASE$(Inventory(i).name) = Purchase$ THEN
                    foundIt% = TRUE

                    IF Gold& >= Inventory(i).buyPrice THEN
                        Gold& = Gold& - Inventory(i).buyPrice
                        Inventory(i).amount = Inventory(i).amount + 1
                        PRINT "Got "; Purchase
                    ELSE
                        PRINT "You don't have enough gold for that"
                    END IF

                    EXIT FOR
                END IF
            NEXT i

            IF NOT foundIt% THEN PRINT "Samael> ooook...I don't quite understande ye, try again."
        CASE "sell"
            displayinventory
            PRINT "What do you wish to sell?"
            INPUT "Item Name>", Sell$

            Sell$ = LCASE$(Sell$)
            FOR i = 0 TO UBOUND(Inventory)
                IF Inventory(i).sellPrice <> 0 AND Inventory(i).amount > 0 AND LCASE$(Inventory(i).name) = Sell$ THEN
                    foundIt% = TRUE

                    PRINT "Samael> Okay I can give ye "; Inventory(i).sellPrice; " gold fer each of em"
                    PRINT "        how many do ye want to sell me?"
                    PRINT "Quantity:"; Inventory(i).amount
                    INPUT "Sell how many?", amount%

                    IF Inventory(i).amount < amount% THEN
                        PRINT "You don't have that many. Anyways, I'll take everything ye got."
                        amount% = Inventory(i).amount
                    END IF

                    Gold& = Gold& + (Inventory(i).sellPrice * amount%)
                    Inventory(i).amount = Inventory(i).amount - amount%

                    EXIT FOR
                END IF
            NEXT i

            IF NOT foundIt% THEN PRINT "Samael> ooook...I don't quite understande ye, try again."
        CASE "leave"
            GOTO SUBEND
        CASE ELSE
            PRINT "huh?"
            GOTO 431
    END SELECT
    GOTO 430
  SUBEND:
END SUB

SUB RANDOMRUNEDROP
    RRD% = INT(RND * 26) + 1
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_RUNE THEN
            RRD% = RRD% - 1
            IF RRD% = 0 THEN
                RANDOMRUNE$ = Inventory(i).name
                Inventory(i).amount = 1
            END IF
        END IF
    NEXT i
END SUB

SUB RANDOMSTRING
    'Generates a random string
    RNDSTRING% = INT(RND * 40)
    COLOR 4
    SELECT CASE RNDSTRING%
        CASE 1 : PRINT "You hear a creaking sound."
        CASE 2 : PRINT "An evil laugh penetrates the silence."
        CASE 3 : PRINT "You hear the screaming of an unknown person."
        CASE 4 : PRINT "You begin to shiver from the cold."
        CASE 5 : PRINT "You sense several eyes on you."
        CASE 6 : PRINT "You hear a low moaning sound nearby."
        CASE 7 : PRINT "A woman's high pitched shriek pierces the silence."
        CASE 8 : PRINT "You look down at a gruesome corpse and shudder."
    END SELECT
END SUB

SUB ReturnWeapon
    LH$ = LHO$
    SELECT CASE LH$
        CASE "Short Sword"        : DAMAGEADDED% = 1
        CASE "Long Sword"         : DAMAGEADDED% = 2
        CASE "Battle Blade"       : DAMAGEADDED% = 3
        CASE "Bastard Sword"      : DAMAGEADDED% = 4
        CASE "Great Sword"        : DAMAGEADDED% = 5
        CASE "Great Battle Blade" : DAMAGEADDED% = 6
        CASE "Holy Sword"         : DAMAGEADDED% = 7
        CASE "Sword +1"           : DAMAGEADDED% = 8
        CASE "Sword +2"           : DAMAGEADDED% = 9
        CASE "Sword +3"           : DAMAGEADDED% = 10
        CASE "Sword +4"           : DAMAGEADDED% = 11
        CASE "Sword +5"           : DAMAGEADDED% = 12
        CASE "Avenger Sword +7"   : DAMAGEADDED% = 15
        CASE "Long Staff"         : DAMAGEADDED% = 4
        CASE "Short Staff"        : DAMAGEADDED% = 2
    END SELECT
END SUB

REM $STATIC
SUB SaveGame
    Operation$ = "Save"
    GetSaveLoadPos

    saveStr$ = "mud"
    IF SavedGame% > 1 THEN
        saveStr$ = saveStr$ & LTRIM$(STR$(SavedGame%))
    END IF
    saveStr$ = saveStr$ & ".sav"

    OPEN saveStr$ FOR OUTPUT AS #1

    'Saving position
    WRITE #1, SavePos%

    'Player Stats
    WRITE #1, Name$, VIT%, STR%, ENG%, DEX%, HPS%, Gold&, EXPR%, STRO%, LH$, RH$, Armour$, DAMAGEADDED%, DamageLostArmour%, ShieldSave%, Sex$, Lvl%, HP%, Class$, MP%, MPS%, Helm$, DamageLostHelm%, STRO%, DEXO%, VITO%, ENGO%

    'Act 1 items, triggers, helmsburg
    WRITE #1, HelmsburgBttl%, Inventory(QITEM_STRANGE_PENDANT).amount, Inventory(QITEM_BURNING_SPHERE).amount, Inventory(QITEM_GOLDEN_SKULL).amount, Inventory(QITEM_CHAOS_STAR).amount, Inventory(QITEM_KEY1).amount, Inventory(QITEM_KEY2).amount, A1ShopEnter%, A1ShopPotion%, A1EnterPit%, Quest%, A3LS%, A3Corpse%, ThroneSwitch%, A12Potions%, A12ShieldPlusTwo%, GoldenSkullTaken%, A14Key2%, A19Lvl1Door%, A19Lvl2Door%, A20Lvl1Door%, A23FamiliarFlute%, A26ChaosStar%, A27GoldenSocket%, A27JadeSocket%, A29StarSocket%, Inventory(QITEM_FAMILIAR_FLUTE).amount, Inventory(QITEM_CHAOS_STAR).amount, A27AvengerSword, A28ChaosStarSocket%, Inventory(QITEM_JADE_SKULL).amount, WightLord%

    'Weapon Inventory
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_WEAPON THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    'Helms
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_HELM THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    'Shield Inventory
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_SHIELD THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    'Armour Inventory
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).equipType = EQUIP_ARMOUR THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    'Potion Inventory
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_POTION THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    'Act1Pt2 SUB Triggers, Quest Items
    WRITE #1, A34Cutscene%, A34CutsceneDone%, A34SecretDoor%, A42Cutscene%, A42LockedGate%, XanathusDead%, XanathusArea$, XanathusHP%, A48BSphere%, A56VampFight, Hint%, GemNum%, GemPuzzleDone%, A67SwordPuzzle%, A67SwordTaken%, RustedSword%, Inventory(QITEM_GATE_KEY).amount, A67PillarOn%

    'Familiar Flute
    WRITE #1, Inventory(QITEM_FAMILIAR_FLUTE).amount

    'Familiar Stuff
    WRITE #1, Familiar$, FAMILIARHP%, FAMILIARDAMAGE%, Owl%, OWLSPELLE$,

    FOR i = 0 TO 8
        WRITE #1, OwlSpells(i).hasIt,
    NEXT i
    WRITE #1, LEARNOWLSPELL$, AL%,
    FOR i = 9 TO 11
        WRITE #1, OwlSpells(i).hasIt,
    NEXT i
    WRITE #1, FamiliarHPS%

    'Class stuff
    WRITE #1, Expertise%

    'All The runestuff
    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_RUNE THEN
            IF firstTaken% THEN
                PRINT #1, "," + CHR$(34); Inventory(i).name; CHR$(34);
            ELSE
                PRINT #1, CHR$(34); Inventory(i).name; CHR$(34);
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    firstTaken% = FALSE
    FOR i = 0 TO UBOUND(Inventory)
        IF Inventory(i).itemType = ITEM_TYPE_RUNE THEN
            IF firstTaken% THEN
                PRINT #1, ","; LTRIM$(STR$(Inventory(i).amount));
            ELSE
                PRINT #1, LTRIM$(STR$(Inventory(i).amount));
                firstTaken% = TRUE
            END IF
        END IF
    NEXT i
    PRINT #1, ""

    CLOSE #1

    SaveToSavegame
  100001
END SUB

SUB SaveToSavegame
    OPEN "sgame.sav" FOR INPUT AS #1

    slotsInUse% = 0
    IF LOF(1) > 0 THEN
        DO
            INPUT #1, SaveSlots(slotsInUse%).playerName, SaveSlots(slotsInUse%).playerClass, SaveSlots(slotsInUse%).savePoint
            IF SaveSlots(slotsInUse%).playerName <> "" THEN
                slotsInUse% = slotsInUse% + 1
            END IF
        LOOP UNTIL EOF(1) OR slotsInUse% > UBOUND(SaveSlots)
    END IF

    CLOSE #1
    OPEN "sgame.sav" FOR OUTPUT AS #2

    IF SavedGame% <= UBOUND(SaveSlots) + 1 THEN
        SaveSlots(SavedGame% - 1).playerName = Name$
        SaveSlots(SavedGame% - 1).playerClass = Class$
        SaveSlots(SavedGame% - 1).savePoint = SavePos%

        IF SavedGame% = slotsInUse% + 1 THEN
            slotsInUse% = slotsInUse% + 1
        END IF
    END IF

    FOR i = 0 TO slotsInUse% - 1
        WRITE #2, SaveSlots(i).playerName, SaveSlots(i).playerClass, SaveSlots(i).savePoint
    NEXT i

    CLOSE #2
END SUB

SUB _Steal (preText AS STRING)
    StealChance% = INT(RND * 100) - DEX%
    IF StealChance% <= 50 THEN
        SELECT CASE ENEMY$
            CASE "Axe Maiden"
                StealItem$ = "a potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
            CASE "Skeleton"
                StealItem$ = "a buckler"
                Inventory(ITEM_BUCKLER).amount = Inventory(ITEM_BUCKLER).amount + 1
            CASE "Giant Spider"
                StealItem$ = "a potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
            CASE "Zombie"
                StealItem$ = "a potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
            CASE "Imp"
                StealItem$ = "a short sword"
                Inventory(ITEM_SHORT_SWORD).amount = Inventory(ITEM_SHORT_SWORD).amount + 1
            CASE "Ghoul"
                StealItem$ = "nothing"
            CASE "Ork"
                StealItem$ = "some leather armour"
                Inventory(ITEM_LEATHER_ARMOUR).amount = Inventory(ITEM_LEATHER_ARMOUR).amount + 1
            CASE "Corpse"
                StealItem$ = "another 100 gold coins"
                Gold& = Gold& + 100
            CASE "Wight"
                StealItem$ = "a great battle blade"
                Inventory(ITEM_GREAT_BATTLE_BLADE).amount = Inventory(ITEM_GREAT_BATTLE_BLADE).amount + 1
            CASE "Fell Bat"
                StealItem$ = "a potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
            CASE "Wraith"
                StealItem$ = "nothing"
            CASE "Dire Wolf"
                StealItem$ = "a potion"
                Inventory(ITEM_POTION).amount = Inventory(ITEM_POTION).amount + 1
            CASE "Lesser Vampire"
                StealItem$ = "a bastard sword"
                Inventory(ITEM_BASTARD_SWORD).amount = Inventory(ITEM_BASTARD_SWORD).amount + 1
            CASE "Banshee"
                StealItem$ = "a long sword"
                Inventory(ITEM_LONG_SWORD).amount = Inventory(ITEM_LONG_SWORD).amount + 1
            CASE "Phantom"
                StealItem$ = "nothing"
            CASE "Zombie Dragon"
                StealItem$ = "some Hard Leather Armour"
                Inventory(ITEM_HARD_LEATHER_ARMOUR).amount = Inventory(ITEM_HARD_LEATHER_ARMOUR).amount + 1
            CASE "Xanathus"
                StealItem$ = "a long staff"
                Inventory(ITEM_LONG_STAFF).amount = Inventory(ITEM_LONG_STAFF).amount + 1
            CASE "Necrotalia"
                StealItem$ = "a jade skull"
                Inventory(QITEM_JADE_SKULL).amount = Inventory(QITEM_JADE_SKULL).amount + 1
        END SELECT
        PRINT preText; StealItem$
    END IF
END SUB

SUB Steal
    _Steal "You jump forward and steal "
END SUB

SUB ToadSteal
    _Steal "Toad steals "
END SUB

REM $DYNAMIC
SUB USEOWLSPELL
    index% = -1

  spellLoop:
    PRINT "Your owl spell list:"
    FOR i = LBOUND(OwlSpells) TO UBOUND(OwlSpells)
        IF OwlSpells(i).hasIt THEN PRINT OwlSpells(i).name
    NEXT i
    INPUT "Which spell do you wish to use?", USEOWL$

    SELECT CASE USEOWL$
        CASE "fireball"       : index% = 0
        CASE "lightning bolt" : index% = 1
        CASE "healing"        : index% = 2
        CASE "eldrich storm"  : index% = 3
        CASE "fire blast"     : index% = 4
        CASE "cure"           : index% = 5
        CASE "augment"        : index% = 6
        CASE "fortune"        : index% = 7
        CASE "predict"        : index% = 8
        CASE "reflect"        : index% = 9
        CASE "cura"           : index% = 10
        CASE "fira"           : index% = 11
        CASE ELSE
            PRINT "Huh?"
            GOTO spellLoop
    END SELECT

    IF NOT OwlSpells(index%).hasIt THEN
        PRINT Familiar$; " doesn't have that spell"
        SLEEP 3
        GOTO spellLoop
    END IF

    ENEMYPTS% = ENEMYPTS% - OwlSpells(index%).dmg
    IF ENEMYPTS% <= 0 THEN
        PRINT "The "; ENEMY$; " has died!"
    ELSE
        IF OwlSpells(index%).heal < 0 THEN
            HP% = HP% - OwlSpells(index%).heal
            IF HP% > HPS% THEN HP% = HPS%
        ELSE
            FAMILIARHP% = FAMILIARHP% + OwlSpells(index%).heal
            IF FAMILIARHP% > FamiliarHPS% THEN FAMILIARHP% = FamiliarHPS%
        END IF

        PRINT Familiar$; " used the "; OwlSpells(index%).name; " spell!"

        SELECT CASE OwlSpells(index%).special
            CASE 1
                STR% = STR% + 5
                DEX% = DEX% + 5
                VIT% = VIT% + 5
                ENG% = ENG% + 5
            CASE 2
                Golden& = Gold&
                GOLDADDED% = Golden& * .1
                Gold& = Gold& + GOLDADDED%
            CASE 3
                PRINT "You were successful at dodging the "; ENEMY$; "'s attack!"
            CASE 4
                PlayerReflect% = 1
        END SELECT
    END IF
END SUB

SUB WorldHelp
    'when user types help in world
    COLOR 15
    PRINT "The following are a list of commands avaliable only in the world area"
    PRINT "---------------------------------------------------------------------"
    PRINT "north, east, south, west, northeast, northwest, southeast, southwest."
    PRINT "-All these are used for navigation, the area profile will tell you"
    PRINT " which directions are avaliable."
    PRINT " "
    PRINT "help - Used to bring up a list commands."
    PRINT ""
    PRINT "stats - Used to bring up your character's stats."
    PRINT ""
    PRINT "inventory - Used to bring up your character's inventory."
    PRINT ""
    PRINT "equipment - Brings up a menu of your character's equipped equipment."
    PRINT ""
    PRINT "equip - Type this and the name of the body part you wish to equip then"
    PRINT "      press enter then type in the name of the item you wish to equip."
    PRINT "      LH - Left Hand, Swords and other weapons"
    PRINT "      RH - Right Hand, Shields"
    PRINT "      HEAD - Head, Caps or any type of head armour"
    PRINT "      ARMOUR - Torso, body armour"
    PRINT ""
    PRINT "describe -  Describe the area around you"
    PRINT " "
    PRINT "get - take an item in the area"
    PRINT "examine - examine an object in the area."
    PRINT "talk to - talk to a person in the area."
    PRINT "use - use an item in your inventory."
    PRINT "menu - show the game menu."
END SUB

SUB XanathusAI
    IF StunTime% > 0 THEN
        PRINT "Xanathus is stunned."
        StunTime% = StunTime% - 1
    ELSE
        XanathusFleeTime% = XanathusFleeTime - 1

        XanAI% = INT(RND * 4) + 1
        SELECT CASE XanAI%
            CASE 1
                PRINT "Xanathus casts a spell of curing on himself."
                XanathusHP% = XanathusHP% + 5
                IF XanathusHP% >= 150 THEN XanathusHP% = 150
            CASE 2
                PRINT "Xanathus casts magic arrow!"
                MiscastChance% = INT(RND * 40)
                IF MiscastChance% >= 10 THEN
                    PRINT "Xanathus miscasts!"
                ELSEIF PlayerReflect% = 1 THEN
                    COLOR 5
                    PRINT "The spell reflects off your magic"
                    PRINT "The reflect spell wears off"
                    PlayerReflect% = 0
                    COLOR 15
                ELSE
                    ArrowDamage% = INT(RND * 20)
                    PRINT "The arrow causes you "; ArrowDamage%; " damage"
                    HPS% = HPS% - ArrowDamage%
                    IF HPS% <= 0 THEN
                        PRINT "You have died."
                    END IF
                END IF
            CASE 3
                PRINT "Xanathus casts magic arrow!"
                MiscastChance% = INT(RND * 40)
                IF MiscastChance% >= 10 THEN
                    PRINT "Xanathus miscasts!"
                ELSEIF PlayerReflect% = 1 THEN
                    COLOR 5
                    PRINT "The spell reflects off your magic"
                    PRINT "The reflect spell wears off"
                    PlayerReflect% = 0
                    COLOR 15
                ELSE
                    ArrowDamage% = INT(RND * 20)
                    PRINT "The arrow causes you "; ArrowDamage%; " damage"
                    HPS% = HPS% - ArrowDamage%
                    IF HPS% <= 0 THEN
                        PRINT "You have died."
                    END IF
                END IF
            CASE 4
                PRINT "Xanathus prepares to flee!"
                XanathusFleeTime% = XanathusFleeTime% - 1
            CASE 5
                PRINT "Xanathus attempts to flee!"
                FleeChance% = INT(RND * 20)
                IF FleeChance% >= 10 THEN
                    PRINT "Xanathus casts raise dead!"
                    MiscastChance% = INT(RND * 40)
                    IF MiscastChance% >= 10 THEN
                        PRINT "Xanathus miscasts!"
                        StunTime% = INT(RND * 4) + 1
                        PRINT "Xanathus is stunned for the next "; StunTime%; " turn(s)."
                    ELSE
                        XanathusFleeTime% = 0
                        COLOR 14
                        PRINT "Sir Jacob> Let me handle this you go after him."
                        SLEEP 3
                    END IF
                END IF
        END SELECT
    END IF
END SUB

SUB XanathusBattle
    CLS
    Boss% = 1
    LHO$ = LH$
    XanathusFleeTime% = 6
    ENEMY$ = "Xanathus"
    ColorPrint 14, "Xanathus> Argh! if you won't stop chasing me then you will die!"
    PRINT "Xanathus readies his staff"

    SPEED% = 10
    ENEMYSPEED% = SPEED%

    cs% = INT(RND * 20) + 1
    COMBATSPEED% = ENG% + cs%

    DO
        IF StunTime% = 0 THEN XanathusFleeTime% = XanathusFleeTime% - 1
        IF XanathusFleeTime% = 0 THEN
            PRINT "Xanathus flees from you!"
            XanathusFlee
            GOTO 4001
        END IF

        PRINT "What would you like to do?"
        IF WeaponThrown% > 0 THEN WeaponThrown% = WeaponThrown% - 1
        IF WeaponThrown% = 0 THEN ReturnWeapon: PRINT "You grab your fallen weapon."
        PRINT "Hitpoints: "; HPS%; "/"; HP%
        INPUT ">", ACTIONA$

        SELECT CASE ACTIONA$
            CASE "steal"
                IF Expertise% <> CLASS_THIEF THEN
                    ColorPrint 5, "Only thieves can steal."
                ELSE
                    IF COMBATSPEED% >= ENEMYSPEED% THEN
                        Steal
                        XanathusAI
                    ELSE
                        XanathusAI
                        Steal
                    END IF
                END IF
            CASE "throw weapon"
                IF Expertise% <> CLASS_ROGUE THEN
                    ColorPrint 5, "Only rogues can throw weapons."
                ELSE
                    IF COMBATSPEED% < ENEMYSPEED% THEN
                        XanathusAI
                    END IF

                    LHO$ = LH$
                    IF LH$ = "Long Staff" THEN RH$ = ""
                    IF LH$ = "Short Staff" THEN RH$ = ""
                    LH$ = ""
                    WeaponThrown% = 3
                    DAMAGEADDED% = DAMAGEADDED% * 3
                    PRINT "You throw your weapon at the "; ENEMY$
                    DAMAGEDONE% = STR% + DAMAGEADDED%
                    XanathusHP% = XanathusHP% - DAMAGEDONE%
                    DAMAGEADDED% = 0
                    IF XanathusHP% <= 0 THEN
                        PRINT "Xanathus falls to the wound."
                        ColorPrint 14, "Xanathus> How could this be?"
                        PRINT "Obtained gate key from Xanathus' body!"
                        Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                        XanathusDead% = 1
                        GOTO 4000
                    END IF

                    IF COMBATSPEED% >= ENEMYSPEED% THEN
                        XanathusAI
                    END IF
                END IF
            CASE "play music"
                IF Expertise% <> CLASS_BARD THEN
                    ColorPrint 5, "Only bards can play music."
                ELSE
                    IF COMBATSPEED% >= ENEMYSPEED% THEN
                        BardMusic
                        XanathusAI
                    ELSE
                        XanathusAI
                        BardMusic
                    END IF
                END IF
            CASE "use potion"
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    XanathusAI
                END IF

                COLOR 5
                IF Inventory(ITEM_POTION).amount >= 1 THEN
                    PRINT "used potion"
                ELSE
                    PRINT "you are out of potions"
                END IF
                COLOR 15

                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    XanathusAI
                END IF
            CASE "call familiar"
                PRINT Familiar$; " arrives and takes your place."
                SLEEP 2
                PRINT "Xanathus casts a banishment!"
                PRINT "you're familiar falls to the ground!"
                FAMILIARHP% = 0
            CASE "use magic"
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF

                MAGIC
                IF XanathusHP% <= 0 THEN
                    PRINT "Xanathus falls to the wound."
                    ColorPrint 14, "Xanathus> How could this be?"
                    PRINT "Obtained gate key from Xanathus' body!"
                    Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                    XanathusDead% = 1
                    GOTO 4000
                ELSEIF COMBATSPEED% >= ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF
            CASE "spit"
                PRINT "You spit in Xanathus' face."
                PRINT "Xanathus wipes it off and laughs."
            CASE "help"
                HELP
            CASE "slash"
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF

                PRINT "You slashed Xanathus in the chest, he staggers back in pain"
                XanathusHP% = XanathusHP% - (DAMAGEADDED% + STR% + 2)
                IF XanathusHP% <= 0 THEN
                    PRINT "Xanathus falls to the wound."
                    ColorPrint 14, "Xanathus> How could this be?"
                    PRINT "Obtained gate key from Xanathus' body!"
                    Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                    XanathusDead% = 1
                    GOTO 4000
                ELSEIF COMBATSPEED% >= ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF
            CASE "thrust"
                IF COMBATSPEED% < ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF

                PRINT "You lunge forward and pierce Xanathus, he staggers back in pain."
                XanathusHP% = XanathusHP% - (STR% + 5 + DAMAGEADDED%)
                IF XanathusHP% <= 0 THEN
                    PRINT "Xanathus falls to the wound."
                    ColorPrint 14, "Xanathus> How could this be?"
                    PRINT "Obtained gate key from Xanathus' body!"
                    Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                    XanathusDead% = 1
                    GOTO 4000
                ELSEIF COMBATSPEED% >= ENEMYSPEED% THEN
                    XanathusAI
                    IF XanathusFleeTime% = 0 THEN
                        XanathusFlee
                        GOTO 4001
                    END IF
                END IF
            CASE "parry"
                PRINT "You attempt to parry Xanathus' blow."
                PC% = INT(RND * 100) + 1
                PARRYCHANCE% = PC% + ShieldSave%
                IF PARRYCHANCE% >= 50 THEN
                    PRINT "You were successful in parrying Xanathus' blow."
                ELSE
                    PRINT "You failed to parry Xanathus' blow.  You take 2 damage."
                    HPS% = HPS% - 2
                END IF
            CASE "punch"
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    PRINT "You aim your punch at the Xanathus' face."
                    StunChance% = INT(RND * 50) - STR%
                    IF StunChance% <= 25 THEN
                        StunTime% = INT(RND * 4) + 1
                        PRINT "Xanathus jumps back in surprise and is stunned for the next "; StunTime%; " turn(s)."
                    ELSE
                        PRINT "Xanathus ignores the punch."
                    END IF
                END IF

                PRINT "Xanathus is angered by your punch."
                XanathusAI
                IF XanathusFleeTime% = 0 THEN
                    XanathusFlee
                    GOTO 4001
                END IF
            CASE "kick"
                IF COMBATSPEED% >= ENEMYSPEED% THEN
                    PRINT "You aim your foot and strike Xanathus in the groin."
                    StunChance% = INT(RND * 50) - STR%
                    IF StunChance% <= 25 THEN
                        StunTime% = INT(RND * 4) + 1
                        PRINT "Xanathus stands there in pain and is stunned for the next "; StunTime%; " turn(s)."
                    ELSE
                        PRINT "Xanathus evades the kick."
                    END IF
                END IF
            CASE "dodge"
                PRINT "As Xanathus attacks, you attempt to dodge his attack."
                DC% = INT(RND * 100) + 1
                DODGECHANCE% = DC% - DEX%
                IF DODGECHANCE% >= 45 THEN
                    PRINT "You were successfully able to dodge Xanathus' attack."
                ELSE
                    PRINT "You were not successful at dodging the Xanathus' attack. You take 2 damage."
                    HPS% = HPS% - 1
                END IF
            CASE "coup de grace"
                IF XanathusHP% <= 3 THEN
                    PRINT "You grasp Xanathus' head, draw back and crush his skull."
                    PRINT "Xanathus falls to the wound."
                    ColorPrint 14, "Xanathus> How could this be?"
                    PRINT "Obtained gate key from Xanathus' body!"
                    Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                    XanathusDead% = 1
                    GOTO 4000
                END IF
            CASE "use owl spell"
                IF Owl% = 1 THEN
                    USEOWLSPELL
                    IF XanathusHP% <= 0 THEN
                        PRINT "Xanathus falls to the wound."
                        ColorPrint 14, "Xanathus> How could this be?"
                        PRINT "Obtained gate key from Xanathus' body!"
                        Inventory(QITEM_GATE_KEY).amount = Inventory(QITEM_GATE_KEY).amount + 1
                        XanathusDead% = 1
                        GOTO 4000
                    END IF
                ELSE
                    PRINT "You don't have an owl."
                END IF
            CASE "run"
                PRINT "You won't run from Xanathus!"
            CASE "judge enemy"
                CORRECTJUDGECHANCE% = INT(RND * 100) + 1
                IF CORRECTJUDGECHANCE% <= 35 THEN
                    PRINT "Xanathus' hitpoints appear to be "; XanathusHP%; "."
                ELSE
                    IF CORRECTJUDGECHANCE% >= 65 THEN
                        PRINT "Xanathus' hitpoints appear to be "; XanathusHP% + 10; "."
                    ELSE
                        PRINT "Xanathus' hit points appear to be "; XanathusHP% + 5; "."
                    END IF
                END IF
            CASE ELSE
                PRINT "Huh?"
        END SELECT
    LOOP WHILE TRUE

  4000
    RANDOMEXPR% = 500
    PRINT "And you have gained "; RANDOMEXPR%; " experience."
    EXPR% = EXPR% + RANDOMEXPR%
    EXPERIENCELVLUP

    IF Expertise% = CLASS_MAGE THEN
        RANDOMRUNEDROP
        PRINT "You have picked up this rune:"; RANDOMRUNE$
        RUNE$ = RUNE$ + RANDOMRUNE$
    END IF
    GOLDDROP% = 150
    PRINT "You picked up"; GOLDDROP%; "gold."
    Gold& = Gold& + GOLDDROP%

    IF Owl% = 1 THEN
        OWLSPELL
    END IF
    SLEEP 10
    STR% = STRO%
    DEX% = DEXO%
    ENG% = ENGO%
    VIT% = VITO%

  4001
    StunTime% = 0
    PlayerReflect% = 0
    ReturnWeapon
    Ethereal% = 0
    Undead% = 0
    Critical% = 0
END SUB

SUB XanathusFlee
    SELECT CASE INT(RND * 8)
        CASE 0 : XanathusArea$ = "NW"
        CASE 1 : XanathusArea$ = "N"
        CASE 2 : XanathusArea$ = "NE"
        CASE 3 : XanathusArea$ = "E"
        CASE 4 : XanathusArea$ = "SE"
        CASE 5 : XanathusArea$ = "S"
        CASE 6 : XanathusArea$ = "SW"
        CASE 7 : XanathusArea$ = "W"
    END SELECT
END SUB

SUB XanathusTaunt
    'Generates a random string for the Xanathus battle
    RNDSTRING% = INT(RND * 12)
    COLOR 14
    SELECT CASE RNDSTRING%
        CASE 1 : PRINT "Xanathus> ha! you can never defeat me."
        CASE 2 : PRINT "Xanathus> You know, i'll never tire from this running."
        CASE 3 : PRINT "Xanathus> Awake O Dead, for there can be no rest for ye beneath the earth."
        CASE 4 : PRINT "Xanathus> You'll never defeat me."
        CASE 5 : PRINT "Xanathus> Bah! the dwarves put up a better fight then you do."
        CASE 6 : PRINT "Xanathus> Once you are dead you shall make excellent warriors of undeath!"
    END SELECT
    COLOR 15
END SUB

SUB XanathusWorldFlee
    IF INT(RND * 40) <= 10 THEN
        PRINT "Xanathus is moving from the area he was in!"
        XanathusFlee
    END IF
END SUB

SUB ColorPrint (outputColor%, outputStr$)
    COLOR outputColor%
    PRINT outputStr$
    COLOR 15
END SUB

SUB InitGlobals
    FOR i = 0 TO UBOUND(Inventory)
        Inventory(i).value = 0
        Inventory(i).buyPrice = 0
        Inventory(i).sellPrice = 0
        Inventory(i).amount = 0
        Inventory(i).equipType = 0
    NEXT i
    'Item Names
    Inventory(QITEM_STRANGE_PENDANT).name = "Strange Pendant"
    Inventory(QITEM_BURNING_SPHERE).name = "Burning Sphere"
    Inventory(QITEM_GOLDEN_SKULL).name = "Golden Skull"
    Inventory(QITEM_JADE_SKULL).name = "Jade Skull"
    Inventory(QITEM_CHAOS_STAR).name = "Chaos Star"
    Inventory(QITEM_KEY1).name = "Key, type 1 (Key 1)"
    Inventory(QITEM_KEY2).name = "Key, type 2 (Key 2)"
    Inventory(QITEM_FAMILIAR_FLUTE).name = "Familiar flute"
    Inventory(QITEM_CHAOS_STAR).name = "Chaos star pendant"
    Inventory(QITEM_GATE_KEY).name = "Gate key"
    Inventory(QITEM_RUSTED_SWORD).name = "Rusted Sword"
    Inventory(ITEM_SHORT_SWORD).name = "Short Sword"
    Inventory(ITEM_LONG_SWORD).name = "Long Sword"
    Inventory(ITEM_BATTLE_BLADE).name = "Battle Blade"
    Inventory(ITEM_BASTARD_SWORD).name = "Bastard Sword"
    Inventory(ITEM_GREAT_SWORD).name = "Great Sword"
    Inventory(ITEM_GREAT_BATTLE_BLADE).name = "Great Battle Blade"
    Inventory(ITEM_HOLY_SWORD).name = "Holy Sword"
    Inventory(ITEM_SWORD_PLUS_ONE).name = "Sword +1"
    Inventory(ITEM_SWORD_PLUS_TWO).name = "Sword +2"
    Inventory(ITEM_SWORD_PLUS_THREE).name = "Sword +3"
    Inventory(ITEM_SWORD_PLUS_FOUR).name = "Sword +4"
    Inventory(ITEM_SWORD_PLUS_FIVE).name = "Sword +5"
    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).name = "Avenger Sword +7"
    Inventory(ITEM_BUCKLER).name = "Buckler"
    Inventory(ITEM_SMALL_SHIELD).name = "Small Shield"
    Inventory(ITEM_LARGE_SHIELD).name = "Large Shield"
    Inventory(ITEM_HOLY_SHIELD).name = "Holy Shield"
    Inventory(ITEM_SHIELD_PLUS_ONE).name = "Shield +1"
    Inventory(ITEM_SHIELD_PLUS_TWO).name = "Shield +2"
    Inventory(ITEM_SHIELD_PLUS_THREE).name = "Shield +3"
    Inventory(ITEM_SHIELD_PLUS_FOUR).name = "Shield +4"
    Inventory(ITEM_SHIELD_PLUS_FIVE).name = "Shield +5"
    Inventory(ITEM_RAGS).name = "Rags"
    Inventory(ITEM_SURCOAT).name = "Surcoat"
    Inventory(ITEM_ROBES_UPPER).name = "Robes (upper)"
    Inventory(ITEM_ROBES_LOWER).name = "Robes (lower)"
    Inventory(ITEM_QUILTED_ARMOUR).name = "Quilted Armour"
    Inventory(ITEM_LEATHER_ARMOUR).name = "Leather Armour"
    Inventory(ITEM_HARD_LEATHER_ARMOUR).name = "Hard Leather Armour"
    Inventory(ITEM_STUDDED_LEATHER).name = "Studded Leather Armour"
    Inventory(ITEM_RING_MAIL).name = "Ring Mail"
    Inventory(ITEM_CHAIN_MAIL).name = "Chain Mail"
    Inventory(ITEM_SCALE_MAIL).name = "Scale Mail"
    Inventory(ITEM_BANDED_MAIL).name = "Banded Mail"
    Inventory(ITEM_BREAST_PLATE).name = "Breast Plate"
    Inventory(ITEM_BANDED_PLATE_MAIL).name = "Banded Plate Mail"
    Inventory(ITEM_FIELD_PLATE_MAIL).name = "Field Plate Mail"
    Inventory(ITEM_FIELD_PLATE).name = "Field Plate"
    Inventory(ITEM_LIGHT_PLATE_MAIL).name = "Light Plate Mail"
    Inventory(ITEM_LIGHT_PLATE).name = "Light Plate"
    Inventory(ITEM_GOTHIC_PLATE_MAIL).name = "Gothic Plate Mail"
    Inventory(ITEM_SHORT_STAFF).name = "Short Staff"
    Inventory(ITEM_LONG_STAFF).name = "Long Staff"
    Inventory(ITEM_CAP).name = "Cap"
    Inventory(ITEM_SKULL_CAP).name = "Skull Cap"
    Inventory(ITEM_HELM).name = "Helm"
    Inventory(ITEM_FULL_HELM).name = "Full Helm"
    Inventory(ITEM_GREAT_HELM).name = "Great Helm"
    Inventory(ITEM_GREAT_HELM_HORNED).name = "Horned Great Helm"
    Inventory(ITEM_MYTHRIL_DWARVEN_HELM).name = "Mythril Dwarven Helm"
    Inventory(ITEM_POTION).name = "Potion"
    Inventory(RUNE_KEN).name = "ken"
    Inventory(RUNE_WAK).name = "wak"
    Inventory(RUNE_YOO).name = "yoo"
    Inventory(RUNE_TOG).name = "tog"
    Inventory(RUNE_WIR).name = "wir"
    Inventory(RUNE_GNU).name = "gnu"
    Inventory(RUNE_POA).name = "poa"
    Inventory(RUNE_RER).name = "rer"
    Inventory(RUNE_COZ).name = "coz"
    Inventory(RUNE_ARP).name = "arp"
    Inventory(RUNE_OJE).name = "oje"
    Inventory(RUNE_TIL).name = "til"
    Inventory(RUNE_ROC).name = "roc"
    Inventory(RUNE_WOD).name = "wod"
    Inventory(RUNE_SHO).name = "sho"
    Inventory(RUNE_VAS).name = "vas"
    Inventory(RUNE_DOP).name = "dop"
    Inventory(RUNE_ROF).name = "rof"
    Inventory(RUNE_POS).name = "pos"
    Inventory(RUNE_UCH).name = "uch"
    Inventory(RUNE_DIRE).name = "dir"
    Inventory(RUNE_FLA).name = "fla"
    Inventory(RUNE_PUD).name = "pud"
    Inventory(RUNE_CAL).name = "cal"
    Inventory(RUNE_DAS).name = "das"
    Inventory(RUNE_USS).name = "uss"
    'Item types
    Inventory(QITEM_STRANGE_PENDANT).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_BURNING_SPHERE).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_GOLDEN_SKULL).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_JADE_SKULL).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_CHAOS_STAR).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_KEY1).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_KEY2).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_FAMILIAR_FLUTE).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_CHAOS_STAR).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_GATE_KEY).itemType = ITEM_TYPE_QITEM
    Inventory(QITEM_RUSTED_SWORD).itemType = ITEM_TYPE_QITEM
    Inventory(ITEM_SHORT_SWORD).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_LONG_SWORD).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_BATTLE_BLADE).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_BASTARD_SWORD).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_GREAT_SWORD).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_GREAT_BATTLE_BLADE).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_HOLY_SWORD).itemType = ITEM_TYPE_SWORD
    Inventory(ITEM_SWORD_PLUS_ONE).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_SWORD_PLUS_TWO).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_SWORD_PLUS_THREE).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_SWORD_PLUS_FOUR).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_SWORD_PLUS_FIVE).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).itemType = ITEM_TYPE_SWORD_PLUS
    Inventory(ITEM_BUCKLER).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SMALL_SHIELD).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_LARGE_SHIELD).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_HOLY_SHIELD).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SHIELD_PLUS_ONE).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SHIELD_PLUS_TWO).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SHIELD_PLUS_THREE).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SHIELD_PLUS_FOUR).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_SHIELD_PLUS_FIVE).itemType = ITEM_TYPE_SHIELD
    Inventory(ITEM_RAGS).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_SURCOAT).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_ROBES_UPPER).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_ROBES_LOWER).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_QUILTED_ARMOUR).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_LEATHER_ARMOUR).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_HARD_LEATHER_ARMOUR).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_STUDDED_LEATHER).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_RING_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_CHAIN_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_SCALE_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_BANDED_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_BREAST_PLATE).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_BANDED_PLATE_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_FIELD_PLATE_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_FIELD_PLATE).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_LIGHT_PLATE_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_LIGHT_PLATE).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_GOTHIC_PLATE_MAIL).itemType = ITEM_TYPE_ARMOUR
    Inventory(ITEM_SHORT_STAFF).itemType = ITEM_TYPE_STAFF
    Inventory(ITEM_LONG_STAFF).itemType = ITEM_TYPE_STAFF
    Inventory(ITEM_CAP).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_SKULL_CAP).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_HELM).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_FULL_HELM).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_GREAT_HELM).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_GREAT_HELM_HORNED).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_MYTHRIL_DWARVEN_HELM).itemType = ITEM_TYPE_HELM
    Inventory(ITEM_POTION).itemType = ITEM_TYPE_POTION
    Inventory(RUNE_KEN).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_WAK).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_YOO).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_TOG).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_WIR).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_GNU).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_POA).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_RER).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_COZ).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_ARP).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_OJE).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_TIL).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_ROC).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_WOD).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_SHO).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_VAS).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_DOP).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_ROF).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_POS).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_UCH).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_DIRE).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_FLA).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_PUD).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_CAL).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_DAS).itemType = ITEM_TYPE_RUNE
    Inventory(RUNE_USS).itemType = ITEM_TYPE_RUNE
    'Equip types
    Inventory(ITEM_SHORT_SWORD).equipType = EQUIP_WEAPON
    Inventory(ITEM_LONG_SWORD).equipType = EQUIP_WEAPON
    Inventory(ITEM_BATTLE_BLADE).equipType = EQUIP_WEAPON
    Inventory(ITEM_BASTARD_SWORD).equipType = EQUIP_WEAPON
    Inventory(ITEM_GREAT_SWORD).equipType = EQUIP_WEAPON
    Inventory(ITEM_GREAT_BATTLE_BLADE).equipType = EQUIP_WEAPON
    Inventory(ITEM_HOLY_SWORD).equipType = EQUIP_WEAPON
    Inventory(ITEM_SWORD_PLUS_ONE).equipType = EQUIP_WEAPON
    Inventory(ITEM_SWORD_PLUS_TWO).equipType = EQUIP_WEAPON
    Inventory(ITEM_SWORD_PLUS_THREE).equipType = EQUIP_WEAPON
    Inventory(ITEM_SWORD_PLUS_FOUR).equipType = EQUIP_WEAPON
    Inventory(ITEM_SWORD_PLUS_FIVE).equipType = EQUIP_WEAPON
    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).equipType = EQUIP_WEAPON
    Inventory(ITEM_BUCKLER).equipType = EQUIP_SHIELD
    Inventory(ITEM_SMALL_SHIELD).equipType = EQUIP_SHIELD
    Inventory(ITEM_LARGE_SHIELD).equipType = EQUIP_SHIELD
    Inventory(ITEM_HOLY_SHIELD).equipType = EQUIP_SHIELD
    Inventory(ITEM_SHIELD_PLUS_ONE).equipType = EQUIP_SHIELD
    Inventory(ITEM_SHIELD_PLUS_TWO).equipType = EQUIP_SHIELD
    Inventory(ITEM_SHIELD_PLUS_THREE).equipType = EQUIP_SHIELD
    Inventory(ITEM_SHIELD_PLUS_FOUR).equipType = EQUIP_SHIELD
    Inventory(ITEM_SHIELD_PLUS_FIVE).equipType = EQUIP_SHIELD
    Inventory(ITEM_RAGS).equipType = EQUIP_ARMOUR
    Inventory(ITEM_SURCOAT).equipType = EQUIP_ARMOUR
    Inventory(ITEM_ROBES_UPPER).equipType = EQUIP_ARMOUR
    Inventory(ITEM_ROBES_LOWER).equipType = EQUIP_ARMOUR
    Inventory(ITEM_QUILTED_ARMOUR).equipType = EQUIP_ARMOUR
    Inventory(ITEM_LEATHER_ARMOUR).equipType = EQUIP_ARMOUR
    Inventory(ITEM_HARD_LEATHER_ARMOUR).equipType = EQUIP_ARMOUR
    Inventory(ITEM_STUDDED_LEATHER).equipType = EQUIP_ARMOUR
    Inventory(ITEM_RING_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_CHAIN_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_SCALE_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_BANDED_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_BREAST_PLATE).equipType = EQUIP_ARMOUR
    Inventory(ITEM_BANDED_PLATE_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_FIELD_PLATE_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_FIELD_PLATE).equipType = EQUIP_ARMOUR
    Inventory(ITEM_LIGHT_PLATE_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_LIGHT_PLATE).equipType = EQUIP_ARMOUR
    Inventory(ITEM_GOTHIC_PLATE_MAIL).equipType = EQUIP_ARMOUR
    Inventory(ITEM_SHORT_STAFF).equipType = EQUIP_WEAPON
    Inventory(ITEM_LONG_STAFF).equipType = EQUIP_WEAPON
    Inventory(ITEM_CAP).equipType = EQUIP_HELM
    Inventory(ITEM_SKULL_CAP).equipType = EQUIP_HELM
    Inventory(ITEM_HELM).equipType = EQUIP_HELM
    Inventory(ITEM_FULL_HELM).equipType = EQUIP_HELM
    Inventory(ITEM_GREAT_HELM).equipType = EQUIP_HELM
    Inventory(ITEM_GREAT_HELM_HORNED).equipType = EQUIP_HELM
    Inventory(ITEM_MYTHRIL_DWARVEN_HELM).equipType = EQUIP_HELM
    'Item values
    Inventory(ITEM_RAGS).value = 1
    Inventory(ITEM_ROBES_UPPER).value = .5
    Inventory(ITEM_ROBES_LOWER).value = .5
    Inventory(ITEM_SURCOAT).value = 1
    Inventory(ITEM_QUILTED_ARMOUR).value = 2
    Inventory(ITEM_LEATHER_ARMOUR).value = 3
    Inventory(ITEM_HARD_LEATHER_ARMOUR).value = 4
    Inventory(ITEM_STUDDED_LEATHER).value = 5
    Inventory(ITEM_CAP).value = 1
    Inventory(ITEM_SKULL_CAP).value = 2
    Inventory(ITEM_HELM).value = 3
    Inventory(ITEM_FULL_HELM).value = 4
    Inventory(ITEM_GREAT_HELM).value = 5
    Inventory(ITEM_GREAT_HELM_HORNED).value = 6
    Inventory(ITEM_MYTHRIL_DWARVEN_HELM).value = 10
    Inventory(ITEM_SHORT_SWORD).value = 1
    Inventory(ITEM_LONG_SWORD).value = 2
    Inventory(ITEM_BASTARD_SWORD).value = 3
    Inventory(ITEM_BATTLE_BLADE).value = 4
    Inventory(ITEM_GREAT_SWORD).value = 5
    Inventory(ITEM_GREAT_BATTLE_BLADE).value = 6
    Inventory(ITEM_HOLY_SWORD).value = 7
    Inventory(ITEM_SWORD_PLUS_ONE).value = 8
    Inventory(ITEM_SWORD_PLUS_TWO).value = 9
    Inventory(ITEM_SWORD_PLUS_THREE).value = 10
    Inventory(ITEM_SWORD_PLUS_FOUR).value = 11
    Inventory(ITEM_SWORD_PLUS_FIVE).value = 12
    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).value = 15
    Inventory(ITEM_SHORT_STAFF).value = 2
    Inventory(ITEM_LONG_STAFF).value = 4
    Inventory(ITEM_BUCKLER).value = 1
    Inventory(ITEM_SMALL_SHIELD).value = 2
    Inventory(ITEM_LARGE_SHIELD).value = 3
    Inventory(ITEM_HOLY_SHIELD).value = 4
    Inventory(ITEM_SHIELD_PLUS_ONE).value = 5
    Inventory(ITEM_SHIELD_PLUS_TWO).value = 6
    Inventory(ITEM_SHIELD_PLUS_THREE).value = 7
    Inventory(ITEM_SHIELD_PLUS_FOUR).value = 8
    Inventory(ITEM_SHIELD_PLUS_FIVE).value = 9
    'Item buying prices
    Inventory(ITEM_POTION).buyPrice = 10
    Inventory(ITEM_SHORT_SWORD).buyPrice = 10
    Inventory(ITEM_LONG_SWORD).buyPrice = 25
    Inventory(ITEM_BASTARD_SWORD).buyPrice = 45
    Inventory(ITEM_BUCKLER).buyPrice = 15
    Inventory(ITEM_SMALL_SHIELD).buyPrice = 25
    Inventory(ITEM_LARGE_SHIELD).buyPrice = 40
    Inventory(ITEM_LEATHER_ARMOUR).buyPrice = 50
    Inventory(ITEM_HARD_LEATHER_ARMOUR).buyPrice = 65
    Inventory(ITEM_SWORD_PLUS_ONE).buyPrice = 100
    Inventory(ITEM_SHORT_STAFF).buyPrice = 25
    Inventory(ITEM_LONG_STAFF).buyPrice = 50
    Inventory(ITEM_CAP).buyPrice = 5
    Inventory(ITEM_SKULL_CAP).buyPrice = 10
    Inventory(ITEM_HELM).buyPrice = 15
    'Item selling prices
    Inventory(ITEM_POTION).sellPrice = 5
    Inventory(ITEM_SHORT_SWORD).sellPrice = 5
    Inventory(ITEM_LONG_SWORD).sellPrice = 15
    Inventory(ITEM_BASTARD_SWORD).sellPrice = 22
    Inventory(ITEM_LEATHER_ARMOUR).sellPrice = 25
    Inventory(ITEM_HARD_LEATHER_ARMOUR).sellPrice = 32
    Inventory(ITEM_SHORT_STAFF).sellPrice = 12
    Inventory(ITEM_LONG).sellPrice = 25
    Inventory(ITEM_CAP).sellPrice = 2
    Inventory(ITEM_SKULL_CAP).sellPrice = 7
    Inventory(ITEM_HELM).sellPrice = 10
    Inventory(ITEM_SWORD_PLUS_ONE).sellPrice = 50
    Inventory(ITEM_SWORD_PLUS_TWO).sellPrice = 100
    Inventory(ITEM_AVENGER_SWORD_PLUS_SEVEN).sellPrice = 1000
    Inventory(ITEM_BUCKLER).sellPrice = 7
    Inventory(ITEM_SMALL_SHIELD).sellPrice = 12
    Inventory(ITEM_LARGE_SHIELD).sellPrice = 20

    FOR i = 0 TO UBOUND(OwlSpells)
        OwlSpells(i).hasIt = FALSE
        OwlSpells(i).dmg = 0
        OwlSpells(i).heal = 0
        OwlSpells(i).special = 0
    NEXT i
    OwlSpells(0).name = "Fireball"
    OwlSpells(0).dmg = 5
    OwlSpells(1).name = "Lightning Bolt"
    OwlSpells(1).dmg = 6
    OwlSpells(2).name = "Healing"
    OwlSpells(2).heal = -5
    OwlSpells(3).name = "Eldritch Storm"
    OwlSpells(3).dmg = 10
    OwlSpells(4).name = "Fire Blast"
    OwlSpells(4).dmg = 7
    OwlSpells(5).name = "Cure"
    OwlSpells(5).heal = 10
    OwlSpells(6).name = "Augment"
    OwlSpells(6).special = 1
    OwlSpells(7).name = "Fortune"
    OwlSpells(7).special = 2
    OwlSpells(8).name = "Predict"
    OwlSpells(8).special = 3
    OwlSpells(9).name = "Reflect"
    OwlSpells(9).special = 4
    OwlSpells(10).name = "Cura"
    OwlSpells(10).heal = 15
    OwlSpells(11).name = "Fira"
    OwlSpells(11).dmg = 15
END SUB
