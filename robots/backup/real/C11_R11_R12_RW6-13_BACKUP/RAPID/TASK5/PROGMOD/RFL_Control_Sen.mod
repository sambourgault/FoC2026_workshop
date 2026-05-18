MODULE RFL_Control_Sen



    !************************************************
    ! Function    :     Function of the Routine
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2017.05.05
    !***************** ETH Zurich *******************
    !
    PROC main()
        !
        ! Synchronize with master
        WaitSyncTask idRFL_MaInitDone,tlMaRecSen;
        !
        ! Idle loop
        WHILE 1=1 DO

            TEST stCurMaJob
            CASE "A042":
                !
                ! Use RRC
                r_A042_Main;
                !
            CASE "A067":
                !
                ! Integral Timber Joints
                r_A067_Main;
            CASE "A073":
                !
                ! Item A073 Impact-Printing
                r_A073_Main;
            CASE "A082":
                !
                ! Item A082_Latthammer
                r_A082_Main;
            CASE "A083":
                !
                ! Item A083 Augmented-Timber
                r_A083_Main;
            CASE "A088":
                !
                ! Item A088 RSL-Mitholz
                r_A088_Main;
            CASE "A098":
                !
                ! Item A098 Fall Demo 2025
                r_A098_Main;
            DEFAULT:
                ! 
                ! Wait time
                WaitTime 0.5;
            ENDTEST
        ENDWHILE
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC



ENDMODULE