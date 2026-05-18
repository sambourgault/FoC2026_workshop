MODULE A083_DataTask_Rob
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
    TASK PERS bool b_A083_MyBool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A083_MyNum:=0;
    !
    ! Demo for Site Visit 2023
    TASK PERS num n_A083_OffsX:=100;    
    TASK PERS num n_A083_OffsY:=100;
    TASK PERS num n_A083_OffsZ:=100;
    
    !************************************************
    ! Declaration :     string
    !************************************************
    !
    TASK PERS string st_A083_MyString:="";

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A083_MyTool:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A083_RefTip:=[TRUE,[[0,0,250],[1,0,0,0]],[2,[0,0,50],[1,0,0,0],0,0,0]];
    !
    ! Demo for Site Visit 2023
    TASK PERS tooldata t_A083_SV23_WoodGripper:=[TRUE,[[0,0,220],[1,0,0,0]],[28,[0,0,125],[1,0,0,0],0,0,0]]; !196 before:269

    !************************************************
    ! Declaration :     loaddata
    !************************************************
    !
    ! Demo for Site Visit 2023
    TASK PERS loaddata ld_A083_SV23_DemoBeam:=[33,[0,0,1],[1,0,0,0],0,0,0];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A083_MyWobjdata:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A083_Wobj_Place:=[FALSE,TRUE,"",[[-207.311,-1071,-39.4772],[0.575754,0.000199967,0.000151784,-0.817623]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A083_Wobj_Pick:=[FALSE,TRUE,"",[[-1049.15,-568.768,-42.1385],[0.233655,-0.00369194,0.000702063,0.972312]],[[0,0,0],[1,0,0,0]]];
    !
    ! Demo for Site Visit 2023
    TASK PERS wobjdata ob_A083_SV23_WobjBase:=[FALSE,TRUE,"",[[7567.92,2613.59,309.519],[1,0.000198113,0.000194477,0.000771701]],[[-41.58,-50,-30],[1,0,0,0]]];
    !
    TASK PERS wobjdata ob_A083_Wobj_Station:=[FALSE,TRUE,"",[[10047.6,2627.32,306.519],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A083_MyJointtarget:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    !
    ! Demo for Site Visit 2023
    TASK PERS jointtarget jp_A083_SV23_PickPos:=[[-62.5085,-53.3891,33.5052,180.037,70.2409,-27.766],[9891.21,-5271.58,-2475.7,0,0,0]];
    TASK PERS jointtarget jp_A083_SV23_PlacePos:=[[-62.5085,-53.389,33.5055,180.037,70.2406,-27.7658],[7674.97,-5103.51,-4720.02,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_A083_MyRobtarget:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    !
    ! Demo points
    TASK PERS robtarget p_A083_Home:=[[0,0,300],[0.247354,0.8325,-0.437708,0.232748],[-2,1,-3,1],[-301.6,9E+09,9E+09,9E+09,9E+09,9E+09]];
    TASK PERS robtarget p_A083_Pick:=[[18,31,1],[0.247354,0.8325,-0.437708,0.232748],[-2,1,-3,1],[-301.6,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !
    ! Demo for Site Visit 2023
    TASK PERS robtarget p_A083_SV23_PickPos:=[[2569.31,3086.76,48.04],[0.000354658,0.706645,-0.707568,0.000386528],[-1,2,-1,0],[9891.21,-5271.58,-2475.7,0,0,0]];
    TASK PERS robtarget p_A083_SV23_MiddlePos:=[[2806.23,2819.08,2461.58],[0.000343873,0.706646,-0.707567,0.000384704],[-1,2,-1,0],[10129.3,-5003.5,-4870.02,0,0,0]];
    TASK PERS robtarget p_A083_SV23_PlacePos:=[[351.94,2923.00,2291.57],[0.000346612,0.706645,-0.707568,0.000385582],[-1,2,-1,0],[7674.97,-5103.51,-4720.02,0,0,0]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A083_MySpeed:=[0,0,0,0];
    !
    ! Demo for Site Visit 2023
    TASK PERS speeddata v_A083_SV23_SpeedMin:=[10,50,10,1];
    TASK PERS speeddata v_A083_SV23_SpeedMed:=[50,250,50,1];
    TASK PERS speeddata v_A083_SV23_SpeedMax:=[400,500,400,1];
ENDMODULE