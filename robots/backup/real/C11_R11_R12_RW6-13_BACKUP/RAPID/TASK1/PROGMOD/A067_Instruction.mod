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
    ! Function    :     Grip load
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2021.03.10
    !***************** ETH Zurich *******************
    !
    PROC r_A067_GripLoad()
        VAR string stLoaddata;
        VAR string stMass;
        VAR string stCog{3};
        VAR string stAom{4};
        VAR string stInertia{3};
        !
        ! Mass
        ld_A067_ActLoad.mass:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        stMass:=NumToStr(ld_A067_ActLoad.mass,1);
        !
        ! Center of gravity
        ld_A067_ActLoad.cog.x:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V2;
        ld_A067_ActLoad.cog.y:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V3;
        ld_A067_ActLoad.cog.z:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V4;
        stCog{1}:=NumToStr(ld_A067_ActLoad.cog.x,1);
        stCog{2}:=NumToStr(ld_A067_ActLoad.cog.y,1);
        stCog{3}:=NumToStr(ld_A067_ActLoad.cog.z,1);
        !
        ! Axes of moment
        ld_A067_ActLoad.aom.q1:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V5;
        ld_A067_ActLoad.aom.q2:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V6;
        ld_A067_ActLoad.aom.q3:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V7;
        ld_A067_ActLoad.aom.q4:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V8;
        stAom{1}:=NumToStr(ld_A067_ActLoad.aom.q1,3);
        stAom{2}:=NumToStr(ld_A067_ActLoad.aom.q2,3);
        stAom{3}:=NumToStr(ld_A067_ActLoad.aom.q3,3);
        stAom{4}:=NumToStr(ld_A067_ActLoad.aom.q4,3);
        !
        ! Inertia
        ld_A067_ActLoad.ix:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V9;
        ld_A067_ActLoad.iy:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V10;
        ld_A067_ActLoad.iz:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V11;
        stInertia{1}:=NumToStr(ld_A067_ActLoad.ix,1);
        stInertia{2}:=NumToStr(ld_A067_ActLoad.iy,1);
        stInertia{3}:=NumToStr(ld_A067_ActLoad.iz,1);
        !
        ! Update grip load
        GripLoad ld_A067_ActLoad;
        !
        ! Create loaddata string
        stLoaddata:="["+stMass+",["+stCog{1}+","+stCog{2}+","+stCog{3}+"],["+stAom{1}+","+stAom{2}+","+stAom{3}+","+stAom{4}+"],["+stInertia{1}+","+stInertia{2}+","+stInertia{3}+"]"+"]";
        !
        ! Event log for robot studio output
        ! r_RRC_EvLogMsg "A067","GripLoad = "+stLoaddata;
        r_RRC_EvLogMsg "A067","GripLoad, new mass = "+stMass;
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! feedback
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
    ! Function    :     Grip unload
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2021.03.10
    !***************** ETH Zurich *******************
    !
    PROC r_A067_GripUnload()
        !
        ! Update grip load
        GripLoad load0;
        !
        ! Event log for robot studio output
        r_RRC_EvLogMsg "A067","GripUnload";
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! feedback
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
        MoveAbsJ jpX\NoEOffs,v5,fine,tool0\WObj:=wobj0;
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
        SoftAct 1,100\Ramp:=100;
        SoftAct 2,50\Ramp:=100;
        SoftAct 3,50\Ramp:=100;
        SoftAct 4,100\Ramp:=100;
        SoftAct 5,100\Ramp:=100;
        SoftAct 6,100\Ramp:=100;
        !
        ! Event log for robot studio output
        r_RRC_EvLogMsg "A067","Soft Servo activ";
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

    !************************************************
    ! Function    :     Stop
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2021.03.23
    !***************** ETH Zurich *******************
    !
    PROC r_A067_Stop()
        !
        ! Stop task
        Stop\NoRegain;
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
    ! Function    :     Start the Interrupt handshak
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.12
    !***************** ETH Zurich *******************
    !
    TRAP tr_A067_IntStart
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Interrupt started";
        !
        ! Set signal interupt done
        SetDO do_A067_InterruptDone,1;
        ! 
        ! Connect Interuppts End
        IDelete in_A067_IntEnd;
        CONNECT in_A067_IntEnd WITH tr_A067_IntEnd;
        ISignalDO\SingleSafe,do_A067_Interrupt,0,in_A067_IntEnd;
        !
        ! ToDo: 
        ! More funtions:
        ! - Skip one move instruction
        ! - Skip instructions
        !
        ! Clear path on 
        r_A067_ClearPathOn;
        
        RETURN ;
    ENDTRAP

    !************************************************
    ! Function    :     End the Interrupt handshak
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.12
    !***************** ETH Zurich *******************
    !
    TRAP tr_A067_IntEnd
        !
        ! Clear path off 
        r_A067_ClearPathOff;
        !
        ! Set signal interupt done
        SetDO do_A067_InterruptDone,0;
        ! 
        ! Connect Interuppts Start
        IDelete in_A067_IntStart;
        CONNECT in_A067_IntStart WITH tr_A067_IntStart;
        ISignalDO\SingleSafe,do_A067_Interrupt,1,in_A067_IntStart;
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Interrupt finished";
        RETURN ;

    ENDTRAP

    !************************************************
    ! Function    :     Clear path on 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.14
    !***************** ETH Zurich *******************
    !
    PROC r_A067_ClearPathOn()
        !
        ! Stop movmend
        StopMove;
        !
        ! Clear path
        ClearPath;
        !
        ! Set clear path flag 
        b_A067_ClearPath:=TRUE;
        !
        ! Reactivate movment
        IF IsStopMoveAct(\FromMoveTask) StartMove;
        !
        ! Create error clear path
        RAISE er_A067_ClearPath;
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Clear Path on for "+st_RRC_Taskname;
        RETURN ;
    ERROR
        !
        ! Propagate the current error to the calling routine
        RAISE ;
    ENDPROC

    !************************************************
    ! Function    :     Clear path off 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.14
    !***************** ETH Zurich *******************
    !
    PROC r_A067_ClearPathOff()
        !
        ! Reset clear path flag 
        b_A067_ClearPath:=FALSE;
        !
        ! Event log for robot studio output        
        r_RRC_EvLogMsg "A067","Clear Path off for "+st_RRC_Taskname;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE