MODULE A083_Instructions
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A083 Augmented-Timber
    !
    ! FUNCTION    :  Inclouds all project specific instructions
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.01.20
    !
    ! Copyright   :  ETH Zürich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Gripper open
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_GripperOpen(\switch NoFeedback)
        !
        ! Read string value
        st_RRC_StringValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! Read float value
        n_RRC_FloatValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        !
        ! Placehoder for your Code
        TPErase;
        TPWrite "Gripper Open";
        WaitTime\InPos,2.0;
        !
        IF NOT Present(NoFeedback) THEN
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
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper close
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_GripperClose(\switch NoFeedback)
        !
        ! Read string value
        st_RRC_StringValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! Read float value
        n_RRC_FloatValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        !
        ! Placehoder for your Code
        TPErase;
        TPWrite "Gripper Close";
        WaitTime 2.0;
        !
        IF NOT Present(NoFeedback) THEN
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
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     RAPID Pick Demo fuer Aurelé
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_Rapid_Pick_Demo()
        !
        ! Move to home position
        MoveL p_A083_Home,v100,z100,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Move over pick
        MoveL Offs(p_A083_Pick,0,0,50),v50,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Open gripper
        r_A083_GripperOpen\NoFeedback;
        !
        ! Move to pick pos
        MoveL p_A083_Pick,v10,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        Stop;
        !
        ! Close gripper
        r_A083_GripperClose\NoFeedback;
        !
        ! Move up
        MoveL Offs(p_A083_Pick,0,0,50),v10,z50,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Back to home
        MoveL p_A083_Home,v100,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
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
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
    
     !************************************************
    ! Function    :     Activate soft move
    ! Programmer  :     Ananya Kango
    ! Date        :     2025.04.26
    !***************** ETH Zurich *******************
    !
    PROC r_A083_ActSoftMove()
        VAR num nStiffness:=0;
        VAR num nStiffnessNonSoftDir:=0;
        VAR string stSoftDir:="Z";
        !
        ! Initialize parameters 
        nStiffness:=0;
        nStiffnessNonSoftDir:=50;
        stSoftDir:="Z";
        !
        ! Read stiffness parameters from rrc
        nStiffness:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        nStiffnessNonSoftDir:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V2;
        !
        ! Read soft direction from rrc
        stSoftDir:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! User message
        ! TPErase;
        TPWrite "Start activating soft move";
        !
        ! Activate selectet soft move
        TEST stSoftDir
        CASE "Z":
            !
            ! Z direction
            CSSAct CSS_Z\StiffnessNonSoftDir:=nStiffnessNonSoftDir\Stiffness:=nStiffness\AllowMove;
        CASE "XY":
            !
            ! XY plane
            CSSAct CSS_XY\StiffnessNonSoftDir:=nStiffnessNonSoftDir\Stiffness:=nStiffness\AllowMove;
        CASE "XYZ":
            !
            ! XYZ all linear directions (but no rotational)
            CSSAct CSS_XYZ\StiffnessNonSoftDir:=nStiffnessNonSoftDir\Stiffness:=nStiffness\AllowMove;
        CASE "XYRZ":
            !
            ! XYZ all linear directions (but no rotational)
            CSSAct CSS_XYRZ\StiffnessNonSoftDir:=nStiffnessNonSoftDir\Stiffness:=nStiffness\AllowMove;
        DEFAULT:
        ENDTEST
        !
        ! User message
        TPWrite "Soft move activated";
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Soft move activ."+"Direction:"+stSoftDir+" Stiffness: "+NumToStr(nStiffness,2)+" None direction: "+NumToStr(nStiffnessNonSoftDir,2);
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Cenerate feedback
            TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
            CASE 1:
                !
                ! Instruction done 
                r_RRC_FDone;
            DEFAULT:
                !
                ! Feedback not supported  
                r_RRC_FError;
            ENDTEST
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Deactivate soft move
    ! Programmer  :     Ananya Kango
    ! Date        :     2025.04.26
    !***************** ETH Zurich *******************
    !
    PROC r_A083_DeactSoftMove()
        VAR robtarget pX:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
        !
        ! User message
        ! TPErase;
        TPWrite "Start deactivating soft move";
        !
        ! Make sure that the robot is not moving
        WaitRob\ZeroSpeed;
        !
        ! Read current position 
        pX:=CRobT(\Tool:=t_RRC_Act,\WObj:=ob_RRC_Act);
        pX.trans.z:=pX.trans.z+0.1;
        !
        ! Deactivate soft move
        !CSSDeactMoveL pX,v10,t_RRC_Act\WObj:=ob_RRC_Act;
        !
        ! Deactivate soft move with a non moving command 
        CSSDeact;
        !
        ! User message
        TPWrite "Soft move deactivated";
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Soft move deactiv";
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Cenerate feedback
            TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
            CASE 1:
                !
                ! Instruction done 
                r_RRC_FDone;
            DEFAULT:
                !
                ! Feedback not supported  
                r_RRC_FError;
            ENDTEST
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE