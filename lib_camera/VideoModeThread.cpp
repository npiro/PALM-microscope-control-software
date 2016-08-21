#include "mex.h"
#include "uc480.h"

// Video modes
#define EXIT 2
#define ACQUIRE 1
#define PAUSE 0

HCAM cam;
HANDLE FrameEvent;
int *pframe;
static int CameraThreadExists = 0;
static int CameraEventExists = 0;
static int VideoMode = 0;

DWORD WINAPI SampleThread(LPVOID Pframe) {
          //mexWarnMsgTxt("thread started");
    
    while (VideoMode != EXIT) {
        if (VideoMode == ACQUIRE) {
            if ( WaitForSingleObject(FrameEvent, 5000) == WAIT_OBJECT_0){
                *(int *)Pframe = 1;
            }
            else{
            //mexWarnMsgTxt("no frame received!");
            }
        }
        else {
            Sleep(1000);
            mexWarnMsgTxt("thread is sleeping!");
        }
    }

    return 0; // Thread is destroyed when this function returns
}

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray*prhs[] ) {
    /* Check for proper number of arguments */
    if (nrhs != 3) {mexErrMsgTxt("3 inputs needed: 1) Camera handle 2) frame variable 3) function mode: 0: Create event handler, 1: Remove event handler, 2: Pause event handler, 3: Resume event handler");
    } else if (nlhs != 0) {mexErrMsgTxt("whoa, big guy.  No Outputs");
    }
    /* Assign pointers to the various parameters */
    cam = *(HCAM *)mxGetPr(prhs[0]);
    pframe = (int *)mxGetPr(prhs[1]);
    int mode = mxGetScalar(prhs[2]);
    char    ErrorStr[100];
    //sprintf(ErrorStr,"mode:%d\n",mode);
    //mexWarnMsgTxt(ErrorStr);
    switch (mode) {
        case 0: // Create event handler and thread
            if (!CameraEventExists) {
                FrameEvent = CreateEvent(NULL, TRUE, FALSE, "");
    
                is_InitEvent(cam, FrameEvent, IS_SET_EVENT_FRAME);
                is_EnableEvent(cam, IS_SET_EVENT_FRAME);
                CameraEventExists = 1;
            }
            else mexWarnMsgTxt("Camera event already exists");
            HANDLE hThread;
            DWORD dwWaitThread;
            
            if (!CameraThreadExists) {
                CameraThreadExists = 1;
                hThread = CreateThread(NULL, 0, SampleThread, pframe, 0, &dwWaitThread);
                if(hThread == NULL) {
        
                    DWORD dwError = GetLastError();
                    sprintf(ErrorStr,"Error creating thread: %d",dwError);
                    mexWarnMsgTxt("error creating thread");
                    CameraThreadExists = 0;
                    return;
                }
                CameraThreadExists = 1;
            }
            else mexWarnMsgTxt("Camera thread already exists");
            
            VideoMode = ACQUIRE;
            break;
        case 1: // Destroy event handler and thread
            VideoMode = EXIT;
            is_DisableEvent(cam, IS_SET_EVENT_FRAME);
            is_ExitEvent(cam, IS_SET_EVENT_FRAME);
            CloseHandle(FrameEvent);
            CameraEventExists = 0;
            CameraThreadExists = 0;
            break;
        case 2: // Pause event handler
            VideoMode = PAUSE;
            is_DisableEvent(cam, IS_SET_EVENT_FRAME);
            is_ExitEvent(cam, IS_SET_EVENT_FRAME);
            break;
        case 3: // Resume event handler
            VideoMode = ACQUIRE;
            is_InitEvent(cam, FrameEvent, IS_SET_EVENT_FRAME);
            is_EnableEvent(cam, IS_SET_EVENT_FRAME);
            break;
        case 4:
        default:
            VideoMode = ACQUIRE;
    }
    
    
    //     mexWarnMsgTxt("thread almost started");
    
    
    
    return;
}