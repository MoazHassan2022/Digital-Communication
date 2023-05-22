function [phi1, phi2] = GM_Bases(s1, s2)
	phi1 = s1 / sqrt(dot(s1, s1));
	
	v2 = s2 - dot(s2, phi1) * phi1;
	phi2 = v2 / sqrt(dot(v2, v2));
	
	phi1 = phi1 * sqrt(length(s1));
	phi2 = phi2 * sqrt(length(s2));
end
