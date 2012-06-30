-- parser produced by Happy Version 1.10

module MiniJava (parse) where

import Misc
import Syntax
import Lexer

data HappyAbsSyn 
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 (Program)
	| HappyAbsSyn5 ([ClassDecl])
	| HappyAbsSyn6 (MainClass)
	| HappyAbsSyn7 (ClassDecl)
	| HappyAbsSyn8 (Maybe Id)
	| HappyAbsSyn9 ([VarDecl])
	| HappyAbsSyn10 ([MethodDecl])
	| HappyAbsSyn11 (VarDecl)
	| HappyAbsSyn12 (MethodDecl)
	| HappyAbsSyn15 (Type)
	| HappyAbsSyn16 (Statement)
	| HappyAbsSyn17 ([Statement])
	| HappyAbsSyn18 ([Exp])
	| HappyAbsSyn20 (Exp)

type HappyReduction = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> OkF(HappyAbsSyn))
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> OkF(HappyAbsSyn))] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> OkF(HappyAbsSyn)

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142 :: Int -> HappyReduction

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54 :: HappyReduction

action_0 (27) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (6) = happyGoto action_2
action_0 _ = happyFail

action_1 (27) = happyShift action_3
action_1 (6) = happyGoto action_2
action_1 _ = happyFail

action_2 (27) = happyShift action_8
action_2 (5) = happyGoto action_6
action_2 (7) = happyGoto action_7
action_2 _ = happyReduce_2

action_3 (26) = happyShift action_5
action_3 _ = happyFail

action_4 (62) = happyAccept
action_4 _ = happyFail

action_5 (60) = happyShift action_11
action_5 _ = happyFail

action_6 _ = happyReduce_1

action_7 (27) = happyShift action_8
action_7 (5) = happyGoto action_10
action_7 (7) = happyGoto action_7
action_7 _ = happyReduce_2

action_8 (26) = happyShift action_9
action_8 _ = happyFail

action_9 (33) = happyShift action_14
action_9 (8) = happyGoto action_13
action_9 _ = happyReduce_6

action_10 _ = happyReduce_3

action_11 (28) = happyShift action_12
action_11 _ = happyFail

action_12 (29) = happyShift action_17
action_12 _ = happyFail

action_13 (60) = happyShift action_16
action_13 _ = happyFail

action_14 (26) = happyShift action_15
action_14 _ = happyFail

action_15 _ = happyReduce_7

action_16 (9) = happyGoto action_19
action_16 _ = happyReduce_9

action_17 (30) = happyShift action_18
action_17 _ = happyFail

action_18 (31) = happyShift action_28
action_18 _ = happyFail

action_19 (26) = happyShift action_24
action_19 (28) = happyShift action_25
action_19 (37) = happyShift action_26
action_19 (38) = happyShift action_27
action_19 (10) = happyGoto action_20
action_19 (11) = happyGoto action_21
action_19 (12) = happyGoto action_22
action_19 (15) = happyGoto action_23
action_19 _ = happyReduce_10

action_20 (61) = happyShift action_34
action_20 _ = happyFail

action_21 _ = happyReduce_8

action_22 (28) = happyShift action_25
action_22 (10) = happyGoto action_33
action_22 (12) = happyGoto action_22
action_22 _ = happyReduce_10

action_23 (26) = happyShift action_32
action_23 _ = happyFail

action_24 _ = happyReduce_21

action_25 (26) = happyShift action_24
action_25 (37) = happyShift action_26
action_25 (38) = happyShift action_27
action_25 (15) = happyGoto action_31
action_25 _ = happyFail

action_26 (58) = happyShift action_30
action_26 _ = happyReduce_20

action_27 _ = happyReduce_19

action_28 (56) = happyShift action_29
action_28 _ = happyFail

action_29 (32) = happyShift action_38
action_29 _ = happyFail

action_30 (59) = happyShift action_37
action_30 _ = happyFail

action_31 (26) = happyShift action_36
action_31 _ = happyFail

action_32 (48) = happyShift action_35
action_32 _ = happyFail

action_33 _ = happyReduce_11

action_34 _ = happyReduce_5

