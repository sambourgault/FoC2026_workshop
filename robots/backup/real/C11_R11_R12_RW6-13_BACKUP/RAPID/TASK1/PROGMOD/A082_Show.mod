MODULE A082_Show
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A082 Latthammer
    !
    ! FUNCTION    :  Show modul includes the routines for the show
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.11.08
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A082_Setup:=FALSE;
    TASK PERS bool b_A082_Nail:=TRUE;
    TASK PERS bool b_A082_Show:=TRUE;
    TASK PERS bool b_A082_Park:=TRUE;
    TASK PERS bool b_A082_Tool:=TRUE;
    TASK PERS bool b_A082_PlaceNails:=TRUE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    ! Offset place to hit robot axis
    CONST num n_A082_OffsAx1:=0;
    CONST num n_A082_OffsAx2:=1.37;
    CONST num n_A082_OffsAx3:=-2.78;
    CONST num n_A082_OffsAx4:=0;
    CONST num n_A082_OffsAx5:=-1.51;
    CONST num n_A082_OffsAx6:=0;
    !
    ! Offset place to hit gantry axis
    CONST num n_A082_OffsExAx1:=-15;
    CONST num n_A082_OffsExAx2:=0;
    CONST num n_A082_OffsExAx3:=-46;
    !
    TASK PERS num n_A082_NailQuntity:=3;
    TASK PERS num n_A082_NailPlaceOffs:=70;
    TASK PERS num n_A082_NailPlaceCounter:=3;
    !
    TASK PERS num n_A082_NailStrikesMed:=6;
    TASK PERS num n_A082_NailStrikes:=1;
    TASK PERS num n_A082_StrikeEnd:=1;

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A082_Latthammer:=[TRUE,[[61.6065,0.815157,437.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_Latthammer_Tip:=[TRUE,[[-109.715,-9.83317,415.978],[0,-0.707107,0,0.707107]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A082_FirstNailPosition:=[[0.000245813,24.9944,-0.000388853,180,25.0007,0.00227823],[9485.06,-1836.53,-2089.65,0,0,0]];
    TASK PERS jointtarget jp_A082_CurrentNail:=[[0.000245813,26.3644,-2.78039,180,23.4907,0.00227823],[9470.06,-1906.53,-2105.65,0,0,0]];
    TASK PERS jointtarget jp_A082_Collision:=[[0.00294965,26.0321,-2.69071,180,21.2301,2.62762],[19586.7,-1955.49,-2075.83,0,0,0]];
    TASK PERS jointtarget jp_A082_Current:=[[3.12231E-05,-72.9999,72.9997,0.000192529,-0.000236193,0.000325877],[9485.06,-1906.53,-4850,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    ! Zukunftstag
    ! CONST robtarget p_A082_ShowNail_1:=[[505.11,725.52,184.87],[0.000298471,0.706911,0.707302,-0.000100075],[0,2,1,0],[19601.7,-1885.49,-2400,0,0,0]];
    ! CONST robtarget p_A082_ShowNail_2:=[[653.79,724.05,184.10],[0.000298559,0.706914,0.7073,-9.94915E-05],[0,2,1,0],[19601.7,-1885.49,-2400,0,0,0]];
    ! CONST robtarget p_A082_ShowNail_3:=[[954.85,725.52,183.91],[0.000299004,0.706914,0.707299,-9.94827E-05],[-1,1,2,0],[19601.7,-1885.49,-2400,0,0,0]];
    ! CONST robtarget p_A082_ShowNail_4:=[[1105.34,727.32,183.20],[0.000294767,0.706911,0.707302,-9.83344E-05],[-1,1,2,0],[19601.7,-1885.49,-2400,0,0,0]];
    !
    ! dfab Familyday
    CONST robtarget p_A082_ShowNail_1:=[[505.11,725.52,184.87],[0.000298471,0.706911,0.707302,-0.000100075],[0,2,1,0],[9485.06,-1906.53,-2400,0,0,0]];
    CONST robtarget p_A082_ShowNail_2:=[[653.79,724.05,184.10],[0.000298559,0.706914,0.7073,-9.94915E-05],[0,2,1,0],[9485.06,-1906.53,-2400,0,0,0]];
    CONST robtarget p_A082_ShowNail_3:=[[954.85,725.52,183.91],[0.000299004,0.706914,0.707299,-9.94827E-05],[-1,1,2,0],[9485.06,-1906.53,-2400,0,0,0]];
    CONST robtarget p_A082_ShowNail_4:=[[1105.34,727.32,183.20],[0.000294767,0.706911,0.707302,-9.83344E-05],[-1,1,2,0],[9485.06,-1906.53,-2400,0,0,0]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A082_ShowMax:=[1000,500,1000,1];
    TASK PERS speeddata v_A082_ShowMed:=[500,500,500,1];
    TASK PERS speeddata v_A082_ShowMin:=[250,500,250,1];

    !************************************************
    ! Declaration :     zonedata
    !************************************************
    !

    !************************************************
    ! Function    :     Nail show
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_NialShow()
        !
        ! Write user message
        TPErase;
        TPWrite "Unmount Tool! ";
        Stop;
        !
        ! Park robot if needed
        IF b_A082_Park rSysH_ToPark;
        Stop;
        !
        ! Set tool
        tAct:=f_RFL_ToolOS(t_A082_Latthammer,vt_A082_Latthammer);
        !
        ! Tool mounting
        IF b_A082_Tool=TRUE AND b_A082_Setup=FALSE THEN
            !
            ! Read current position
            jp_A082_Current:=CJointT();
            !
            ! Move Gantry XY to home
            jp_A082_Current.extax.eax_a:=jp_A082_Home.extax.eax_a;
            jp_A082_Current.extax.eax_b:=jp_A082_Home.extax.eax_b;
            MoveAbsJ jp_A082_Current,v_A082_ShowMax,z200,tAct;
            !
            ! Move to nail load position
            MoveAbsJ jp_A082_Home,v_A082_ShowMed,fine,tAct;
            !
            ! Write user message
            TPErase;
            TPWrite "Mount Tool! ";
            !
            ! Stop task to feed a nail
            Stop\AllMoveTasks;
        ENDIF
        !
        ! Learn first nail position if setup is active
        IF b_A082_Setup r_A082_LearnFirstNailPosition;
        !
        ! Place nails
        IF b_A082_Nail AND b_A082_PlaceNails r_A082_PlaceNails65;
        !
        ! Presnet robot show
        IF b_A082_Show=TRUE THEN
            !
            ! Move to nail load position
            MoveAbsJ jp_A082_Home,v100,z100,tAct;
            !
            ! 1. Target nail head
            r_A082_TargetNailHead 2;
            !
            ! Move to nail load position
            MoveAbsJ jp_A082_Home,v200,z50,tAct;
            !
            ! 2. Tool turn
            r_A082_Show_2_ToolTurn;
            IF b_A082_Nail r_A082_HitNail_65_Low(1);
            !
            ! 3. Axis 1 move
            r_A082_Show_3_Axis1;
            IF b_A082_Nail r_A082_HitNail_65_Med(3);
            !
            ! 4. Latthammer tip
            r_A082_Show_4_LatHamTip;
            IF b_A082_Nail r_A082_HitNail_65_InOne(2);
        ENDIF
        !
        ! Move to nail load position
        MoveAbsJ jp_A082_Home,v200,fine,tAct;
        !
        ! Reactivate nail placing
        b_A082_PlaceNails:=TRUE;
        !
        ! Finish
        Stop;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Learn the first nail place position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_LearnFirstNailPosition()
        !
        ! Deactivate external offsets
        EOffsOff;
        !
        ! Move to possible home position with current gantry position
        jp_A082_Current:=CJointT();
        jp_A082_Current.robax:=jp_A082_Home.robax;
        jp_A082_Current.extax.eax_b:=jp_A082_Home.extax.eax_b;
        jp_A082_Current.extax.eax_c:=jp_A082_Home.extax.eax_c;
        MoveAbsJ jp_A082_Current,v200,fine,tAct;
        !
        ! Define new load position
        ! MoveAbsJ jp_A082_Home,v200,fine,tAct; Maybe not needed
        !
        ! Clear teach pendant output
        TPErase;
        !
        ! Write user message
        TPWrite "Inserart a Nail in the Lathammer and";
        TPWrite "move manually with Gantry to the first";
        TPWrite "nail location!";
        !
        ! Stop task to feed a nail
        Stop\NoRegain;
        !
        ! Workobject ob_A082_Table needs to be updated !
        ! Show pos p_A082_ShowNail_1-4 external vaules need to be updated ! 
        !
        ! Learn current location
        jp_A082_FirstNailPosition:=CJointT();
        !
        ! Move up to finish the procedure
        EOffsSet [0,0,-10,0,0,0];
        MoveAbsJ jp_A082_FirstNailPosition,v20,fine,tAct;
        EOffsOff;
        !
        ! Update Home position
        jp_A082_Home.extax.eax_a:=jp_A082_FirstNailPosition.extax.eax_a;
        jp_A082_Home.extax.eax_b:=jp_A082_FirstNailPosition.extax.eax_b-n_A082_NailPlaceOffsY;
        !
        ! Clear teach pendant output
        TPErase;
        !
        ! Setup done
        b_A082_Setup:=FALSE;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Place a nails with 65mm length in soft wood
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_PlaceNails65()
        !
        ! Overgive first place position
        jp_A082_CurrentNail:=jp_A082_FirstNailPosition;
        !
        ! Reset counter
        n_A082_NailPlaceCounter:=0;
        !
        ! Placing loop
        WHILE n_A082_NailPlaceCounter<n_A082_NailQuntity DO
            !
            ! Increase nail placements
            Incr n_A082_NailPlaceCounter;
            !
            ! Move to nail load position
            MoveAbsJ jp_A082_Home,v200,fine,tAct\WObj:=obAct;
            !
            ! Write user message
            TPErase;
            TPWrite "Load Nail: "\Num:=n_A082_NailPlaceCounter;
            !
            ! Stop task to feed a nail
            Stop\AllMoveTasks;
            !
            ! Activate motion supervision
            MotionSup\On;
            !
            ! Move over place location
            EOffsSet [0,0,-10,0,0,0];
            MoveAbsJ jp_A082_CurrentNail,v100,fine,tAct;
            !
            ! Push nail in until collision detection or finial place position
            EOffsSet [0,0,25,0,0,0];
            MoveAbsJ jp_A082_CurrentNail,v10,fine,tAct;
            !
            ! Smooth motion wiht lower acceleration ramp
            AccSet 100,25;
            !
            ! Move up and release force from nail
            EOffsSet [0,0,7,0,0,0];
            MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedLow,z1,tAct;
            !
            ! Move away to release the nail
            EOffsSet [-15,0,7,0,0,0];
            MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedHigh,z5,tAct;
            !
            ! Move up over nail head
            EOffsSet [-15,0,-50,0,0,0];
            MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedHigh,z5,tAct;
            !
            ! Deactivat offset for external axis
            EOffsOff;
            !
            ! Define next nail position
            jp_A082_CurrentNail.extax.eax_b:=jp_A082_CurrentNail.extax.eax_b-(n_A082_NailPlaceOffs);
        ENDWHILE
        !
        ! Nails placed
        b_A082_PlaceNails:=FALSE;
        !
        ! Move to nail load position
        MoveAbsJ jp_A082_Home,v200,fine,tAct;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Hit nail 65mm with medium strength
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_HitNail_65_Med(num nPlace)
        !
        ! Target nail head
        r_A082_TargetNailHead nPlace;
        !
        ! Initialize naili position
        n_A082_NailStrikes:=0;
        n_A082_StrikeEnd:=6;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=225;
        !
        ! Nail loop
        WHILE n_A082_StrikeEnd>n_A082_NailStrikes DO
            !
            ! Count hammer strikes
            Incr n_A082_NailStrikes;
            !
            ! Event log message with current target nail position
            r_RFL_EvLogMsg st_A082_EvLogMsgHeader,"Strike number: "+NumToStr(n_A082_NailStrikes,0);
            !
            ! Retract
            jp_A082_Retract:=jp_A082_CurrentNail;
            jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+15;
            jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+15;
            jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-75;
            MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
            !
            ! Strike with overshoot
            jp_A082_Overshoot:=jp_A082_CurrentNail;
            jp_A082_Overshoot.robax.rax_2:=jp_A082_Overshoot.robax.rax_2-0.5;
            jp_A082_Overshoot.robax.rax_3:=jp_A082_Overshoot.robax.rax_3-0.05;
            jp_A082_Overshoot.robax.rax_5:=jp_A082_Overshoot.robax.rax_5+3.15;
            jp_A082_Overshoot.extax.eax_c:=jp_A082_Overshoot.extax.eax_c+9;
            MoveAbsJ jp_A082_Overshoot,v_A082_HitSpeed,z20,tAct;
            !
            ! Update current z hight
            jp_A082_CurrentNail.extax.eax_c:=jp_A082_Overshoot.extax.eax_c;
        ENDWHILE
        !
        ! Retract
        jp_A082_Retract:=jp_A082_CurrentNail;
        jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+5;
        jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+5;
        jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-25;
        MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
        RETURN ;
    ERROR
        !
        ! Errorhandler for collision dedection
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Handle error collision
            r_A082_ErrCollStop;
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Hit nail 65mm with low strength
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_HitNail_65_Low(num nPlace)
        !
        ! Target nail head
        r_A082_TargetNailHead nPlace;
        !
        ! Initialize naili position
        n_A082_NailStrikes:=0;
        n_A082_StrikeEnd:=11;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=200;
        !
        ! Nail loop
        WHILE n_A082_StrikeEnd>n_A082_NailStrikes DO
            !
            ! Count hammer strikes
            Incr n_A082_NailStrikes;
            !
            ! Event log message with current target nail position
            r_RFL_EvLogMsg st_A082_EvLogMsgHeader,"Strike number: "+NumToStr(n_A082_NailStrikes,0);
            !
            ! Retract
            jp_A082_Retract:=jp_A082_CurrentNail;
            jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+7.5;
            jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+7.5;
            jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-50;
            MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
            !
            ! Strike with overshoot
            jp_A082_Overshoot:=jp_A082_CurrentNail;
            jp_A082_Overshoot.robax.rax_2:=jp_A082_Overshoot.robax.rax_2-0.3;
            jp_A082_Overshoot.robax.rax_3:=jp_A082_Overshoot.robax.rax_3-0.025;
            jp_A082_Overshoot.robax.rax_5:=jp_A082_Overshoot.robax.rax_5+3;
            jp_A082_Overshoot.extax.eax_c:=jp_A082_Overshoot.extax.eax_c+5;
            MoveAbsJ jp_A082_Overshoot,v_A082_HitSpeed,z20,tAct;
            !
            ! Update current z hight
            jp_A082_CurrentNail.extax.eax_c:=jp_A082_Overshoot.extax.eax_c;
        ENDWHILE
        !
        ! Retract
        jp_A082_Retract:=jp_A082_CurrentNail;
        jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+5;
        jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+5;
        jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-25;
        MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
        RETURN ;
    ERROR
        !
        ! Errorhandler for collision dedection
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Handle error collision
            r_A082_ErrCollStop;
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Hit nail 65mm in one strike
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_HitNail_65_InOne(num nPlace)
        !
        ! Target nail head
        r_A082_TargetNailHead nPlace;
        !
        ! Initialize naili position
        n_A082_NailStrikes:=0;
        n_A082_StrikeEnd:=1;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=250;
        !
        ! Nail loop
        WHILE n_A082_StrikeEnd>n_A082_NailStrikes DO
            !
            ! Count hammer strikes
            Incr n_A082_NailStrikes;
            !
            ! Event log message with current target nail position
            r_RFL_EvLogMsg st_A082_EvLogMsgHeader,"Strike number: "+NumToStr(n_A082_NailStrikes,0);
            !
            ! Retract
            jp_A082_Retract:=jp_A082_CurrentNail;
            jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+20;
            jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+20;
            jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-100;
            MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
            !
            ! Strike with overshoot
            jp_A082_Overshoot:=jp_A082_CurrentNail;
            jp_A082_Overshoot.robax.rax_2:=jp_A082_Overshoot.robax.rax_2-0.75;
            jp_A082_Overshoot.robax.rax_3:=jp_A082_Overshoot.robax.rax_3-0.35;
            jp_A082_Overshoot.robax.rax_5:=jp_A082_Overshoot.robax.rax_5+6;
            jp_A082_Overshoot.extax.eax_c:=jp_A082_Overshoot.extax.eax_c+30;
            MoveAbsJ jp_A082_Overshoot,v_A082_HitSpeed,z20,tAct;
            !
            ! Update current z hight
            jp_A082_CurrentNail.extax.eax_c:=jp_A082_Overshoot.extax.eax_c;
        ENDWHILE
        !
        ! Retract
        jp_A082_Retract:=jp_A082_CurrentNail;
        jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+5;
        jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+5;
        jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-25;
        MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct;
        RETURN ;
    ERROR
        !
        ! Errorhandler for collision dedection
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Handle error collision
            r_A082_ErrCollStop;
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Hit nail 65mm slow with many hits
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TargetNailHead(num nPlace)
        !
        ! Read origin
        jp_A082_CurrentNail:=jp_A082_FirstNailPosition;
        !
        ! Calculate hit position for robot
        jp_A082_CurrentNail.robax.rax_1:=jp_A082_CurrentNail.robax.rax_1+n_A082_OffsAx1;
        jp_A082_CurrentNail.robax.rax_2:=jp_A082_CurrentNail.robax.rax_2+n_A082_OffsAx2;
        jp_A082_CurrentNail.robax.rax_3:=jp_A082_CurrentNail.robax.rax_3+n_A082_OffsAx3;
        jp_A082_CurrentNail.robax.rax_4:=jp_A082_CurrentNail.robax.rax_4+n_A082_OffsAx4;
        jp_A082_CurrentNail.robax.rax_5:=jp_A082_CurrentNail.robax.rax_5+n_A082_OffsAx5;
        jp_A082_CurrentNail.robax.rax_6:=jp_A082_CurrentNail.robax.rax_6+n_A082_OffsAx6;
        !
        ! Calculate hit position for gantry
        jp_A082_CurrentNail.extax.eax_a:=jp_A082_CurrentNail.extax.eax_a+n_A082_OffsExAx1;
        jp_A082_CurrentNail.extax.eax_b:=jp_A082_CurrentNail.extax.eax_b+n_A082_OffsExAx2-((nPlace-1)*n_A082_NailPlaceOffs);
        jp_A082_CurrentNail.extax.eax_c:=jp_A082_CurrentNail.extax.eax_c+n_A082_OffsExAx3;
        !
        ! Activate motion supervision
        MotionSup\On;
        !
        ! Move over nail head
        EOffsSet [0,0,-2,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v150,fine,tAct;
        !
        ! Deactivat offset for external axis
        EOffsOff;
        RETURN ;
    ERROR
        !
        ! Errorhandler for collision dedection
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Handle error collision
            r_A082_ErrCollStop;
        ENDIF
    ENDPROC


    !************************************************
    ! Function    :     Hit nail 65mm slow with many hits
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_ErrCollStop()
        !
        ! Clear current path
        ClearPath;
        !
        ! Write user message
        TPErase;
        TPWrite "Collision error!";
        TPWrite "Collision detection off.";
        !
        ! Deactivate motion supervision
        MotionSup\Off;
        !
        ! Continue without collision detection
        StartMove;
        !
        ! Store current position
        jp_A082_Collision:=CJointT();
        !
        ! Move up
        EOffsSet [0,0,-100,0,0,0];
        MoveAbsJ jp_A082_Collision,v50,fine,tAct;
        EOffsOff;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=300;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Show Tool Turn
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_Show_2_ToolTurn()
        !
        ! Read current position
        jpCurrent:=jp_A082_Home;
        !
        ! Move
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6+270;
        MoveAbsJ jpCurrent,v_A082_ShowMax,z50,tAct;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6-270;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6-270;
        MoveAbsJ jpCurrent,v_A082_ShowMax,z50,tAct;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6+270;
        MoveAbsJ jpCurrent,v_A082_ShowMax,z50,tAct;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Show Axis 1
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_Show_3_Axis1()
        !
        ! Read current position
        jpCurrent:=jp_A082_Home;
        !
        ! Move
        jpCurrent.robax.rax_1:=jpCurrent.robax.rax_1+7.5;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6+180;
        MoveAbsJ jpCurrent,v_A082_ShowMax,fine,tAct;
        WaitTime 0.5;
        jpCurrent.robax.rax_1:=jpCurrent.robax.rax_1-7.5;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6-180;
        MoveAbsJ jpCurrent,v_A082_ShowMax,z0,tAct;
        jpCurrent.robax.rax_1:=jpCurrent.robax.rax_1-7.5;
        jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6-180;
        MoveAbsJ jpCurrent,v_A082_ShowMax,fine,tAct;
        WaitTime 0.5;
        !jpCurrent.robax.rax_1:=jpCurrent.robax.rax_1+7.5;
        !jpCurrent.robax.rax_6:=jpCurrent.robax.rax_6+180;
        !MoveAbsJ jpCurrent,v_A082_ShowMax,z0,tAct;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Show Latthammer tip
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.11.08
    !***************** ETH Zürich *******************
    !
    PROC r_A082_Show_4_LatHamTip()
        VAR num nAirCap;
        VAR num nWaitTime;
        !
        ! Set tool and work object
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Tip,vt_A082_Latthammer_Tip);
        obAct:=f_RFL_WobjOS(ob_A082_Table,vob_A082_Table);
        !
        ! Lift work object up for safety
        obAct.oframe.trans.z:=obAct.oframe.trans.z+0.5;
        !
        nAirCap:=5;
        nWaitTime:=1.0;
        !
        !        Stop;
        !        MoveJ [[799.60,793.54,411.35],[0.000298028,0.706914,0.7073,-0.000102151],[-1,1,1,0],[19601.7,-1885.49,-2400,0,0,0]],v1000,z50,tAct\WObj:=obAct;
        !        MoveL [[505.11,725.52,184.87],[0.000298471,0.706911,0.707302,-0.000100075],[0,2,1,0],[19601.7,-1885.49,-2400,0,0,0]],v1000,z50,tAct\WObj:=obAct;
        !        MoveL [[653.79,724.05,184.10],[0.000298559,0.706914,0.7073,-9.94915E-05],[0,2,1,0],[19601.7,-1885.49,-2400,0,0,0]],v1000,z50,tAct\WObj:=obAct;
        !        MoveL [[954.85,725.52,183.91],[0.000299004,0.706914,0.707299,-9.94827E-05],[-1,1,2,0],[19601.7,-1885.49,-2400,0,0,0]],v1000,z50,tAct\WObj:=obAct;
        !        MoveL [[1105.34,727.32,183.20],[0.000294767,0.706911,0.707302,-9.83344E-05],[-1,1,2,0],[19601.7,-1885.49,-2400,0,0,0]],v1000,z50,tAct\WObj:=obAct;
        !
        !
        ! 1.
        MoveJ p_A082_ShowNail_1,v_A082_ShowMax,fine,tAct\WObj:=obAct;
        MoveL Offs(p_A082_ShowNail_1,0,0,nAirCap),v_A082_ShowMax,z0,tAct\WObj:=obAct;
        !
        ! 4.
        MoveL Offs(p_A082_ShowNail_4,0,0,nAirCap),v_A082_ShowMax,z0,tAct\WObj:=obAct;
        MoveL p_A082_ShowNail_4,v_A082_ShowMax,fine,tAct\WObj:=obAct;
        WaitTime nWaitTime;
        MoveL Offs(p_A082_ShowNail_4,0,0,nAirCap),v_A082_ShowMax,z0,tAct\WObj:=obAct;
        !
        ! 2.
        MoveL Offs(p_A082_ShowNail_2,0,0,nAirCap),v_A082_ShowMax,z0,tAct\WObj:=obAct;
        MoveL p_A082_ShowNail_2,v_A082_ShowMax,fine,tAct\WObj:=obAct;
        WaitTime nWaitTime;
        MoveL Offs(p_A082_ShowNail_2,0,0,nAirCap),v_A082_ShowMax,z0,tAct\WObj:=obAct;
        !
        AccSet 25,10;
        ! 3.
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMed,z0,tAct\WObj:=obAct;
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMin,z0,tAct\WObj:=obAct;
        EOffsSet [0,-750,0,0,0,0];
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMin,z0,tAct\WObj:=obAct;
        EOffsSet [0,750,0,0,0,0];
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMin,z0,tAct\WObj:=obAct;
        EOffsOff;
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMin,z0,tAct\WObj:=obAct;
        MoveL Offs(p_A082_ShowNail_3,0,0,nAirCap),v_A082_ShowMed,z0,tAct\WObj:=obAct;
        !
        AccSet 100,100;
        !
        ! Move to nail load position
        MoveAbsJ jp_A082_Home,v_A082_ShowMin,fine,tAct;
        RETURN ;
    ERROR
        !
        ! Errorhandler for collision dedection
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Handle error collision
            r_A082_ErrCollStop;
        ENDIF
    ENDPROC
ENDMODULE