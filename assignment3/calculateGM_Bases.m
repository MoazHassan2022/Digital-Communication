function [phi1, phi2] = calculateGM_Bases(s1, s2)
    phi1 = s1 / norm(s1);
    
    v2 = s2 - dot(s2, phi1) * phi1;
    phi2 = v2 / norm(v2);
    
    phi1 = phi1 * sqrt(numel(s1));
    phi2 = phi2 * sqrt(numel(s2));
end