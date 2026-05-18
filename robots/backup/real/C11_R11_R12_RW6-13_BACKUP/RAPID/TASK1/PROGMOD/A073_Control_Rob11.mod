MODULE A073_Control_Rob11
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
    !
    ! FUNCTION    :  Control modul and project main
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
    ! Function    :     Main function (start project)
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A073_Main()
        !
        ! Synchronize with controller
        WaitSyncTask id_A073_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A073 Main";
        !
        ! Initialize task for Project
        r_A073_InitTask;
        !
        ! Execution loop
        WHILE b_A073_Run=TRUE DO
            !
            ! Check current mode
            IF b_A073_Jogging=TRUE THEN
                !
                ! Jogging loop
                WHILE b_A073_Jogging=TRUE DO
                    !
                    r_A073_Jogging;
                    !
                    ! Crance cycle time
                    WaitTime n_A073_Jog_CycleTime;
                ENDWHILE
            ELSEIF b_A073_Setup=TRUE THEN
                !
                ! Setup
                r_A073_Setup;
            ELSEIF b_A073_RRC=TRUE THEN
                !
                ! Use RRC
                r_RRC_Main;
            ELSE
                ! Crance cycle time
                WaitTime n_A073_Jog_CycleTime;
            ENDIF
            !
        ENDWHILE
        !
        ! Message to user
        TPWrite "A073 End";
        !
        ! Synchronize with controller
        WaitSyncTask id_A073_MainEnd,tl_RFL_All;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize task for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A073_InitTask()
        !
        WaitSyncTask id_A073_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A073_InitSpeed;
        !
        ! Initialize signals
        r_A073_InitSig;
        !
        ! Initalize variables
        r_A073_InitVar;
        !
        ! Task synchronization to update the synchronization state
        WaitSyncTask id_A073_CheckSyncSta,tl_A073_CtrlRob;
        !
        ! Synchronization state defined
        IF b_A073_GantrySyncOn=TRUE THEN
            !
            ! Reactivate synchronization for coiordinated mode
            r_A073_SyncGantry;
        ELSE
            !
            ! Deactivate synchronization for independet mode
            r_A073_UnsyncGantry;
        ENDIF
        !
        WaitSyncTask id_A073_InitTaskEnd,tl_RFL_All;
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize signals for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A073_InitSig()
        !
        WaitSyncTask id_A073_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A073_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_InitVar()
        !
        WaitSyncTask id_A073_InitVarSta,tl_RFL_All;
        !
        ! Placeholder
        !
        WaitSyncTask id_A073_InitVarEnd,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize speed settings for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_InitSpeed()
        !
        WaitSyncTask id_A073_InitSpeedSta,tl_RFL_All;
        !
        ! Set speed limits
        r_RFL_SetSpeedLimit slim_A073_Ctrl;
        !
        ! Safety time
        WaitTime\InPos,1.0;
        !
        WaitSyncTask id_A073_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Synchronize Gantry
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.14
    !***************** ETH Zurich *******************
    !
    PROC r_A073_SyncGantry()
        !
        WaitSyncTask id_A073_InitSyncSta,tl_A073_CtrlRob;
        !
        ! Check for in position
        WaitRob\InPos;
        !
        ! Activate synchronization
        IF IsSyncMoveOn()=FALSE SyncMoveOn id_A073_SyncGantryOn,tl_A073_Gantry;
        !
        WaitSyncTask id_A073_InitSyncEnd,tl_A073_CtrlRob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Unsynchronize Gantry
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.14
    !***************** ETH Zurich *******************
    !
    PROC r_A073_UnsyncGantry()
        !
        WaitSyncTask id_A073_InitUnsyncSta,tl_A073_CtrlRob;
        !
        ! Check for in position
        WaitRob\InPos;
        !
        ! Deactivate synchronization
        IF IsSyncMoveOn()=TRUE SyncMoveOff id_A073_SyncGantryOff;
        !
        WaitSyncTask id_A073_InitUnsyncEnd,tl_A073_CtrlRob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE