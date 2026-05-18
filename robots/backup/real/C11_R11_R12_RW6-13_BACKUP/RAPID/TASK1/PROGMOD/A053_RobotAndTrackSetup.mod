MODULE A053_RobotAndTrackSetup
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS jointtarget jp_A053_TrackPlatePos1:=[[0,-70,35,0,35,0],[11764.1,-3539,-1927,0,0,0]];
    TASK PERS jointtarget jp_A053_TrackPlatePos2:=[[0,-70,35,0,35,0],[11764.1,-3508.98,-2788.78,0,0,0]];
    
    !************************************************
    ! Function    :     Function of the Routine
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.05
    !***************** ETH Zurich *******************
    !
    PROC r_A053_SetupTrackPlate()
        !
        ! Connect tool signals 
        r_Tc11_T1_ConAliSig;
        !
        ! Close gripper
        r_Tc11_T1_GrOn;
        !
        ! Move over measurement position
        
        !
        ! Mesasurement move
        MoveAbsJ jp_A053_TrackPlatePos1\NoEOffs,v1000,z50,tool0\WObj:=wobj0; 
        MoveAbsJ jp_A053_TrackPlatePos2\NoEOffs,v1000,z50,tool0\WObj:=wobj0; 
        
        !
        ! Placehoder for Code
        RETURN ;
        ERROR
        ! Placeholder for Error Code...
    ENDPROC
    
    
    
    
ENDMODULE