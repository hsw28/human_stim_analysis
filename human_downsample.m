function y = human_downsample(channels)

channels = channels';
y = downsample(channels,16);

y = y';
