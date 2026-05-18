MODULE A073_Instruction_R12
	PERS tooldata t_A073_Trowel:=[TRUE,[[5.40169,101.105,323.072],[0.92388,-0.382683,0,0]],[0.1,[2.5,10,50],[1,0,0,0],0,0,0]];
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
    ! Function    :     Pick tool
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.07.14
    !***************** ETH Zürich *******************
    !
    PROC r_A073_PickTool()
        !
        ! Move to pick position jointtarget
        MoveAbsJ jp_A073_PickTool\NoEOffs,v1000,fine,tool0\WObj:=wobj0;
        !
        ! Move to pick position robtarget
        MoveL p_A073_PickTool,v100,fine,tool0\WObj:=wobj0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Follow Gantry 11 synchron with MoveAbsJ and multi move
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.09
    !***************** ETH Zurich *******************
    !
    PROC r_A073_FollowGantry()
        !
        ! Check if synchronization is on
        IF IsSyncMoveOn()=TRUE THEN
            !
            ! Synchronize tasks
            WaitSyncTask id_A073_MoveGantrySync,tl_A073_Gantry;

            !
            ! Set robot axis
            jp_RRC_Act.robax:=rj_A073_RobotStandby;
            !
            ! Set external axis
            jp_RRC_Act.extax.eax_a:=n_A073_ActGantrySyncX;
            jp_RRC_Act.extax.eax_b:=n_A073_ActGantrySyncY+n_A073_CarrierOffs;
            jp_RRC_Act.extax.eax_c:=n_A073_ActGantrySyncZ+n_A073_ZAxisCalib;
            jp_RRC_Act.extax.eax_d:=0;
            jp_RRC_Act.extax.eax_e:=0;
            jp_RRC_Act.extax.eax_f:=0;
            !
            ! Set tcp speed
            r_RRC_RasTCPSpeed n_A073_ActGantrySyncSpeed;
            !
            ! Set zone
            r_RRC_RasZone n_A073_ActGantrySyncZone;
            !
            ! Increase identity number
            Incr idn_A073_SyncID;
            !
            ! Move synchronized
            MoveAbsJ jp_RRC_Act\ID:=idn_A073_SyncID,v_RRC_Act,z_RRC_Act,t_RRC_Act;
        ELSE
            !
            ! Synchronization is missing, user messae in other task
        ENDIF
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                DEFAULT:
                    !
                    ! Not defined
                    !
                    ! Feedback not supported
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ENDPROC

ENDMODULE