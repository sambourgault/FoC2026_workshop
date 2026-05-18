MODULE A073_Instruction_Rob11
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
    ! Function    :     Get Gantry position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.17
    !***************** ETH Zurich *******************
    !
    PROC r_A073_GantryPos()
        !
        ! Read actual jointtartet
        r_RRC_ReadActJointT;
        !
        ! Read external axis and add tool calibration values
        r_RRC_FAddValue jp_RRC_Act.extax.eax_a+n_A073_ToolCalibX;
        r_RRC_FAddValue jp_RRC_Act.extax.eax_b*(-1)-n_A073_ToolCalibY;
        r_RRC_FAddValue jp_RRC_Act.extax.eax_c*(-1)-n_A073_ToolCalibZ;
        !
        ! Add standard feedback instruction done
        r_RRC_FDone;
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
            !
            ! Check additional feedback
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
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Move Gantry 11 and 12 synchron with a MoveAbsJ and multi move
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.09
    !***************** ETH Zurich *******************
    !
    PROC r_A073_MoveGantrySync()
        !
        ! Check if synchronization is on
        IF IsSyncMoveOn()=TRUE THEN
            !
            ! Share data
            n_A073_ActGantrySyncX:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1-n_A073_ToolCalibX;
            n_A073_ActGantrySyncY:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V2*(-1)-n_A073_ToolCalibY;
            n_A073_ActGantrySyncZ:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V3*(-1)-n_A073_ToolCalibZ;
            n_A073_ActGantrySyncSpeed:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V4;
            n_A073_ActGantrySyncZone:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V5;
            !
            ! Senety check for y value
            b_A073_Y_ValueNotOk:=FALSE;
            !IF n_A073_ActGantrySyncY<nMinValueY b_A073_Y_ValueNotOk:=TRUE;
            !IF n_A073_ActGantrySyncY>nMaxValueY b_A073_Y_ValueNotOk:=TRUE;

            !IF b_A073_Y_ValueNotOk=FALSE THEN

            !
            ! Synchronize tasks
            WaitSyncTask id_A073_MoveGantrySync,tl_A073_Gantry;
            !
            ! Set robot axis
            jp_RRC_Act.robax:=rj_A073_RobotStandby;
            !
            ! Set external axis
            jp_RRC_Act.extax.eax_a:=n_A073_ActGantrySyncX;
            jp_RRC_Act.extax.eax_b:=n_A073_ActGantrySyncY;
            jp_RRC_Act.extax.eax_c:=n_A073_ActGantrySyncZ;
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
            ! User message synchronization is missing
            btr_A073_Answer:=UIMessageBox(
                \Header:=st_a073_MsgHeader
                \MsgArray:=["Gantry is not in synchronization.","Action (r_A073_MoveGantrySync) is skiped.","","",""]
                \BtnArray:=["Ok"]
                \Icon:=iconWarning);
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


    !************************************************
    ! Function    :     Move Gantry 11 and 12 synchron with a MoveAbsJ and multi move and use Robot 11 for action
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.08.09
    !***************** ETH Zurich *******************
    !
    PROC r_A073_MoveGantrySyncAndUseR11()
        !
        ! Check if synchronization is on
        IF IsSyncMoveOn()=TRUE THEN
            !
            ! Read and set robot axis
            jp_RRC_Act.robax.rax_1:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
            jp_RRC_Act.robax.rax_2:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V2;
            jp_RRC_Act.robax.rax_3:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V3;
            jp_RRC_Act.robax.rax_4:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V4;
            jp_RRC_Act.robax.rax_5:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V5;
            jp_RRC_Act.robax.rax_6:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V6;
            !
            ! Share data
            n_A073_ActGantrySyncX:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V7;
            n_A073_ActGantrySyncY:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V8;
            n_A073_ActGantrySyncZ:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V9;
            n_A073_ActGantrySyncSpeed:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V10;
            n_A073_ActGantrySyncZone:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V11;
            !
            ! Synchronize tasks
            WaitSyncTask id_A073_MoveGantrySync,tl_A073_Gantry;
            !
            ! Set external axis
            jp_RRC_Act.extax.eax_a:=n_A073_ActGantrySyncX;
            jp_RRC_Act.extax.eax_b:=n_A073_ActGantrySyncY;
            jp_RRC_Act.extax.eax_c:=n_A073_ActGantrySyncZ;
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
            ! User message synchronization is missing
            btr_A073_Answer:=UIMessageBox(
                \Header:=st_a073_MsgHeader
                \MsgArray:=["Gantry is not in synchronization.","Action (r_A073_MoveGantrySync) is skiped.","","",""]
                \BtnArray:=["Ok"]
                \Icon:=iconWarning);
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