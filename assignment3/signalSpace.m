function [v1, v2] = signalSpace(s, phi1, phi2)
	v1 = dot(s, phi1) / length(s);
	v2 = dot(s, phi2) / length(s);
end