action_35 _ = happyReduce_12

action_36 (56) = happyShift action_40
action_36 _ = happyFail

action_37 _ = happyReduce_18

action_38 (58) = happyShift action_39
action_38 _ = happyFail

action_39 (59) = happyShift action_43
action_39 _ = happyFail

action_40 (26) = happyShift action_24
action_40 (37) = happyShift action_26
action_40 (38) = happyShift action_27
action_40 (13) = happyGoto action_41
action_40 (15) = happyGoto action_42
action_40 _ = happyReduce_15

action_41 (57) = happyShift action_46
action_41 _ = happyFail

action_42 (26) = happyShift action_45
action_42 _ = happyFail

action_43 (26) = happyShift action_44
action_43 _ = happyFail

action_44 (57) = happyShift action_50
action_44 _ = happyFail

action_45 (49) = happyShift action_49
action_45 (14) = happyGoto action_48
action_45 _ = happyReduce_17

action_46 (60) = happyShift action_47
action_46 _ = happyFail

action_47 (9) = happyGoto action_53
action_47 _ = happyReduce_9

action_48 _ = happyReduce_14

action_49 (26) = happyShift action_24
action_49 (37) = happyShift action_26
action_49 (38) = happyShift action_27
action_49 (15) = happyGoto action_52
action_49 _ = happyFail

action_50 (60) = happyShift action_51
action_50 _ = happyFail

action_51 (26) = happyShift action_63
action_51 (35) = happyShift action_57
action_51 (39) = happyShift action_58
action_51 (45) = happyShift action_59
action_51 (60) = happyShift action_60
action_51 (16) = happyGoto action_62
action_51 _ = happyFail

action_52 (26) = happyShift action_61
action_52 _ = happyFail

action_53 (26) = happyShift action_56
action_53 (35) = happyShift action_57
action_53 (37) = happyShift action_26
action_53 (38) = happyShift action_27
action_53 (39) = happyShift action_58
action_53 (45) = happyShift action_59
action_53 (60) = happyShift action_60
action_53 (11) = happyGoto action_21
action_53 (15) = happyGoto action_23
action_53 (16) = happyGoto action_54
action_53 (17) = happyGoto action_55
action_53 _ = happyReduce_29

action_54 (26) = happyShift action_63
action_54 (35) = happyShift action_57
action_54 (39) = happyShift action_58
action_54 (45) = happyShift action_59
action_54 (60) = happyShift action_60
action_54 (16) = happyGoto action_54
action_54 (17) = happyGoto action_73
action_54 _ = happyReduce_29

action_55 (34) = happyShift action_72
action_55 _ = happyFail

action_56 (47) = happyShift action_64
action_56 (58) = happyShift action_65
action_56 _ = happyReduce_21

action_57 (56) = happyShift action_71
action_57 _ = happyFail

action_58 (56) = happyShift action_70
action_58 _ = happyFail

action_59 (56) = happyShift action_69
action_59 _ = happyFail

action_60 (26) = happyShift action_63
action_60 (35) = happyShift action_57
action_60 (39) = happyShift action_58
action_60 (45) = happyShift action_59
action_60 (60) = happyShift action_60
action_60 (16) = happyGoto action_54
action_60 (17) = happyGoto action_68
action_60 _ = happyReduce_29

action_61 (49) = happyShift action_49
action_61 (14) = happyGoto action_67
action_61 _ = happyReduce_17

action_62 (61) = happyShift action_66
action_62 _ = happyFail

action_63 (47) = happyShift action_64
action_63 (58) = happyShift action_65
action_63 _ = happyFail

action_64 (25) = happyShift action_79
action_64 (26) = happyShift action_80
action_64 (41) = happyShift action_81
action_64 (42) = happyShift action_82
action_64 (43) = happyShift action_83
action_64 (44) = happyShift action_84
action_64 (50) = happyShift action_85
action_64 (56) = happyShift action_86
action_64 (20) = happyGoto action_93
action_64 (21) = happyGoto action_75
action_64 (22) = happyGoto action_76
action_64 (23) = happyGoto action_77
action_64 (24) = happyGoto action_78
action_64 _ = happyFail

