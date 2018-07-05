%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%QubitRf.frequency=4456758250;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chooseQubit=2;
switch chooseQubit
    case 3
        modfGE=modfQ3;
%         IQScaleGE=IQScaleQ3;
%         PhasedelayGE=PhasedelayQ3;
    case 2
        modfGE=modfQ2;
        IQScaleGE=IQScaleQ2;
        PhasedelayGE=PhasedelayQ2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cyclelength=99000;
% tek.setupRestore( 'empty.awg', 'Z:');
% pause(5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfGE,IQScaleGE,PhasedelayGE,modfGE,IQScaleGE,PhasedelayGE,0);
% %[waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(0,1,0,0,1,0,0);
% % [waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfEF,IQScaleEF,PhasedelayEF,modfEF,IQScaleEF,PhasedelayEF,mysigma);
% waveformNameTemplate='CalSSB';
% for ch = 1:4
%     channel = sprintf('chan_%d', ch);
%     tek.(channel).voltageAmplitude   = voltage(ch);
%     tek.(channel).voltageOffset      = offset(ch);                
%     tek.(channel).marker1VoltageHigh = 2;
%     tek.(channel).marker1VoltageLow  = 0;                
%     tek.(channel).marker2VoltageHigh = 2;
%     tek.(channel).marker2VoltageLow  = 0;                
% end
% tek.wavelist.deleteAll();    %可能比较花时间的语句
% pause(2);
% for ch = 1:4   %重置波形操作 
%     myw_channel = sprintf('ch%d', ch);
%     waveformName = [waveformNameTemplate,myw_channel];
%     newLength=cyclelength;
%     tek.wavelist.new(waveformName, newLength, 'INT'); 
%     channel = sprintf('chan_%d', ch);
%     tek.(channel).waveform = waveformName;
%     tek.(channel).enabled = 1;
%     eval(['x=waveform',num2str(ch),';']);
%     eval(['y=mark',num2str(ch*2-1),';']);
%     eval(['z=mark',num2str(ch*2),';']);
%     tek.wavelist.writeWaveforms(waveformName, x,y,z ); 
% end
% pause(1);
% tek.run();
%ASA.frequency=QubitRf.frequency;pause(3);ASA.PeakSearch();
% Ch3_offset=tek.chan_3.voltageOffset;Ch4offset=tek.chan_4.voltageOffset;
% offset=[0,0,Ch3_offset,Ch4offset];
% IQScaleGE=IQScaleGE*tek.chan_3.voltageAmplitude/tek.chan_4.voltageAmplitude
% PhasedelayGE=PhasedelayGE+tek.chan_3.skew*1e9*modfGE/1000*2*pi
% ASA.frequency=QubitRf.frequency;pause(3);ASA.PeakSearch();
% ASA.frequency=QubitRf.frequency-modfGE*1e6;pause(3);ASA.PeakSearch();
tek1.setupRestore( 'empty.awg', 'Z:');
pause(5);
[waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfGE,IQScaleGE,PhasedelayGE,modfQ3,1,0,0);
%[waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(0,1,0,0,1,0,0);
% [waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfEF,IQScaleEF,PhasedelayEF,modfEF,IQScaleEF,PhasedelayEF,mysigma);
waveformNameTemplate='CalSSB';
for ch = 1:4
    channel = sprintf('chan_%d', ch);
    tek1.(channel).voltageAmplitude   = voltage_2awg(ch);
    tek1.(channel).voltageOffset      = offset_2awg(ch);                
    tek1.(channel).marker1VoltageHigh = 2;
    tek1.(channel).marker1VoltageLow  = 0;                
    tek1.(channel).marker2VoltageHigh = 2;
    tek1.(channel).marker2VoltageLow  = 0;                
end
tek1.wavelist.deleteAll();    %可能比较花时间的语句
pause(2);
for ch = 1:4   %重置波形操作 
    myw_channel = sprintf('ch%d', ch);
    waveformName = [waveformNameTemplate,myw_channel];
    newLength=cyclelength;
    tek1.wavelist.new(waveformName, newLength, 'INT'); 
    channel = sprintf('chan_%d', ch);
    tek1.(channel).waveform = waveformName;
    tek1.(channel).enabled = 1;
    eval(['x=waveform',num2str(ch),';']);
    eval(['y=mark',num2str(ch*2-1),';']);
    eval(['z=mark',num2str(ch*2),';']);
    tek1.wavelist.writeWaveforms(waveformName, x,y,z ); 
end
pause(1);
tek1.run();