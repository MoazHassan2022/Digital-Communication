% test 3
x = -6:0.01:6;
n_bits = 3;
xmax = 6;
m = 0; % midrise
q_ind_midrise = UniformQuantizer(x, n_bits, xmax, m);
deq_val_midrise = UniformDequantizer(q_ind_midrise,n_bits,xmax,m);

m = 1; % midtread
q_ind_midtread = UniformQuantizer(x, n_bits, xmax, m);
deq_val_midtread = UniformDequantizer(q_ind_midtread,n_bits,xmax,m);

plot(x, deq_val_midrise),
xlabel('input'); ylabel('dequantized');
title('Quantization/Dequantization with midrise');
figure;
plot(x, deq_val_midtread),
xlabel('input'); ylabel('dequantized');
title('Quantization/Dequantization with midtread');

% test 4
x = -5 + (10).*rand(10000,1); % using rand function
xmax = 5;
m = 0; % midrise
SNR_sim_vec = zeros(7,1);
SNR_theo_vec = zeros(7,1);
for n_bits = 2:1:8
    quantized = UniformQuantizer(x,n_bits,xmax,m);
    deq = UniformDequantizer(quantized,n_bits,xmax,m).';
    q_error = x - deq;
    SNR_sim_vec(n_bits-1) = mag2db(mean(x.^2)/mean(q_error.^2)); 
    L = 2^n_bits;
    SNR_theo_vec(n_bits-1) = mag2db(mean(x.^2) *((3*(L^2))/(xmax^2)));
end

nbits_vec = 2:1:8;
figure();
plot(nbits_vec,SNR_sim_vec);
hold on;
plot(nbits_vec,SNR_theo_vec);
hold off;
xlabel('number of bits'); ylabel('SNR (dB)'); title('SNR vs Number of bits');

% test 5
m = 0;
sign = 2 * randi([0 1], 1, 10000) - 1;
x = sign .* exprnd(1, 1, 10000);
xmax = max(abs(x));
SNR_theo_vec = zeros(7, 1);
SNR_sim_vec = zeros(7, 1);
for n_bits = 2:1:8
quantized = UniformQuantizer(x, n_bits, xmax, m);
deq = UniformDequantizer(quantized, n_bits, xmax, m);
q_error = x - deq;
L = 2 ^ n_bits;
SNR_sim_vec(n_bits - 1) = mag2db(mean(x.^2) / mean(q_error.^2));
SNR_theo_vec(n_bits - 1) = mag2db(mean(x.^2) * ((3*(L^2))/(xmax^2)));
end

nbits_vec = 2:1:8;
figure();
plot(nbits_vec, SNR_theo_vec);
hold on
plot(nbits_vec, SNR_sim_vec);
title('Quantization/Dequantization on non-uniform random input');
xlabel('number of bits');
ylabel('SNR (dB)');

% test 6
m = 0;
mu = 200;
sign = 2 * randi([0 1], 1, 10000) - 1;
x = sign .* exprnd(1, 1, 10000);
xmax = max(abs(x));
SNR_theo_vec = zeros(7, 1);
SNR_sim_vec = zeros(7, 1);
% compress input
compressed = sign .* (log(1 + mu * abs(x / xmax)) / log(1 + mu));
for n_bits = 2:1:8
quantized = UniformQuantizer(compressed, n_bits, max(compressed), m);
deq = UniformDequantizer(quantized, n_bits, max(compressed), m);
% expande the signal again
expanded = sign .* (((1 + mu).^ abs(deq) - 1) / mu);
% denormailze the signal
final = expanded * xmax;
q_error = x - final;
L = 2 ^ n_bits;
SNR_sim_vec(n_bits - 1) = mag2db(mean(x.^2) / mean(q_error.^2));
SNR_theo_vec(n_bits - 1) = mag2db(3*(L^2)/(log(1+mu))^2);
end

nbits_vec = 2:1:8;
figure();
plot(nbits_vec, SNR_theo_vec);
hold on
plot(nbits_vec, SNR_sim_vec);
title('Quantization/Dequantization on non-uniform random input with mu = 200');
xlabel('number of bits');
ylabel('SNR (dB)');