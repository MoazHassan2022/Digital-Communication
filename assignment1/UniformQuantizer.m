function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
L = 2^n_bits; % quantization levels
delta = 2*xmax/L; % quantization interval width
offset = (m == 0) * delta / 2; % midrise
levels = linspace(-xmax+offset, xmax-offset, L);
q_ind = zeros(size(in_val)); % initialize output vector
for i=1:length(in_val)
    [~, ind] = min(abs(levels-in_val(i))); % find closest level
    q_ind(i) = ind-1; % get index starting from 0
end
end