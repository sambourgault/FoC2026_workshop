MODULE RFL_TC_T7
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  RFL Toolchanger Tool 7 = PDS Spindle
    !
    ! FUNCTION    :  Inclouds all tool changer featuers
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2017.09.28 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2017
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    LOCAL PERS bool b_Tc12_T7_TestLoopOn:=TRUE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    CONST num nTime_Tc12_T7_SpAirOn:=0.5;
    CONST num nTime_Tc12_T7_SpindleTakeCtr:=0.5;
    !CONST num nTime_Tc12_T7_SpindleOn:=3;
    CONST num nTime_Tc12_T7_SpindleOn:=2;
    !CONST num nTime_Tc12_T7_SpindleOff:=8;
    CONST num nTime_Tc12_T7_SpindleOff:=2;
    !
    LOCAL PERS num n_Tc12_T7_OffsZ:=200;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    CONST string st_Tc12_T7_MsgHeader:="TC12 Tool 7";
    CONST string st_Tc12_T7_Unit:="PNetTcT7";

    !************************************************
    ! Declaration :     loaddata
    !************************************************
    !
    TASK PERS loaddata ld_Tc12_T7:=[20,[0,0,30],[1,0,0,0],0,0,0];

    !************************************************
    ! Declaration :     signaldi
    !************************************************
    !

    !************************************************
    ! Declaration :     signaldo
    !************************************************
    !
    VAR signaldo do_Tc12_T7SpAirOn;

    !************************************************
    ! Declaration :     smsg
    !************************************************
    !
    LOCAL CONST smsg smsgT7SpOn:=["PDS Spindle","Press Go to start the spindle.","Or exit the program with program stop and PP-Main.","","","","Go","x.jpg"];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    LOCAL PERS robtarget p_TcT7_TesInt_10:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    LOCAL PERS robtarget p_TcT7_TesInt_20:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     intnum
    !************************************************
    !
    VAR intnum ir_Tc12_T7_SpindleOverheat;
    VAR intnum ir_Tc12_T7_SpindleDriveError;

    !************************************************
    ! Function    :     Connect alias signals 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_ConAliSig()
        !
        ! Outputs
        AliasIO doTc12Valve1A,do_Tc12_T7SpAirOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Connect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Disconnect alias signals
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_DisconAliSig()
        !
        ! Outputs
        AliasIOReset do_Tc12_T7SpAirOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Spindle Air on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_SpAirOn()
        !
        ! Set Signals
        SetDO do_Tc12_T7SpAirOn,1;
        !
        ! Time for action
        WaitTime nTime_Tc12_T7_SpAirOn;
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Spindle air on done";
        RETURN ;
    ERROR
        !
        ! Try next when alis not connectet
        IF ERRNO=ERR_NO_ALIASIO_DEF TPWrite "Spindle signal not connected!";
        r_RFL_ProgError;
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Spindle on
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_SpindleOn()
        !
        ! Check for IOUnit
        IF f_RFL_CheckIOUnitReady(st_Tc12_T7_Unit) THEN
            !
            ! IOUnit ready 
            !
            ! Check spindle drive ready 
            WaitDI diTcT7DrReady,1,\Visualize\Header:="Waiting for signal"\MsgArray:=["Movement will not start until","the condition below is TRUE"]\Icon:=iconError;
            !
            ! User safety message befor speed up
            r_RFL_SMsg smsgT7SpOn;
            !
            ! Take controll from spindel drive
            SetDo doTcT7DrSpRCtrOn,1;
            !
            ! Reaction time for drive
            WaitTime nTime_Tc12_T7_SpindleTakeCtr;
            !
            ! Wait until robot has reached his position 
            WaitRob\InPos;
            !
            ! Set Signals
            SetDO doTcT7DrSpBwdOn,0;
            SetDO doTcT7DrSpFwdOn,1;
            !
            ! Activate trap routines 
            IWatch ir_Tc12_T7_SpindleOverheat;
            IWatch ir_Tc12_T7_SpindleDriveError;
            ! 
            ! User message
            rTPMsg "Spindel start, acceleration phase";
            !
            ! Time for action
            WaitTime\InPos,nTime_Tc12_T1GripOn;
            !
            ! Clear user message
            TPErase;
        ENDIF
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Spindle on done";
        RETURN ;
    ERROR
        ! 
        ! Placeholder 
    ENDPROC

    !************************************************
    ! Function    :     Spindle off
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_SpindleOff()
        !
        ! Check for IOUnit
        IF f_RFL_CheckIOUnitReady(st_Tc12_T7_Unit) THEN
            !
            ! Take controll from spindel drive
            SetDo doTcT7DrSpRCtrOn,1;
            !
            ! Deactivate trap routines 
            ISleep ir_Tc12_T7_SpindleOverheat;
            ISleep ir_Tc12_T7_SpindleDriveError;
            !
            ! Set Signals
            SetDO doTcT7DrSpBwdOn,0;
            SetDO doTcT7DrSpFwdOn,0;
            ! 
            ! User message
            rTPMsg "Spindle Stop, deceleration phase";
            !
            ! Time for action
            WaitTime nTime_Tc12_T7_SpindleOff;
            !
            ! Clear user message
            TPErase;
            !
            ! Release controll from spindel drive
            SetDO doTcT7DrSpRCtrOn,0;
        ENDIF
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Spindle off done";
        RETURN ;
    ERROR
        ! 
        ! Placeholder 
    ENDPROC

    !************************************************
    ! Function    :     Reset Tool 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    ! **************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_ResTool()
        !
        ! Function
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Reset tool done";
        RETURN ;
    ERROR
        !
        ! Placeholder
    ENDPROC

    !************************************************
    ! Function    :     Initialize Interrupt Routines
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_InitInt()
        !
        ! Check for IOUnit
        IF f_RFL_CheckIOUnitReady(st_Tc12_T7_Unit) THEN
            !
            ! Check input signal
            WaitDI diTcT7DrReady,1,\Visualize\Header:="Waiting for signal"\MsgArray:=["Movement will not start until","the condition below is TRUE"]\Icon:=iconError;
            !
            ! Initialize Spindle Overheat and set it in sleep mode
            IDelete ir_Tc12_T7_SpindleOverheat;
            CONNECT ir_Tc12_T7_SpindleOverheat WITH tr_Tc12_T7_SpError;
            ISignalDI diTcT7DrReady,0,ir_Tc12_T7_SpindleOverheat;
            !
            ! Deactivate trape until us
            ISleep ir_Tc12_T7_SpindleOverheat;
            !
            ! Check input signal
            WaitDI diTcT7SpTemReg,1,\Visualize\Header:="Waiting for signal"\MsgArray:=["Movement will not start until","the condition below is TRUE"]\Icon:=iconError;
            !
            ! Initialize Spindle Drive Error 
            IDelete ir_Tc12_T7_SpindleDriveError;
            CONNECT ir_Tc12_T7_SpindleDriveError WITH tr_Tc12_T7_SpError;
            ISignalDI diTcT7SpTemReg,0,ir_Tc12_T7_SpindleDriveError;
            !
            ! Deactivate trape until us
            ISleep ir_Tc12_T7_SpindleDriveError;
        ENDIF
        !
        ! Log Msg 
        rLogMsg st_Tc12_T7_MsgHeader,"Disonnect alias signals done";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Trap Routine Spindle Error
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.27
    !***************** ETH Zurich *******************
    !
    TRAP tr_Tc12_T7_SpError
        VAR string stMsg;
        !
        ! Initialize
        !
        ! Stop robot motion 
        StopMove;
        !
        ! Stop spindle
        r_Tc12_T7_SpindleOff;
        ! 
        ! Set User Message
        IF diTcT7DrReady=0 THEN
            !
            ! Drive Error 
            stMsg:="Spindle Drive Error, Robot has stopped, restart with PP-Main!";
        ELSEIF diTcT7SpTemReg=0 THEN
            !
            ! Spindel Overheat
            stMsg:="Spindle Overheat Error, Robot has stopped, restart with PP-Main!";
        ELSE
            !
            ! Default message
            stMsg:="Spindle Error, Robot has stopped, restart with PP-Main!";
        ENDIF
        !
        ! User message 
        nAnswer:=UIMessageBox(
            \Header:=st_Tc12_T7_MsgHeader
            \Message:=stMsg
            \Buttons:=btnOK
            \Icon:=iconError);
    ENDTRAP

    !************************************************
    ! Function    :     Trap Routine Spindle Error
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.08.28
    !***************** ETH Zurich *******************
    !
    PROC r_Tc12_T7_TestInterrupts()
        !
        ! Read current position
        rReadPosTemp;
        !
        ! Activate spindle
        r_Tc12_T7_SpindleOn;
        !
        ! Test loop
        WHILE b_Tc12_T7_TestLoopOn=TRUE DO
            !
            ! Move with Offset Up
            MoveL Offs(pTemp,0,0,n_Tc12_T7_OffsZ),vSysHMed,z50,tool0\WObj:=wobj0;
            !
            ! Move back to start position 
            MoveL pTemp,vSysHMed,z50,tool0\WObj:=wobj0;
        ENDWHILE
        !
        ! Deactivate spindle
        r_Tc12_T7_SpindleOff;
        !
        ! End of test
        Stop\AllMoveTasks;
    ENDPROC
ENDMODULE