
clc;clear all;
close all;
close all hidden;
%about tcp protocol
bufferLen = 393+2;% 
TCPServer = tcpip('localhost',1234,'NetworkRole','server');
set(TCPServer,'InputBufferSize',bufferLen);
%set(TCPServer,'Terminator','#');
set(TCPServer,'Timeout',10);
fopen(TCPServer);

%intel 5300 is a wifi adapter with 40MHz channel support and 116 subcarier
carrier_frequency = 5.32*10^9;%2.437*10^9
channel_space = 40*10^6/30;
antenna_space = 0.225;

sub_freq_delta = channel_space;
wrapped_packet_number = 2;
total_pks = [];
 while 1 < break_condition
     while(1)
         nBytes = get(TCPServer,'BytesAvailable');
         if nBytes >= bufferLen
%              disp('read bytes ');disp(nBytes);
              break;
         end
     end
     i = i + 1;
     
     x = linspace(1+i*N,N+i*N,N);
     
     data = fread(TCPServer,nBytes,'uint8');
     flushinput(TCPServer);
     data = data(4:length(data));
%      disp(length(data));
     if length(data) == 392  % this means that we receive a valid package, if not parse the package will enconter error
         % here we use another way to plot the data
%          disp('valide data');
         d = uint8(data);
         csi = read_bfee(d);
         
%% To do something here

     else
         continue;
     end
 end

 
fclose(TCPServer);
disp('server closed');
