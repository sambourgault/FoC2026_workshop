MODULE A082_DataGlobal
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A082 Latthammer
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.10.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A082_Run;
    PERS bool b_A082_CtrlWaitForJob;
    PERS bool b_A082_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A082_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A082_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A082_Max;
    PERS speeddata v_A082_Med;
    PERS speeddata v_A082_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A082_Ctrl;

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A082_MainSta;
    VAR syncident id_A082_MainEnd;

    VAR syncident id_A082_InitTaskSta;
    VAR syncident id_A082_InitTaskEnd;
    !
    VAR syncident id_A082_InitVarSta;
    VAR syncident id_A082_InitVarEnd;
    !
    VAR syncident id_A082_InitSigSta;
    VAR syncident id_A082_InitSigEnd;
    !
    VAR syncident id_A082_InitSpeedSta;
    VAR syncident id_A082_InitSpeedSet;
    VAR syncident id_A082_InitSpeedEnd;

ENDMODULE