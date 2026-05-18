MODULE A088_DataGlobal
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
    PERS bool b_A088_Run;
    PERS bool b_A088_CtrlWaitForJob;
    PERS bool b_A088_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A088_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A088_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A088_Max;
    PERS speeddata v_A088_Med;
    PERS speeddata v_A088_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A088_Ctrl;

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