% READRESOURCES - Read strings, labels, symbols (if they exist) and other default values

function [experimentdata,params] = readResources(e,validating)

if nargin<2
    validating = 0;
end

frustumparams.name = {'left','right','bottom','top','nearVal','farVal'};
frustumparams.type = {'number','number','number','number','number','number'};
frustumparams.description = {'left side','right side','bottom','top','near plane location','far plane location'};
frustumparams.default = {-5,5,-5,5,2,500};
frustumparams.required = [0 0 0 0 0 0];
frustumparams.classname = 'frustum';
frustumparams.classdescription = 'Frustum parameters for viewing transformation';

vrparams.name = {'scale','rotate','translation','stereomode','eyedistance','cameralocation','center','up','frustum'};
vrparams.type = {'matrix_1_3','matrix_1_3','matrix_1_3','number','number','matrix_1_3','matrix_1_3','matrix_1_3',frustumparams};
vrparams.description = {'Scale factor for the hand','Rotation to apply to the hand','Translation to apply to the hand',...
    'stereomode (see Psychtoolbox for the values)','eye distance (when using stereo)','camera location (x,y,z)',...
    'center of scene (x,y,z)','up direction (x,y,z)','Viewing transformation'};
vrparams.default = {[1 1 1],[0 0 0],[0 0 0],0,1,[0 2 22],[5 5 5],[0 1 0],readParameters(frustumparams,[])};
vrparams.required = [0 0 0 0 0 0 0 0 0];
vrparams.classdescription = 'rendering parameters for virtual reality';
vrparams.classname = 'vr';
% when viewing from above, these should be
% experimentdata.vr.cameralocation = [0 22 0];
% experimentdata.vr.center = [0 0 0];
% experimentdata.vr.up = [0 0 -1];

labelparams.name = {'location','fontSize','text'};
labelparams.type = {'matrix_1_2','number','string'};
labelparams.description = {'Location on screen for label (x,y), in the range 0-1','Font size (pts)','text to display'};
labelparams.default = {[0 0],12,''};
labelparams.required = [1 1 1];
labelparams.classname = 'labels';
labelparams.classdescription = 'Text to show on the screen throughout the experiment (e.g. target labels)';

tactorSequencesparams.name = {'commands','parameters'};
tactorSequencesparams.type = {'matrix_1_n','cellarray'};
tactorSequencesparams.description = {'Each element should be 1 (turn on specified tactors), 2 (wait for a specified time), 3(turn off all tactors) or 4(set source)','Each cell should be (depending on the command): for 1, an array with the tactors to turn on; for 2, the duration (in ms); for 3, empty; for 4(0=none,1=sin1,2=sin2,3=sin1+sin2)'};
tactorSequencesparams.default = {1,{'1'}};
tactorSequencesparams.required = [1 1];
tactorSequencesparams.classname = 'tactorSequences';
tactorSequencesparams.classdescription = 'Define sequences of tactor events for later playback';

tactorparams.name = {'COMport','sequences',...
    'sinFreq1','sinFreq2','gain'};
tactorparams.type = {'string',tactorSequencesparams,'number','number','number'};
tactorparams.description = {'Either a number (indicating a serial port to connect to  - can be found in Device manager), or a string, indicating a bluetooth identifier (can be found using instrhwinfo(''Bluetooth''))',...
    'description of the tactor sequences that can be played back later',...
    'Frequency of the first sine wave (sine wave(s) to use can be defined in sequences)','Frequency of the second sine wave (sine wave(s) to use can be defined in sequences)',...
    'Gain level of the amplifiers (0,1,2 or 3)'};
tactorparams.default = {1,[],250,240,3};
tactorparams.required = [1 0,0,0,0];
tactorparams.classname = 'tactors';
tactorparams.classdescription = 'Define details of the tactor stimulation';

serialparams.name = {'COMport','baudRate'};
serialparams.type={'number','number'};
serialparams.description = {'A number indicating a serial port to connect to  - can be found in Device manager in Windows','baud rate'};
serialparams.default = {1,115200};
serialparams.required = [1 0];
serialparams.classname = 'serial';
serialparams.classdescription = 'Define the parameters of the serial port to be used for sending triggers';

parallelparams.name = {'portname'};
parallelparams.type={'string'};
parallelparams.description = {'The name of the serial port, e.g. LPT1'};
parallelparams.default = {'LPT1'};
parallelparams.required = [1];
parallelparams.classname = 'parallel';
parallelparams.classdescription = 'Define the parameters of the parallel port to be used for sending triggers';

beepsparams.name = {'frequency','duration'};
beepsparams.type = {'number','number'};
beepsparams.default = {500,0.15};
beepsparams.required = [1 1];
beepsparams.description = {'beep frequency (in Hz). ','beep duration (in seconds)'};
beepsparams.classdescription = 'Beeps throughout the trial';
beepsparams.classname = 'beeps';

stringsparams.name = {'name','value'};
stringsparams.type = {'string','string'};
stringsparams.default = {'',''};
stringsparams.required = [1 1];
stringsparams.description = {'Name of string to change (see list in file defaultstrings)','New value for that string'};
stringsparams.classdescription = 'Replacement strings to be shown, mostly as feedback';
stringsparams.classname = 'strings';

params.name = {'images','strings','sounds','beeps','symbols','staircases','monitorWidth','monitorHeight',...
    'viewingDistance','xshift','framerate','vr','MCtrigger','incrementOnAbort','mouseTargets','targetPosition','boxes','labels','tactors','serial','parallel'};
params.type = {'cellarray',stringsparams,'cellarray',beepsparams,'cellarray','cellarray','number','number',...
    'number','number','number',vrparams,'number','boolean','matrix_n_4','matrix_n_2','matrix_n_4',labelparams,tactorparams,serialparams,parallelparams};
params.description = {'Cell array of the filenames of the images (which are in the stimuli directory)',...
    'Strings to replace the default (for feedback, etc).',...
    'Cell array of the filenames of .wav sound files to play (which are in the stimuli directory). All files need to have the same sample frequency and number of channels.',...
    'Details of custom beeps to play back during the trials',...
    'A cell array of strings to display (e.g. {''<'',''>''})',...
    'A cell array of staircases',...
    'The width of the monitor in cm',...
    'The height of the monitor in cm',...
    'The viewing distance in cm',...
    'Horizontal shift of stimuli from the center of the screen',...
    'Frame rate to aim for (if the program can''t keep up with the monitor frame rate)',...
    'details of the vr setup (if vrstimulus is going to be used)',...
    'details of the DAQ card trigger (1 = output, 2 = input, empty if not used)',...
    'whether to move to the next trial when the trial is aborted (e.g. due to starting too early or late). If 0, then repeat the same trial, if 1 move to the next trial',...
    'details of mouse targets (that can be clicked). Each row should be (x,y,width,height), in the range 0-1',...
    'details of target positions. Each row should be (x,y) or (x,y,z), depending on the recording device used. These values can be overridden using the defineTarget response.',...
    'details of boxes to show on the screen. Each row should be (x,y,width,height), in the range 0-1',...
    'list of labels (strings) that can be shown',...
    'details of the tactor stimulation (vibration)',...
    'details of the serial port to be used for a trigger',...
    'details of the parallel port to be used for a trigger'};

params.default = {[],[],[],[],[],[],70,30,...
    68,0,NaN,[],[],0,[],[],NaN,[],[],[],[]};
