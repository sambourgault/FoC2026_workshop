MODULE A073_Jogging_Rob12
	PERS tooldata t_A073_StraightTrowel:=[TRUE,[[406.135,9.37971,101.604],[0.707106,0,-0.707106,0]],[0.5,[0,0,0],[1,0,0,0],0,0,0]];
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
    ! FUNCTION    :  Project specific instructions
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.06.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Move to initial position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_GoToInitPos()
        !
        ! Move to initial position
        MoveAbsJ jp_A073_InitPos\NoEOffs,v_A073_Init,fine,tool0\WObj:=wobj0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Jogging of Gantry-Axis
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_Jogging()
        !
        ! Synchronisation
        WaitSyncTask id_A073_Joging_Start,tl_A073_CtrlRob;
        !
        ! Jogging works only in synchronization mode
        IF IsSyncMoveOn()=TRUE THEN
            !
            ! Manual jogging
            WHILE b_A073_Jogging=TRUE DO
                !
                ! Check move direction
                IF b_A073_JogCTRL_Z_Pos=TRUE OR b_A073_JogCTRL_Z_Neg=TRUE THEN
                    !
                    ! Move Z-Axis
                    r_A073_JogZ;
                ELSE
                    !
                    ! Crance cycle time
                    WaitTime n_A073_Jog_CycleTime;
                ENDIF
            ENDWHILE
        ELSE
            !
            ! Not in synchron mode
        ENDIF
        !
        ! Synchronisation
        WaitSyncTask id_A073_Joging_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC


    !************************************************
    ! Function    :     Jogging of Z-Axis
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_JogZ()
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_Z_Start,tl_A073_CtrlRob;
        !
        ! Read current position
        jp_A073_Jog_Z:=CJointT();
        !
        ! Set speed, distance and blend
        v_A073_Act:=v_A073_Jog_Z_Low;
        n_A073_Acc:=n_A073_Z_Acc;
        n_A073_Ramp:=n_A073_Z_Ramp;
        n_A073_ActStep:=n_A073_Z_MoveStepLow;
        z_A073_Act:=z1;
        !
        ! Acceleration update
        AccSet n_A073_Acc,n_A073_Ramp;
        !
        ! Jog loop
        WHILE b_A073_JogCTRL_Z_Pos=TRUE OR b_A073_JogCTRL_Z_Neg=TRUE DO
            !
            ! Positive movmend
            IF b_A073_JogCTRL_Z_Pos=TRUE jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c-n_A073_ActStep;
            !
            ! Negative movmend
            IF b_A073_JogCTRL_Z_Neg=TRUE jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c+n_A073_ActStep;
            !
            ! Reset robot okey state
            b_A073_JogOk_R12:=FALSE;
            !
            ! Check new move value
            IF jp_A073_Jog_Z.extax.eax_c>n_A073_JogMaxZ AND jp_A073_Jog_Z.extax.eax_c<n_A073_JogMinZ b_A073_JogOk_R12:=TRUE;
            !
            ! Give robot state to controller
            WaitSyncTask id_A073_JogRob_State,tl_A073_CtrlRob;
            !
            ! Wait for controller state
            WaitSyncTask id_A073_JogCTRL_State,tl_A073_CtrlRob;
            !
            ! Check if movment is doable
            IF b_A073_JogOk_CTRL=TRUE THEN
                !
                ! Do movement
                MoveAbsJ jp_A073_Jog_Z\ID:=idn_A073_Jog_Z_Neg\NoEOffs,v_A073_Act,z_A073_Act,tCurrent;
            ELSE
                !
                ! Movment not okay
            ENDIF
            !
            ! Sync loop
            WaitSyncTask id_A073_JogCTRL_Loop,tl_A073_CtrlRob;
        ENDWHILE
        !
        ! Wait until movmend finish
        WaitRob\InPos;
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_Z_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Jogging of Z-Axis
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_JogX()
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_X_Start,tl_A073_CtrlRob;
        !
        ! Read current position
        jp_A073_Jog_Z:=CJointT();
        !
        ! Set speed, distance and blend
        v_A073_Act:=v_A073_Jog_Z_Low;
        n_A073_Acc:=n_A073_Z_Acc;
        n_A073_Ramp:=n_A073_Z_Ramp;
        n_A073_ActStep:=n_A073_Z_MoveStepLow;
        z_A073_Act:=z1;
        !
        ! Acceleration update
        AccSet n_A073_Acc,n_A073_Ramp;
        !
        ! Jog loop
        WHILE b_A073_JogCTRL_Z_Pos=TRUE OR b_A073_JogCTRL_Z_Neg=TRUE DO
            !
            ! Positive movmend
            IF b_A073_JogCTRL_Z_Pos=TRUE jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c-n_A073_ActStep;
            !
            ! Negative movmend
            IF b_A073_JogCTRL_Z_Neg=TRUE jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c+n_A073_ActStep;
            !
            ! Reset robot okey state
            b_A073_JogOk_R12:=FALSE;
            !
            ! Check new move value
            IF jp_A073_Jog_Z.extax.eax_c>n_A073_JogMaxZ AND jp_A073_Jog_Z.extax.eax_c<n_A073_JogMinZ b_A073_JogOk_R12:=TRUE;
            !
            ! Give robot state to controller
            !WaitSyncTask id_A073_JogRob_State,tl_A073_CtrlRob;
            !
            ! Wait for controller state
            !WaitSyncTask id_A073_JogCTRL_State,tl_A073_CtrlRob;
            !
            ! Check if movment is doable
            IF b_A073_JogOk_CTRL=TRUE THEN
                !
                ! Do movement
                MoveAbsJ jp_A073_Jog_Z\ID:=idn_A073_Jog_Z_Neg\NoEOffs,v_A073_Act,z_A073_Act,tCurrent;
            ELSE
                !
                ! Movment not okay
            ENDIF
            !
            ! Sync loop
            !WaitSyncTask id_A073_JogCTRL_Loop,tl_A073_CtrlRob;
        ENDWHILE
        !
        ! Wait until movmend finish
        WaitRob\InPos;
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_X_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC


ENDMODULE