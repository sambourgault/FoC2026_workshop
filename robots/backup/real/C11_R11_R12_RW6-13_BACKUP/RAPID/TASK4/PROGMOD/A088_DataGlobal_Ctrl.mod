MODULE A088_DataGlobal_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A088 RSL-Mitholz
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
    PERS bool b_A088_Run:=TRUE;
    PERS bool b_A088_CtrlWaitForJob:=TRUE;
    PERS bool b_A088_CtrlInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A088_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A088_JobForCtrl:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A088_Max:=[400,100,400,10];
    PERS speeddata v_A088_Med:=[250,50,250,10];
    PERS speeddata v_A088_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A088_Ctrl:=[245,31,31,31,46,46,46,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A088_MainSta;
    VAR syncident id_A088_MainEnd;

    VAR syncident id_A088_InitTaskSta;
    VAR syncident id_A088_InitTaskEnd;
    !
    VAR syncident id_A088_InitVarSta;
    VAR syncident id_A088_InitVarEnd;
    !
    VAR syncident id_A088_InitSigSta;
    VAR syncident id_A088_InitSigEnd;
    !
    VAR syncident id_A088_InitSpeedSta;
    VAR syncident id_A088_InitSpeedSet;
    VAR syncident id_A088_InitSpeedEnd;

ENDMODULE