function [offset,IQScale,Phasedelay,SSBrst1,SSBrst2]=lxg_SearchSSB(QubitFreq,ASA,tek,tekvoltage,tekoffset0,tekIQScale0,tekPhasedelay0)
persistent SSBnumber;
if isempty(SSBnumber)
    SSBnumber=0;
end
modfGE=100;
IQScaleGE=tekIQScale0;
PhasedelayGE=tekPhasedelay0;
mysigma=6;
voltage=tekvoltage;
offset=tekoffset0;
loadCalSSB;
ASA.frequency=QubitFreq-100e6;
pause(2);
ASA.PeakSearch();
% --------------------------------------------------------------------
Ch3_flag=false;
Ch4_flag=false;
Ch3_offset=0;
Ch4_offset=0;
Ch3_Amp=4;
Ch3_Skew=0;
i=0;
while ~(Ch3_flag&&Ch4_flag)
    i=i+1;
    In_Ch3_offset=Ch3_offset;
    In_Ch4_offset=Ch4_offset;
    for Offset_step=[0.1 0.01 0.001]
        temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
        Ch3_offset=lxg_FindCh3_OffsetSSB(ASA,tek,temp,Offset_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    end
    if(In_Ch3_offset==Ch3_offset)
        Ch3_flag=true;
    end
    for Offset_step=[0.1 0.01 0.001]
        temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
        Ch4_offset=lxg_FindCh4_OffsetSSB(ASA,tek,temp,Offset_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    end
    if(In_Ch4_offset==Ch4_offset)
        Ch4_flag=true;
    end
    final_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    if(final_peak<=-75)
        Ch3_flag=true;
        Ch4_flag=true;
    end
    if(i==6)
        Ch3_flag=true;
        Ch4_flag=true;
    end
end
SSBrst1=final_peak;
% -----------------------------------------------------------------------------
ASA.frequency=QubitFreq-200e6;
pause(2);
ASA.PeakSearch();
Ch3_Amp_flag=false;
Ch3_Skew_flag=false;
i=0;

% 
% Skew_step=0.1;
%         temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
%         Ch3_Skew=lxg_FindCh3_SkewSSB(ASA,tek,temp,Skew_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
% 
% Amp_step=0.1;
%         temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
%         Ch3_Amp=lxg_FindCh3_AmpSSB(ASA,tek,temp,Amp_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
% 
% Skew_step=0.01;
%         temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
%         Ch3_Skew=lxg_FindCh3_SkewSSB(ASA,tek,temp,Skew_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
% 
% Amp_step=0.01;
%         temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
%         Ch3_Amp=lxg_FindCh3_AmpSSB(ASA,tek,temp,Amp_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);




while ~(Ch3_Amp_flag&&Ch3_Skew_flag)
    i=i+1;
    In_Ch3_Amp=Ch3_Amp;
    In_Ch3_Skew=Ch3_Skew;
    for Skew_step=[0.1 0.01 0.001]
        temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
        Ch3_Skew=lxg_FindCh3_SkewSSB(ASA,tek,temp,Skew_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    end
    if(In_Ch3_Skew==Ch3_Skew)
        Ch3_Skew_flag=true;
    end
    for Amp_step=[0.1 0.01 0.001]
        temp=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew)  ;
        Ch3_Amp=lxg_FindCh3_AmpSSB(ASA,tek,temp,Amp_step,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    end
    if(In_Ch3_Amp==Ch3_Amp)
        Ch3_Amp_flag=true;
    end

    final_peak=lxg_FindSSBPeak(ASA,tek,Ch3_offset,Ch4_offset,Ch3_Amp,Ch3_Skew);
    if(final_peak<=-75)
        Ch3_Amp_flag=true;
        Ch3_Skew_flag=true;
    end
    if(i==16)
        Ch3_Amp_flag=true;
        Ch3_Skew_flag=true;
    end
end
SSBrst2=final_peak;
% ----------------------------------------------------------------
Ch3_offset=tek.chan_3.voltageOffset;
ch2offset=tek.chan_4.voltageOffset;
ch3amp=tek.chan_3.voltageAmplitude;
ch3skew=tek.chan_3.skew;

SSBnumber=SSBnumber+1;
offset=[0,0,Ch3_offset,ch2offset];
IQScale=ch3amp/tek.chan_4.voltageAmplitude;
Phasedelay=ch3skew*1e9*0.1*2*pi;
end