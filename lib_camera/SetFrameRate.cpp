#include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   double FrameRate = mxGetScalar(prhs[1]); // Frame rate
   double *NewFrameRate;
   /* Check for proper number of arguments */
   if (!(nrhs == 2)) {
              mexErrMsgTxt("you have to give me three inputs: Camera handle, Gain value, Exposure time (ms)"); 
   }
   /*if (!(nlhs == 1)) {
              mexErrMsgTxt("you have to give me one output: the new exposure time"); 
   }*/
   
   
   if (FrameRate != 0) {
    if (!(nlhs == 1)) {
         mexErrMsgTxt("you have to give me one output: the new frane rate"); 
    }
    plhs[0]=mxCreateDoubleMatrix(1,1, mxREAL);
    NewFrameRate = mxGetPr(plhs[0]);
    error = is_SetFrameRate(cam,FrameRate,NewFrameRate);
    if (error != IS_SUCCESS) {
            printf("errorCode: %d\n", error);
            mexErrMsgTxt("Error setting frame rate");
            
    }
    
                
    
   }
   return;
}