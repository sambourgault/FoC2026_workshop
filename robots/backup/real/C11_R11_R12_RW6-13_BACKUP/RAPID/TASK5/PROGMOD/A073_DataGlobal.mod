MODULE A073_DataGlobal
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.01.20
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A073_Run;
    PERS bool b_A073_CtrlWaitForJob;
    PERS bool b_A073_CtrlInUse;
    !
    ! Modus
    PERS bool b_A073_Setup;
    PERS bool b_A073_Jogging;
    PERS bool b_A073_RRC;
    !
    ! Setup
    PERS bool b_A073_Init;
    PERS bool b_A073_PickTool;
    PERS bool b_A073_PlaceTool;
    !
    ! Jogging X
    PERS bool b_A073_Jog_X_Pos;
    PERS bool b_A073_Jog_X_Neg;
    PERS bool b_A073_JogCTRL_X_Pos;
    PERS bool b_A073_JogCTRL_X_Neg;
    !
    ! Jogging Y
    PERS bool b_A073_Jog_Y_Pos;
    PERS bool b_A073_Jog_Y_Neg;
    PERS bool b_A073_JogCTRL_Y_Pos;
    PERS bool b_A073_JogCTRL_Y_Neg;
    !
    ! Jogging Z
    PERS bool b_A073_Jog_Z_Pos;
    PERS bool b_A073_Jog_Z_Neg;
    PERS bool b_A073_JogCTRL_Z_Pos;
    PERS bool b_A073_JogCTRL_Z_Neg;
    !
    PERS bool b_A073_Jog_Fast;
    !
    ! Jogging check
    PERS bool b_A073_JogOk_CTRL;
    PERS bool b_A073_JogOk_R11;
    PERS bool b_A073_JogOk_R12;
    !
    ! Global constant values
    PERS bool b_A073_GantrySyncSwitching;
    PERS bool b_A073_GantrySyncOn;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A073_Jog_CycleTime;
    PERS num n_A073_Setup_CycleTime;
    !
    PERS num n_A073_Z_Acc;
    PERS num n_A073_Z_Ramp;
    PERS num n_A073_Z_MoveStepHigh;
    PERS num n_A073_Z_MoveStepLow;
    !
    PERS num n_A073_Modus;
    !
    ! Gantry synchronization
    PERS num n_A073_ActGantrySyncX;
    PERS num n_A073_ActGantrySyncY;
    PERS num n_A073_ActGantrySyncZ;
    PERS num n_A073_ActGantrySyncSpeed;
    PERS num n_A073_ActGantrySyncZone;
    !
    ! Pickup parameters (synchron movment)
    PERS num n_A073_PickOffsZ_LiftTool_1;
    PERS num n_A073_PickOffsZ_LiftTool_2;
    !
    ! Global constant values
    PERS num n_A073_CarrierOffs;
    PERS num n_A073_ZAxisCalib;
    PERS num n_A073_ToolCalibX;
    PERS num n_A073_ToolCalibY;
    PERS num n_A073_ToolCalibZ;
    !
    ! Ganry jogging limits X-Axis
    PERS num n_A073_JogMaxX;
    PERS num n_A073_JogMinX;
    !
    ! Ganry jogging limits Y-Axis
    PERS num n_A073_JogMaxY;
    PERS num n_A073_JogMinY;
    !
    ! Ganry jogging limits Z-Axis
    PERS num n_A073_JogMaxZ;
    PERS num n_A073_JogMinZ;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A073_MsgHeader;
    !
    PERS string st_A073_JobForCtrl;
    PERS string st_A073_Status;
    PERS string st_A073_Modus;
    PERS string st_A073_SyncStatus;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A073_Max;
    PERS speeddata v_A073_Med;
    PERS speeddata v_A073_Min;
    !
    PERS speeddata v_A073_Init;
    !
    PERS speeddata v_A073_Jog_Z_High;
    PERS speeddata v_A073_Jog_Z_Low;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A073_Ctrl;

    !************************************************
    ! Declaration :     tasks
    !************************************************
    !
    PERS tasks tl_A073_CtrlRob{7};
    PERS tasks tl_A073_Gantry{7};

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A073_MainSta;
    VAR syncident id_A073_MainEnd;

    VAR syncident id_A073_InitTaskSta;
    VAR syncident id_A073_InitTaskEnd;
    !
    VAR syncident id_A073_InitVarSta;
    VAR syncident id_A073_InitVarEnd;
    !
    VAR syncident id_A073_InitSigSta;
    VAR syncident id_A073_InitSigEnd;
    !
    VAR syncident id_A073_InitSpeedSta;
    VAR syncident id_A073_InitSpeedSet;
    VAR syncident id_A073_InitSpeedEnd;
    !
    VAR syncident id_A073_CheckSyncSta;
    VAR syncident id_A073_InitSyncSta;
    VAR syncident id_A073_InitSyncEnd;
    !
    VAR syncident id_A073_InitUnsyncSta;
    VAR syncident id_A073_InitUnsyncEnd;
    !
    VAR syncident id_A073_SyncGantryOn;
    VAR syncident id_A073_SyncGantryOff;
    !
    VAR syncident id_A073_Setup_Start;
    VAR syncident id_A073_Setup_End;
    !
    VAR syncident id_A073_Setup_Init_Start;
    VAR syncident id_A073_Setup_Init_R11ToPark;
    VAR syncident id_A073_Setup_Init_R11InPark;
    VAR syncident id_A073_Setup_Init_R12ToPark;
    VAR syncident id_A073_Setup_Init_R12InPark;
    VAR syncident id_A073_Setup_Init_End;
    !
    VAR syncident id_A073_Setup_PickTool_Start;
    VAR syncident id_A073_Setup_PickTool_PosR11;
    VAR syncident id_A073_Setup_PickTool_PosR12;
    VAR syncident id_A073_Setup_PickTool_End;
    !
    VAR syncident id_A073_Setup_PlaceTool_Start;
    VAR syncident id_A073_Setup_PlaceTool_MovToSta;
    VAR syncident id_A073_Setup_PlaceTool_InSta;
    VAR syncident id_A073_Setup_PlaceTool_RelR11;
    VAR syncident id_A073_Setup_PlaceTool_R11Free;
    VAR syncident id_A073_Setup_PlaceTool_RelR12;
    VAR syncident id_A073_Setup_PlaceTool_R12Free;
    VAR syncident id_A073_Setup_PlaceTool_End;
    !
    VAR syncident id_A073_Joging_Start;
    VAR syncident id_A073_JogRob_State;
    VAR syncident id_A073_JogCTRL_State;
    VAR syncident id_A073_JogCTRL_Loop;
    VAR syncident id_A073_Joging_End;
    !
    VAR syncident id_A073_Jog_X_Start;
    VAR syncident id_A073_Jog_X_Pos;
    VAR syncident id_A073_Jog_X_Neg;
    VAR syncident id_A073_Jog_X_End;
    !
    VAR syncident id_A073_Jog_Y_Start;
    VAR syncident id_A073_Jog_Y_Pos;
    VAR syncident id_A073_Jog_Y_Neg;
    VAR syncident id_A073_Jog_Y_End;
    !
    VAR syncident id_A073_Jog_Z_Start;
    VAR syncident id_A073_Jog_Z_Pos;
    VAR syncident id_A073_Jog_Z_Neg;
    VAR syncident id_A073_Jog_Z_End;
    !
    VAR syncident id_A073_MoveGantrySync;

    !************************************************
    ! Declaration :     identno
    !************************************************
    !
    PERS identno idn_A073_Jog_Z_Pos;
    PERS identno idn_A073_Jog_Z_Neg;

ENDMODULE