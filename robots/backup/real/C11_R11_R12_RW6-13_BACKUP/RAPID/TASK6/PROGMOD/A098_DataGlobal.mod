MODULE A098_DataGlobal
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
    PERS bool b_A098_Run;
    PERS bool b_A098_CtrlWaitForJob;
    PERS bool b_A098_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A098_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A098_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A098_Max;
    PERS speeddata v_A098_Med;
    PERS speeddata v_A098_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A098_Ctrl;

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