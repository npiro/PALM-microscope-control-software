//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///
//###########################################################################//
//#                                                                         #//
//# Functions here will be wrapped automatically                            #//
//# in the Cuc480Dll class.                                                 #//
//#                                                                         #//
//#     (c) 2004 - 2009                                                     #//
//#                                                                         #//
//###########################################################################//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///

// USBCAMEXP is_StopLiveVideo          (HCAM hf, INT Wait);
USB2CAMERA_MACRO_DO(StopLiveVideo)
DECLARE((HCAM hf, INT Wait))

// USBCAMEXP is_FreezeVideo            (HCAM hf, INT Wait);
USB2CAMERA_MACRO_DO(FreezeVideo)
DECLARE((HCAM hf, INT Wait))
 
// USBCAMEXP is_CaptureVideo           (HCAM hf, INT Wait);
USB2CAMERA_MACRO_DO(CaptureVideo)
DECLARE((HCAM hf, INT Wait))
 
// USBCAMEXP is_IsVideoFinish          (HCAM hf, BOOL* pbo);
USB2CAMERA_MACRO_DO(IsVideoFinish)
DECLARE((HCAM hf, BOOL* pbo))

// USBCAMEXP is_HasVideoStarted        (HCAM hf, BOOL* pbo);
USB2CAMERA_MACRO_DO(HasVideoStarted)
DECLARE((HCAM hf,  BOOL* pbo))

// USBCAMEXP is_SetBrightness          (HCAM hf, INT Bright);
USB2CAMERA_MACRO_DO(SetBrightness)
DECLARE((HCAM hf, INT Bright))

// USBCAMEXP is_SetContrast            (HCAM hf, INT Cont);
USB2CAMERA_MACRO_DO(SetContrast)
DECLARE((HCAM hf, INT Cont))

// USBCAMEXP is_SetGamma               (HCAM hf, INT nGamma);
USB2CAMERA_MACRO_DO(SetGamma)
DECLARE((HCAM hf, INT Mode))

// USBCAMEXP is_AllocImageMem          (HCAM hf, INT width, INT height, INT bitspixel, char** ppcImgMem, int* pid);
USB2CAMERA_MACRO_DO(AllocImageMem)
DECLARE((HCAM hf, INT width, INT height, INT bitspixel, char** ppcImgMem, int* pid))

// USBCAMEXP is_SetImageMem            (HCAM hf, char* pcMem, int id);
USB2CAMERA_MACRO_DO(SetImageMem)
DECLARE((HCAM hf, char* pcMem, int id))

// SBCAMEXP is_FreeImageMem           (HCAM hf, char* pcMem, int id);
USB2CAMERA_MACRO_DO(FreeImageMem)
DECLARE((HCAM hf, char* pcMem, int id))

// USBCAMEXP is_GetImageMem            (HCAM hf, VOID** pMem);
USB2CAMERA_MACRO_DO(GetImageMem)
DECLARE((HCAM hf, VOID** pMem))

// USBCAMEXP is_GetActiveImageMem      (HCAM hf, char** ppcMem, int* pnID);
USB2CAMERA_MACRO_DO(GetActiveImageMem)
DECLARE((HCAM hf, char** pccMem, int* pnID ))

// USBCAMEXP is_InquireImageMem        (HCAM hf, char* pcMem, int nID, int* pnX, int* pnY, int* pnBits, int* pnPitch);
USB2CAMERA_MACRO_DO(InquireImageMem)
DECLARE((HCAM hf, char* pcMem, int nID, int* pnX, int* pnY, int* pnBits, int* pnPitch))

// USBCAMEXP is_GetImageMemPitch       (HCAM hf, INT* pPitch);
USB2CAMERA_MACRO_DO(GetImageMemPitch)
DECLARE((HCAM hf, INT* pPitch))

// USBCAMEXP is_SetAllocatedImageMem   (HCAM hf, INT width, INT height, INT bitspixel, char* pcImgMem, int* pid);
USB2CAMERA_MACRO_DO(SetAllocatedImageMem)
DECLARE((HCAM hf, INT width, INT height, INT bitspixel, char* pcImgMem, int* pid))

// USBCAMEXP is_SaveImageMem           (HCAM hf, char* File, char* pcMem, int nID);
USB2CAMERA_MACRO_DO(SaveImageMem)
DECLARE((HCAM hf, char* File, char* pcMem, int nID))

// USBCAMEXP is_CopyImageMem           (HCAM hf, char* pcSource, int nID, char* pcDest);
USB2CAMERA_MACRO_DO(CopyImageMem)
DECLARE((HCAM hf, char* pcSource, int nID, char* pcDest))

// USBCAMEXP is_CopyImageMemLines      (HCAM hf, char* pcSource, int nID, int nLines, char* pcDest);
USB2CAMERA_MACRO_DO(CopyImageMemLines)
DECLARE((HCAM hf, char* pcSource, int nID, int nLines, char* pcDest))

