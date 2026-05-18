MODULE RFL_Fat2_11
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
    PROC rFatRelTool()
        !
        MoveAbsJ [[34.5244,24.6572,-36.1822,-187.893,44.2537,224.694],[7454.01,-4357.02,-3993.19,0,0,0]]\NoEOffs, v1000, z50, tTeachTip;

        MoveL pFatRelTool,v100,fine,tTeachTip;

        EOffsSet [0,0,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [500,0,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [2000,0,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [0,0,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [0,500,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [0,2000,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [0,0,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;
        EOffsSet [1300,1300,0,0,0,0];
        MoveL RelTool(pFatRelTool,0,0,0\Rx:=0\Ry:=0\Rz:=0),v100,fine,tTeachTip;
        EOffsOff;

        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE