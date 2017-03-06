function out = uint82int8(in)
    if in < 127
        out = in;
    else
        out = -int8(uint8(128) - (uint8(in) - uint8(128)));
    end
    
end