action_65 (25) = happyShift action_79
action_65 (26) = happyShift action_80
action_65 (41) = happyShift action_81
action_65 (42) = happyShift action_82
action_65 (43) = happyShift action_83
action_65 (44) = happyShift action_84
action_65 (50) = happyShift action_85
action_65 (56) = happyShift action_86
action_65 (20) = happyGoto action_92
action_65 (21) = happyGoto action_75
action_65 (22) = happyGoto action_76
action_65 (23) = happyGoto action_77
action_65 (24) = happyGoto action_78
action_65 _ = happyFail

action_66 (61) = happyShift action_91
action_66 _ = happyFail

action_67 _ = happyReduce_16

action_68 (61) = happyShift action_90
action_68 _ = happyFail

action_69 (25) = happyShift action_79
action_69 (26) = happyShift action_80
action_69 (41) = happyShift action_81
action_69 (42) = happyShift action_82
action_69 (43) = happyShift action_83
action_69 (44) = happyShift action_84
action_69 (50) = happyShift action_85
action_69 (56) = happyShift action_86
action_69 (20) = happyGoto action_89
action_69 (21) = happyGoto action_75
action_69 (22) = happyGoto action_76
action_69 (23) = happyGoto action_77
action_69 (24) = happyGoto action_78
action_69 _ = happyFail

action_70 (25) = happyShift action_79
action_70 (26) = happyShift action_80
action_70 (41) = happyShift action_81
action_70 (42) = happyShift action_82
action_70 (43) = happyShift action_83
action_70 (44) = happyShift action_84
action_70 (50) = happyShift action_85
action_70 (56) = happyShift action_86
action_70 (20) = happyGoto action_88
action_70 (21) = happyGoto action_75
action_70 (22) = happyGoto action_76
action_70 (23) = happyGoto action_77
action_70 (24) = happyGoto action_78
action_70 _ = happyFail

action_71 (25) = happyShift action_79
action_71 (26) = happyShift action_80
action_71 (41) = happyShift action_81
action_71 (42) = happyShift action_82
action_71 (43) = happyShift action_83
action_71 (44) = happyShift action_84
action_71 (50) = happyShift action_85
action_71 (56) = happyShift action_86
action_71 (20) = happyGoto action_87
action_71 (21) = happyGoto action_75
action_71 (22) = happyGoto action_76
action_71 (23) = happyGoto action_77
action_71 (24) = happyGoto action_78
action_71 _ = happyFail

action_72 (25) = happyShift action_79
action_72 (26) = happyShift action_80
action_72 (41) = happyShift action_81
action_72 (42) = happyShift action_82
action_72 (43) = happyShift action_83
action_72 (44) = happyShift action_84
action_72 (50) = happyShift action_85
action_72 (56) = happyShift action_86
action_72 (20) = happyGoto action_74
action_72 (21) = happyGoto action_75
action_72 (22) = happyGoto action_76
action_72 (23) = happyGoto action_77
action_72 (24) = happyGoto action_78
action_72 _ = happyFail

action_73 _ = happyReduce_28

action_74 (48) = happyShift action_110
action_74 (51) = happyShift action_95
action_74 (52) = happyShift action_96
action_74 (53) = happyShift action_97
action_74 (54) = happyShift action_98
action_74 (55) = happyShift action_99
action_74 _ = happyFail

action_75 _ = happyReduce_34

action_76 (46) = happyShift action_109
action_76 _ = happyReduce_40

action_77 _ = happyReduce_43

action_78 (58) = happyShift action_108
action_78 _ = happyReduce_42

action_79 _ = happyReduce_45

action_80 _ = happyReduce_46

action_81 _ = happyReduce_47

action_82 _ = happyReduce_48

action_83 _ = happyReduce_49

action_84 (26) = happyShift action_106
action_84 (37) = happyShift action_107
action_84 _ = happyFail

action_85 (25) = happyShift action_79
action_85 (26) = happyShift action_80
action_85 (41) = happyShift action_81
action_85 (42) = happyShift action_82
action_85 (43) = happyShift action_83
action_85 (44) = happyShift action_84
action_85 (50) = happyShift action_85
action_85 (56) = happyShift action_86
action_85 (21) = happyGoto action_105
action_85 (22) = happyGoto action_76
action_85 (23) = happyGoto action_77
action_85 (24) = happyGoto action_78
action_85 _ = happyFail

