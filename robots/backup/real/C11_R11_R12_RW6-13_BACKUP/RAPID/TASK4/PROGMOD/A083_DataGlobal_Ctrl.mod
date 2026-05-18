MODULE A083_DataGlobal_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A083 Augmented-Timber
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
    PERS bool b_A083_Run:=TRUE;
    PERS bool b_A083_CtrlWaitForJob:=TRUE;
    PERS bool b_A083_CtrlInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A083_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A083_JobForCtrl:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A083_Max:=[400,100,400,10];
    PERS speeddata v_A083_Med:=[250,50,250,10];
    PERS speeddata v_A083_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A083_Ctrl:=[245,31,31,31,46,46,46,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A083_MainSta;
    VAR syncident id_A083_MainEnd;

    VAR syncident id_A083_InitTaskSta;
    VAR syncident id_A083_InitTaskEnd;
    !
    VAR syncident id_A083_InitVarSta;
    VAR syncident id_A083_InitVarEnd;
    !
    VAR syncident id_A083_InitSigSta;
    VAR syncident id_A083_InitSigEnd;
    !
    VAR syncident id_A083_InitSpeedSta;
    VAR syncident id_A083_InitSpeedSet;
    VAR syncident id_A083_InitSpeedEnd;

ENDMODULE