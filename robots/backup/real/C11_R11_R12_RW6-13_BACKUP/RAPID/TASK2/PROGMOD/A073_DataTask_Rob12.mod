MODULE A073_DataTask_Rob12
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
    !
    ! FUNCTION    :  Includ all Task Data's for Project
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

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A073_MyBool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A073_Acc:=50;
    TASK PERS num n_A073_Ramp:=50;
    TASK PERS num n_A073_ActStep:=1;
    !
    TASK PERS num n_A073_PickOffsY:=-1000;
    TASK PERS num n_A073_PickOffsZ_Up:=-2500;
    TASK PERS num n_A073_PickOffsZ_Down:=200;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    TASK PERS string st_A073_MyString:="";

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A073_MyTool:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A073_MyWobjdata:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     robjoint
    !************************************************
    !
    CONST robjoint rj_A073_RobotStandby:=[0,90,0,0,15,0];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    ! Pick postion of tool 
    CONST jointtarget jp_A073_PickTool:=[[1.16662E-05,92.2987,-2.16902,-0.00121177,0.00027126,0.000442887],[25268.6,-5386.55,-1407.82,0,0,0]];
    !
    TASK PERS jointtarget jp_A073_InitPos:=[[0,-65,65,0,35,0],[17400,-8600,-4850,0,0,0]];
    TASK PERS jointtarget jp_A073_CurrentPos:=[[0,-65,65,0,35,0],[17400,-3600,-4850,0,0,0]];
    TASK PERS jointtarget jp_A073_Jog_Z:=[[-0.00028876,89.998,-8.70269E-06,-0.000204693,15.0001,8.92072E-05],[22285.2,-5603.22,-1524.48,0,0,0]];
    !
    TASK PERS jointtarget jp_A073_Act:=[[0,90,0,0,15,0],[25268.6,-5386.55,-1407.82,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    ! Pick postion of tool 
    CONST robtarget p_A073_PickTool:=[[26706.18,5385.99,2361.83],[0.000288908,0.00157488,-0.000140909,-0.999999],[-1,-1,0,0],[25268.6,-5386.55,-1407.82,0,0,0]];
    !
    TASK PERS robtarget p_A073_MyRobtarget:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A073_Act:=[50,50,50,10];
    
    !************************************************
    ! Declaration :     zonedata
    !************************************************
    !
    TASK PERS zonedata z_A073_Act:=[FALSE,1,1,1,0.1,1,0.1];

    !************************************************
    ! Declaration :     btnres
    !************************************************
    !
    TASK PERS btnres btr_A073_Answer:=1;

    !************************************************
    ! Declaration :     identno
    !************************************************
    !
    CONST identno idn_A073_SyncID_PickUp:=1;
    CONST identno idn_A073_SyncID_PlaceDown:=2;
    VAR identno idn_A073_SyncID:=0;

ENDMODULE