action_86 (25) = happyShift action_79
action_86 (26) = happyShift action_80
action_86 (41) = happyShift action_81
action_86 (42) = happyShift action_82
action_86 (43) = happyShift action_83
action_86 (44) = happyShift action_84
action_86 (50) = happyShift action_85
action_86 (56) = happyShift action_86
action_86 (20) = happyGoto action_104
action_86 (21) = happyGoto action_75
action_86 (22) = happyGoto action_76
action_86 (23) = happyGoto action_77
action_86 (24) = happyGoto action_78
action_86 _ = happyFail

action_87 (51) = happyShift action_95
action_87 (52) = happyShift action_96
action_87 (53) = happyShift action_97
action_87 (54) = happyShift action_98
action_87 (55) = happyShift action_99
action_87 (57) = happyShift action_103
action_87 _ = happyFail

action_88 (51) = happyShift action_95
action_88 (52) = happyShift action_96
action_88 (53) = happyShift action_97
action_88 (54) = happyShift action_98
action_88 (55) = happyShift action_99
action_88 (57) = happyShift action_102
action_88 _ = happyFail

action_89 (51) = happyShift action_95
action_89 (52) = happyShift action_96
action_89 (53) = happyShift action_97
action_89 (54) = happyShift action_98
action_89 (55) = happyShift action_99
action_89 (57) = happyShift action_101
action_89 _ = happyFail

action_90 _ = happyReduce_22

action_91 _ = happyReduce_4

action_92 (51) = happyShift action_95
action_92 (52) = happyShift action_96
action_92 (53) = happyShift action_97
action_92 (54) = happyShift action_98
action_92 (55) = happyShift action_99
action_92 (59) = happyShift action_100
action_92 _ = happyFail

action_93 (48) = happyShift action_94
action_93 (51) = happyShift action_95
action_93 (52) = happyShift action_96
action_93 (53) = happyShift action_97
action_93 (54) = happyShift action_98
action_93 (55) = happyShift action_99
action_93 _ = happyFail

action_94 _ = happyReduce_26

action_95 (25) = happyShift action_79
action_95 (26) = happyShift action_80
action_95 (41) = happyShift action_81
action_95 (42) = happyShift action_82
action_95 (43) = happyShift action_83
action_95 (44) = happyShift action_84
action_95 (50) = happyShift action_85
action_95 (56) = happyShift action_86
action_95 (20) = happyGoto action_126
action_95 (21) = happyGoto action_75
action_95 (22) = happyGoto action_76
action_95 (23) = happyGoto action_77
action_95 (24) = happyGoto action_78
action_95 _ = happyFail

action_96 (25) = happyShift action_79
action_96 (26) = happyShift action_80
action_96 (41) = happyShift action_81
action_96 (42) = happyShift action_82
action_96 (43) = happyShift action_83
action_96 (44) = happyShift action_84
action_96 (50) = happyShift action_85
action_96 (56) = happyShift action_86
action_96 (20) = happyGoto action_125
action_96 (21) = happyGoto action_75
action_96 (22) = happyGoto action_76
action_96 (23) = happyGoto action_77
action_96 (24) = happyGoto action_78
action_96 _ = happyFail

action_97 (25) = happyShift action_79
action_97 (26) = happyShift action_80
action_97 (41) = happyShift action_81
action_97 (42) = happyShift action_82
action_97 (43) = happyShift action_83
action_97 (44) = happyShift action_84
action_97 (50) = happyShift action_85
action_97 (56) = happyShift action_86
action_97 (20) = happyGoto action_124
action_97 (21) = happyGoto action_75
action_97 (22) = happyGoto action_76
action_97 (23) = happyGoto action_77
action_97 (24) = happyGoto action_78
action_97 _ = happyFail

