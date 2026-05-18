MODULE RFL_JobiGPS_Ma
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Job Routines for iGPS 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.07.06 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Example form Static Correction iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rSCiGPS_Example()
        !
        WaitSyncTask idSCiGPS_ExampleSta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in SC-iGPS Example";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idSCiGPS_ExampleEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Data set creation form Static Correction iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rSCiGPS_DataSetCre()
        !
        WaitSyncTask idSCiGPS_DataSetCreSta,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in SC-iGPS Data set creation";
        !
        ! Placeholder for Master Code 
        ! 
        WaitSyncTask idSCiGPS_DataSetCreEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Update Offline Data form Static Correction iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.24
    ! **************** ETH Zurich *******************
    !
    PROC rSCiGPS_UpdateOfflineData()
        VAR bool bSuccessful;
        !
        WaitSyncTask idSCiGPS_UpdateOfflineDataStart,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in SC-iGPS Update Offline Data";
        ! 
        WaitSyncTask idSCiGPS_UpdateOfflineDataEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move Robot in Static Correction iGPS calibration position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.10.31
    ! **************** ETH Zurich *******************
    !
    PROC rSCiGPS_CalibPos()
        !
        WaitSyncTask idSCiGPS_CalibPosStart,tlAll;
        !
        ! Temp Msg for Operator
        TPWrite "Master in SC-iGPS Calibration Position";
        !
        ! Sync Robots
        WaitSyncTask idSCiGPS_CalibPosCompactDone,tlAll;
        !
        WaitSyncTask idSCiGPS_CalibPosEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Example form Dynamic Correction iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.18
    ! **************** ETH Zurich *******************
    !
    PROC rDCiGPS_Example()
        !
        WaitSyncTask idDCiGPS_ExampleSta,tlAll;
        !
        Stop;
        ! Temp Msg for Operator
        TPWrite "Master in DC-iGPS Example";
        ! 
        WaitSyncTask idDCiGPS_ExampleEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Calibration form Dynamic Correction iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.18
    ! **************** ETH Zurich *******************
    !
    PROC rDCiGPS_Calib()
        !
        WaitSyncTask idDCiGPS_CalibSta,tlAll;
        !
        Stop;
        ! Temp Msg for Operator
        TPWrite "Master in DC-iGPS Calibration";
        ! 
        WaitSyncTask idDCiGPS_CalibEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE