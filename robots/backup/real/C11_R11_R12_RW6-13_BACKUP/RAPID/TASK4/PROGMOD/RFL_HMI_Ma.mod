MODULE RFL_HMI_Ma
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
    ! FUNCTION    :  Control Routines for ETH
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2016.08.11 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2016
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     User Interface Master Window
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rUIMasterWindow()
        ! 
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="ETH Zurich Digital Fabrication",
                    liMaWinHome
                    \Buttons:=btnOKCancel
                    \Icon:=iconInfo
                    \DefaultIndex:=1);

        IF btnAnswer=resOK THEN


            TEST nUiListItem
            CASE 1:
                ! Item ABB Example
                stJobFrmMa:="rExample";
                !
            CASE 2:
                ! Item ABB Calibration
                stJobFrmMa:="rMoveToCalibPos";
                !
            CASE 3:
                ! Item ABB Move to BreakCheckPos
                stJobFrmMa:="rMoveToBreakCheckPos";
                !
            CASE 4:
                ! Item ETH Factory acceptance test
                stJobFrmMa:="rFacAccTest";
                !
            CASE 5:
                ! Item A009 Stefana
                stJobFrmMa:="rMainA009";
                !
            CASE 6:
                ! Item A009 Stefana
                stJobFrmMa:="rMainA011";
                !
            CASE 7:
                ! Item A019 Timber
                stJobFrmMa:="rMainA019";
                !
            CASE 8:
                ! Item A024 Timber
                stJobFrmMa:="rMainA024";
                !
            CASE 9:
                ! Item A029 FloRaCal
                stJobFrmMa:="rMainA029";
                !
            DEFAULT:
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
        ELSE
            ! User has select Cancel
        ENDIF

        ! Start Job for Tasks

    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window Home
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWinHome()
        !
        ! View Window Home
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="ETH Zurich / NCCR Digital Fabrication",
                    liMaWinHome
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! View Window ABB
                rUIMaWinABB;
            CASE 2:
                !
                ! View Window iGPS
                rUIMaWiniGPS;
            CASE 3:
                !
                ! View Window Project
                rUIMaWinProject;
            CASE 4:
                !
                ! View Window System Helper 
                stJobFrmMa:="rRFL_SysHelper";
                !
                ! Master have a Job
                bWaitForJob:=FALSE;
            CASE 5:
                !
                ! View Window Equipment & Tools
                rUIMaWinEquAndTools;
            CASE 6:
                !
                ! Item Break Check
                stJobFrmMa:="r_ABB_MoveToBrakeCheckPos";
                !
                ! Master have a Job
                bWaitForJob:=FALSE;
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window ABB
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWinABB()
        !
        ! View Window ABB
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="ABB",
                    liMaWinABB
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item ABB Calibration
                stJobFrmMa:="r_ABB_MoveToCalibPos";
            CASE 2:
                !
                ! Item ABB Calibration
                stJobFrmMa:="r_ABB_MoveToRefPos";
            CASE 3:
                !
                ! Item ABB Calibration
                stJobFrmMa:="r_ABB_CraneFunction";
            CASE 4:
                !
                ! Item ABB Example
                stJobFrmMa:="r_ABB_Example";
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window iGPS
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.18
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWiniGPS()
        !
        ! View Window iGPS
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="iGPS",
                    liMaWiniGPS
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item RFL Static Correction
                rUIMaWiniGPS_SC;
            CASE 2:
                !
                ! Item RFL Dynamic Correction
                rUIMaWiniGPS_DC;
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window iGPS Static Correction
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.18
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWiniGPS_SC()
        !
        ! View Window iGPS
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="iGPS Static Correction",
                    liMaWinSCiGPS
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item SCiGPS Example
                stJobFrmMa:="rSCiGPS_Example";
            CASE 2:
                !
                ! Item SCiGPS Data set creation
                stJobFrmMa:="rSCiGPS_DataSetCre";
            CASE 3:
                !
                ! Item SCiGPS Data set creation
                stJobFrmMa:="rSCiGPS_UpdateOfflineData";
            CASE 4:
                !
                ! Item SCiGPS Data set creation
                stJobFrmMa:="rSCiGPS_CalibPos";
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window iGPS Dynamic Correction 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.18
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWiniGPS_DC()
        !
        ! View Window iGPS
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="iGPS Dynamic Correction",
                    liMaWinDCiGPS
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item DCiGPS Example
                stJobFrmMa:="rDCiGPS_Example";
            CASE 2:
                !
                ! Item DCiGPS IMU Calibration
                stJobFrmMa:="rDCiGPS_Calib";
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window Project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.06
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWinProject()
        !
        ! View Window Project
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="RFL Projects",
                    liMaWinProject
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item RRC
                stJobFrmMa:="r_A042_Main";
                stCurMaJob:="A042";
            CASE 2:
                !
                ! Item Integral Timber Joints
                stJobFrmMa:="r_A067_Main";
                stCurMaJob:="A067";
            CASE 3:
                !
                ! Item A073 Impact-Printing
                stJobFrmMa:="r_A073_Main";
                stCurMaJob:="A073";
            CASE 4:
                !
                ! Item Latthammer
                stJobFrmMa:="r_A082_Main";
                stCurMaJob:="A082";
            CASE 5:
                !
                ! Item A083 Augmented-Timber
                stJobFrmMa:="r_A083_Main";
                stCurMaJob:="A083";              
            CASE 6:
                !
                ! Item A088 RSL-Mitholz
                stJobFrmMa:="r_A088_Main";
                stCurMaJob:="A088";              
            CASE 7:
                !
                ! Item A098 Fall Demo 2025
                stJobFrmMa:="r_A098_Main";
                stCurMaJob:="A098";              
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
            !
            ! Ask the user for a shortcut to his project
            nAnswer:=UIMessageBox(
                \Header:="RFL Projects"
                \MsgArray:=["If you want to set a shortcut to your project","select YES",""]
                \Buttons:=btnYesNo
                \Icon:=iconInfo);
            !
            ! Check the user answer
            IF nAnswer=resYes THEN
                !
                ! Yes
                ! Set the shortcut to the project;
                bProjectShortcut:=TRUE;
            ELSE
                !
                ! No
                ! Reset the shortcut to the project;
                bProjectShortcut:=FALSE;
            ENDIF
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     User Interface Window Equipment & Tools
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.07.07
    ! **************** ETH Zurich *******************
    !
    PROC rUIMaWinEquAndTools()
        !
        ! View Window Project
        nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="RFL Equipment & Tools",
                    liMaWinEquAndTools
                    \BtnArray:=stBtnOkExit
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
        !
        ! Check answer
        IF btnAnswer=1 THEN
            !
            ! Button answer OK
            TEST nUiListItem
            CASE 1:
                !
                ! Item Saw
                stJobFrmMa:="r_E001_Saw1";
            CASE 2:
                !
                ! Item Saw
                stJobFrmMa:="r_C001_Cam1";
            CASE 3:
                !
                ! Item Tool-Changer
                stJobFrmMa:="rRFL_TC11";
            CASE 4:
                !
                ! Item Tool-Changer
                stJobFrmMa:="rRFL_TC12";
            DEFAULT:
                !
                ! Undefined Item 
                r_RFL_ProgError;
            ENDTEST
            !
            ! Master have a Job
            bWaitForJob:=FALSE;
        ELSE
            !
            ! User has select Exit
        ENDIF
        !
        ! Start Job for Tasks
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE