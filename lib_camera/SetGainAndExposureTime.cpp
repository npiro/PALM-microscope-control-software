#include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   long MasterGain = (long)mxGetScalar(prhs[1]); // Set to 0 to keep current value
   double ExposureTime = mxGetScalar(prhs[2]); // Exposure time in ms. Set to 0 to keep current value
   double *NewExposureTime;
   /* Check for proper number of arguments */
   if (!(nrhs == 3)) {
              mexErrMsgTxt("you have to give me three inputs: Camera handle, Gain value, Exposure time (ms)"); 
   }
   /*if (!(nlhs == 1)) {
              mexErrMsgTxt("you have to give me one output: the new exposure time"); 
   }*/
   
   if (MasterGain != 0) {
    error = is_SetHardwareGain(cam,MasterGain,IS_IGNORE_PARAMETER,IS_IGNORE_PARAMETER,IS_IGNORE_PARAMETER);
    if (error != IS_SUCCESS) {
            printf("errorCode: %d\n", error);
            mexErrMsgTxt("Error setting gain"); 
    }
   }
   if (ExposureTime != 0) {
    if (!(nlhs == 1)) {
         mexErrMsgTxt("you have to give me one output: the new exposure time"); 
    }
    plhs[0]=mxCreateDoubleMatrix(1,1, mxREAL);
    NewExposureTime = mxGetPr(plhs[0]);
    error = is_SetExposureTime(cam,ExposureTime,NewExposureTime);
    if (error != IS_SUCCESS) {
            printf("errorCode: %d\n", error);
            mexErrMsgTxt("Error setting gain");
            
    }
    
                
    
   }
   return;
}