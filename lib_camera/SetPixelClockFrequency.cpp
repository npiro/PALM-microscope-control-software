#include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   int PixelClockFrequency = (int)mxGetScalar(prhs[1]); // Frame rate
   double *NewPixelClockFrequency;
   /* Check for proper number of arguments */
   if (!(nrhs == 2)) {
              mexErrMsgTxt("you have to give me two inputs: Camera handle, Pixel clock frequency (MHz)"); 
   }
   /*if (!(nlhs == 1)) {
              mexErrMsgTxt("you have to give me one output: the new exposure time"); 
   }*/
   
   
   if (PixelClockFrequency != 0) {
    if (!(nlhs == 1)) {
         mexErrMsgTxt("you have to give me one output: the new frane rate"); 
    }
    plhs[0]=mxCreateDoubleMatrix(1,1, mxREAL);
    NewPixelClockFrequency = mxGetPr(plhs[0]);
    error = is_SetPixelClock(cam,PixelClockFrequency);
    if (error != IS_SUCCESS) {
        *NewPixelClockFrequency=(double)is_SetPixelClock(cam,IS_GET_PIXEL_CLOCK);
    }    
    else
        *NewPixelClockFrequency = (double)PixelClockFrequency;
   }
   return;
}