action_98 (25) = happyShift action_79
action_98 (26) = happyShift action_80
action_98 (41) = happyShift action_81
action_98 (42) = happyShift action_82
action_98 (43) = happyShift action_83
action_98 (44) = happyShift action_84
action_98 (50) = happyShift action_85
action_98 (56) = happyShift action_86
action_98 (20) = happyGoto action_123
action_98 (21) = happyGoto action_75
action_98 (22) = happyGoto action_76
action_98 (23) = happyGoto action_77
action_98 (24) = happyGoto action_78
action_98 _ = happyFail

action_99 (25) = happyShift action_79
action_99 (26) = happyShift action_80
action_99 (41) = happyShift action_81
action_99 (42) = happyShift action_82
action_99 (43) = happyShift action_83
action_99 (44) = happyShift action_84
action_99 (50) = happyShift action_85
action_99 (56) = happyShift action_86
action_99 (20) = happyGoto action_122
action_99 (21) = happyGoto action_75
action_99 (22) = happyGoto action_76
action_99 (23) = happyGoto action_77
action_99 (24) = happyGoto action_78
action_99 _ = happyFail

action_100 (47) = happyShift action_121
action_100 _ = happyFail

action_101 (48) = happyShift action_120
action_101 _ = happyFail

action_102 (26) = happyShift action_63
action_102 (35) = happyShift action_57
action_102 (39) = happyShift action_58
action_102 (45) = happyShift action_59
action_102 (60) = happyShift action_60
action_102 (16) = happyGoto action_119
action_102 _ = happyFail

action_103 (26) = happyShift action_63
action_103 (35) = happyShift action_57
action_103 (39) = happyShift action_58
action_103 (45) = happyShift action_59
action_103 (60) = happyShift action_60
action_103 (16) = happyGoto action_118
action_103 _ = happyFail

action_104 (51) = happyShift action_95
action_104 (52) = happyShift action_96
action_104 (53) = happyShift action_97
action_104 (54) = happyShift action_98
action_104 (55) = happyShift action_99
action_104 (57) = happyShift action_117
action_104 _ = happyFail

action_105 _ = happyReduce_41

action_106 (56) = happyShift action_116
action_106 _ = happyFail

action_107 (58) = happyShift action_115
action_107 _ = happyFail

action_108 (25) = happyShift action_79
action_108 (26) = happyShift action_80
action_108 (41) = happyShift action_81
action_108 (42) = happyShift action_82
action_108 (43) = happyShift action_83
action_108 (44) = happyShift action_84
action_108 (50) = happyShift action_85
action_108 (56) = happyShift action_86
action_108 (20) = happyGoto action_114
action_108 (21) = happyGoto action_75
action_108 (22) = happyGoto action_76
action_108 (23) = happyGoto action_77
action_108 (24) = happyGoto action_78
action_108 _ = happyFail

action_109 (26) = happyShift action_112
action_109 (40) = happyShift action_113
action_109 _ = happyFail

action_110 (61) = happyShift action_111
action_110 _ = happyFail

action_111 _ = happyReduce_13

action_112 (56) = happyShift action_132
action_112 _ = happyFail

action_113 _ = happyReduce_51

action_114 (51) = happyShift action_95
action_114 (52) = happyShift action_96
action_114 (53) = happyShift action_97
action_114 (54) = happyShift action_98
action_114 (55) = happyShift action_99
action_114 (59) = happyShift action_131
action_114 _ = happyFail

action_115 (25) = happyShift action_79
action_115 (26) = happyShift action_80
action_115 (41) = happyShift action_81
action_115 (42) = happyShift action_82
action_115 (43) = happyShift action_83
action_115 (44) = happyShift action_84
action_115 (50) = happyShift action_85
action_115 (56) = happyShift action_86
action_115 (20) = happyGoto action_130
action_115 (21) = happyGoto action_75
action_115 (22) = happyGoto action_76
action_115 (23) = happyGoto action_77
action_115 (24) = happyGoto action_78
action_115 _ = happyFail

action_116 (57) = happyShift action_129
action_116 _ = happyFail

action_117 _ = happyReduce_54

action_118 (36) = happyShift action_128
action_118 _ = happyFail

action_119 _ = happyReduce_24

action_120 _ = happyReduce_25

action_121 (25) = happyShift action_79
action_121 (26) = happyShift action_80
action_121 (41) = happyShift action_81
action_121 (42) = happyShift action_82
action_121 (43) = happyShift action_83
action_121 (44) = happyShift action_84
action_121 (50) = happyShift action_85
action_121 (56) = happyShift action_86
action_121 (20) = happyGoto action_127
action_121 (21) = happyGoto action_75
action_121 (22) = happyGoto action_76
action_121 (23) = happyGoto action_77
action_121 (24) = happyGoto action_78
action_121 _ = happyFail

action_122 _ = happyReduce_39

action_123 (55) = happyShift action_99
action_123 _ = happyReduce_38

action_124 (55) = happyShift action_99
action_124 _ = happyReduce_37

action_125 (53) = happyShift action_97
action_125 (54) = happyShift action_98
action_125 (55) = happyShift action_99
action_125 _ = happyReduce_36

action_126 (52) = happyShift action_96
action_126 (53) = happyShift action_97
action_126 (54) = happyShift action_98
action_126 (55) = happyShift action_99
action_126 _ = happyReduce_35

action_127 (48) = happyShift action_137
action_127 (51) = happyShift action_95
action_127 (52) = happyShift action_96
action_127 (53) = happyShift action_97
action_127 (54) = happyShift action_98
action_127 (55) = happyShift action_99
action_127 _ = happyFail

action_128 (26) = happyShift action_63
action_128 (35) = happyShift action_57
action_128 (39) = happyShift action_58
action_128 (45) = happyShift action_59
action_128 (60) = happyShift action_60
action_128 (16) = happyGoto action_136
action_128 _ = happyFail

action_129 _ = happyReduce_53

action_130 (51) = happyShift action_95
action_130 (52) = happyShift action_96
action_130 (53) = happyShift action_97
action_130 (54) = happyShift action_98
action_130 (55) = happyShift action_99
action_130 (59) = happyShift action_135
action_130 _ = happyFail

action_131 _ = happyReduce_52

action_132 (25) = happyShift action_79
action_132 (26) = happyShift action_80
action_132 (41) = happyShift action_81
action_132 (42) = happyShift action_82
action_132 (43) = happyShift action_83
action_132 (44) = happyShift action_84
action_132 (50) = happyShift action_85
action_132 (56) = happyShift action_86
action_132 (18) = happyGoto action_133
action_132 (20) = happyGoto action_134
action_132 (21) = happyGoto action_75
action_132 (22) = happyGoto action_76
action_132 (23) = happyGoto action_77
action_132 (24) = happyGoto action_78
action_132 _ = happyReduce_30

action_133 (57) = happyShift action_140
action_133 _ = happyFail

action_134 (49) = happyShift action_139
action_134 (51) = happyShift action_95
action_134 (52) = happyShift action_96
action_134 (53) = happyShift action_97
action_134 (54) = happyShift action_98
action_134 (55) = happyShift action_99
action_134 (19) = happyGoto action_138
action_134 _ = happyReduce_32

action_135 _ = happyReduce_44

action_136 _ = happyReduce_23

action_137 _ = happyReduce_27

action_138 _ = happyReduce_31

action_139 (25) = happyShift action_79
action_139 (26) = happyShift action_80
action_139 (41) = happyShift action_81
action_139 (42) = happyShift action_82
action_139 (43) = happyShift action_83
action_139 (44) = happyShift action_84
action_139 (50) = happyShift action_85
action_139 (56) = happyShift action_86
action_139 (20) = happyGoto action_141
action_139 (21) = happyGoto action_75
action_139 (22) = happyGoto action_76
action_139 (23) = happyGoto action_77
action_139 (24) = happyGoto action_78
action_139 _ = happyFail

action_140 _ = happyReduce_50

action_141 (49) = happyShift action_139
action_141 (51) = happyShift action_95
action_141 (52) = happyShift action_96
action_141 (53) = happyShift action_97
action_141 (54) = happyShift action_98
action_141 (55) = happyShift action_99
action_141 (19) = happyGoto action_142
action_141 _ = happyReduce_32

action_142 _ = happyReduce_33

happyReduce_1 = happySpecReduce_2 4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn4
		 (Program happy_var_1 happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_0 5 happyReduction_2
happyReduction_2  =  HappyAbsSyn5
		 ([]
	)

happyReduce_3 = happySpecReduce_2 5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happyReduce 17 6 happyReduction_4
happyReduction_4 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_15) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_12)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (MainClass happy_var_2 happy_var_12 happy_var_15
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 7 7 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_6) `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ClassDecl happy_var_2 happy_var_3 happy_var_5 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_0 8 happyReduction_6
happyReduction_6  =  HappyAbsSyn8
		 (Nothing
	)

happyReduce_7 = happySpecReduce_2 8 happyReduction_7
happyReduction_7 (HappyTerminal (TokenId happy_var_2))
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2 9 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0 9 happyReduction_9
happyReduction_9  =  HappyAbsSyn9
		 ([]
	)

happyReduce_10 = happySpecReduce_0 10 happyReduction_10
happyReduction_10  =  HappyAbsSyn10
		 ([]
	)

happyReduce_11 = happySpecReduce_2 10 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3 11 happyReduction_12
happyReduction_12 _
	(HappyTerminal (TokenId happy_var_2))
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 (VarDecl happy_var_1 happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 13 12 happyReduction_13
happyReduction_13 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_11) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_9) `HappyStk`
	(HappyAbsSyn9  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (MethodDecl happy_var_2 happy_var_3 happy_var_5 happy_var_8 happy_var_9 happy_var_11
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_3 13 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_3)
	(HappyTerminal (TokenId happy_var_2))
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn9
		 (VarDecl happy_var_1 happy_var_2 : happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_0 13 happyReduction_15
happyReduction_15  =  HappyAbsSyn9
		 ([]
	)

happyReduce_16 = happyReduce 4 14 happyReduction_16
happyReduction_16 ((HappyAbsSyn9  happy_var_4) `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (VarDecl happy_var_2 happy_var_3 : happy_var_4
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_0 14 happyReduction_17
happyReduction_17  =  HappyAbsSyn9
		 ([]
	)

happyReduce_18 = happySpecReduce_3 15 happyReduction_18
happyReduction_18 _
	_
	_
	 =  HappyAbsSyn15
		 (T_IntArray
	)

happyReduce_19 = happySpecReduce_1 15 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn15
		 (T_Boolean
	)

happyReduce_20 = happySpecReduce_1 15 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn15
		 (T_Int
	)

happyReduce_21 = happySpecReduce_1 15 happyReduction_21
happyReduction_21 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn15
		 (T_Id happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3 16 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (S_Block happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 7 16 happyReduction_23
happyReduction_23 ((HappyAbsSyn16  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (S_If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 5 16 happyReduction_24
happyReduction_24 ((HappyAbsSyn16  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (S_While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 5 16 happyReduction_25
happyReduction_25 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (S_Print happy_var_3
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 4 16 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (S_Assign happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 7 16 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (S_ArrayAssign happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_2 17 happyReduction_28
happyReduction_28 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 : happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_0 17 happyReduction_29
happyReduction_29  =  HappyAbsSyn17
		 ([]
	)

happyReduce_30 = happySpecReduce_0 18 happyReduction_30
happyReduction_30  =  HappyAbsSyn18
		 ([]
	)

happyReduce_31 = happySpecReduce_2 18 happyReduction_31
happyReduction_31 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 : happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_0 19 happyReduction_32
happyReduction_32  =  HappyAbsSyn18
		 ([]
	)

happyReduce_33 = happySpecReduce_3 19 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2 : happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1 20 happyReduction_34
happyReduction_34 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3 20 happyReduction_35
happyReduction_35 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (B_Op BoolAnd  happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3 20 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (B_Op LessThan happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3 20 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (B_Op Add      happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3 20 happyReduction_38
happyReduction_38 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (B_Op Subtract happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3 20 happyReduction_39
happyReduction_39 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (B_Op Multiply happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1 21 happyReduction_40
happyReduction_40 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2 21 happyReduction_41
happyReduction_41 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (E_Not happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1 22 happyReduction_42
happyReduction_42 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1 22 happyReduction_43
happyReduction_43 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happyReduce 5 23 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (E_NewArray happy_var_4
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1 24 happyReduction_45
happyReduction_45 (HappyTerminal (TokenLit happy_var_1))
	 =  HappyAbsSyn20
		 (E_Int (read happy_var_1)
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1 24 happyReduction_46
happyReduction_46 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn20
		 (E_Id happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1 24 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn20
		 (E_true
	)

happyReduce_48 = happySpecReduce_1 24 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn20
		 (E_false
	)

happyReduce_49 = happySpecReduce_1 24 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn20
		 (E_this
	)

happyReduce_50 = happyReduce 6 24 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Call "" happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_51 = happySpecReduce_3 24 happyReduction_51
happyReduction_51 _
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (Length happy_var_1
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happyReduce 4 24 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (E_Index happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 4 24 happyReduction_53
happyReduction_53 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (E_NewObj happy_var_2
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_3 24 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 62 62 (error "reading EOF!") (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenLit happy_dollar_dollar -> cont 25;
	TokenId happy_dollar_dollar -> cont 26;
	TokenKeyword "class" -> cont 27;
	TokenKeyword "public" -> cont 28;
	TokenKeyword "static" -> cont 29;
	TokenKeyword "void" -> cont 30;
	TokenKeyword "main" -> cont 31;
	TokenKeyword "String" -> cont 32;
	TokenKeyword "extends" -> cont 33;
	TokenKeyword "return" -> cont 34;
	TokenKeyword "if" -> cont 35;
	TokenKeyword "else" -> cont 36;
	TokenKeyword "int" -> cont 37;
	TokenKeyword "boolean" -> cont 38;
	TokenKeyword "while" -> cont 39;
	TokenKeyword "length" -> cont 40;
	TokenKeyword "true" -> cont 41;
	TokenKeyword "false" -> cont 42;
	TokenKeyword "this" -> cont 43;
	TokenKeyword "new" -> cont 44;
	TokenKeyword "print" -> cont 45;
	TokenOp "." -> cont 46;
	TokenOp "=" -> cont 47;
	TokenOp ";" -> cont 48;
	TokenOp "," -> cont 49;
	TokenOp "!" -> cont 50;
	TokenOp "&&" -> cont 51;
	TokenOp "<" -> cont 52;
	TokenOp "+" -> cont 53;
	TokenOp "-" -> cont 54;
	TokenOp "*" -> cont 55;
	TokenBracket '(' -> cont 56;
	TokenBracket ')' -> cont 57;
	TokenBracket '[' -> cont 58;
	TokenBracket ']' -> cont 59;
	TokenBracket '{' -> cont 60;
	TokenBracket '}' -> cont 61;
	}

happyThen = ((>>=) :: OkF a -> (a -> OkF b) -> OkF b)
happyReturn = (return :: a -> OkF a)
happyThen1 m k tks = ((>>=) :: OkF a -> (a -> OkF b) -> OkF b) m (\a -> k a tks)
happyReturn1 = \a tks -> (return :: a -> OkF a) a

parse_aux tks = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happyError ts
 = fail ("Parse error, tokens left =\n" ++ unlines (map show ts))








parse :: String -> OkF Program
parse s
 = do
      ts <- all_tokens s
      parse_aux ts
{-# LINE 1 "GenericTemplate.hs" -}
{-# LINE 1 "GenericTemplate.hs" -}
-- $Id: MiniJava.hs,v 1.4 2005/01/24 19:04:21 dcs0pcc Exp $

{-# LINE 15 "GenericTemplate.hs" -}






















































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

happyAccept j tk st sts (HappyStk ans _) = 

					   (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 127 "GenericTemplate.hs" -}


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = action nt j tk st sts (fn v1 `HappyStk` stk')

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = action nt j tk st sts (fn v1 v2 `HappyStk` stk')

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = action nt j tk st sts (fn v1 v2 v3 `HappyStk` stk')

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk = action nt j tk st1 sts1 (fn stk)
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - (1)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - (1)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError


{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
