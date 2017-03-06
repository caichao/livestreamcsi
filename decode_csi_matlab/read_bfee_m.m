function outcell = read_bfee_m(inBytes)
%this function is used to replace the function read_bfee by mex file
% the original mex file is not very stable when the sampling frequency is
% leveled up

% remeber in matlab, the index starts from 1, not zero 0;
	timestamp_low = int32(inBytes(1)) + (int32(inBytes(2)) * pow2(8) ) + int32((inBytes(3)) * pow2(16)) + int32(inBytes(4)) * pow2(24);
	bfee_count = uint16(inBytes(5)) + uint16(inBytes(6)) * pow2(8);
	Nrx = uint16(inBytes(9));
	Ntx = uint16(inBytes(10));
	rssi_a = uint16(inBytes(11));
	rssi_b = uint16(inBytes(12));
	rssi_c = uint16(inBytes(13));
	noise = uint82int8(inBytes(14));
	agc = uint16(inBytes(15));
	antenna_sel = uint16(inBytes(16));
	len = uint16(inBytes(17)) + (uint16(inBytes(18)) * pow2(8));
	fake_rate_n_flags = uint16(inBytes(19)) + (uint16(inBytes(20)) * pow2(8));
	calc_len = (30 * (Nrx * Ntx * 8 * 2 + 3) + 7) / 8;
	payload = inBytes(21:length(inBytes));
	
    outcell.timstamp_low = timestamp_low;
    outcell.bfee_count = bfee_count;
    outcell.Nrx = Nrx;
    outcell.Ntx = Ntx;
    outcell.rssi_a = rssi_a;
    outcell.rssi_b = rssi_b;
    outcell.rssi_c = rssi_c;
    outcell.noise = noise;
    outcell.agc = agc;
    outcell.rate = fake_rate_n_flags;
    
    
% 	size = {Ntx, Nrx, 30};
% 	csi = cell(3, size, mxDOUBLE_CLASS, mxCOMPLEX);
% 	mwSize perm_size() = {1, 3};
% 	mxArray *perm = mxCreateNumericArray(2, perm_size, mxDOUBLE_CLASS, mxREAL);
% 	double* ptrR = (double *)mxGetPr(csi);
% 	double* ptrI = (double *)mxGetPi(csi);

% 	/* Check that length matches what it should */
	if len ~= calc_len
% 		mexErrMsgIdAndTxt("MIMOToolbox:read_bfee_new:size","Wrong beamforming matrix size.");
        disp('Wrong beamforming matrix size');
        exit(0);
    end

% 	/* Compute CSI from all this crap :) */
% 	for (i = 0; i < 30; ++i)
% 	{
% 		index += 3;
% 		remainder = index % 8;
% 		for (j = 0; j < Nrx * Ntx; ++j)
% 		{
% 			tmp = (payload(index / 8) >> remainder) |
% 				(payload(index/8+1) << (8-remainder));
% 			//printf("%d\n", tmp);
% 			*ptrR = (double) tmp;
% 			++ptrR;
% 			tmp = (payload(index / 8+1) >> remainder) |
% 				(payload(index/8+2) << (8-remainder));
% 			*ptrI = (double) tmp;
% 			++ptrI;
% 			index += 16;
% 		}
% 	}
 % the CSI matrix format is Tx * Rx * subcarrieer
    tmpR = 0;
    tmpI = 0;
    %csi = zeros(Ntx,Nrx,30);
    index = 0;
    for m = 1:1:30
        index = index + 3;
        remainder = mod(index,8);
        for j = 1:1:Nrx
            for k = 1:1:Ntx
%                 tmpR = bitor(uint8(payload(fix(index / 8) +1)/pow2(remainder)), uint8((payload(fix(index / 8) +2)*pow2(8-remainder))));
%                 tmpI = bitor(uint8(payload(fix(index / 8) +2)/pow2(remainder)), uint8((payload(fix(index / 8) +3)*pow2(8-remainder))));
                tmpR = expandableor(uint8(fix(double(payload(fix(index / 8) +1))/pow2(remainder))),shift(payload(fix(index / 8) +2),(8-remainder)));
                tmpI = expandableor(uint8(fix(double(payload(fix(index / 8) +2))/pow2(remainder))),shift(payload(fix(index / 8) +3),(8-remainder)));
                %tmpR = uint82int8(tmpR);
                %tmpI = uint82int8(tmpI);
                csi(k,j,m) = double(tmpR) + double(tmpI)*1i;
                index = index + 16;
            end
        end       
    end
    
% 	/* Compute the permutation array */
% 	ptrR = (double *)mxGetPr(perm);
% 	ptrR(0) = (bitand(antenna_sel,3)) + 1;
% 	ptrR(1) = (bitand(fix((antenna_sel / 4)) , 3)) + 1;
% 	ptrR(2) = (bitand((fix(antenna_sel / 8)) , 3)) + 1;
    
    outcell.csi = csi;
%     outcell.perm = ptrR;

end