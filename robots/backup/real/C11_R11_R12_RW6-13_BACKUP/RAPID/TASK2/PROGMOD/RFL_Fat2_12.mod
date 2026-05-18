MODULE RFL_Fat2_12
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C 13 / Stefano-Franscini-Platz 1 
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Routines for ETH Factary acceptance test
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2016.12.16 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2016
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Master rFacAccTest Routine form ETH
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.14
    ! **************** ETH Zurich *******************
    !
    PROC rFatPointCopyR11()
        !
        MoveJ Offs(pFatRelTool,0,0,200),v500,fine,tTeachTip;

        MoveL pFatRelTool,v10,fine,tTeachTip;

        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE