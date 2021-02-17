function fs = human_coheres(lfpone, lfptwo, lowband, highband, window_in_sec, same)
	%MAKE SURE YOU PUT IN DOWNSAMPLED DATA
%put in two signals. filter them before if ya want
% input low and high bands you wanna look at
% input time in seconds, then does it in windows overlapping by half the period
%if you want to compare the same set of channels against each other just put the set for lfpone and lfptwo
%for input same, put 0 if lfps are not same and 1 if same

channellength = length(lfpone);
i = window_in_sec*2000;
halfi = i./2;


curtime = 0;
allpairs = NaN(size(lfpone,1),size(lfpone,1));
%first channel is c and second channel is n;
for c=1:size(lfpone,1);
		if same==1
			startc = c+1;
		else
			startc = c;
		end
			for n=startc:size(lfpone,1);
		allcoh = []; %reset for new channel pair
		curtime = 1;
		while curtime<=channellength-i;

			[wcoh,wcs,f] = wcoherence(lfpone(c,curtime:curtime+i), lfptwo(n,curtime:curtime+i), i);
			%find INDEX of values of frequency in theta band
			indx = find(f>lowband & f<highband);
			%those index values are the ones we wanna keep for wcoh
			wcoh = wcoh(indx, :);
			allcoh = horzcat(allcoh,wcoh);
			curtime = curtime+halfi;

		end

		%find average coherence for the pair
		meancoh = mean(mean(allcoh, 1));
		%fill into matrix
		allpairs(c,n) = meancoh;
	end %finished computing for pair of interest

end %finished computing for all pairs

fs = allpairs;

% average across theta freq
% might not want to do this. not clear yet





%freq = f(indx);
%coh = allcoh;
