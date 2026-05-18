MODULE A067_DataGlobal_Ma
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
    ! HISTORY     :  2019.06.20
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !
    !***********************************************************************************
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A067_Run:=TRUE;
    PERS bool b_A067_MaWaitForJob:=TRUE;
    PERS bool b_A067_MaInUse:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A067_AccRamp:=33;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A067_JobForMa:=" ";

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A067_Max:=[1000,100,1000,10];
    PERS speeddata v_A067_Med:=[250,50,250,10];
    PERS speeddata v_A067_Min:=[50,25,250,10];

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A067_Master:=[245,16,39,43,43,20,5,0,0,0,0,0,0];

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A067_MainSta;
    VAR syncident id_A067_MainEnd;

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