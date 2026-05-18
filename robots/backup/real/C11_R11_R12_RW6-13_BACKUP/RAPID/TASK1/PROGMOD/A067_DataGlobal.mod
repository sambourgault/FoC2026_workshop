MODULE A067_DataGlobal
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A067 Integral Timber Joints
    !
    ! FUNCTION    :  Includ all Global Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2019.11.29
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A067_Run;
    PERS bool b_A067_MaWaitForJob;
    PERS bool b_A067_MaInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A067_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A067_JobForMa:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A067_Max;
    PERS speeddata v_A067_Med;
    PERS speeddata v_A067_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A067_Master;

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A067_MainSta;
    VAR syncident id_A067_MainEnd;
    !
    VAR syncident id_A067_InitTaskSta;
    VAR syncident id_A067_InitTaskEnd;
    !
    VAR syncident id_A067_InitVarSta;
    VAR syncident id_A067_InitVarEnd;
    !
    VAR syncident id_A067_InitSigSta;
    VAR syncident id_A067_InitSigEnd;
    !
    VAR syncident id_A067_InitSpeedSta;
    VAR syncident id_A067_InitSpeedSet;
    VAR syncident id_A067_InitSpeedEnd;

ENDMODULE