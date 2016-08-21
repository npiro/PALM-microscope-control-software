classdef (Sealed) ModeNumber

properties  (Constant)
     Piston =1
     TiltX = 2
     TiltY = 3 
     Defocus = 4
     Astigmatism45 = 5
     Astigmatism = 6 
     ComaX = 7 
     ComaY = 8 
     Trefoil45 = 9
     Trefoil = 10
     Spherical = 11
     Astigmatism245 = 12
     Astigmatism2 = 13
     Trefoil135 = 14
     Trefoil90 = 15
end %constant properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
methods (Access = private)
%private so that you can't instatiate.
    function out = ModeNumber
    end %Colors()
end %private methods
end %class Colors
