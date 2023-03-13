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
    q_error = x - deq_val;
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