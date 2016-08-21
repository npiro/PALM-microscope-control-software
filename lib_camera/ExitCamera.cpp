 #include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   
   /* Check for proper number of arguments */
   if (!(nrhs == 1 || nrhs == 2)) {
              mexErrMsgTxt("you have to give me one or two inputs"); 
   }
   
   error = is_ExitCamera(cam);
   if (error != IS_SUCCESS) {
            printf("errorCode: %d\n", error);
            mexErrMsgTxt("Error exiting camera"); 
   }
   return;   
}

