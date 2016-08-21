function WaitForFrame(cam) 
%   WaitForFrame(cam) Wait for the next frame in the Thorlabs camera

frame = int32(0);
   % disp('wating for thread m-file')
   
   WaitForFrameThread(cam,frame);
   % disp('wating for thread mex started')
   FreezeVideo(cam);
   while ~frame
       pause(.1)
   %     frame
   end
   %is_StopLiveVideo(cam,IS_WAIT);
end
