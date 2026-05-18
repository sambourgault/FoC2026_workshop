MODULE A042_DataGlobal
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 RRC - RAPID Robot Communication
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
    PERS bool b_A042_Run;
    PERS bool b_A042_CtrlWaitForJob;
    PERS bool b_A042_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A042_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A042_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A042_Max;
    PERS speeddata v_A042_Med;
    PERS speeddata v_A042_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A042_Ctrl;

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A042_MainSta;
    VAR syncident id_A042_MainEnd;

    VAR syncident id_A042_InitTaskSta;
    VAR syncident id_A042_InitTaskEnd;
    !
    VAR syncident id_A042_InitVarSta;
    VAR syncident id_A042_InitVarEnd;
    !
    VAR syncident id_A042_InitSigSta;
    VAR syncident id_A042_InitSigEnd;
    !
    VAR syncident id_A042_InitSpeedSta;
    VAR syncident id_A042_InitSpeedSet;
    VAR syncident id_A042_InitSpeedEnd;

ENDMODULE