%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%QubitRf.frequency=4.4601e9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cyclelength=99000;
tek.setupRestore( 'empty.awg', 'Z:');
pause(5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfGE,IQScaleGE,PhasedelayGE,modfGE,IQScaleGE,PhasedelayGE,0);
%[waveform1,mark1,mark2,waveform2,mark3,mark4,waveform3,mark5,mark6,waveform4,mark7,mark8]=CalSSBSequence1(modfEF,IQScaleEF,PhasedelayEF,modfEF,IQScaleEF,PhasedelayEF,mysigma);
waveformNameTemplate='CalSSB';
for ch = 1:4
    channel = sprintf('chan_%d', ch);
    tek.(channel).voltageAmplitude   = voltage(ch);
    tek.(channel).voltageOffset      = offset(ch);                
    tek.(channel).marker1VoltageHigh = 2;
    tek.(channel).marker1VoltageLow  = 0;                
    tek.(channel).marker2VoltageHigh = 2;
    tek.(channel).marker2VoltageLow  = 0;                
end
tek.wavelist.deleteAll();    %可能比较花时间的语句
pause(2);
for ch = 1:4   %重置波形操作 
    myw_channel = sprintf('ch%d', ch);
    waveformName = [waveformNameTemplate,myw_channel];
    newLength=cyclelength;
    tek.wavelist.new(waveformName, newLength, 'INT'); 
    channel = sprintf('chan_%d', ch);
    tek.(channel).waveform = waveformName;
    tek.(channel).enabled = 1;
    eval(['x=waveform',num2str(ch),';']);
    eval(['y=mark',num2str(ch*2-1),';']);
    eval(['z=mark',num2str(ch*2),';']);
    tek.wavelist.writeWaveforms(waveformName, x,y,z ); 
end
pause(1);
tek.run();
% ASA.frequency=QubitRf.frequency;pause(3);ASA.PeakSearch();
% ASA.frequency=QubitRf.frequency-100e6;pause(3);ASA.PeakSearch();