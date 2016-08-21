#include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
 
   /* Check for proper number of arguments */
   if (!(nrhs == 5)) {
              mexErrMsgTxt("you have to give me five input: camera hendle, x, y, width, height"); 
   }
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   int x = (int)mxGetScalar(prhs[1]);
   int y = (int)mxGetScalar(prhs[2]);
   int width = (int)mxGetScalar(prhs[3]);
   int height = (int)mxGetScalar(prhs[4]);
   
 
   error = is_SetAOI( cam, IS_SET_IMAGE_AOI, &x, &y, &width, &height);
   if (error != IS_SUCCESS) {
            printf("errorCode: %d\npositions: %d %d %d %d\n", error,x,y,width,height);
            mexErrMsgTxt("Error setting AOI"); 
   }
   return;   
}

