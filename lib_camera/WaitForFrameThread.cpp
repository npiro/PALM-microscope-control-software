   #include "mex.h"
   #include "uc480.h"
   HCAM cam;
   HANDLE FrameEvent;
   int *pframe;
   DWORD WINAPI SampleThread(LPVOID Pframe)
    {   
   //      mexWarnMsgTxt("thread started");
   
       if ( WaitForSingleObject(FrameEvent, 5000) != WAIT_OBJECT_0){
           mexWarnMsgTxt("no frame received!");
       }
       else{
       //      mexWarnMsgTxt("frame!");   
   }
 
   is_DisableEvent(cam, IS_SET_EVENT_FRAME);
   is_ExitEvent(cam, IS_SET_EVENT_FRAME);
   CloseHandle(FrameEvent);
   
   *(int *)Pframe = 1;
   
   return 0;
   }
   void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
   {     
   /* Check for proper number of arguments */
   if (nrhs != 2) {mexErrMsgTxt("2 inputs"); 
   } else if (nlhs != 0) {mexErrMsgTxt("whoa, big guy.  No Outputs"); 
   }     
   /* Assign pointers to the various parameters */         
   cam = *(HCAM *)mxGetPr(prhs[0]);
   pframe = (int *)mxGetPr(prhs[1]);
   
   FrameEvent = CreateEvent(NULL, TRUE, FALSE, "");
   
   is_InitEvent(cam, FrameEvent, IS_SET_EVENT_FRAME);
   is_EnableEvent(cam, IS_SET_EVENT_FRAME);
   
   //     mexWarnMsgTxt("thread almost started");
   
   HANDLE hThread;
   DWORD dwWaitThread;
   hThread = CreateThread(NULL,0,SampleThread,pframe,0,&dwWaitThread);
   if(hThread == NULL)
   {
       
       DWORD dwError = GetLastError();
       mexWarnMsgTxt("error creating thread");
       return;     
   }
   
   return;   
   }