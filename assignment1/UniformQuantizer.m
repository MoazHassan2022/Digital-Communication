function quantized = UniformQuantizer(in_val, n_bits, xmax, m)
% number of levels
L = 2 ^ n_bits;
delta = 2 * xmax / L;
if (m == 0)
% midrise
quantized = floor((in_val + delta) / delta);
quantized = quantized + abs(min(quantized)) + 1;
else
% midtread
quantized = round((in_val + xmax) / delta) + 1;
end
quantized(quantized >= L) = L;
end