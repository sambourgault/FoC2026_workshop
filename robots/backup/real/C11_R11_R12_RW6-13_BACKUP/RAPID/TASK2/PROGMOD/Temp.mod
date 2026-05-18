MODULE Temp

    CONST jointtarget jp_AXXX_HomeR12:=[[0,-65,65,0,35,0],[1000,-12137,-4800,0,0,0]];

    PROC r_AXXX_Home()
        MoveAbsJ jp_AXXX_HomeR12,v200,fine,tool0\WObj:=wobj0;
    ENDPROC
ENDMODULE