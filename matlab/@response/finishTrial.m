% FINISHTRIAL - whether this trial should be finished at this time
% This should not be run directly, it is called by runexperiment.m
% This method should be overloaded by a child class if you want an
% ability to finish a trial early (say if a target has been reached)

function [toFinish,thistrial,experimentdata] = finishTrial(r,thistrial,experimentdata,e,lastposition)
toFinish = false;
[keyIsDown, secs, keycode] = KbCheck;
if ~isempty(find(keycode,1)) && find(keycode,1)==KbName('q')
    toFinish = true;
end
