function plotSignalWithNoise(testCase, s1_v1, s1_v2, s2_v1, s2_v2, s1, s2, phi1, phi2)
    % Draw the signal space representation of the signals before adding noise
    figure('Name', 'Signal Points with Noise', 'NumberTitle', 'off');
    scatter(s1_v1, s1_v2, 100, 'r', 'filled');
    hold on;
    scatter(s2_v1, s2_v2, 100, 'b', 'filled');

    % E / sigma^2 list in dB 
    EoSigma = [-5, 0, 10];
    Es1 = norm(s1) / sqrt(numel(s1));
    Es2 = norm(s2) / sqrt(numel(s2));

    sigma1 = Es1 ./ db2mag(EoSigma);
    sigma2 = Es2 ./ db2mag(EoSigma);

    for i = 1:50
        r1 = signalSpaceWithNoise(s1, sigma1(testCase));
        r2 = signalSpaceWithNoise(s2, sigma2(testCase));

        % Calculate signal space representation of the generated samples
        [r1_v1, r1_v2] = signalSpace(r1, phi1, phi2);
        [r2_v1, r2_v2] = signalSpace(r2, phi1, phi2);

        % Draw the signal space representation of the signals after adding noise
        scatter(r1_v1, r1_v2, [], [0.6350 0.0780 0.1840]);
        scatter(r2_v1, r2_v2, [], [0.3010 0.7450 0.9330]);
    end

    legend('Signal 1', 'Signal 2', 'Signal 1 with Noise', 'Signal 2 with Noise');
    xlabel('Phi1');
    ylabel('Phi2');
    title(['Signal Points with Noise with E/sigma^2 = ' num2str(EoSigma(testCase)) 'dB']);
    grid on;
end