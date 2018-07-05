function [Ch4_offset]=lxg_FindCh4_OffsetSSB(ASA,tek,temp,step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)
 Ch4_offset=Ch4_offset+step;
SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
if (SSB_peak<=temp)
    while(SSB_peak<temp)
        temp=SSB_peak;
        Ch4_offset=Ch4_offset+step;
        SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    end
    Ch4_offset=Ch4_offset-step;
else
    Ch4_offset=Ch4_offset-2*step;
     SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    while(SSB_peak<temp)
        temp=SSB_peak;
        Ch4_offset=Ch4_offset-step;
        SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    end
    Ch4_offset=Ch4_offset+step;
end