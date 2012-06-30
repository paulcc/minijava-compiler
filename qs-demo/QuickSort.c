

//------------------------------------------------------------------------------
#include "rts.h"


//------------------------------------------------------------------------------
extern Ptr jumpQuickSort[];
extern Ptr jumpQS[];



//------------------------------------------------------------------------------
int main_ (int *fp) {
    grab(4);
    main_:
    fp[-1] = obj_alloc(8,jumpQS);
    push(10);
    push(fp[-1]);
    fp[-2] = DEREF(/*QS.Start*/0,sp);
    pop(2);
    fp[-3] = printf("%d\n",fp[-2]);
    goto main__exit;
    main__exit:
    pop(4);
    return retval;
}


//------------------------------------------------------------------------------
int QS_Start (int *fp) {
    grab(7);
    L_93:
    push(fp[1]);
    push(fp[0]);
    fp[-2] = DEREF(/*QS.Init*/3,sp);
    pop(2);
    fp[-1] = fp[-2];
    push(fp[0]);
    fp[-3] = DEREF(/*QS.Print*/2,sp);
    pop(1);
    fp[-1] = fp[-3];
    fp[-4] = printf("%d\n",9999);
    fp[-1] = (*(int *)((fp[0] + 4)) - 1);
    push(fp[-1]);
    push(0);
    push(fp[0]);
    fp[-5] = DEREF(/*QS.Sort*/1,sp);
    pop(3);
    fp[-1] = fp[-5];
    push(fp[0]);
    fp[-6] = DEREF(/*QS.Print*/2,sp);
    pop(1);
    fp[-1] = fp[-6];
    retval = 0;
    goto QS_Start_exit;
    QS_Start_exit:
    pop(7);
    return retval;
}


