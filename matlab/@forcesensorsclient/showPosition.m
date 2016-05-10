% SHOWPOSITION - show the position for the force sensors (as a dot)

function [lastposition,thistrial] = showPosition(m,thistrial,experimentdata,e,frame)

% get the current position
lastposition = getsample(m);
lastposition = lastposition(2:end-1);

thistrial.lastposition = lastposition;

[lastsampleVisual,thistrial] = calculateLastPosition(m,lastposition,thistrial,frame);

lastpositionVisual(:,1) = lastsampleVisual(:,1) * experimentdata.screenInfo.screenRect(3);
lastpositionVisual(:,2) = lastsampleVisual(:,2) * experimentdata.screenInfo.screenRect(4);

thistrial.lastpositionVisual = lastpositionVisual;

thistrial = showPositionCommon(m,lastpositionVisual,thistrial,experimentdata,e,frame);