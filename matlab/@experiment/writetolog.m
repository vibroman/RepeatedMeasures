% WRITETOLOG - write information about the experiment to a log file
%
% writetolog(e,message)
%
% Writes the string in message to the logfile, together with the time it was called
% (using accurate Psychtoolbox function GetSecs)

function writetolog(e,message)

s = GetSecs;
fprintf(e.log_fp,'%.12f: %s\n',s,message);
