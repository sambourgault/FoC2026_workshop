MODULE A067_Instruction
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A067 Integral Timber Joints
    !
    ! FUNCTION    :  Main and Control Modul 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2019.11.29
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Deactivate soft servo
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.07.31
    !***************** ETH Zurich *******************
    !
    PROC r_A067_DeactSoftServo()
        VAR jointtarget jpX:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
        !
        ! User message with current values
        ! TPErase;
        TPWrite "Soft Servo Off";
        !
        ! Make sure that the robot is not moving
        WaitRob\ZeroSpeed;
        !
        ! Read current position 
        jpX:=CJointT();
        !
        ! Move to position 
        MoveAbsJ jpX\NoEOffs,v100,fine,tool0\WObj:=wobj0;
        !
        ! Activate soft servo
        SoftDeact;
        !
        ! User message
        TPWrite "Soft Servo Off (Done)";
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Soft Servo passiv";
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
    ! Function    :     Activate soft servo
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.07.31
    !***************** ETH Zurich *******************
    !
    PROC r_A067_ActSoftServo()
        !
        ! User message with current values
        ! TPErase;
        TPWrite "Soft Servo On";
        !
        ! Activate soft servo
        SoftAct 1,10\Ramp:=100;
        SoftAct 2,10\Ramp:=100;
        SoftAct 3,10\Ramp:=100;
        SoftAct 4,10\Ramp:=100;
        SoftAct 5,20\Ramp:=100;
        SoftAct 6,80\Ramp:=100;
        !
        ! Event log for robot studio output
        r_RRC_EvLogMsg "A067","Soft Servo activ";
        TPWrite "Soft Servo On (OK)";
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
    ! Function    :     Activate soft move
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.08.24
    !***************** ETH Zurich *******************
    !
    PROC r_A067_ActSoftMove()
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
        r_RRC_EvLogMsg "A067","Soft move activ."+"Direction:"+stSoftDir+" Stiffness: "+NumToStr(nStiffness,2) +" None direction: "+NumToStr(nStiffnessNonSoftDir,2);
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
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.08.24
    !***************** ETH Zurich *******************
    !
    PROC r_A067_DeactSoftMove()
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
        ! Deactivate soft move with a non moving command (by Victor)
        CSSDeact;
        !
        ! User message
        TPWrite "Soft move deactivated";
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Soft move activ";
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
    ! Function    :     Teachpendant plotting
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.08.24
    !***************** ETH Zurich *******************
    !
    PROC r_A067_TPPlot()
        !
        ! Read Text 
        st_RRC_TPWrite:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! Show message to user 
        TPWrite st_RRC_TPWrite;
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
    ! Function    :     Teachpendant erase
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2020.08.24
    !***************** ETH Zurich *******************
    !
    PROC r_A067_TPErase()
        !
        ! Clear panel 
        TPErase;
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