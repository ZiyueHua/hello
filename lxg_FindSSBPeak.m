function [SSB_peak]=lxg_FindSSBPeak(ASA,tek,ch3_offset,ch4_offset,Ch3_Amp,Ch3_Skew)
            tek.chan_3.voltageOffset=ch3_offset;
            tek.chan_4.voltageOffset=ch4_offset;
            tek.chan_3.voltageAmplitude=Ch3_Amp;
            tek.chan_3.skew=Ch3_Skew*1e-9;
            pause(0.5);
            SSB_peak=ASA.FindPeakValue();
end