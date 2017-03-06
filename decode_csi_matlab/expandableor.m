function out = expandableor(var_uint8,var_uint16) 
% this is the expandable bitor function 
% the input elements are uint8 param and uint16 param
% the output is int8
tmp = bitor(uint16(var_uint8),var_uint16);

% retreive the lower 8bit data
tmp = mod(tmp, pow2(8));
tmp = uint8(tmp);
out = uint82int8(tmp);
end