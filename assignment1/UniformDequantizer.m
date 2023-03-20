function deq = UniformDequantizer(q_ind, n_bits, xmax, m)
% number of levels
L = 2 ^ n_bits;
delta = 2 * xmax / L;
% vector represents levels
levels = ((1 - m) * delta/2) - xmax : delta : ((1 - m) * delta/2) + xmax;
deq = levels(q_ind);
end