//------------------------------------------------------------------------------
int QS_Sort (int *fp) {
    grab(44);
    L_94:
    fp[-5] = 0;
    if ((fp[1] < fp[2]) == 1) goto L_0;
    L_55:
    fp[-4] = 0;
    goto L_56;
    L_56:
    retval = 0;
    goto QS_Sort_exit;
    L_0:
    fp[-9] = fp[2];
    if (fp[-9] < 0) goto L_3;
    L_1:
    if (fp[-9] < *(int *)(*(int *)(fp[0]))) goto L_2;
    L_3:
    crash_array();
    goto L_2;
    L_2:
    fp[-1] = *(int *)((*(int *)(fp[0]) + (4 * (fp[-9] + 1))));
    fp[-2] = (fp[1] - 1);
    fp[-3] = fp[2];
    fp[-6] = 1;
    goto L_4;
    L_4:
    if (fp[-6] == 0) goto L_39;
    L_5:
    fp[-7] = 1;
    goto L_6;
    L_6:
    if (fp[-7] == 0) goto L_14;
    L_7:
    fp[-2] = (fp[-2] + 1);
    fp[-11] = fp[-2];
    if (fp[-11] < 0) goto L_10;
    L_8:
    if (fp[-11] < *(int *)(*(int *)(fp[0]))) goto L_9;
    L_10:
    crash_array();
    goto L_9;
    L_9:
    fp[-8] = *(int *)((*(int *)(fp[0]) + (4 * (fp[-11] + 1))));
    if (((fp[-8] < fp[-1]) == 0) == 1) goto L_11;
    L_12:
    fp[-7] = 1;
    goto L_13;
    L_13:
    goto L_6;
    L_11:
    fp[-7] = 0;
    goto L_13;
    L_14:
    fp[-7] = 1;
    goto L_15;
    L_15:
    if (fp[-7] == 0) goto L_23;
    L_16:
    fp[-3] = (fp[-3] - 1);
    fp[-13] = fp[-3];
    if (fp[-13] < 0) goto L_19;
    L_17:
    if (fp[-13] < *(int *)(*(int *)(fp[0]))) goto L_18;
    L_19:
    crash_array();
    goto L_18;
    L_18:
    fp[-8] = *(int *)((*(int *)(fp[0]) + (4 * (fp[-13] + 1))));
    if (((fp[-1] < fp[-8]) == 0) == 1) goto L_20;
    L_21:
    fp[-7] = 1;
    goto L_22;
    L_22:
    goto L_15;
    L_20:
    fp[-7] = 0;
    goto L_22;
    L_23:
    fp[-15] = fp[-2];
    if (fp[-15] < 0) goto L_26;
    L_24:
    if (fp[-15] < *(int *)(*(int *)(fp[0]))) goto L_25;
    L_26:
    crash_array();
    goto L_25;
    L_25:
    fp[-5] = *(int *)((*(int *)(fp[0]) + (4 * (fp[-15] + 1))));
    fp[-17] = fp[-2];
    if (fp[-17] < 0) goto L_29;
    L_27:
    if (fp[-17] < *(int *)(*(int *)(fp[0]))) goto L_28;
    L_29:
    crash_array();
    goto L_28;
    L_28:
    fp[-35] = (*(int *)(fp[0]) + (4 * (fp[-17] + 1)));
    fp[-19] = fp[-3];
    if (fp[-19] < 0) goto L_32;
    L_30:
    if (fp[-19] < *(int *)(*(int *)(fp[0]))) goto L_31;
    L_32:
    crash_array();
    goto L_31;
    L_31:
    *(int *)(fp[-35]) = *(int *)((*(int *)(fp[0]) + (4 * (fp[-19] + 1))));
    fp[-21] = fp[-3];
    if (fp[-21] < 0) goto L_35;
    L_33:
    if (fp[-21] < *(int *)(*(int *)(fp[0]))) goto L_34;
    L_35:
    crash_array();
    goto L_34;
    L_34:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-21] + 1)))) = fp[-5];
    if ((fp[-3] < (fp[-2] + 1)) == 1) goto L_36;
    L_37:
    fp[-6] = 1;
    goto L_38;
    L_38:
    goto L_4;
    L_36:
    fp[-6] = 0;
    goto L_38;
    L_39:
    fp[-23] = fp[-3];
    if (fp[-23] < 0) goto L_42;
    L_40:
    if (fp[-23] < *(int *)(*(int *)(fp[0]))) goto L_41;
    L_42:
    crash_array();
    goto L_41;
    L_41:
    fp[-36] = (*(int *)(fp[0]) + (4 * (fp[-23] + 1)));
    fp[-25] = fp[-2];
    if (fp[-25] < 0) goto L_45;
    L_43:
    if (fp[-25] < *(int *)(*(int *)(fp[0]))) goto L_44;
    L_45:
    crash_array();
    goto L_44;
    L_44:
    *(int *)(fp[-36]) = *(int *)((*(int *)(fp[0]) + (4 * (fp[-25] + 1))));
    fp[-27] = fp[-2];
    if (fp[-27] < 0) goto L_48;
    L_46:
    if (fp[-27] < *(int *)(*(int *)(fp[0]))) goto L_47;
    L_48:
    crash_array();
    goto L_47;
    L_47:
    fp[-37] = (*(int *)(fp[0]) + (4 * (fp[-27] + 1)));
    fp[-29] = fp[2];
    if (fp[-29] < 0) goto L_51;
    L_49:
    if (fp[-29] < *(int *)(*(int *)(fp[0]))) goto L_50;
    L_51:
    crash_array();
    goto L_50;
    L_50:
    *(int *)(fp[-37]) = *(int *)((*(int *)(fp[0]) + (4 * (fp[-29] + 1))));
    fp[-31] = fp[2];
    if (fp[-31] < 0) goto L_54;
    L_52:
    if (fp[-31] < *(int *)(*(int *)(fp[0]))) goto L_53;
    L_54:
    crash_array();
    goto L_53;
    L_53:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-31] + 1)))) = fp[-5];
    fp[-38] = fp[0];
    fp[-39] = fp[1];
    fp[-40] = (fp[-2] - 1);
    push(fp[-40]);
    push(fp[-39]);
    push(fp[-38]);
    fp[-33] = DEREF(/*QS.Sort*/1,sp);
    pop(3);
    fp[-4] = fp[-33];
    fp[-41] = fp[0];
    fp[-42] = (fp[-2] + 1);
    fp[-43] = fp[2];
    push(fp[-43]);
    push(fp[-42]);
    push(fp[-41]);
    fp[-34] = DEREF(/*QS.Sort*/1,sp);
    pop(3);
    fp[-4] = fp[-34];
    goto L_56;
    QS_Sort_exit:
    pop(44);
    return retval;
}


