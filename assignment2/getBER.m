function [BER, filteredOutput, sampledOutput, gtAfterNoise] = getBER(bits, gt, filter, bitsSize)
    BER = zeros(1, 31);
    i = 1;

    for eNoDB = -10:1:20
        % Add AWGN noise with snr = E / (No/2)
        gtAfterNoise = awgn(gt, 2*eNoDB, 'measured');

        % Apply the filter
        filteredOutput = conv(filter, gtAfterNoise);

        % Repeat last element to make size to be correct
        filteredOutput(end + 1) = filteredOutput(end);

        % Ignore first 10 elements
        filteredOutput = filteredOutput(11:end);

        % Normalize the output
        outputMin = min(filteredOutput);
        outputMax = max(filteredOutput);
        filteredOutput = (filteredOutput - outputMin) / (outputMax - outputMin);
        filteredOutput = 2*filteredOutput - 1;

        % Sample the output
        sampledOutput = filteredOutput(10:10:(10*bitsSize));

        % Take a decision
        receivedBits = double((sampledOutput >= 0));

        % Counting errors
        BER(i) = sum(bits ~= receivedBits);
        i = i + 1;
    end

    BER = BER / bitsSize;
end