MODULE A098_DataGlobal_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A098 Fall_Demo_2025
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2025.10.31
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A098_Run:=TRUE;
    PERS bool b_A098_CtrlWaitForJob:=TRUE;
    PERS bool b_A098_CtrlInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A098_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A098_JobForCtrl:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A098_Max:=[400,100,400,10];
    PERS speeddata v_A098_Med:=[250,50,250,10];
    PERS speeddata v_A098_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A098_Ctrl:=[245,31,31,31,46,46,46,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A098_MainSta;
    VAR syncident id_A098_MainEnd;

    VAR syncident id_A098_InitTaskSta;
    VAR syncident id_A098_InitTaskEnd;
    !
    VAR syncident id_A098_InitVarSta;
    VAR syncident id_A098_InitVarEnd;
    !
    VAR syncident id_A098_InitSigSta;
    VAR syncident id_A098_InitSigEnd;
    !
    VAR syncident id_A098_InitSpeedSta;
    VAR syncident id_A098_InitSpeedSet;
    VAR syncident id_A098_InitSpeedEnd;

ENDMODULE