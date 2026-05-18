MODULE RFL_Control_12B
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Control Routines for ETH
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2018.01.18 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2018
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Main
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2018.01.11
    ! **************** ETH Zurich *******************
    !
    PROC main()
        !
        ! Initalisation 
        !
        ! Work process
        WHILE 1=1 DO
            !
            ! Run DCiGPSDispatcher
            DCiGPSDispatcher stiGPSRobName;
            ! 
            ! Idle Loop
            WaitTime 0.1;
        ENDWHILE
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE