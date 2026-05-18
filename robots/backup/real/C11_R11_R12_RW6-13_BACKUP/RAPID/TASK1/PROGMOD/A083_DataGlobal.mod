MODULE A083_DataGlobal
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
    PERS bool b_A083_Run;
    PERS bool b_A083_CtrlWaitForJob;
    PERS bool b_A083_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A083_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A083_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A083_Max;
    PERS speeddata v_A083_Med;
    PERS speeddata v_A083_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A083_Ctrl;

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