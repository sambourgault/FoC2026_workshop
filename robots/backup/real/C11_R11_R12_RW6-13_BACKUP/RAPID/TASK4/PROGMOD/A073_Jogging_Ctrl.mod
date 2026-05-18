MODULE A073_Jogging_Ctrl
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
                IF b_A073_Jog_Z_Pos=TRUE OR b_A073_Jog_Z_Neg=TRUE THEN
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
            ! Not in synchron mode, user message
            btr_A073_Answer:=UIMessageBox(
                \Header:=st_a073_MsgHeader
                \MsgArray:=["Gantry is not in synchronization.","Use standard jogging procedure from ABB with the Joystick.","","",""]
                \BtnArray:=["Ok"]
                \Icon:=iconInfo);
            !
            ! Deactivate jogging mode
            b_A073_Jogging:=FALSE;
            st_A073_Modus:="";
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
        ! Set controller jog Z
        IF b_A073_Jog_Z_Pos=TRUE b_A073_JogCTRL_Z_Pos:=TRUE;
        IF b_A073_Jog_Z_Neg=TRUE b_A073_JogCTRL_Z_Neg:=TRUE;
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_Z_Start,tl_A073_CtrlRob;
        !
        ! Loop for positive movmend
        WHILE b_A073_JogCTRL_Z_Pos=TRUE OR b_A073_JogCTRL_Z_Neg=TRUE DO
            !
            ! Reset controller jogging okey state
            b_A073_JogOk_CTRL:=FALSE;
            !
            ! Wait for robot states
            WaitSyncTask id_A073_JogRob_State,tl_A073_CtrlRob;
            !
            ! Check movment state of robots
            IF b_A073_JogOk_R11=TRUE AND b_A073_JogOk_R12=TRUE THEN
                !
                ! Movment posible
                b_A073_JogOk_CTRL:=TRUE;
            ELSE
                !
                ! Movment not possible
                btr_A073_Answer:=UIMessageBox(
                \Header:=st_a073_MsgHeader
                \MsgArray:=["Jog Z Limit","Change direction.","","",""]
                \BtnArray:=["Ok"]
                \Icon:=iconInfo);
            ENDIF
            !
            ! Give controller state to robots
            WaitSyncTask id_A073_JogCTRL_State,tl_A073_CtrlRob;
            !
            ! Update jog state
            b_A073_JogCTRL_Z_Pos:=FALSE;
            b_A073_JogCTRL_Z_Neg:=FALSE;
            !
            ! Set controller jog
            IF b_A073_Jog_Z_Pos=TRUE b_A073_JogCTRL_Z_Pos:=TRUE;
            IF b_A073_Jog_Z_Neg=TRUE b_A073_JogCTRL_Z_Neg:=TRUE;
            !
            ! Sync loop
            WaitSyncTask id_A073_JogCTRL_Loop,tl_A073_CtrlRob;
        ENDWHILE
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
        ! Set controller jog Z
        IF b_A073_Jog_Z_Pos=TRUE b_A073_JogCTRL_Z_Pos:=TRUE;
        IF b_A073_Jog_Z_Neg=TRUE b_A073_JogCTRL_Z_Neg:=TRUE;
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_X_Start,tl_A073_CtrlRob;
        !
        ! Loop for positive movmend
        WHILE b_A073_JogCTRL_Z_Pos=TRUE OR b_A073_JogCTRL_Z_Neg=TRUE DO
            !
            ! Reset controller jogging okey state
            b_A073_JogOk_CTRL:=FALSE;
            !
            ! Wait for robot states
            !WaitSyncTask id_A073_JogRob_State,tl_A073_CtrlRob;
            !
            ! Check movment state of robots
            IF b_A073_JogOk_R11=TRUE AND b_A073_JogOk_R12=TRUE THEN
                !
                ! Movment posible
                b_A073_JogOk_CTRL:=TRUE;
            ELSE
                !
                ! Movment not possible
                btr_A073_Answer:=UIMessageBox(
                \Header:=st_a073_MsgHeader
                \MsgArray:=["Jog Z Limit","Change direction.","","",""]
                \BtnArray:=["Ok"]
                \Icon:=iconInfo);
            ENDIF
            !
            ! Give controller state to robots
            !WaitSyncTask id_A073_JogCTRL_State,tl_A073_CtrlRob;
            !
            ! Update jog state
            b_A073_JogCTRL_Z_Pos:=FALSE;
            b_A073_JogCTRL_Z_Neg:=FALSE;
            !
            ! Set controller jog
            IF b_A073_Jog_Z_Pos=TRUE b_A073_JogCTRL_Z_Pos:=TRUE;
            IF b_A073_Jog_Z_Neg=TRUE b_A073_JogCTRL_Z_Neg:=TRUE;
            !
            ! Sync loop
            !WaitSyncTask id_A073_JogCTRL_Loop,tl_A073_CtrlRob;
        ENDWHILE
        !
        ! Synchronisation
        WaitSyncTask id_A073_Jog_X_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC
ENDMODULE