function [Tifstack]=Read_Tifstack
%Reads in a Tif image stack and converts it to a 3D array of doubles.

%% Load Video
[fileName,filePath] = uigetfile('*.tif', 'Open Video');
if filePath==0, error('None selected!'); end
Filepath=fullfile(filePath,fileName);

InfoImage=imfinfo(Filepath);
mImage=InfoImage(1).Width;
nImage=InfoImage(1).Height;
NumberImages=size(InfoImage,1);
 
Tifstack=zeros(nImage,mImage,NumberImages,'uint16');
h=waitbar(0,'Load Video','WindowStyle','modal');
for i=1:NumberImages
   Tifstack(:,:,i)=imread(Filepath,'Index',i);
   waitbar(i/NumberImages);
end
Tifstack=double(Tifstack);

%Divide Tifstack by 2^16 Bits to normalize it to 1;
Tifstack=Tifstack/(2^16);
close(h);