#include "mex.h"
#include "uc480.h"
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
   int error;
   int BitsPerPixel = 8;
   int x,y,width,height;
   double *xd,*yd,*widthd,*heightd;
   /* Check for proper number of arguments */
   if (!(nrhs == 1)) {
              mexErrMsgTxt("you have to give me one input: camera handle"); 
   }
   if (!(nlhs == 4)) {
              mexErrMsgTxt("you have to give me four outputs: x, y, width, height"); 
   }
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
    plhs[0]=mxCreateDoubleMatrix(1,1, mxREAL);
    plhs[1]=mxCreateDoubleMatrix(1,1, mxREAL);
    plhs[2]=mxCreateDoubleMatrix(1,1, mxREAL);
    plhs[3]=mxCreateDoubleMatrix(1,1, mxREAL);
    
    xd=mxGetPr(plhs[0]);
    yd=mxGetPr(plhs[1]);
    widthd=mxGetPr(plhs[2]);
    heightd=mxGetPr(plhs[3]);
    //y = mxGetPr(plhs[1]);
    //width = mxGetPr(plhs[2]);
    //height = mxGetPr(plhs[3]);
    error = is_SetAOI( cam, IS_GET_IMAGE_AOI, &x, &y, &width, &height);
    *xd = (double)x;
    *yd = (double)y;
    *widthd = (double)width;
    *heightd = (double)height;
    
    if (error != IS_SUCCESS) {
            printf("errorCode: %d\n", error);
            mexErrMsgTxt("Error setting AOI"); 
    }
    
    
    
   
   return;   
}

