% SHOWIMAGESETUP - Prepare a "showImage" trial.
% Do not call directly, will be called by runexperiment

function thistrial = setup(s,e,thistrial,experimentdata)

thisimage = experimentdata.images{s.stimuli};
thistrial.textureIndex = Screen('MakeTexture',experimentdata.screenInfo.curWindow,thisimage);
Screen('DrawTexture',experimentdata.screenInfo.curWindow,thistrial.textureIndex);
Screen('Flip',experimentdata.screenInfo.curWindow,1);
writetolog(e,'Showed image in showImage');
thistrial.recording = 0; % We do not record data in the 'showImage' trials
% (use  'image' to record)
