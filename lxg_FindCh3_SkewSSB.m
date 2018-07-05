function [Ch3_Skew]=lxg_FindCh3_SkewSSB(ASA,tek,temp,step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)
 Ch3_Skew=Ch3_Skew+step;
SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
if (SSB_peak<=temp)
    while(SSB_peak<temp)
        temp=SSB_peak;
        Ch3_Skew=Ch3_Skew+step;
        SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    end
    Ch3_Skew=Ch3_Skew-step;
else
    Ch3_Skew=Ch3_Skew-2*step;
     SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    while(SSB_peak<temp)
        temp=SSB_peak;
        Ch3_Skew=Ch3_Skew-step;
        SSB_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)   ;
    end
    Ch3_Skew=Ch3_Skew+step;
end