// USBCAMEXP is_AddToSequence          (HCAM hf, char* pcMem, INT nID);
USB2CAMERA_MACRO_DO(AddToSequence)
DECLARE((HCAM hf, char* pcImgMem, int nId))

// USBCAMEXP is_ClearSequence          (HCAM hf);
USB2CAMERA_MACRO_DO(ClearSequence)
DECLARE((HCAM hf))

// USBCAMEXP is_GetActSeqBuf           (HCAM hf, INT* pnNum, char** ppcMem, char** ppcMemLast);
USB2CAMERA_MACRO_DO(GetActSeqBuf)
DECLARE((HCAM hf, INT* pnNum, char** ppcMem, char** ppcMemLast))

// USBCAMEXP is_LockSeqBuf             (HCAM hf, INT nNum, char* pcMem);
USB2CAMERA_MACRO_DO(LockSeqBuf)
DECLARE((HCAM hf, INT nNum, char* pcMem))

// USBCAMEXP is_UnlockSeqBuf           (HCAM hf, INT nNum, char* pcMem);
USB2CAMERA_MACRO_DO(UnlockSeqBuf)
DECLARE((HCAM hf, INT nNum, char* pcMem))

// USBCAMEXP is_SetImageSize           (HCAM hf, INT x, INT y);
USB2CAMERA_MACRO_DO(SetImageSize)
DECLARE((HCAM hf, INT x, INT y))

// USBCAMEXP is_SetImagePos            (HCAM hf, INT x, INT y);
USB2CAMERA_MACRO_DO(SetImagePos)
DECLARE((HCAM hf, INT x, INT y))

// USBCAMEXP is_GetError               (HCAM hf, INT* pErr, char** ppcErr);
USB2CAMERA_MACRO_DO(GetError)
DECLARE((HCAM hf, INT* pErr, char** ppcErr))

// USBCAMEXP is_SetErrorReport         (HCAM hf, INT Mode);
USB2CAMERA_MACRO_DO(SetErrorReport)
DECLARE((HCAM hf, INT Mode))

// USBCAMEXP is_ReadEEPROM             (HCAM hf, INT Adr, char* pcString, INT Count);
USB2CAMERA_MACRO_DO(ReadEEPROM)
DECLARE((HCAM hf, INT Adr, char* pcString, INT Count))

// USBCAMEXP is_WriteEEPROM            (HCAM hf, INT Adr, char* pcString, INT Count);
USB2CAMERA_MACRO_DO(WriteEEPROM)
DECLARE((HCAM hf, INT Adr, char* pcString, INT Count))

// USBCAMEXP is_SaveImage              (HCAM hf, char* File);
USB2CAMERA_MACRO_DO(SaveImage)
DECLARE((HCAM hf, char* File))

// USBCAMEXP is_SetColorMode           (HCAM hf, INT Mode);
USB2CAMERA_MACRO_DO(SetColorMode)
DECLARE((HCAM hf, INT Mode))

// USBCAMEXP is_GetColorDepth          (HCAM hf, INT* pnCol, INT* pnColMode);
USB2CAMERA_MACRO_DO(GetColorDepth)
DECLARE((HCAM hf, INT* pnCol, INT* pnColMode))

// USBCAMEXP is_RenderBitmap       (HCAM hf, INT nMemID, HWND hwnd, INT nMode);
USB2CAMERA_MACRO_DO(RenderBitmap)
DECLARE((HCAM hf, INT nMemID, HWND hwnd, INT nMode))

// USBCAMEXP is_SetDisplayMode         (HCAM hf, INT Mode);
USB2CAMERA_MACRO_DO(SetDisplayMode)
DECLARE((HCAM hf, INT Mode))

// USBCAMEXP is_GetDC                  (HCAM hf, HDC* phDC);
USB2CAMERA_MACRO_DO(GetDC)
DECLARE((HCAM hf, HDC* phDC))

// USBCAMEXP is_ReleaseDC              (HCAM hf, HDC hDC);
USB2CAMERA_MACRO_DO(ReleaseDC)
DECLARE((HCAM hf, HDC hDC))

// USBCAMEXP is_UpdateDisplay          (HCAM hf);
USB2CAMERA_MACRO_DO(UpdateDisplay)
DECLARE((HCAM hf))

// USBCAMEXP is_SetDisplaySize         (HCAM hf, INT x, INT y);
USB2CAMERA_MACRO_DO(SetDisplaySize)
DECLARE((HCAM hf, INT x, INT y))

// USBCAMEXP is_SetDisplayPos          (HCAM hf, INT x, INT y);
USB2CAMERA_MACRO_DO(SetDisplayPos)
DECLARE((HCAM hf, INT x, INT y))

// USBCAMEXP is_LockDDOverlayMem       (HCAM hf, VOID** ppMem, INT* pPitch);
USB2CAMERA_MACRO_DO(LockDDOverlayMem)
DECLARE((HCAM hf, VOID** ppMem, INT* pPitch))

// USBCAMEXP is_UnlockDDOverlayMem     (HCAM hf);
USB2CAMERA_MACRO_DO(UnlockDDOverlayMem)
DECLARE((HCAM hf))

