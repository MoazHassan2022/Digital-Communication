% test 1
in_val = -6:0.01:6;
n_bits = 3;
xmax = 6;
m = 0; % midrise
q_ind_midrise = UniformQuantizer(in_val, n_bits, xmax, m);
deq_val_midrise = UniformDequantizer(q_ind_midrise,n_bits,xmax,m);

m = 1; % midtread
q_ind_midtread = UniformQuantizer(in_val, n_bits, xmax, m);
deq_val_midtread = UniformDequantizer(q_ind_midtread,n_bits,xmax,m);

hold on, plot(in_val, deq_val_midrise), plot(in_val, deq_val_midtread), 
hold off, xlabel('input'); ylabel('dequantized');
title('Quantization/Dequantization with midrise & midtread');

% test 2
x = -5 + (10).*rand(10000,1); % using rand function
xmax = 5;
m = 0; % midrise
SNR_sim_vec = zeros(7,1);
SNR_theo_vec = zeros(7,1);
for n_bits = 2:1:8
    q_ind = UniformQuantizer(x,n_bits,xmax,m);
    deq_val = UniformDequantizer(q_ind,n_bits,xmax,m).';
    q_error = x - deq_val.';
    SNR_sim_vec(n_bits-1) = mean(x.^2)/mean(q_error.^2); 
    delta = (2*xmax)/(2^n_bits);
    SNR_theo_vec(n_bits-1) = (3/2)*(xmax^2)/(delta^2);
end

nbits_vec = 2:1:8;
figure();
plot(nbits_vec,10*log10(SNR_sim_vec)); % dB
hold on;
plot(nbits_vec,10*log10(SNR_theo_vec));
hold off;
xlabel('number of bits'); ylabel('SNR (dB)'); title('SNR vs Number of bits');

% test 3
polarity = 2*(rand(1, 10000) < 0.5) - 1;
magnitude = exprnd(0, 1, 10000);
x = polarity.*magnitude;
xmax = 5;
m = 0; % midrise
SNR_sim_vec = zeros(7,1);
SNR_theo_vec = zeros(7,1);
for n_bits = 2:1:8
    q_ind = UniformQuantizer(x,n_bits,xmax,m);
    deq_val = UniformDequantizer(q_ind,n_bits,xmax,m).';
    q_error = x - deq_val.';
    SNR_sim_vec(n_bits-1) = mean(x.^2)/mean(q_error.^2); 
    delta = (2*xmax)/(2^n_bits);
    SNR_theo_vec(n_bits-1) = (3/2)*(xmax^2)/(delta^2);
end

nbits_vec = 2:1:8;
figure();
plot(nbits_vec,10*log10(SNR_sim_vec)); % dB
hold on;
plot(nbits_vec,10*log10(SNR_theo_vec));
hold off;
xlabel('number of bits'); ylabel('SNR (dB)'); title('SNR vs Number of bits');


% req 6
xmax = 5;
mu_values = [0, 5, 100, 200];

% Define n_bits values
n_bits_values = 2:8;

% Calculate SNR for each n_bits value and mu value
SNR_sim = zeros(length(mu_values), length(n_bits_values));
SNR_theory = zeros(length(mu_values), length(n_bits_values));
for i = 1:length(mu_values)
    mu = mu_values(i);
    for j = 1:length(n_bits_values)
        n_bits = n_bits_values(j);
        % Compress the input signal
        x_comp = sign(x).*log(1 + mu*abs(x)/xmax)/log(1 + mu);

        q_ind = UniformQuantizer(x,n_bits,xmax,m);
        deq_val = UniformDequantizer(q_ind,n_bits,xmax,m).';

        % Expand the quantized signal
        q_val_exp = sign(deq_val).*((1 + mu).^abs(deq_val) - 1)./(mu*abs(xmax));
        q_val_exp(isnan(q_val_exp)) = 0;

        % Calculate quantization error
        quant_error = x - q_val_exp.';
        delta = (2*xmax)/(2^n_bits);
        SNR_sim(i, j) = 10*log10(mean(x.^2)/mean(quant_error.^2));
        SNR_theory(i, j) = 10*log10((3/2)*(xmax^2)/(delta^2));
    end
end

% Plot the simulation and theoretical SNR
figure;
plot(n_bits_values, SNR_sim(1,:), 'b', n_bits_values, SNR_sim(2,:), 'r', n_bits_values, SNR_sim(3,:), 'g', n_bits_values, SNR_sim(4,:), 'm');
title('SNR vs n bits');
xlabel('n bits');
ylabel('SNR (dB)');
legend(sprintf('\\mu = %d', mu_values(1)), sprintf('\\mu = %d', mu_values(2)), sprintf('\\mu = %d', mu_values(3)), sprintf('\\mu = %d', mu_values(4)));

figure;
plot(n_bits_values, SNR_sim(1,:), 'b', n_bits_values, SNR_theory(1,:), 'r', n_bits_values, SNR_sim(2,:), 'g', n_bits_values, SNR_theory(2,:), 'm', n_bits_values, SNR_sim(3,:), 'c', n_bits_values, SNR_theory(3,:), 'y', n_bits_values, SNR_sim(4,:), 'k', n_bits_values, SNR_theory(4,:), 'Color', [0.5 0.5 0.5]);
title('SNR vs n bits');
xlabel('n bits');
ylabel('SNR (dB)');
legend(sprintf('Simulation, \\mu = %d', mu_values(1)), sprintf('Theory, \\mu = %d', mu_values(1)), sprintf('Simulation, \\mu = %d', mu_values(2)), sprintf('Theory, \\mu = %d', mu_values(2)), sprintf('Simulation, \\mu = %d', mu_values(3)), sprintf('Theory, \\mu = %d', mu_values(3)), sprintf('Simulation, \\mu = %d', mu_values(4)), sprintf('Theory, \\mu = %d', mu_values(4)));



