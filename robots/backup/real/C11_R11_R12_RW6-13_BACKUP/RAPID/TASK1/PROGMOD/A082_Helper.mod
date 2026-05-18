MODULE A082_Helper
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
    ! FUNCTION    :  Helper modul for any project related tests 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.10.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A082_BeamHight:=100;
    TASK PERS num n_A082_NailLength:=80;
    TASK PERS num n_A082_PlaceDeep:=40;
    TASK PERS num n_A082_HitPoint:=10;
    TASK PERS num n_A082_HitDistance:=50;
    TASK PERS num n_A082_HitStep:=5;
    TASK PERS num n_A082_HitAngle:=0;
    TASK PERS num n_A082_HitCorY:=2;
    TASK PERS num n_A082_LatthammerNailHolderOffs:=42;
    TASK PERS num n_A082_CalibLatNailHeadPosX:=1;
    TASK PERS num n_A082_CalibLatNailHeadPosY:=-3;
    TASK PERS num n_A082_CalibLatNailHeadPosZ:=13;
    TASK PERS num n_A082_CalibLatTipNailHeadPosX:=2;
    TASK PERS num n_A082_CalibLatTipNailHeadPosY:=-9;
    TASK PERS num n_A082_CalibLatTipNailHeadPosZ:=25;
    TASK PERS num n_A082_NailPlaceOffsX:=0;
    TASK PERS num n_A082_NailPlaceOffsY:=70;

    TASK PERS num n_A082_HitStepZ:=10;

    TASK PERS num n_A082_MotSupTuning:=200;

    ! 
    TASK PERS num n_A082_AxisSoftness:=0;
    TASK PERS num n_A082_AxisSoftnessRamp:=100;

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    ! TASK PERS tooldata t_A082_Latthammer:=[TRUE,[[61.6065,0.815157,437.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    ! TASK PERS tooldata t_A082_Latthammer_Tip:=[TRUE,[[-108.976,-10.2186,416.603],[0,-0.707106781,0,0.707106781]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_Latthammer_Nail_Head:=[TRUE,[[18.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_Latthammer_Nail_Tip:=[TRUE,[[98.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_Latthammer_Nail_65:=[TRUE,[[83.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_Latthammer_Nail_80:=[TRUE,[[98.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A082_LoadId:=[TRUE,[[98.9691,-0.120957,449.5],[0.707107,0,0.707107,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    !
    TASK PERS tooldata vt_A082_Latthammer:=[TRUE,[[59.9965,-0.004843,345.97],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata vt_A082_Latthammer_Nail_Head:=[TRUE,[[18.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata vt_A082_Latthammer_Tip:=[TRUE,[[-99.996,-8.9986,318.993],[0,-0.707106781,0,0.707106781]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata vt_A082_Latthammer_Nail_Tip:=[TRUE,[[97.9991,-0.000957,356.54],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata vt_A082_Latthammer_Nail_65:=[TRUE,[[83.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata vt_A082_Latthammer_Nail_80:=[TRUE,[[98.9691,-0.120957,449.5],[0.707106781,0,0.707106781,0]],[4.9,[-22.9,-60.6,225.1],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    ! Zunkunftstag
    ! TASK PERS wobjdata ob_A082_Table:=[FALSE,TRUE,"",[[22756.4,1144.21,769.945],[0.707882,0.000977027,-0.000811009,0.706329]],[[-50,-50,0],[1,0,0,0]]];
    !
    ! dfab Familyday 
    TASK PERS wobjdata ob_A082_Table:=[FALSE,TRUE,"",[[12634.2,1167.24,774.518],[0.707374,-0.00233245,-0.000786433,0.706835]],[[-65,-52,-1],[1,0,0,0]]];
    TASK PERS wobjdata vob_A082_Table:=[FALSE,TRUE,"",[[22762.854418116,1154.23035723,780.038875746],[0.707882285,0.000977027,-0.000811009,0.706329284]],[[-50,-50,100],[1,0,0,0]]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A082_Home:=[[0,25,0,180,25,0],[9485.06,-1906.53,-2400,0,0,0]];
    TASK PERS jointtarget jp_A082_LoadIdHome:=[[0,25,0,180,25,0],[19000,-2575,-3400,0,0,0]];

    TASK PERS jointtarget jp_A082_Back:=[[0,33,27,180,-30,0],[20150,-1575,-2400,0,0,0]];
    TASK PERS jointtarget jp_A082_Hit:=[[0,25,-16,180,10,0],[20150,-1575,-2400,0,0,0]];

    ! Position the robot with a nail in lathammer on the origin position (first nail) to setup the place origin 
    TASK PERS jointtarget jp_A082_PlaceOrigin:=[[0,30,-10,180,20,0],[19470,-1470,-2127,0,0,0]];

    ! Position the robot with a with the lathammer on the hit position (first nail) to setup the hit origin  
    TASK PERS jointtarget jp_A082_HitOrigin:=[[0,31.37,-12.78,180,18.49,0],[19455,-1470,-2177,0,0,0]];

    TASK PERS jointtarget jp_A082_Retract:=[[0.000245813,31.3644,2.21961,180,-1.5093,0.00227823],[9470.06,-1906.53,-2105.65,0,0,0]];
    TASK PERS jointtarget jp_A082_Overshoot:=[[0.000245813,25.6144,-3.13039,180,29.4907,0.00227823],[9470.06,-1906.53,-2105.65,0,0,0]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_A082_NailPosition:=[[430,100,0],[0,0.707106781,0.707106781,0],[-1,2,0,0],[20150,-1575,-2400,0,0,0]];
    TASK PERS robtarget p_A082_CollisionTest:=[[434.38,271.46,58.08],[6.27702E-05,0.707103,0.707111,-2.37963E-05],[0,2,-1,0],[20150,-1575,-2400,0,0,0]];
    !
    CONST robtarget p_A082_CollisionPoint:=[[555,775,-40],[0.000461338,0.706929,0.707285,-1.59546E-05],[-1,2,0,0],[19500,-1650,-2400,0,0,0]];
    CONST robtarget p_A082_NailPosOrientation:=[[555,775,-40],[0.000461338,0.706929,0.707285,-1.59546E-05],[-1,2,0,0],[19500,-1650,-2400,0,0,0]];
    !
    TASK PERS robtarget p_A082_NailPos:=[[555,775,-40],[0.000461338,0.706929,0.707285,-1.59546E-05],[-1,2,0,0],[19500,-1650,-2400,0,0,0]];
    !
    TASK PERS robtarget p_A082_CurrentPos:=[[252.805,778.044,71.5934],[0.000348283,0.706943,0.70727,-6.24691E-05],[-1,2,0,0],[19470,-1350,-2122.99,0,0,0]];
    TASK PERS robtarget p_A082_NailHeadPos:=[[515.956,787.003,53.5718],[0.000541629,0.70693,0.707284,-4.76406E-05],[0,2,-1,0],[19500,-1650,-2400,0,0,0]];
    TASK PERS robtarget p_A082_NailHeadPosLat:=[[253.805,775.044,84.5934],[0.000348283,0.706943,0.70727,-6.24691E-05],[-1,2,0,0],[19470,-1350,-2122.99,0,0,0]];
    TASK PERS robtarget p_A082_NailHeadPosLatTip:=[[254.805,769.044,96.5934],[0.000348283,0.706943,0.70727,-6.24691E-05],[-1,2,0,0],[19470,-1350,-2122.99,0,0,0]];
    TASK PERS robtarget p_A082_HitPos:=[[550.87,780.99,53.06],[0.0359803,-0.705997,-0.706362,-0.036425],[0,2,-1,0],[19500,-1650,-2400,0,0,0]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A082_HitSpeed:=[8000,500,1000,1];
    TASK PERS speeddata v_A082_ReleaseSpeedLow:=[10,500,10,1];
    TASK PERS speeddata v_A082_ReleaseSpeedHigh:=[75,500,75,1];

    !************************************************
    ! Declaration :     zonedata
    !************************************************
    !
    TASK PERS zonedata z_A082_Zone:=[FALSE,400,600,600,60,60,60];

    !************************************************
    ! Function    :     Flexible Tests 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_Test()
        !
        ! Test setup (set tool, work object etc.) 
        r_A082_TestSetup;
        r_A082_PlaceNail_65;
        r_A082_TargetNail_65;
        r_A082_HitNail_65;
        !
        Stop;
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test setup
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestSetup()
        !
        ! Set accelerarion and ramp
        AccSet 100,100;
        !
        ! Set tool and work object 
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_Tip,vt_A082_Latthammer_Nail_Tip);
        obAct:=f_RFL_WobjOS(ob_A082_Table,vob_A082_Table);
        !
        ! Shift workobject plane to beam hight
        obAct.oframe.trans.z:=n_A082_BeamHight;
        !
        ! Move to load nail position
        MoveAbsJ jp_A082_Home\NoEOffs,v200,fine,tAct\WObj:=obAct;
        Stop;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Place a nail with 65mm length in the soft wood 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_PlaceNail_65()
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Set data
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_65,vt_A082_Latthammer_Nail_65);
        !
        ! Only to setup origin position 
        IF b_A082_Setup=TRUE THEN
            EOffsOff;
            n_A082_NailPlaceCounter:=0;
            Stop;
            MoveAbsJ jp_A082_PlaceOrigin,v100,fine,tAct\WObj:=obAct;
            Stop;
        ENDIF
        ! 
        ! Read start origin
        jp_A082_CurrentNail:=jp_A082_PlaceOrigin;
        !
        ! Define nail position
        jp_A082_CurrentNail.extax.eax_a:=jp_A082_CurrentNail.extax.eax_a-(n_A082_NailPlaceOffsX*n_A082_NailPlaceCounter);
        jp_A082_CurrentNail.extax.eax_b:=jp_A082_CurrentNail.extax.eax_b-(n_A082_NailPlaceOffsY*n_A082_NailPlaceCounter);
        jp_A082_CurrentNail.extax.eax_c:=jp_A082_CurrentNail.extax.eax_c;
        !
        ! Activate motion supervision
        MotionSup\On;
        !            
        ! Move over place location
        EOffsSet [0,0,-10,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v100,fine,tAct\WObj:=obAct;
        !
        ! Push nail in until collision detection or finial place position
        EOffsSet [0,0,25,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v10,fine,tAct\WObj:=obAct;
        !
        ! Increase nail placements 
        Incr n_A082_NailPlaceCounter;
        !
        ! Smooth motion wiht lower acceleration ramp
        AccSet 100,25;
        !
        ! Move up and release force from nail 
        EOffsSet [0,0,7,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedLow,z1,tAct\WObj:=obAct;
        !
        ! Move away to release the nail
        EOffsSet [-15,0,7,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedHigh,z5,tAct\WObj:=obAct;
        !
        ! Move up over nail head 
        EOffsSet [-15,0,-50,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedHigh,z5,tAct\WObj:=obAct;
        !
        ! Deactivat offset for external axis  
        EOffsOff;
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Clear current path
            ClearPath;
            !
            ! Deactivate motion supervision 
            MotionSup\Off;
            !
            ! Start motion again
            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Target to hit a nail with 65mm length in the soft wood
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TargetNail_65()
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Set data
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_65,vt_A082_Latthammer_Nail_65);
        !
        ! Only to setup origin position 
        IF b_A082_Setup=TRUE THEN
            Stop;
            MoveAbsJ jp_A082_HitOrigin,v100,fine,tAct\WObj:=obAct;
            Stop;
        ENDIF
        ! 
        ! Read start origin
        jp_A082_CurrentNail:=jp_A082_HitOrigin;
        !
        ! Define nail position
        jp_A082_CurrentNail.extax.eax_a:=jp_A082_CurrentNail.extax.eax_a-(n_A082_NailPlaceOffsX*(n_A082_NailPlaceCounter-1));
        jp_A082_CurrentNail.extax.eax_b:=jp_A082_CurrentNail.extax.eax_b-(n_A082_NailPlaceOffsY*(n_A082_NailPlaceCounter-1));
        jp_A082_CurrentNail.extax.eax_c:=jp_A082_CurrentNail.extax.eax_c;
        !
        ! Activate motion supervision
        MotionSup\On;
        !            
        ! Move over nail head
        EOffsSet [0,0,-10,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedHigh,fine,tAct\WObj:=obAct;
        !
        ! Move to nail head
        EOffsSet [0,0,0,0,0,0];
        MoveAbsJ jp_A082_CurrentNail,v_A082_ReleaseSpeedLow,fine,tAct\WObj:=obAct;
        !
        ! Deactivat offset for external axis  
        EOffsOff;
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Clear current path
            ClearPath;
            !
            ! Deactivate motion supervision 
            MotionSup\Off;
            !
            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Hit nail 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_HitNail_65()
        !
        ! Set data
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_65,vt_A082_Latthammer_Nail_65);
        !
        ! Only to setup origin position 
        IF b_A082_Setup=TRUE THEN
            Stop;
            MoveAbsJ jp_A082_HitOrigin,v100,fine,tAct\WObj:=obAct;
            Stop;
        ENDIF
        ! 
        ! Read start origin
        jp_A082_CurrentNail:=jp_A082_HitOrigin;
        !
        ! Define nail position
        jp_A082_CurrentNail.extax.eax_a:=jp_A082_CurrentNail.extax.eax_a-(n_A082_NailPlaceOffsX*(n_A082_NailPlaceCounter-1));
        jp_A082_CurrentNail.extax.eax_b:=jp_A082_CurrentNail.extax.eax_b-(n_A082_NailPlaceOffsY*(n_A082_NailPlaceCounter-1));
        jp_A082_CurrentNail.extax.eax_c:=jp_A082_CurrentNail.extax.eax_c;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=n_A082_MotSupTuning;
        !
        ! Full acceleration 
        AccSet 100,100;
        !
        ! Test loop
        FOR nColDeep FROM 10 TO 80 STEP n_A082_HitStepZ DO
            !
            TPWrite "Collision = ",\Num:=nColDeep;
            !            
            ! Retract
            jp_A082_Retract:=jp_A082_CurrentNail;
            jp_A082_Retract.robax.rax_2:=jp_A082_Retract.robax.rax_2+20;
            jp_A082_Retract.robax.rax_3:=jp_A082_Retract.robax.rax_3+20;
            jp_A082_Retract.robax.rax_5:=jp_A082_Retract.robax.rax_5-100;
            MoveAbsJ jp_A082_Retract,v_A082_HitSpeed,z200,tAct\WObj:=obAct;
            !
            ! Collision point 
            !*MoveAbsJ jp_A082_CurrentNail,v_A082_HitSpeed,z200,tAct\WObj:=obAct;
            !
            ! Overshoot  
            jp_A082_Overshoot:=jp_A082_CurrentNail;
            jp_A082_Overshoot.robax.rax_2:=jp_A082_Overshoot.robax.rax_2-0.5;
            jp_A082_Overshoot.robax.rax_3:=jp_A082_Overshoot.robax.rax_3-0;
            jp_A082_Overshoot.robax.rax_5:=jp_A082_Overshoot.robax.rax_5+2;
            jp_A082_Overshoot.extax.eax_c:=jp_A082_Overshoot.extax.eax_c+n_A082_HitStepZ;
            MoveAbsJ jp_A082_Overshoot,v_A082_HitSpeed,z20,tAct\WObj:=obAct;
            !
            ! Update current z hight
            jp_A082_CurrentNail.extax.eax_c:=jp_A082_Overshoot.extax.eax_c;
            !
        ENDFOR
        !            
        ! Final Retract
        MoveAbsJ jp_A082_Retract,v1000,z50,tAct\WObj:=obAct;
        !
        ! Deactivat offset for external axis  
        EOffsOff;
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !* StorePath;
            !* MoveL p1,v200,z10,tool\WObj:=wobj;
            !* RestoPath;
            ClearPath;
            MotionSup\Off;
            StartMove;
            !
            TPWrite "Error collision stop!";
            Stop;
        ENDIF
        TRYNEXT;
    ENDPROC

    PROC x()
        MoveL [[550.88,780.99,53.07],[0.000523564,0.706935,0.707279,-6.46581E-05],[0,2,-1,0],[19500,-1650,-2400,0,0,0]],v1000,z50,t_A082_Latthammer\WObj:=obAct;
        MoveL [[550.87,780.99,53.06],[0.0359803,-0.705997,-0.706362,-0.036425],[0,2,-1,0],[19500,-1650,-2400,0,0,0]],v1000,z50,t_A082_Latthammer\WObj:=obAct;
    ENDPROC


    !************************************************
    ! Function    :     Hit nail 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TeachShowNails()
        !
        ! Set tool and work object 
        tAct:=t_ABB_RFLTip;
        obAct:=f_RFL_WobjOS(ob_A082_Table,vob_A082_Table);
        MoveJ [[505.21,723.91,183.25],[0.195833,0.679697,0.679148,-0.196005],[0,2,-1,0],[19601.7,-1885.48,-2399.99,0,0,0]], v1000, z50, tAct\WObj:=obAct;
        MoveJ [[654.50,722.39,182.90],[0.195826,0.679701,0.679151,-0.195991],[0,2,-1,0],[19601.7,-1885.48,-2399.99,0,0,0]], v1000, z50, tAct\WObj:=obAct;
        MoveJ [[954.94,724.34,181.75],[0.195821,0.679699,0.679154,-0.195994],[-1,1,0,0],[19601.7,-1885.48,-2399.99,0,0,0]], v1000, z50, tAct\WObj:=obAct;
        MoveJ [[1105.13,725.23,181.52],[0.195831,0.679702,0.679147,-0.195998],[-1,1,0,0],[19601.7,-1885.48,-2399.99,0,0,0]], v1000, z50, tAct\WObj:=obAct;

        MoveL [[550.88,780.99,53.07],[0.000523564,0.706935,0.707279,-6.46581E-05],[0,2,-1,0],[19500,-1650,-2400,0,0,0]],v1000,z50,t_A082_Latthammer\WObj:=obAct;
        MoveL [[550.87,780.99,53.06],[0.0359803,-0.705997,-0.706362,-0.036425],[0,2,-1,0],[19500,-1650,-2400,0,0,0]],v1000,z50,t_A082_Latthammer\WObj:=obAct;
    ENDPROC


    !************************************************
    ! Function    :     Hit nail in one hit 65mm length  
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestHitNailInOnce_65()
        !
        ! Move to load nail position
        MoveAbsJ jp_A082_Home\NoEOffs,v200,fine,tAct\WObj:=obAct;
        !
        ! Activate motion supervision
        MotionSup\On;
        !
        ! Set tool and position
        tAct:=f_RFL_ToolOS(t_A082_Latthammer,vt_A082_Latthammer);
        p_A082_NailHeadPos:=p_A082_NailHeadPosLat;
        !
        ! Activate programm displacmend 
        PDispSet [[0,0,0],[1,0,0,0]];
        !
        ! Target nail 
        MoveJ Offs(p_A082_NailHeadPos,0,0,10),v200,fine,tAct\WObj:=obAct;
        MoveJ Offs(p_A082_NailHeadPos,0,0,0),v50,fine,tAct\WObj:=obAct;
        !
        ! Prepare strike
        MoveL Offs(p_A082_NailHeadPos,0,0,1600),v6000,z100,tAct\WObj:=obAct;
        MoveL Offs(p_A082_NailHeadPos,0,0,0),v6000,z100,tAct\WObj:=obAct;
        MoveL Offs(p_A082_NailHeadPos,0,0,-200),v6000,fine,tAct\WObj:=obAct;
        !
        ! Move to load nail position
        MoveAbsJ jp_A082_Home\NoEOffs,v200,fine,tAct\WObj:=obAct;
        !
        ! Deactivate programm displacmend 
        PDispOff;
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Clear current path
            ClearPath;
            !
            ! Deactivate motion supervision 
            MotionSup\Off;
            !
            !
            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Test soft servo funtionality 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_HitNail()
        !
        ! Set data
        tAct:=f_RFL_ToolOS(t_A082_Latthammer,vt_A082_Latthammer);
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Activate motion supervision
        MotionSup\On\TuneValue:=n_A082_MotSupTuning;
        !
        ! Test loop
        FOR nColDeep FROM -50 TO 150 STEP 10 DO
            !
            TPWrite "Collision = ",\Num:=nColDeep;
            !            
            ! Collision free 
            MoveL Offs(p_A082_HitPos,0,0,300),v5000,z50,tAct\WObj:=obAct;
            !
            ! Collision point 
            !MoveL p_A082_CollisionPoint,v1000,z50,tAct\WObj:=obAct;
            !
            ! Collision  
            MoveL Offs(p_A082_HitPos,0,0,-nColDeep),v5000,z0,tAct\WObj:=obAct;
            !
        ENDFOR
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !* StorePath;
            !* MoveL p1,v200,z10,tool\WObj:=wobj;
            !* RestoPath;
            ClearPath;
            MotionSup\Off;
            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Place a nail with 65mm length in the soft wood 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_PlaceNail_65_caresian()
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Set data
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_65,vt_A082_Latthammer_Nail_65);
        p_A082_NailPos:=p_A082_NailPosOrientation;
        !
        ! Define nail position
        p_A082_NailPos.trans.x:=425+(n_A082_NailPlaceOffsX*n_A082_NailPlaceCounter);
        p_A082_NailPos.trans.y:=790;
        p_A082_NailPos.trans.z:=0;
        !
        ! Activate motion supervision
        MotionSup\On;
        !            
        ! Move over place location 
        MoveL Offs(p_A082_NailPos,0,0,10),v100,fine,tAct\WObj:=obAct;
        !
        ! Push nail in until collision detection or finial place position
        MoveL Offs(p_A082_NailPos,0,0,-25),v10,fine,tAct\WObj:=obAct;
        !
        ! Increase nail placements 
        Incr n_A082_NailPlaceCounter;
        !
        ! Change tool
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_Head,vt_A082_Latthammer_Nail_Head);
        !
        ! Store current postion
        p_A082_CurrentPos:=CRobT(\Tool:=tAct\WObj:=obAct);
        !
        ! Store current position as inizial position for nail head position 
        p_A082_NailHeadPosLat:=p_A082_CurrentPos;
        p_A082_NailHeadPosLatTip:=p_A082_CurrentPos;
        ! 
        ! Adjust Latthammer nail position to real world conditions 
        p_A082_NailHeadPosLat.trans.x:=p_A082_NailHeadPosLat.trans.x+n_A082_CalibLatNailHeadPosX;
        p_A082_NailHeadPosLat.trans.y:=p_A082_NailHeadPosLat.trans.y+n_A082_CalibLatNailHeadPosY;
        p_A082_NailHeadPosLat.trans.z:=p_A082_NailHeadPosLat.trans.z+n_A082_CalibLatNailHeadPosZ;
        ! 
        ! Adjust Latthammer Tip nail position to real world conditions 
        p_A082_NailHeadPosLatTip.trans.x:=p_A082_NailHeadPosLatTip.trans.x+n_A082_CalibLatTipNailHeadPosX;
        p_A082_NailHeadPosLatTip.trans.y:=p_A082_NailHeadPosLatTip.trans.y+n_A082_CalibLatTipNailHeadPosY;
        p_A082_NailHeadPosLatTip.trans.z:=p_A082_NailHeadPosLatTip.trans.z+n_A082_CalibLatTipNailHeadPosZ;
        !
        ! Release nail 
        MoveL Offs(p_A082_CurrentPos,0,0,13),v10,fine,tAct\WObj:=obAct;
        MoveL Offs(p_A082_CurrentPos,0,15,13),v10,fine,tAct\WObj:=obAct;
        !
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Clear current path
            ClearPath;
            !
            ! Deactivate motion supervision 
            MotionSup\Off;
            !
            !


            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC




    !************************************************
    ! Function    :     Test Tool's  
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestTool()
        VAR num nTest;
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Reset test counter 
        nTest:=0;
        !
        ! Test loop 
        WHILE nTest<=2 DO
            !
            ! Move to load nail position
            MoveAbsJ jp_A082_Home\NoEOffs,v200,fine,tAct\WObj:=obAct;
            !
            ! Increase test counter
            Incr nTest;
            !
            ! 
            TEST nTest
            CASE 1:
                !
                ! Set tool and position
                tAct:=f_RFL_ToolOS(t_A082_Latthammer,vt_A082_Latthammer);
                p_A082_NailHeadPos:=p_A082_NailHeadPosLat;
            CASE 2:
                !
                ! Set tool and position
                tAct:=f_RFL_ToolOS(t_A082_Latthammer_Tip,t_A082_Latthammer_Tip);
                p_A082_NailHeadPos:=p_A082_NailHeadPosLatTip;
            DEFAULT:
            ENDTEST
            !
            ! 
            ConfL\Off;
            !
            ! Release nail 
            MoveL Offs(p_A082_NailHeadPos,0,0,10),v50,fine,tAct\WObj:=obAct;
            MoveL Offs(p_A082_NailHeadPos,0,0,0),v5,fine,tAct\WObj:=obAct;
            !
            Stop;
            !
            MoveL Offs(p_A082_NailHeadPos,0,0,10),v5,fine,tAct\WObj:=obAct;
            !
            ConfL\On;
        ENDWHILE

        !
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !
            ! Clear current path
            ClearPath;
            !
            ! Deactivate motion supervision 
            MotionSup\Off;
            !
            !


            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC


    !************************************************
    ! Function    :     Test soft servo funtionality 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestColDetAndZone()
        !
        ! Clear teach pandent output
        TPErase;
        !
        ! Activate motion supervision
        MotionSup\On;
        !
        ! Test loop
        FOR nColDeep FROM -5 TO 20 STEP 1 DO
            !
            TPWrite "Collision = ",\Num:=nColDeep;
            !            
            ! Collision free 
            MoveL Offs(p_A082_CollisionPoint,0,0,100),v100,fine,tAct\WObj:=obAct;
            !
            ! Collision point 
            !MoveL p_A082_CollisionPoint,v1000,z50,tAct\WObj:=obAct;
            !
            ! Collision  
            MoveL Offs(p_A082_CollisionPoint,0,0,-nColDeep),v100,fine,tAct\WObj:=obAct;
            !
        ENDFOR
        RETURN ;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !* StorePath;
            !* MoveL p1,v200,z10,tool\WObj:=wobj;
            !* RestoPath;
            ClearPath;
            MotionSup\Off;
            StartMove;
            !
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;
    ENDPROC

    !************************************************
    ! Function    :     Only to teach temporary positions 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TeachTempPos()
        MoveAbsJ [[0,25,0,180,25,0],[20150,-1575,-2400,0,0,0]]\NoEOffs,v1000,z50,t_A082_Latthammer\WObj:=ob_A082_Table;
    ENDPROC

    !************************************************
    ! Function    :     First test series 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_Test_1()
        !
        ! Set accelerarion and ramp
        AccSet 100,100;
        !
        ! Set tool and work object 
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_Tip,vt_A082_Latthammer_Nail_Tip);
        obAct:=f_RFL_WobjOS(ob_A082_Table,vob_A082_Table);
        !
        ! Shift workobject plane to beam hight
        obAct.oframe.trans.z:=n_A082_BeamHight;
        !
        ! Move to load nail position
        MoveAbsJ jp_A082_Home\NoEOffs,v200,fine,tAct\WObj:=obAct;

        !
        ! Move over nail position  
        MoveL Offs(p_A082_NailPosition,0,0,100),v200,fine,tAct\WObj:=obAct;
        !
        ! Move place nail  
        !MoveL Offs(p_A082_NailPosition,0,0,0),v10,z0,tAct\WObj:=obAct;
        MoveL Offs(p_A082_NailPosition,0,0,-n_A082_PlaceDeep),v2000,z0,tAct\WObj:=obAct;

        !WaitTime 0.50;

        MoveL Offs(p_A082_NailPosition,0,0,0),v5,z0,tAct\WObj:=obAct;
        MoveL Offs(p_A082_NailPosition,0,10,0),v5,z0,tAct\WObj:=obAct;
        MoveL Offs(p_A082_NailPosition,0,10,100),v50,fine,tAct\WObj:=obAct;
        Stop;
        !
        ! Change tool 
        tAct:=f_RFL_ToolOS(t_A082_Latthammer,vt_A082_Latthammer);
        !
        ! Set start for hit point
        n_A082_HitPoint:=n_A082_NailLength;

        WHILE n_A082_HitPoint>=0 DO

            n_A082_HitPoint:=n_A082_HitPoint-n_A082_HitStep;

            MoveL RelTool(Offs(p_A082_NailPosition,0,0,n_A082_HitPoint+n_A082_HitDistance),0,0,0\Ry:=n_A082_HitAngle),v_A082_HitSpeed,z0,tAct\WObj:=obAct;
            MoveL RelTool(Offs(p_A082_NailPosition,0,0,n_A082_HitPoint),0,0,0\Ry:=n_A082_HitAngle),v_A082_HitSpeed,z0,tAct\WObj:=obAct;
            MoveL RelTool(Offs(p_A082_NailPosition,0,n_A082_HitCorY,n_A082_HitPoint),0,0,0\Ry:=n_A082_HitAngle),v_A082_HitSpeed,z0,tAct\WObj:=obAct;


        ENDWHILE
        MoveL Offs(p_A082_NailPosition,0,10,100),v50,z0,tAct\WObj:=obAct;

        !
        ! Stop


        !
        ! Placehoder for Code
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test soft servo funtionality 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestSoftServo()
        VAR num nOffs;
        !
        ! Set collision offset
        nOffs:=80;
        TPErase;
        TPWrite "Offs = ",\Num:=nOffs;
        !
        ! Test loop
        FOR nOffs FROM 20 TO 70 STEP 5 DO
            !
            TPWrite "Offs = ",\Num:=nOffs;
            !
            ! Tune servos 
            !* TuneServo ROB_1,2,200;
            !* TuneServo ROB_1,3,50;
            !* TuneServo ROB_1,5,200;
            !
            ! Activate soft servo
            !* SoftAct 2,n_A082_AxisSoftness\Ramp:=n_A082_AxisSoftnessRamp;
            !* SoftAct 3,100;
            !* SoftAct 5,n_A082_AxisSoftness\Ramp:=n_A082_AxisSoftnessRamp;
            !
            ! Set collision offset
            EOffsSet [0,0,nOffs,0,0,0];
            !
            ! Execute motion 
            MoveAbsJ [[0.000331649,32.8478,27.4135,180,-30.661,-0.131389],[20150,-1575,-2400,0,0,0]],v7000,fine,tAct\WObj:=obAct;
            MoveAbsJ [[3.12231E-05,25,-15.9014,180,10.2691,-0.13134],[20150,-1575,-2400,0,0,0]],v7000,z100,tAct\WObj:=obAct;
            MoveAbsJ [[0.000331649,32.8478,27.4135,180,-30.661,-0.131389],[20150,-1575,-2400,0,0,0]],v7000,fine,tAct\WObj:=obAct;
            !
            ! Stop
            ! Stop;            
        ENDFOR
        EOffsOff;
        SoftDeact;
        TuneReset;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test for collision detection
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_TestCollision()
        !
        ! Set accelerarion and ramp
        AccSet 100,100;
        !
        ! Set tool and work object 
        tAct:=f_RFL_ToolOS(t_A082_Latthammer_Nail_Tip,vt_A082_Latthammer_Nail_Tip);
        obAct:=f_RFL_WobjOS(ob_A082_Table,vob_A082_Table);
        !
        ! Test loop
        WHILE TRUE DO
            !
            ! Move to collision free position
            MoveL Offs(p_A082_CollisionTest,0,0,50),v100,fine,tAct\WObj:=obAct;
            !
            ! Activat motion supervision 
            MotionSup\On\TuneValue:=100;
            !
            ! Stop
            Stop;
            !
            ! Make collision
            MoveL Offs(p_A082_CollisionTest,0,0,-20),v10,fine,tAct\WObj:=obAct;
        ENDWHILE
        RETURN ;
        MoveL p_A082_CollisionTest,v100,z0,tAct\WObj:=obAct;
    ERROR
        IF ERRNO=ERR_COLL_STOP THEN
            !* StorePath;
            !* MoveL p1,v200,z10,tool\WObj:=wobj;
            !* RestoPath;
            ClearPath;
            MotionSup\Off;
            StartMove;
            !
            TPErase;
            TPWrite "Error collision stop!";
        ENDIF
        TRYNEXT;

    ENDPROC

    !************************************************
    ! Function    :     Load Identification 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.10.13
    !***************** ETH Zürich *******************
    !
    PROC r_A082_LoadIdentifcation()
        !
        ! Set accelerarion and ramp
        AccSet 100,100;
        !
        ! Set tool and work object 
        t_A082_LoadId:=t_A082_Latthammer_Nail_Tip;
        !
        ! Move to starting point 
        MoveAbsJ jp_A082_LoadIdHome\NoEOffs,v200,fine,t_A082_LoadId\WObj:=wobj0;
        !
        ! Run systemroutine load identify 
        LoadIdentify;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Select tool for Operation System (real or virtual controller) 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.09.30
    ! **************** ETH Zurich *******************
    !
    FUNC tooldata f_RFL_ToolOS(tooldata tReal,tooldata tVirtual)
        !
        ! Check if execution is on real controller or virtual controller 
        IF RobOS() THEN
            !
            ! Real controller
            RETURN tReal;
        ELSE
            !
            ! Virtual controller 
            RETURN tVirtual;
        ENDIF
    ENDFUNC

    !************************************************
    ! Function    :     Select work object for Operation System (real or virtual controller) 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.09.30
    ! **************** ETH Zurich *******************
    !
    FUNC wobjdata f_RFL_WobjOS(wobjdata obReal,wobjdata obVirtual)
        !
        ! Check if execution is on real controller or virtual controller 
        IF RobOS() THEN
            !
            ! Real controller
            RETURN obReal;
        ELSE
            !
            ! Virtual controller 
            RETURN obVirtual;
        ENDIF
    ENDFUNC
ENDMODULE