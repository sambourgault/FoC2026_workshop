MODULE RFL_JobiGPS_12
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
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
        ! Start SCiGPS Example
        StaticCorrectionExample stiGPSRobName;
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
        ! Start SCiGPS Data set creation
        DataSetCreation stiGPSRobName;
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
        VAR string sErrorMessage;
        !
        WaitSyncTask idSCiGPS_UpdateOfflineDataStart,tlAll;
        !
        ! Start SCiGPS Data set creation
        OfflineDataUpdater stiGPSRobName,\error_ui:=true,\corr_error_msg:=sErrorMessage;
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
        ! Bring robot in compact position
        rSysH_ToCompact;
        !
        ! Sync Robots
        WaitSyncTask idSCiGPS_CalibPosCompactDone,tlAll;
        !
        ! Set X-Axis
        jp_iGPS_CalibPos.extax.eax_a:=n_iGPS_CalipPos_XAxis;
        !
        ! Move in calibration pos
        MoveAbsJ jp_iGPS_CalibPos,vRFLMed,fine,tool0;
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
        ! Start SCiGPS Example
        RFLDCMotionTaskExample stiGPSRobName;
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
        ! Start SCiGPS Calibration 
        RFLDCiGPSIMUCalibration;
        ! 
        WaitSyncTask idDCiGPS_CalibEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE