function Tab_Selection(~,Tab_Selection)
%TAB_SELECTION Summary of this function goes here
%   Detailed explanation goes here
   State=Tab_Selection.NewValue.Title;
   
   if strcmp(State,'Trajectory') == true 
      Update_Tab1;
   elseif strcmp(State,'Identify Active States') == true 
      Update_Tab2;
   elseif strcmp(State,'Population Identification') == true 
      Update_Tab3;    
   elseif strcmp(State,'Summarize Trajectory Data') == true 
      Update_Tab4;  
   elseif strcmp(State,'Video Analysis & Rendering') == true 
      Update_Tab5;
             
   else
       
               
   end



