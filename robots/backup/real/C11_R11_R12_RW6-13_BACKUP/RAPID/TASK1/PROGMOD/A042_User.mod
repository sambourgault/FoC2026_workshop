MODULE A042_User
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A042 RRC - RAPID Robot Communication
    !
    ! FUNCTION    :  Free to use for current user
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  rrc@arch.ethz.ch
    !
    ! HISTORY     :  2024.10.28
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS bool b_A042_SyncFeedbackDone:=TRUE;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    CONST string st_A042_UserHeader:="Adonis Lau";

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A042_TeachTip:=[TRUE,[[0,0,250],[1,0,0,0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A042_DemoGripper:=[TRUE,[[0,0,350],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    !
    ! Baumer O200.GP-GW1J.72NV (Led Pinpoint)
    ! Calibration error =  12.1mm
    TASK PERS tooldata t_A042_Sensor_Uncalib:=[TRUE,[[0,0,348],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A042_Sensor_Calib:=[TRUE,[[0,0,360.1],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    ! Tape thickness =  2.81mm
    TASK PERS tooldata t_A042_Sensor_Calib_Tape:=[TRUE,[[0,0,362.91],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    
    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A042_PickUpStation:=[FALSE,TRUE,"",[[-1034.41,6141.67,-0.131388],[0.922867,0.00454283,-0.000331707,-0.385092]],[[70,40,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A042_BuildSpace:=[FALSE,TRUE,"",[[-33.978,7103.65,106.942],[1,-4.88496E-05,3.36893E-05,-7.14644E-05]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A042_Sensor:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,-20],[1,0,0,0]]];
  
ENDMODULE