MODULE A073_DataGlobal_Ctrl
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
    PERS bool b_A073_Run:=TRUE;
    PERS bool b_A073_CtrlWaitForJob:=TRUE;
    PERS bool b_A073_CtrlInUse:=FALSE;
    !
    ! Modus
    PERS bool b_A073_Setup:=TRUE;
    PERS bool b_A073_Jogging:=FALSE;
    PERS bool b_A073_RRC:=FALSE;
    !
    ! Setup
    PERS bool b_A073_Init:=FALSE;
    PERS bool b_A073_PickTool:=FALSE;
    PERS bool b_A073_PlaceTool:=FALSE;
    !
    ! Jogging X
    PERS bool b_A073_Jog_X_Pos:=FALSE;
    PERS bool b_A073_Jog_X_Neg:=FALSE;
    PERS bool b_A073_JogCTRL_X_Pos:=FALSE;
    PERS bool b_A073_JogCTRL_X_Neg:=FALSE;
    !
    ! Jogging Y
    PERS bool b_A073_Jog_Y_Pos:=FALSE;
    PERS bool b_A073_Jog_Y_Neg:=FALSE;
    PERS bool b_A073_JogCTRL_Y_Pos:=FALSE;
    PERS bool b_A073_JogCTRL_Y_Neg:=FALSE;
    !
    ! Jogging Z
    PERS bool b_A073_Jog_Z_Pos:=FALSE;
    PERS bool b_A073_Jog_Z_Neg:=FALSE;
    PERS bool b_A073_JogCTRL_Z_Pos:=FALSE;
    PERS bool b_A073_JogCTRL_Z_Neg:=FALSE;
    !
    PERS bool b_A073_Jog_Fast:=TRUE;
    !
    ! Jogging check 
    PERS bool b_A073_JogOk_CTRL:=FALSE;
    PERS bool b_A073_JogOk_R11:=FALSE;
    PERS bool b_A073_JogOk_R12:=FALSE;
    !
    ! Global constant values
    PERS bool b_A073_GantrySyncSwitching:=FALSE;
    PERS bool b_A073_GantrySyncOn:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A073_Jog_CycleTime:=0.15;
    PERS num n_A073_Setup_CycleTime:=0.15;
    !
    PERS num n_A073_Z_Acc:=50;
    PERS num n_A073_Z_Ramp:=50;
    PERS num n_A073_Z_MoveStepHigh:=5;
    PERS num n_A073_Z_MoveStepLow:=1;
    !
    PERS num n_A073_Modus:=1;
    !
    ! Gantry synchronization
    PERS num n_A073_ActGantrySyncX:=25257.2;
    PERS num n_A073_ActGantrySyncY:=-2548.86;
    PERS num n_A073_ActGantrySyncZ:=-1575;
    PERS num n_A073_ActGantrySyncSpeed:=50;
    PERS num n_A073_ActGantrySyncZone:=1;
    !
    ! Pickup parameters (synchron movment)
    PERS num n_A073_PickOffsZ_LiftTool_1:=-200;
    PERS num n_A073_PickOffsZ_LiftTool_2:=-1800;
    !
    ! Global constant values
    PERS num n_A073_CarrierOffs:=-2843.48;
    PERS num n_A073_ZAxisCalib:=1.52;
    !
    ! Z-Axis differnz from pick up postion
    PERS num n_A073_ToolCalibX:=-68.6;
    PERS num n_A073_ToolCalibY:=-1466.5;
    PERS num n_A073_ToolCalibZ:=1075;
    !
    ! Ganry jogging limits X-Axis
    PERS num n_A073_JogMaxX:=20100;
    PERS num n_A073_JogMinX:=19900;
    !
    ! Ganry jogging limits Y-Axis
    PERS num n_A073_JogMaxY:=-12237;
    PERS num n_A073_JogMinY:=0;
    !
    ! Ganry jogging limits Z-Axis
    PERS num n_A073_JogMaxZ:=-4740;
    PERS num n_A073_JogMinZ:=-4540;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A073_MsgHeader:="Impact Printing";
    !
    PERS string st_A073_JobForCtrl:=" ";
    PERS string st_A073_Status:="*** Setup ***";
    PERS string st_A073_Modus:="Setup";
    PERS string st_A073_SyncStatus:="Independent";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A073_Max:=[400,100,400,10];
    PERS speeddata v_A073_Med:=[250,50,250,10];
    PERS speeddata v_A073_Min:=[50,25,250,10];
    !
    PERS speeddata v_A073_Init:=[100,50,100,1];
    !
    PERS speeddata v_A073_Jog_Z_High:=[200,100,200,10];
    PERS speeddata v_A073_Jog_Z_Low:=[50,50,50,10];
    !

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A073_Ctrl:=[500,0,0,0,0,0,0,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     tasks
    !************************************************
    !
    PERS tasks tl_A073_CtrlRob{7}:=[["T_CTRL"],["T_ROB11"],["T_ROB12"],[""],[""],[""],[""]];
    PERS tasks tl_A073_Gantry{7}:=[["T_ROB11"],["T_ROB12"],[""],[""],[""],[""],[""]];

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
    PERS identno idn_A073_Jog_Z_Pos:=300;
    PERS identno idn_A073_Jog_Z_Neg:=310;

ENDMODULE