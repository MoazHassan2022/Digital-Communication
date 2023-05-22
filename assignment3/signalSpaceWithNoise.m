function r = signalSpaceWithNoise(s, sigma)
	% Generate AWGN
	noise = sigma * randn(1, length(s));

	% Add noise to the signals
	r = s + noise;
end