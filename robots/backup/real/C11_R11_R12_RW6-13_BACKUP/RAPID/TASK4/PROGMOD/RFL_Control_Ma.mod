MODULE RFL_Control_Ma
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
    ! Function    :     Main
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC main()
        !
        ! Read system specification
        r_RFL_SysSpec;
        !
        ! Initalisation
        rInitTask;
        !
        ! Work process
        WHILE bRun=TRUE DO
            !
            ! Idle Loop
            WHILE bWaitForJob=TRUE DO
                !
                ! User Interface
                rUIMaWinHome;
                !
                ! Short waittime
                WaitTime 0.1;
            ENDWHILE
            !
            ! Execute  Job from Master
            rExecuteJobFrmMa;
        ENDWHILE
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Task
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rInitTask()
        !
        WaitSyncTask idRFL_InitTaskSta,tlAll;
        !
        ! Clear TP Window
        TPErase;
        !
        ! Speed
        rInitSpeed;
        !
        ! Signals
        rInitSig;
        !
        ! Variables
        rInitVar;
        !
        ! Synchronize with master
        WaitSyncTask idRFL_MaInitDone,tlMaRecSen;
        !
        WaitSyncTask idRFL_InitTaskEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.09.27
    ! **************** ETH Zurich *******************
    !
    PROC rInitSig()
        !
        WaitSyncTask idRFL_InitSigSta,tlAll;
        !
        ! Switch saw off
        !* r_E001_SawOff;
        !
        ! Init comm port for saw
        !* rEL6001_Init_Com1;
        !
        WaitSyncTask idRFL_InitSigEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Variables
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rInitVar()
        !
        WaitSyncTask idRFL_InitVarSta,tlAll;
        !
        !
        zMaMin:=z10;
        zMaMed:=z100;
        zMaMax:=z200;
        !
        ! FlexPendant porgrammable key 4 is used for Master reset
        IF doViMaFP3=1 OR bProjectShortcut=FALSE THEN
            !
            ! Master reset
            !
            ! Reset the project shortcut to start the Masterwindow
            bProjectShortcut:=FALSE;
            !
            ! Reset job for master
            bWaitForJob:=TRUE;
            stJobFrmMa:="InitVar";
            stCurMaJob:="InitVar";
            !
            ! Reset the resetsignal
            SetDo doViMaFP3,0;
        ELSE
            !
            ! No master reset
        ENDIF
        !
        WaitSyncTask idRFL_InitVarEnd,tlAll;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize Speed
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.02.21
    ! **************** ETH Zurich *******************
    !
    PROC rInitSpeed()
        !
        WaitSyncTask idRFL_InitSpeedSta,tlAll;
        !
        ! Speed limit off
        r_RFL_SpeedLimitOff;
        !
        ! Wait until speed is set in task
        WaitSyncTask idRFL_InitSpeedSet,tlAll;
        !
        ! Speed limit on
        r_RFL_SpeedLimitOn;
        !
        WaitSyncTask idRFL_InitTaskEnd,tlAll;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Execute Job from Master
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC rExecuteJobFrmMa()
        !
        WaitSyncTask idRFL_ExeJobFrmMaSta,tlAll;
        !
        %stJobFrmMa %;
        !
        WaitSyncTask idRFL_ExeJobFrmMaEnd,tlAll;
        !
        ! Job finish
        bWaitForJob:=TRUE;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     ProgError
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.08.11
    ! **************** ETH Zurich *******************
    !
    PROC r_RFL_ProgError()
        !
        ! User Msg
        rTPMsg "Program Error or not finisht programmed";
        !
        ! Stop Program
        Stop;
        Stop;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE