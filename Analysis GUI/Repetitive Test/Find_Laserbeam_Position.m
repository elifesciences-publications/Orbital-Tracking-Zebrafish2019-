function [Xmax, Ymax] = Find_Laserbeam_Position(Data)
%FIND_BRIGHTEST_PIXEL Finds the brightest Pixel in an image and performs a center of mass analysis to find the position of the reflected laser beam.
%   This function finds the center of mass of the intensity profile of the
%   reflected laser beam.
Max=0;
Xmax=0;
Ymax=0;
Size=size(Data,1);

for i=1:Size
   for j=1:Size
        if Data(i,j) >= Max
            Ymax=j;
            Xmax=i;
            Max=Data(i,j);
        end
   end
end

%%Center of Mass for brightest pixel

Window_Size=10;
Datanew=Data(Xmax-Window_Size:Xmax+Window_Size,Ymax-Window_Size:Ymax+Window_Size);
xData=mean(Datanew,1);
yData=mean(Datanew,2);
Sum_Masses_x=sum(xData);
Sum_Masses_y=sum(yData);
Vector_x=(Xmax-Window_Size:1:Xmax+Window_Size);
Vector_y=(Ymax-Window_Size:1:Ymax+Window_Size);
Xmax=round(sum(xData.*Vector_x)/Sum_Masses_x);
Ymax=round(sum(yData.*Vector_y')/Sum_Masses_y);

end

