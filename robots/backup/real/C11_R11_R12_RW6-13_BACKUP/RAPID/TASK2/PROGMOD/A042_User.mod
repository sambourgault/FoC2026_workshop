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
    ! Calibration error =  11.1mm
    TASK PERS tooldata t_A042_Sensor_Uncalib:=[TRUE,[[0,0,348],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A042_Sensor_Calib:=[TRUE,[[0,0,359.1],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    ! Tape thickness =  3.45mm
    TASK PERS tooldata t_A042_Sensor_Calib_Tape:=[TRUE,[[0,0,362.55],[1,0,0,0.0]],[1.5,[0,0,0.001],[1,0,0,0],0,0,0]];
    
    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A042_PickUpStation:=[FALSE,TRUE,"",[[-1055.19,8060.02,-5.76073],[0.925585,0.0019509,-0.0017668,0.378531]],[[70,-40,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A042_BuildSpace:=[FALSE,TRUE,"",[[-23.8779,7102.73,106.513],[0.999996,-0.00294957,0.000127463,-5.4398E-06]],[[1,1,0],[1,0,0,0]]];
    TASK PERS wobjdata ob_A042_Sensor:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,-20],[1,0,0,0]]];
  
ENDMODULE