// USBCAMEXP is_LockDDMem              (HCAM hf, VOID** ppMem, INT* pPitch);
USB2CAMERA_MACRO_DO(LockDDMem)
DECLARE((HCAM hf, VOID** ppMem, INT* pPitch))

// USBCAMEXP is_UnlockDDMem            (HCAM hf);
USB2CAMERA_MACRO_DO(UnlockDDMem)
DECLARE((HCAM hf))

// USBCAMEXP is_GetDDOvlSurface        (HCAM hf, void** ppDDSurf);
USB2CAMERA_MACRO_DO(GetDDOvlSurface)
DECLARE((HCAM hf, void** ppDDSurf))

// USBCAMEXP is_SetKeyColor            (HCAM hf, INT r, INT g, INT b);
USB2CAMERA_MACRO_DO(SetKeyColor)
DECLARE((HCAM hf, INT r, INT g, INT b ))

// USBCAMEXP is_PrepareStealVideo      (HCAM hf, int Mode, ULONG StealColorMode);
USB2CAMERA_MACRO_DO(PrepareStealVideo)
DECLARE((HCAM hf, int Mode, ULONG StealColorMode))

// USBCAMEXP is_StealVideo             (HCAM hf, int Wait);
USB2CAMERA_MACRO_DO(StealVideo)
DECLARE((HCAM hf, int Wait))

// USBCAMEXP is_SetHwnd                (HCAM hf, HWND hwnd);
USB2CAMERA_MACRO_DO(SetHwnd)
DECLARE((HCAM hf, HWND hwnd))

// USBCAMEXP is_GetVsyncCount          (HCAM hf, long* pIntr, long* pActIntr);
USB2CAMERA_MACRO_DO(GetVsyncCount)
DECLARE((HCAM hf, long* pIntr, long* pActIntr))

// USBCAMEXP is_GetOsVersion           ();
USB2CAMERA_MACRO_DO(GetOsVersion)
DECLARE((void))

//  USBCAMEXP is_GetDllVersion()
USB2CAMERA_MACRO_DO(GetDLLVersion)
DECLARE((void))

// USBCAMEXP is_InitEvent              (HCAM hf, HANDLE hEv, INT which);
USB2CAMERA_MACRO_DO(InitEvent)
DECLARE((HCAM hf, HANDLE hEv, INT which))

// USBCAMEXP is_ExitEvent              (HCAM hf, INT which);
USB2CAMERA_MACRO_DO(ExitEvent)
DECLARE((HCAM hf, INT which))

// USBCAMEXP is_EnableEvent            (HCAM hf, INT which);
USB2CAMERA_MACRO_DO(EnableEvent)
DECLARE((HCAM hf, INT which))

// USBCAMEXP is_DisableEvent           (HCAM hf, INT which);
USB2CAMERA_MACRO_DO(DisableEvent)
DECLARE((HCAM hf, INT which))

// USBCAMEXP is_SetIO                  (HCAM hf, INT nIO);
USB2CAMERA_MACRO_DO(SetIO)
DECLARE((HCAM hf, INT nIO))

// USBCAMEXP is_SetFlashStrobe         (HCAM hf, INT nMode, INT nLine);
USB2CAMERA_MACRO_DO(SetFlashStrobe)
DECLARE((HCAM hf, INT nMode, INT nLine))

// USBCAMEXP is_SetExternalTrigger     (HCAM hf, INT nTriggerMode);
USB2CAMERA_MACRO_DO(SetExternalTrigger)
DECLARE((HCAM hf, INT nTriggerMode))

// USBCAMEXP is_SetTriggerCounter      (HCAM hf, INT nValue);
USB2CAMERA_MACRO_DO(SetTriggerCounter)
DECLARE((HCAM hf, INT nValue))

// USBCAMEXP is_SetRopEffect           (HCAM hf, INT effect, INT param, INT reserved);
USB2CAMERA_MACRO_DO(SetRopEffect)
DECLARE((HCAM hf, INT effect, INT param, INT reserved))

// USBCAMEXP is_InitCamera		(HCAM* phf, HWND hWnd)
USB2CAMERA_MACRO_DO(InitCamera)
DECLARE((HCAM* phf, HWND hWnd))

// USBCAMEXP is_ExitCamera		(HCAM* phf, HWND hWnd)
USB2CAMERA_MACRO_DO(ExitCamera)
DECLARE((HCAM hf))

// USBCAMEXP is_GetCameraInfo		(HCAM hf, PCAMINFO pInfo)
USB2CAMERA_MACRO_DO(GetCameraInfo)
DECLARE((HCAM hf, PCAMINFO pInfo))

// USBCAMEXPUL is_CameraStatus		(HCAM hf, INT nInfo, ULONG ulValue)
USB2CAMERA_MACRO_DO(CameraStatus)
DECLARE((HCAM hf, INT nInfo, ULONG ulValue))

// USBCAMEXP is_GetCameraType		(HCAM hf)
USB2CAMERA_MACRO_DO(GetCameraType)
DECLARE((HCAM hf))

// USBCAMEXP is_GetNumberOfCameras		(INT* pnNumCams)
USB2CAMERA_MACRO_DO(GetNumberOfCameras)
DECLARE((INT* pnNumCams))

// USBCAMEXP is_GetPixelClockRange( HCAM hf, double *min, double *max, double *intervall );
USB2CAMERA_MACRO_DO(GetPixelClockRange)
DECLARE(( HCAM hf, INT *pnMIn, INT *pnMax ))

// USBCAMEXP is_SetPixelClock       (HCAM hf, INT nClockt);
USB2CAMERA_MACRO_DO(SetPixelClock)
DECLARE((HCAM hf, INT nClock))

// USBCAMEXP is_GetUsedBandwidth( HCAM hf );
USB2CAMERA_MACRO_DO(GetUsedBandwidth)
DECLARE(( HCAM hf ))

// USBCAMEXP is_GetFrameTimeRange( HCAM hf, double *min, double *max, double *intervall );
USB2CAMERA_MACRO_DO(GetFrameTimeRange)
DECLARE(( HCAM hf, double *min, double *max, double *intervall ))

// USBCAMEXP is_SetFrameRate           ( HCAM hf, double FPS, double* newFPS )
USB2CAMERA_MACRO_DO(SetFrameRate)
DECLARE(( HCAM hf, double FPS, double* newFPS ))

// USBCAMEXP is_GetExposureRange( HCAM hf, double *min, double *max, double *intervall );
USB2CAMERA_MACRO_DO(GetExposureRange)
DECLARE(( HCAM hf, double *min, double *max, double *intervall ))

// USBCAMEXP is_SetExposureTime           ( HCAM hf, double EXP, double* newEXP )
USB2CAMERA_MACRO_DO(SetExposureTime)
DECLARE(( HCAM hf, double EXP, double* newEXP ))

// USBCAMEXP is_GetFramesPerSecond           ( HCAM hf, double *dblFPS )
USB2CAMERA_MACRO_DO(GetFramesPerSecond)
DECLARE(( HCAM hf, double *dblFPS ))

// USBCAMEXP is_SetIOMask       (HCAM hf, INT nMask);
USB2CAMERA_MACRO_DO(SetIOMask)
DECLARE((HCAM hf, INT nMask))

// USBCAMEXP is_GetSensorInfo           (HCAM hf, PSENSORINFO pInfo )
USB2CAMERA_MACRO_DO(GetSensorInfo)
DECLARE((HCAM hf, PSENSORINFO pInfo ))

// USBCAMEXP is_GetRevisionInfo        (HCAM hf, PREVISIONINFO prevInfo);
USB2CAMERA_MACRO_DO(GetRevisionInfo)
DECLARE((HCAM hf, PREVISIONINFO prevInfo))

// USBCAMEXP is_EnableAutoExit           ( HCAM hf, INT nMode )
USB2CAMERA_MACRO_DO(EnableAutoExit)
DECLARE(( HCAM hf, INT nMode ))

// USBCAMEXP is_EnableMessage           (HCAM hf, INT which, HWND hWnd)
USB2CAMERA_MACRO_DO(EnableMessage)
DECLARE((HCAM hf, INT which, HWND hWnd))

// USBCAMEXP is_SetHardwareGain           (HCAM hf, INT nMaster, INT nRed, INT nGreen, INT nBlue )
USB2CAMERA_MACRO_DO(SetHardwareGain)
DECLARE((HCAM hf, INT nMaster, INT nRed, INT nGreen, INT nBlue ))

// USBCAMEXP is_SetRenderMode           ( HCAM hf, INT Mode )
USB2CAMERA_MACRO_DO(SetRenderMode)
DECLARE(( HCAM hf, INT Mode ))

// USBCAMEXP is_SetWhiteBalance           ( HCAM hf, INT nMode )
USB2CAMERA_MACRO_DO(SetWhiteBalance)
DECLARE(( HCAM hf, INT nMode ))

// USBCAMEXP is_SetWhiteBalanceMultipliers           ( HCAM hf, double dblRed, double dblGreen, double dblBlue )
USB2CAMERA_MACRO_DO(SetWhiteBalanceMultipliers)
DECLARE(( HCAM hf, double dblRed, double dblGreen, double dblBlue ))

// USBCAMEXP is_GetWhiteBalanceMultipliers           ( HCAM hf, double *pdblRed, double *pdblGreen, double *pdblBlue )
USB2CAMERA_MACRO_DO(GetWhiteBalanceMultipliers)
DECLARE(( HCAM hf, double *pdblRed, double *pdblGreen, double *pdblBlue ))

// USBCAMEXP is_SetEdgeEnhancement		( HCAM hf, INT nEnable )
USB2CAMERA_MACRO_DO(SetEdgeEnhancement)
DECLARE(( HCAM hf, INT nEnable ))

// USBCAMEXP is_SetColorCorrection		( HCAM hf, INT nEnable, double *factors )
USB2CAMERA_MACRO_DO(SetColorCorrection)
DECLARE(( HCAM hf, INT nEnable, double *factors ))

// USBCAMEXP is_SetBlCompensation		( HCAM hf, INT nEnable, INT offset, INT reserved )
USB2CAMERA_MACRO_DO(SetBlCompensation)
DECLARE(( HCAM hf, INT nEnable, INT offset, INT reserved ))

// USBCAMEXP is_SetBadPixelCorrection( HCAM hf, INT nEnable, INT threshold )
USB2CAMERA_MACRO_DO(SetBadPixelCorrection)
DECLARE(( HCAM hf, INT nEnable, INT threshold ))

// USBCAMEXP is_LoadBadPixelCorrectionTable( HCAM hf, char *File )
USB2CAMERA_MACRO_DO(LoadBadPixelCorrectionTable)
DECLARE(( HCAM hf, char *File ))

// USBCAMEXP is_SaveBadPixelCorrectionTable( HCAM hf, char *File )
USB2CAMERA_MACRO_DO(SaveBadPixelCorrectionTable)
DECLARE(( HCAM hf, char *File ))

// USBCAMEXP is_SetBadPixelCorrectionTable( HCAM hf, INT nMode, WORD *pList )
USB2CAMERA_MACRO_DO(SetBadPixelCorrectionTable)
DECLARE(( HCAM hf, INT nMode, WORD *pList ))

// USBCAMEXP is_SetMemoryMode( HCAM hf, INT nCount, INT nDelay );
USB2CAMERA_MACRO_DO(SetMemoryMode)
DECLARE((HCAM hf, INT nCount, INT nDelay ))

// USBCAMEXP is_TransferImage(  HCAM hf, INT nMemID, INT seqID, INT imageNr, INT reserved );
USB2CAMERA_MACRO_DO(TransferImage)
DECLARE((  HCAM hf, INT nMemID, INT seqID, INT imageNr, INT reserved ))

// USBCAMEXP is_TransferMemorySequence( HCAM hf, INT seqID, INT StartNr, INT nCount, INT nSeqPos );
USB2CAMERA_MACRO_DO(TransferMemorySequence)
DECLARE(( HCAM hf, INT seqID, INT StartNr, INT nCount, INT nSeqPos ))

// USBCAMEXP is_MemoryFreezeVideo( (HCAM hf, INT nMemID, INT Wait );
USB2CAMERA_MACRO_DO(MemoryFreezeVideo)
DECLARE(( HCAM hf, INT nMemID, INT Wait ))

// USBCAMEXP is_GetLastMemorySequence( HCAM hf, INT *pID );
USB2CAMERA_MACRO_DO(GetLastMemorySequence)
DECLARE(( HCAM hf, INT *pID ))

// USBCAMEXP is_GetNumberOfMemoryImages( HCAM hf, INT pID, INT *pnCount );
USB2CAMERA_MACRO_DO(GetNumberOfMemoryImages)
DECLARE(( HCAM hf, INT pID, INT *pnCount ))

// USBCAMEXP is_GetMemorySequenceWindow( HCAM hf, INT nID, INT *left, INT *top, INT *right, INT *bottom );
USB2CAMERA_MACRO_DO(GetMemorySequenceWindow)
DECLARE(( HCAM hf, INT nID, INT *left, INT *top, INT *right, INT *bottom ))

// USBCAMEXP is_IsMemoryBoardConnected( HCAM hf, BOOL* pConnected  );
USB2CAMERA_MACRO_DO(IsMemoryBoardConnected)
DECLARE(( HCAM hf, BOOL* pConnected  ))

// USBCAMEXP is_ResetMemory( HCAM hf );
USB2CAMERA_MACRO_DO(ResetMemory)
DECLARE(( HCAM hf, INT nReserved ))

// USBCAMEXP is_SetSubSampling( HCAM hf, INT mode );
USB2CAMERA_MACRO_DO(SetSubSampling)
DECLARE(( HCAM hf, INT mode ))

// USBCAMEXP is_ForceTrigger( HCAM hf );
USB2CAMERA_MACRO_DO(ForceTrigger)
DECLARE(( HCAM hf ))

// USBCAMEXP is_GetBusSpeed( HCAM hf )
USB2CAMERA_MACRO_DO(GetBusSpeed)
DECLARE(( HCAM hf  ))

// USBCAMEXP is_SetBinning( HCAM hf, INT mode );
USB2CAMERA_MACRO_DO(SetBinning)
DECLARE(( HCAM hf, INT mode ))

// USBCAMEXP is_ResetToDefault( HCAM hf );
USB2CAMERA_MACRO_DO(ResetToDefault)
DECLARE(( HCAM hf ))

// USBCAMEXP is_LoadParameters( HCAM hf );
USB2CAMERA_MACRO_DO(LoadParameters)
DECLARE(( HCAM hf, char* pFilename ))

// USBCAMEXP is_SaveParameters( HCAM hf );
USB2CAMERA_MACRO_DO(SaveParameters)
DECLARE(( HCAM hf, char* pFilename ))

// USBCAMEXP is_GetGlobalFlashDelays( HCAM hf, ULONG *pulDelay, ULONG *pulDuration );
USB2CAMERA_MACRO_DO(GetGlobalFlashDelays)
DECLARE(( HCAM hf, ULONG *pulDelay, ULONG *pulDuration ))

// USBCAMEXP is_SetFlashDelay( HCAM hf, ULONG ulDelay, ULONG ulDuration );
USB2CAMERA_MACRO_DO(SetFlashDelay)
DECLARE(( HCAM hf, ULONG ulDelay, ULONG ulDuration  ))

// USBCAMEXP is_LoadImage              (HCAM hf, char* File);
USB2CAMERA_MACRO_DO(LoadImage)
DECLARE((HCAM hf, char* File))

// USBCAMEXP is_SetImageAOI( HCAM hf, INT xPos, INT yPos, INT width, INT height );
USB2CAMERA_MACRO_DO(SetImageAOI)
DECLARE(( HCAM hf, INT xPos, INT yPos, INT width, INT height  ))

// USBCAMEXP is_SetCameraID( HCAM hf, INT nID );
USB2CAMERA_MACRO_DO(SetCameraID)
DECLARE(( HCAM hf, INT nID  ))

// USBCAMEXP is_SetBayerConversion( HCAM hf, INT nMode );
USB2CAMERA_MACRO_DO(SetBayerConversion)
DECLARE(( HCAM hf, INT nMode  ))

// USBCAMEXP is_SetTestImage( HCAM hf, INT nMode );
USB2CAMERA_MACRO_DO(SetTestImage)
DECLARE(( HCAM hf, INT nMode  ))

// USBCAMEXP is_SetHardwareGamma( HCAM hf, INT nMode );
USB2CAMERA_MACRO_DO(SetHardwareGamma)
DECLARE(( HCAM hf, INT nMode  ))

// USBCAMEXP is_GetCameraList                (PUC480_CAMERA_LIST pucl);
USB2CAMERA_MACRO_DO(GetCameraList)
DECLARE((PUC480_CAMERA_LIST pucl))

// USBCAMEXP is_SetAOI                       (HCAM hf, INT type, INT *pXPos, INT *pYPos, INT *pWidth, INT *pHeight);
USB2CAMERA_MACRO_DO(SetAOI)
DECLARE((HCAM hf, INT type, INT *pXPos, INT *pYPos, INT *pWidth, INT *pHeight))

// USBCAMEXP is_SetAutoParameter             (HCAM hf, INT param, double *pval1, double *pval2);
USB2CAMERA_MACRO_DO(SetAutoParameter)
DECLARE((HCAM hf, INT param, double *pval1, double *pval2))

// USBCAMEXP is_GetAutoInfo                  (HCAM hf, UC480_AUTO_INFO *pInfo);
USB2CAMERA_MACRO_DO(GetAutoInfo)
DECLARE((HCAM hf, UC480_AUTO_INFO *pInfo))

// is_ConvertImage(HCAM hf, char* pcSource, int nIDSource, char** pcDest, INT *nIDDest, INT * reserve);
USB2CAMERA_MACRO_DO(ConvertImage)
DECLARE((HCAM hf, char* pcSource, int nIDSource, char** pcDest, INT *nIDDest, INT * reserve))

// USBCAMEXP is_EnableDDOverlay        (HCAM hf);
USB2CAMERA_MACRO_DO(EnableDDOverlay)
DECLARE((HCAM hf))

// USBCAMEXP is_DisableDDOverlay       (HCAM hf);
USB2CAMERA_MACRO_DO(DisableDDOverlay)
DECLARE((HCAM hf))

// USBCAMEXP is_ShowDDOverlay          (HCAM hf);
USB2CAMERA_MACRO_DO(ShowDDOverlay)
DECLARE((HCAM hf))

// USBCAMEXP is_HideDDOverlay          (HCAM hf);
USB2CAMERA_MACRO_DO(HideDDOverlay)
DECLARE((HCAM hf))

// USBCAMEXP is_SetLED                  ( HCAM hf, INT nValue );
USB2CAMERA_MACRO_DO(SetLED)
DECLARE(( HCAM hf, INT nValue  ))

// USBCAMEXP is_SetGlobalShutter        ( HCAM hf, INT mode );
USB2CAMERA_MACRO_DO(SetGlobalShutter)
DECLARE(( HCAM hf, INT mode  ))

// USBCAMEXP is_SetConvertParam         (HCAM hf, BOOL ColorCorrection, INT BayerConversionMode, INT ColorMode, INT Gamma, double* WhiteBalanceMultipliers);
USB2CAMERA_MACRO_DO(SetConvertParam)
DECLARE((HCAM hf, BOOL ColorCorrection, INT BayerConversionMode, INT ColorMode, INT Gamma, double* WhiteBalanceMultipliers))

// USBCAMEXP is_GetImageHistogram       (HCAM hf, int nID, INT ColorMode, DWORD* pHistoMem);
USB2CAMERA_MACRO_DO(GetImageHistogram)
DECLARE((HCAM hf, int nID, INT ColorMode, DWORD* pHistoMem))

// USBCAMEXP is_SetGainBoost            (HCAM hf, INT mode);
USB2CAMERA_MACRO_DO(SetGainBoost)
DECLARE((HCAM hf, INT mode ))

// USBCAMEXP is_SetExtendedRegister     ( HCAM hf, INT index,WORD value);
USB2CAMERA_MACRO_DO(SetExtendedRegister)
DECLARE(( HCAM hf, INT index,WORD value))

// USBCAMEXP is_SetHWGainFactor         (HCAM hf, INT nMode, INT nFactor);
USB2CAMERA_MACRO_DO(SetHWGainFactor)
DECLARE((HCAM hf, INT nMode, INT nFactor ))

//USBCAMEXP is_GetExtendedRegister      (HCAM hf, INT index, WORD *pwValue)
USB2CAMERA_MACRO_DO(GetExtendedRegister)
DECLARE((HCAM hf, INT index, WORD *pwValue))

//USBCAMEXP is_GetHdrMode      (HCAM hf, INT *Mode)
USB2CAMERA_MACRO_DO(GetHdrMode)
DECLARE((HCAM hf, INT *Mode))

//USBCAMEXP is_EnableHdr      (HCAM hf, INT Enable)
USB2CAMERA_MACRO_DO(EnableHdr)
DECLARE((HCAM hf, INT Enable))

// USBCAMEXP is_SetHdrKneepoints (HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize)
USB2CAMERA_MACRO_DO(SetHdrKneepoints)
DECLARE(( HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize ))

// USBCAMEXP is_GetHdrKneepoints (HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize)
USB2CAMERA_MACRO_DO(GetHdrKneepoints)
DECLARE(( HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize ))

// USBCAMEXP is_GetHdrKneepointInfo (HCAM hf, KNEEPOINTINFO *KneepointInfo, INT KneepointInfoSize)
USB2CAMERA_MACRO_DO(GetHdrKneepointInfo)
DECLARE(( HCAM hf, KNEEPOINTINFO *KneepointInfo, INT KneepointInfoSize ))

// USBCAMEXP is_SetOptimalCameraTiming (HCAM hf, INT Mode, INT Timeout, INT *pMaxPxlClk, double *pMaxFrameRate)
USB2CAMERA_MACRO_DO(SetOptimalCameraTiming)
DECLARE(( HCAM hf, INT Mode, INT Timeout, INT *pMaxPxlClk, double *pMaxFrameRate))



// UC480CAMEXP is_GetEthDeviceInfo	( HCAM hf, UC480_ETH_DEVICE_INFO* pDeviceInfo, UINT uStructSize);
USB2CAMERA_MACRO_DO(GetEthDeviceInfo)
DECLARE(( HCAM hf, UC480_ETH_DEVICE_INFO* pDeviceInfo, UINT uStructSize ))

// UC480CAMEXP is_SetPersistentIpCfg	( HCAM hf, UC480_ETH_IP_CONFIGURATION* pIpCfg, UINT uStructSize);
USB2CAMERA_MACRO_DO(SetPersistentIpCfg)
DECLARE(( HCAM hf, UC480_ETH_IP_CONFIGURATION* pIpCfg, UINT uStructSize ))

// UC480CAMEXP is_SetStarterFirmware	( HCAM hf, const CHAR* pcFilepath, UINT uFilepathLen);
USB2CAMERA_MACRO_DO(SetStarterFirmware)
DECLARE(( HCAM hf, const CHAR* pcFilepath, UINT uFilepathLen ))

// UC480CAMEXP is_SetAutoCfgIpSetup	( INT iAdapterID, const UC480_ETH_AUTOCFG_IP_SETUP* pSetup, UINT uStructSize);
USB2CAMERA_MACRO_DO(SetAutoCfgIpSetup)
DECLARE(( INT iAdapterID, const UC480_ETH_AUTOCFG_IP_SETUP* pSetup, UINT uStructSize ))

// UC480CAMEXP is_SetPacketFilter	( INT iAdapterID, UINT uFilterSetting);
USB2CAMERA_MACRO_DO(SetPacketFilter)
DECLARE(( INT iAdapterID, UINT uFilterSetting ))

//	UC480CAMEXP is_GetComportNumber	(HCAM hf, UINT *ComportNumber);
USB2CAMERA_MACRO_DO(GetComportNumber)
DECLARE((HCAM hf, UINT *ComportNumber))

//	UC480CAMEXP is_GetSupportedTestImages (HCAM hf, INT *SupportedTestImages);
USB2CAMERA_MACRO_DO(GetSupportedTestImages)
DECLARE((HCAM hf, INT *SupportedTestImages))

//	UC480CAMEXP is_GetTestImageValueRange (HCAM hf, INT TestImage, INT *TestImageValueMin, INT *TestImageValueMax);
USB2CAMERA_MACRO_DO(GetTestImageValueRange)
DECLARE((HCAM hf, INT TestImage, INT *TestImageValueMin, INT *TestImageValueMax))

//	UC480CAMEXP is_SetSensorTestImage (HCAM hf, INT Param1, INT Param2);
USB2CAMERA_MACRO_DO(SetSensorTestImage)
DECLARE((HCAM hf, INT Param1, INT Param2))

//  UC480CAMEXP is_SetCameraLUT       (HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue)
USB2CAMERA_MACRO_DO(SetCameraLUT)
DECLARE((HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue))

//  UC480CAMEXP is_GetCameraLUT       (HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue)
USB2CAMERA_MACRO_DO(GetCameraLUT)
DECLARE((HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue))

//  UC480CAMEXP is_SetColorConverter  (HCAM hf, INT ColorMode, INT ConvertMode)
USB2CAMERA_MACRO_DO(SetColorConverter)
DECLARE((HCAM hf, INT ColorMode, INT ConvertMode))

//  UC480CAMEXP is_GetColorConverter  (HCAM hf, INT ColorMode, INT *pCurrentConvertMode, INT *pDefaultConvertMode, INT *pSupportedConvertModes)
USB2CAMERA_MACRO_DO(GetColorConverter)
DECLARE((HCAM hf, INT ColorMode, INT *pCurrentConvertMode, INT *pDefaultConvertMode, INT *pSupportedConvertModes))
 
// UC480CAMEXP is_GetCaptureErrorInfo (HCAM hf, UC480_CAPTURE_ERROR_INFO *pCaptureErrorInfo, UINT SizeCaptureErrorInfo);
USB2CAMERA_MACRO_DO(GetCaptureErrorInfo)
DECLARE((HCAM hf, UC480_CAPTURE_ERROR_INFO *pCaptureErrorInfo, UINT SizeCaptureErrorInfo))

//  UC480CAMEXP is_ResetCaptureErrorInfo (HCAM hf);
USB2CAMERA_MACRO_DO(ResetCaptureErrorInfo)
DECLARE((HCAM hf))

//  UC480CAMEXP is_WaitForNextImage (HCAM hf, UINT timeout, char **ppcMem, INT *imageID)
USB2CAMERA_MACRO_DO(WaitForNextImage)
DECLARE(( HCAM hf, UINT timeout, char **ppcMem, INT *imageID ))

//  UC480CAMEXP is_InitImageQueue (HCAM hf, INT nMode)
USB2CAMERA_MACRO_DO(InitImageQueue)
DECLARE(( HCAM hf, INT nMode ))

//  UC480CAMEXP is_ExitImageQueue (HCAM hf)
USB2CAMERA_MACRO_DO(ExitImageQueue)
DECLARE(( HCAM hf ))

// UC480CAMEXP is_SetTimeout  (HCAM hf, UINT nMode, UINT Timeout)
USB2CAMERA_MACRO_DO(SetTimeout)
DECLARE(( HCAM hf, UINT nMode, UINT Timeout ))

// UC480CAMEXP is_GetTimeout  (HCAM hf, UINT nMode, UINT *pTimeout)
USB2CAMERA_MACRO_DO(GetTimeout)
DECLARE(( HCAM hf, UINT nMode, UINT *pTimeout ))

// UC480CAMEXP is_GetSensorScalerInfo   (HCAM hf, SENSORSCALERINFO *pSensorScalerInfo, INT nSensorScalerInfoSize)
USB2CAMERA_MACRO_DO(GetSensorScalerInfo)
DECLARE(( HCAM hf, SENSORSCALERINFO *pSensorScalerInfo, INT nSensorScalerInfoSize ))

// UC480CAMEXP is_SetSensorScaler        (HCAM hf, UINT nMode, double dblFactor) 
USB2CAMERA_MACRO_DO(SetSensorScaler)
DECLARE(( HCAM hf, UINT nMode, double dblFactor ))

// UC480CAMEXP is_GetImageInfo           (HCAM hf, INT nID, UC480IMAGEINFO *pImageInfo, INT ImageInfoSize)
USB2CAMERA_MACRO_DO(GetImageInfo)
DECLARE(( HCAM hf, INT nID, UC480IMAGEINFO *pImageInfo, INT ImageInfoSize ))

// UC480CAMEXP is_GetDuration            (HCAM hf, UINT nMode, INT* pnTime)
USB2CAMERA_MACRO_DO(GetDuration)
DECLARE(( HCAM hf, UINT nMode, INT *pnTime ))

// UC480CAMEXP is_DirectRenderer         (HCAM hf, UINT nMode, void *pParam, UINT SizeOfParam)
USB2CAMERA_MACRO_DO(DirectRenderer)
DECLARE(( HCAM hf, UINT nMode, void *pParam, UINT SizeOfParam ))
