#Ploting CSI in real-time
These file are basically used to plot csi in real-time using MATLAB. You need some pre-knowledge about how to extract CSI. 

## decode_csi_matlab
The files under this folder are used to parse the CSI data using MATLAB. You can use them to see how the CSI data are wraped in the .dat file and transplant them into another language. Noted that the original version to decode CSI publish on [github](http://dhalperi.github.io/linux-80211n-csitool/) mainly use fuction "read_bfee", if you want to  replace it with "read_bfee_m" written here, you will need all the files under this folder. 

## log_to_file
The files under this folder is to send the CSI data through a TCP channel.  You need to compile it using gcc. 
``` 
gcc log_to_file.c -o log 
```
You can then run 
```
sudo ./log
```
to send the data to the TCP server. If you want to save the sent data at the same time. You can give the argument, like this:
```
sudo ./log save.dat
```
The port number is 1234 in this program. You can modify in the file or make it as an input argument. You can also modify the IP address in this file and send the CSI data to another computer or broadcast the CSI data to many computers. 



##parse_code_matlab
The files under this folder is the original ones to decode the CSI data. Since it use C language to decode the CSI data, it is much more efficient. If you want to use the "realtime_plot.m" under the "realtime plot" folder, you should place these files with "realtime_plot.m" in the same directory. 

## realtime plot
The file under this folder is a TCP server acceptint realtime CSI data.  I just do some basics stuffs to decode the original CSI without any further process. You can do anything at your will. System prototype like CARM, Ubicarse, WiGest, Spotify, etc can be implemented based on this. 

## Steps to plot csi data in realtime
* step 1 : complie the log_to_file.c
```
gcc log_to_file.c -o log
```
Place this file under "netlink" folder. 
* step2 : place the files under "realtime plot" and "parse_code_matlab" in the same directory. This directory can be anywhere on your hard disk. 
* step3 : run
You should first run the server code. That is, excute "realtime_plot.m" first. Then run the log program "sudo ./log". If it is ok, you can see some print logs like "connect is ok". 
Noted that the basic steps to enable CSI can be done before or after these steps. 

If you encounter any problem, you can contact me at chao08@gmail.com.  I hope some one can make some awesome UI and share it in the community. 

MIT License

Copyright (c) 2017 Chao Cai chao08@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.