//START_TABLE sw_reg
`SWREG_W(KNN_RESET,          1, 0) //Timer soft reset
`SWREG_W(KNN_ENABLE,         1, 0) //Timer enable
`SWREG_W(KNN_Ax,            16, 0)
`SWREG_W(KNN_Bx,            16, 0)
`SWREG_W(KNN_Ay,            16, 0)
`SWREG_W(KNN_By,            16, 0)
`SWREG_W(KNN_LABEL,          8, 0)
`SWREG_W(KNN_acesso,          8, 0)
`SWREG_R(KNN_Dist,          32, 0)
`SWREG_R(KNN_Out,           80, 0)
`SWREG_R(KNN_Out2,          32, 0)
`SWREG_W(KNN_PIP,          1, 0)
