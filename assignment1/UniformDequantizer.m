function deq_val = UniformDequantizer(q_ind,n_bits,xmax,m)
L = 2^n_bits; % quantization levels
delta = 2*xmax/L; % quantization interval width
values = -xmax + (1-m)*delta/2 + (0:L-1)*delta; % values vector
deq_val = values(q_ind+1); % find the corresponding value for q_ind
end