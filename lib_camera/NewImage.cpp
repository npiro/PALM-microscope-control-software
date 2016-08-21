 #include "mex.h"
#include "uc480.h"
   void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
   {     
       int error;
   int BitsPerPixel = 8;
   HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
   
   /* Check for proper number of arguments */
   if (!(nrhs == 1 || nrhs == 2)) {mexErrMsgTxt("you have to give me one or two inputs"); 
   }
   
   //Get sensor info, principally for the CDD size 
   SENSORINFO sInfo;
   int nX,nY;
   
   error = is_GetSensorInfo( cam, &sInfo );
   nX = sInfo.nMaxWidth;
   nY = sInfo.nMaxHeight;
   
   if (error != IS_SUCCESS) {mexErrMsgTxt("Error getting sensor info"); 
   }
  
   //If no input image structure, make a new one
   if (nrhs == 1){
        if (nlhs != 1) {mexErrMsgTxt("One input requires one output for this program, Bub"); 
   } 
       
       //create matlab image structure with "image" field of uint8 data type,
   //"pointer" field with int-valued pointer to the image buffer,
   // and "ID" field with int-valued ID for this buffer.
   char *pimage; 
   
   const char *field_names[] = {"image", "pointer", "ID"};
   mwSize dims[2] = {1, 1 };
   plhs[0] = mxCreateStructArray(2, dims, 3, field_names);//Create image structure
   int image_field = mxGetFieldNumber(plhs[0],"image");
   int pointer_field = mxGetFieldNumber(plhs[0],"pointer");
   int ID_field = mxGetFieldNumber(plhs[0],"ID");
   
   mxArray *pimage_field;
   pimage_field = mxCreateNumericMatrix(nX,nY, mxUINT8_CLASS,mxREAL);
   mxSetFieldByNumber(plhs[0],0,image_field,pimage_field); 
   //image array 2nd output, 1st field
   pimage = (char *)mxGetPr(pimage_field);
       
   //set the camera memory to the matlab image array
   int *ID,*ppointer;
   
   mxArray *ppointer_field;
   ppointer_field = mxCreateNumericMatrix(1, 1, mxINT32_CLASS,mxREAL);
   mxSetFieldByNumber(plhs[0],0,pointer_field,ppointer_field); 
   //image memory pointer 2nd output, 2nd field
    ppointer = (int *)mxGetPr(ppointer_field);
   *ppointer = (int)pimage;
   
   mxArray *pID_field;
   pID_field = mxCreateNumericMatrix(1, 1, mxINT32_CLASS,mxREAL);
   mxSetFieldByNumber(plhs[0],0,ID_field,pID_field); 
   //image memory pointer 2nd output, 3rd field
    ID = (int *)mxGetPr(pID_field);
  
   //Set I.image to be memory buffer for camera, using its pointer, and 
   //creating the "ID" for this memory buffer
    error = is_SetAllocatedImageMem(cam,nX,nY,BitsPerPixel,pimage,ID);
   
   if (error != IS_SUCCESS) {mexErrMsgTxt("Error allocating image memory"); 
   }
   
   //Activate I.image memory
   error = is_SetImageMem(cam,pimage,*ID);

   if (error !=IS_SUCCESS){mexErrMsgTxt("Error activating image memory"); 
   }
   } 
   //If they give two inputs, the second is taken as an existing image
   //structure and used.
   else if (nrhs == 2){    
       if (nlhs != 0) {mexErrMsgTxt("Two inputs requires no outputs for this program, Bub"); 
   } else if (!mxIsStruct(prhs[1])){
       mexErrMsgTxt("That second input has to be an image structure, you know.");
   }
   const char *field_names[] = {"image", "pointer", "ID"};
   
   int image_field = mxGetFieldNumber(prhs[1],"image");
   int pointer_field = mxGetFieldNumber(prhs[1],"pointer");
   int ID_field = mxGetFieldNumber(prhs[1],"ID");
   
   mxArray *ppointer_field = mxGetFieldByNumber(prhs[1],0,pointer_field);
   char *pimage = (char *)*(int *)mxGetPr(ppointer_field);
   mxArray *pID_field = mxGetFieldByNumber(prhs[1],0,ID_field);
   int *ID = (int *)mxGetPr(pID_field);  
   
   //Activate I.image memory
   error = is_SetImageMem(cam,pimage,*ID);

   if (error !=IS_SUCCESS){
   mexErrMsgTxt("Error activating image memory"); 
   }
   
   }        return;   
   }
