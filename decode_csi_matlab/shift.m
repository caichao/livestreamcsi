function out = shift(in,n)
% this function emulate the left shift function in c
% with the uppper bit ignored and low bit is filled with zeros
    tmp = uint8(0);
    tmp = pow2(n);
    tmp1 = uint16(tmp) * uint16(in);
    %tmp = uint8(mod(tmp1,pow2(n)));
    %out = uint82int8(tmp);
    out = tmp1;
end