//------------------------------------------------------------------------------
int QS_Print (int *fp) {
    grab(6);
    L_95:
    fp[-1] = 0;
    goto L_57;
    L_57:
    if ((fp[-1] < *(int *)((fp[0] + 4))) == 0) goto L_62;
    L_58:
    fp[-2] = fp[-1];
    if (fp[-2] < 0) goto L_61;
    L_59:
    if (fp[-2] < *(int *)(*(int *)(fp[0]))) goto L_60;
    L_61:
    crash_array();
    goto L_60;
    L_60:
    fp[-5] = *(int *)((*(int *)(fp[0]) + (4 * (fp[-2] + 1))));
    fp[-4] = printf("%d\n",fp[-5]);
    fp[-1] = (fp[-1] + 1);
    goto L_57;
    L_62:
    retval = 0;
    goto QS_Print_exit;
    QS_Print_exit:
    pop(6);
    return retval;
}


//------------------------------------------------------------------------------
int QS_Init (int *fp) {
    grab(25);
    L_96:
    *(int *)((fp[0] + 4)) = fp[1];
    fp[-23] = fp[0];
    fp[-1] = fp[1];
    fp[-24] = ((1 + fp[-1]) * 4);
    fp[-2] = (int)malloc(fp[-24]);
    *(int *)(fp[-2]) = fp[-1];
    *(int *)(fp[-23]) = fp[-2];
    fp[-3] = 0;
    if (fp[-3] < 0) goto L_65;
    L_63:
    if (fp[-3] < *(int *)(*(int *)(fp[0]))) goto L_64;
    L_65:
    crash_array();
    goto L_64;
    L_64:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-3] + 1)))) = 20;
    fp[-5] = 1;
    if (fp[-5] < 0) goto L_68;
    L_66:
    if (fp[-5] < *(int *)(*(int *)(fp[0]))) goto L_67;
    L_68:
    crash_array();
    goto L_67;
    L_67:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-5] + 1)))) = 7;
    fp[-7] = 2;
    if (fp[-7] < 0) goto L_71;
    L_69:
    if (fp[-7] < *(int *)(*(int *)(fp[0]))) goto L_70;
    L_71:
    crash_array();
    goto L_70;
    L_70:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-7] + 1)))) = 12;
    fp[-9] = 3;
    if (fp[-9] < 0) goto L_74;
    L_72:
    if (fp[-9] < *(int *)(*(int *)(fp[0]))) goto L_73;
    L_74:
    crash_array();
    goto L_73;
    L_73:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-9] + 1)))) = 18;
    fp[-11] = 4;
    if (fp[-11] < 0) goto L_77;
    L_75:
    if (fp[-11] < *(int *)(*(int *)(fp[0]))) goto L_76;
    L_77:
    crash_array();
    goto L_76;
    L_76:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-11] + 1)))) = 2;
    fp[-13] = 5;
    if (fp[-13] < 0) goto L_80;
    L_78:
    if (fp[-13] < *(int *)(*(int *)(fp[0]))) goto L_79;
    L_80:
    crash_array();
    goto L_79;
    L_79:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-13] + 1)))) = 11;
    fp[-15] = 6;
    if (fp[-15] < 0) goto L_83;
    L_81:
    if (fp[-15] < *(int *)(*(int *)(fp[0]))) goto L_82;
    L_83:
    crash_array();
    goto L_82;
    L_82:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-15] + 1)))) = 6;
    fp[-17] = 7;
    if (fp[-17] < 0) goto L_86;
    L_84:
    if (fp[-17] < *(int *)(*(int *)(fp[0]))) goto L_85;
    L_86:
    crash_array();
    goto L_85;
    L_85:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-17] + 1)))) = 9;
    fp[-19] = 8;
    if (fp[-19] < 0) goto L_89;
    L_87:
    if (fp[-19] < *(int *)(*(int *)(fp[0]))) goto L_88;
    L_89:
    crash_array();
    goto L_88;
    L_88:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-19] + 1)))) = 19;
    fp[-21] = 9;
    if (fp[-21] < 0) goto L_92;
    L_90:
    if (fp[-21] < *(int *)(*(int *)(fp[0]))) goto L_91;
    L_92:
    crash_array();
    goto L_91;
    L_91:
    *(int *)((*(int *)(fp[0]) + (4 * (fp[-21] + 1)))) = 5;
    retval = 0;
    goto QS_Init_exit;
    QS_Init_exit:
    pop(25);
    return retval;
}


//------------------------------------------------------------------------------
static Ptr jumpQuickSort[] = { &main_
};
static Ptr jumpQS[] = { &QS_Start
                      , &QS_Sort
                      , &QS_Print
                      , &QS_Init
};

