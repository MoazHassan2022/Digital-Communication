close all

% Set the size of the bits array
% TODO: make this 10^5
bitsSize = 15;

% Generate a random array of zeros and ones
bits = randi([0,1],1,bitsSize);

% Pulse Shaping (make every 0 => -1, 1 => 1)
shaped = 2*bits - 1;

% Array that will hold same data but repeated to simulate holding every bit
gt = zeros(1, 10 * bitsSize);

% Pulse Shaping (repeating every bit 10 times)
for i = 1:1:bitsSize
    gt((10*i):(10*i)+10) = shaped(i);
end

% Cut last 10 elements to make correct size 
gt = gt(1:end-10);

tBits = 1:1:bitsSize;
tGt = 1:1:(10 * bitsSize);
eNoDB = -10:1:20;
% plot(tBits, bits),
% xlabel('Time'); ylabel('Bits');
% title('Generation of Random Bits');

% figure;
% plot(tGt, gt),
% xlabel('Time'); ylabel('g(t)');
% title('After Pulse Shaping');
 
% 1- Matched Filter
% Get matched filter (rectangular pulse with unit energy)
matchedFilter = ones(1, 10);
[simBERMatched, filteredOutputMatched, sampledOutputMatched, gtAfterNoiseMatched] = getBER(bits, gt, matchedFilter, bitsSize);

% disp(simBERMatched);

% Get theoretical BER
theoryBERMatched = 0.5*erfc(sqrt(10.^(eNoDB/10)));

plotSemilogy(eNoDB, theoryBERMatched, simBERMatched, 'Matched Filter');

% 2- h(t) = delta(t)
% Get matched filter (rectangular pulse with unit energy)
deltaFilter = zeros(1, 10);
deltaFilter(5) = 1;
[simBERDelta, filteredOutputDelta, sampledOutputDelta, gtAfterNoiseDelta] = getBER(bits, gt, deltaFilter, bitsSize);

% disp(simBERDelta);

% 3- h(t) = right-angled triangle with height = sqrt(5), width = 10
triYValues = linspace(0, sqrt(3), 10);
[simBERTri, filteredOutputTri, sampledOutputTri, gtAfterNoiseTri] = getBER(bits, gt, triYValues, bitsSize);

% disp(simBERTri);


% figure;
% plot(tGt, gtAfterNoise),
% xlabel('Time'); ylabel('g(t)');
% title('After Adding AWGN');

% figure;
% plot(tGt, filteredOutput),
% xlabel('Time'); ylabel('y(t)');
% title('After Matched Filter');

% tSampled = 1:1:length(sampledOutput);
% figure;
% plot(tSampled, sampledOutput),
% xlabel('Time'); ylabel('ySampled(t)');
% title('After Sampling');

% tTriangle = 1:1:10;
% figure;
% plot(tTriangle, yValues),
% xlabel('Time'); ylabel('tri(t)');
% title('Triangle Shaping');

samplingPoints = 10:10:(10*bitsSize);

plotThreeOutputs(tGt, filteredOutputMatched, filteredOutputDelta, filteredOutputTri, samplingPoints)

