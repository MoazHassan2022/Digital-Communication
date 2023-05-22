function r = signalSpaceWithNoise(s, sigma)
    % Generate additive white Gaussian noise (AWGN)
    noise = sigma * randn(size(s));

    % Add noise to the signal
    r = s + noise;
end