params.required = [0 0 0 2 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
params.classdescription = 'General parameters for the entire expriment';
params.classname = 'experimentdata';

if nargout>1
    % If making documentation, add all clients, otherwise just the relevant ones
    for k=1:numel(e.allclients)
        if ~strcmp(e.allclients{k},'socket')
            count = numel(params.name)+1;
            params.name{count} = e.allclients{k};
            cn = [e.allclients{k} 'client'];
            eval(['[p,p] = ' cn '([]);']);
            params.type{count} = p;
            params.description{count} = p.classdescription;
            params.default{count} = [];
            params.required(count) = 0;
        end
    end
    % If making documentation, add all staircases, otherwise just the relevant ones
    count2 = 0;
    index = find(strcmp(params.name,'staircases'));
    clear vals;
    for k=1:numel(e.allstaircases)
        if ~isempty(e.allstaircases{k})
            count2 = count2 + 1;
            cn = [e.allstaircases{k} 'staircase'];
            eval(['[p,p] = ' cn '([]);']);
            vals{count2} = p;
        end
    end
    params.type{index} = vals;
else
    if isempty(e.devices)
        error('There must be at least one recording device');
    end
    devicesfields = fields(e.devices);
    for k=1:numel(devicesfields)
        params.name{numel(params.name)+1} = devicesfields{k};
        params.type{numel(params.type)+1} = 'ignore';
        params.description{numel(params.description)+1} = '';
        params.default{numel(params.default)+1} = [];
        params.required(numel(params.required)+1) = 0;
    end
    if ~isempty(e.staircases)
        staircasefields = fields(e.staircases);
        for k=1:numel(staircasefields)
            params.name{numel(params.name)+1} = staircasefields{k};
            params.type{numel(params.type)+1} = 'ignore';
            params.description{numel(params.description)+1} = '';
            params.default{numel(params.default)+1} = [];
            params.required(numel(params.required)+1) = 0;
        end
    end
end

if nargout>1
    experimentdata = [];
    return;
end

% find the parent directory of RepeatedMeasures
thisfile = which('experiment');
pathstr = fileparts(thisfile);
% allow for either slash type
parentDir = strrep(pathstr,'matlab\@experiment','');
parentDir = strrep(parentDir,'matlab/@experiment','');

imageDir = 'stimuli/';
% If there is no stimuli dir, use the default stimuli
if ~exist(imageDir,'dir')
    imageDir = [parentDir 'stimuli/'];
end

soundDir = 'sounds/';
% If there is no sound dir, use the default sounds
if ~exist(soundDir,'dir')
    soundDir = [parentDir 'sounds/'];
end
% Read in annoying beep
[experimentdata.annoyingBeep,experimentdata.annoyingBeepf] = audioread([soundDir 'Buzz.wav']);

% Default texts
experimentdata.texts = defaultstrings;

% Set some defaults
experimentdata = readParameters(params,e.protocol.setup,experimentdata);

if ~isempty(experimentdata.images)
    imagenames = experimentdata.images;
    experimentdata = rmfield(experimentdata,'images');
    numimages = numel(imagenames);
    experimentdata.images = cell(numimages,1);
    for m=1:numimages
        [experimentdata.images{m},map,experimentdata.alpha{m}] = imread([imageDir imagenames{m}]);
        if ~isempty(map)
            error(['Cannot deal with images with colormap: ' imageDir imagenames{m}]);
        end
        if ~isa(experimentdata.images{m},'uint8')
            error(['Requires 8 bit images. This file is not:' imageDir imagenames{m}]);
        end
        % If actually a grey scale image, convert to one channel
        if length(size(experimentdata.images{m}))==3
            channel1 = experimentdata.images{m}(:,:,1);
            channel2 = experimentdata.images{m}(:,:,2);
            channel3 = experimentdata.images{m}(:,:,3);
            if all(channel1(:)==channel2(:)) && all(channel2(:)==channel3(:))
                experimentdata.images{m} = experimentdata.images{m}(:,:,1);
            end
        end
    end
end

if ~isempty(experimentdata.tactors) && ~validating
    tactorData = experimentdata.tactors;
    experimentdata.tactorSequences = tactorData.sequences;
    % connect to the tactor
    experimentdata.tactors = tactor(tactorData.COMport,1);
    % Setup the sequences
    experimentdata = makecellifnot(experimentdata,'tactorSequences');
    
    for k=1:numel(experimentdata.tactorSequences)
        clear seqParams;
        for m=1:numel(experimentdata.tactorSequences{k}.parameters)
            seqParams{m} = str2num(experimentdata.tactorSequences{k}.parameters{m}); %#ok<AGROW,ST2NM>
        end
        defineSequence(experimentdata.tactors,k,experimentdata.tactorSequences{k}.commands,seqParams);
    end
    setSinFreq(experimentdata.tactors,1,tactorData.sinFreq1);
    setSinFreq(experimentdata.tactors,2,tactorData.sinFreq2);
    setGain(experimentdata.tactors,tactorData.gain);
end

if ~isempty(experimentdata.serial) && ~validating
    serialData = experimentdata.serial;
    % connect to the serial port
    experimentdata.serial = serialport(serialData.COMport,serialData.baudRate);
end

if ~isempty(experimentdata.parallel) && ~validating
    parallelData = experimentdata.parallel;
    % connect to the parallel port
    experimentdata.parallel = parallelport(parallelData.portname);
end

if ~isempty(experimentdata.staircases)
    staircases = experimentdata.staircases;
    experimentdata = rmfield(experimentdata,'staircases');
 
    for k=1:numel(staircases)
        thefields = fields(staircases{k});
        eval(['experimentdata.staircases{k} = ' thefields{1} 'staircase(staircases{k}.' thefields{1} ',experimentdata,0);'])
    end
    
end


% load the sounds
if ~isempty(experimentdata.sounds)
    % First we have to initialise the sound
    if ~validating
        InitializePsychSound;
    end
    for k=1:numel(experimentdata.sounds)
        wavFilename = ['stimuli/' experimentdata.sounds{k}];
        if ~exist(wavFilename,'file')
            error('No wav file %s found',wavFilename);
        end
        [wavedata, freq] = audioread(wavFilename);
        wavedata = wavedata';
        nrchannels = size(wavedata,1); % Number of rows == number of channels.
        
        if k==1
            experimentdata.freq = freq;
            experimentdata.nrchannels = nrchannels;
        else
            if experimentdata.freq ~= freq || experimentdata.nrchannels ~= nrchannels
                error('The frequency and number of channels of the wav files must be the same for all the files');
            end
        end
        if ~validating
            experimentdata.audioBuffer(k) = PsychPortAudio('CreateBuffer',[],wavedata);
        end
    end
end

% load the beeps
if ~isempty(experimentdata.beeps)
    % First we have to initialise the sound (if not already initalized)
    if ~validating && ~isempty(experimentdata.sounds)
        InitializePsychSound;
    end
    % If not specified (from the audio files), set to empty (i.e. use default values)
    if ~isfield(experimentdata,'freq')
        experimentdata.freq = [];
    end
    % If not specified by the audio files, set the number of channels to 1 (mono)
    if ~isfield(experimentdata,'nrchannels')
        experimentdata.nrchannels = 1;
    end
    
    experimentdata = makecellifnot(experimentdata,'beeps');
    
    if ~validating
        for k=1:numel(experimentdata.beeps)
            beepdata = MakeBeep(experimentdata.beeps{k}.frequency, experimentdata.beeps{k}.duration);
            if experimentdata.nrchannels>1
                beepdata = repmat(beepdata,experimentdata.nrchannels,1);
            end
            experimentdata.beepbuffer{k} = PsychPortAudio('CreateBuffer',[],beepdata);
        end
    end
end

if ~isempty(experimentdata.strings)
    str = experimentdata.strings;
    if ~iscell(str)
        str = {str};
    end
    for m=1:numel(str)
        if isempty(str2num(str{m}.value))
            experimentdata.texts.(str{m}.name) = str{m}.value;
        else
            experimentdata.texts.(str{m}.name) = uint8(str2num(str{m}.value));
        end
    end
end
