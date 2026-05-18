MODULE RFL_Temp_iGPS



    !************************************************
    ! Function    :     Function of the Routine
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.05
    !***************** ETH Zurich *******************
    !
    PROC riGPS_BaseCorrection()
        VAR num nTestOffset:=1000;
        MoveAbsJ [[-0.05014,-44.7915,21.2001,-0.050253,-66.6024,16.8512],[2000.01,-4322.59,-3824.82,0,0,0]]\NoEOffs, v1000, fine, tool0;
        !
        ! Read current position
        rReadPosTemp;
        !
        ! Test loop
        WHILE bRun=TRUE DO
            !
            ! Move to Start point
            EOffsOff;
            MoveAbsJ jpTemp,vRFLMed,fine,tool0;
            !
            ! Move Robot with offset
            MoveJ Offs(pTemp,nTestOffset,0,0),vRFLMed,fine,tool0;
            !
            ! Move Robot without offset
            MoveJ Offs(pTemp,0,0,0),vRFLMed,fine,tool0;
            !
            ! Move Gantry with offset
            EOffsSet [nTestOffset,0,0,0,0,0];
            MoveAbsJ jpTemp,vRFLMed,fine,tool0;
        ENDWHILE
        ! Placehoder for Code
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE