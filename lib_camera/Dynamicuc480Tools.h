//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///
//###########################################################################//
//#                                                                         #//
//#     (c) 2006 - 2009                                                     #//
//#                                                                         #//
//###########################################################################//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///

// Dynamicuc480Tools.h: interface for the dynamic loading of the uc480_tools.dll


#pragma once
#include "uc480_tools.h"

#define DECLARE_FUNCTION(name) DLL_##name name

class CDynamicuc480Tools
{

typedef INT (__stdcall* DLL_isavi_InitAVI)			(INT* pnAviID,HCAM hcam);
typedef INT (__stdcall* DLL_isavi_ExitAVI)			(INT nAviID);
typedef INT (__stdcall* DLL_isavi_SetImageSize)		(INT nAviID,INT cMode, long Width, long Height, long PosX, long PosY, long LineOffset);
typedef INT (__stdcall* DLL_isavi_OpenAVI)			(INT nAviID, const char* strFileName);
typedef INT (__stdcall* DLL_isavi_CloseAVI)			(INT nAviID);
typedef INT (__stdcall* DLL_isavi_StartAVI)			(INT nAviID);
typedef INT (__stdcall* DLL_isavi_StopAVI)			(INT nAviID);
typedef INT (__stdcall* DLL_isavi_AddFrame)			(INT nAviID,char *pcImageMem);
typedef INT (__stdcall* DLL_isavi_SetFrameRate)		(INT nAviID,double fr);
typedef INT (__stdcall* DLL_isavi_SetImageQuality)	(INT nAviID,int q);
typedef INT (__stdcall* DLL_isavi_GetAVISize)		(INT nAviID,float *size);
typedef INT (__stdcall* DLL_isavi_GetAVIFileName)	(INT nAviID, char* strName);

typedef INT (__stdcall* DLL_isavi_GetnCompressedFrames)(INT nAviID,unsigned long *nFrames);
typedef INT (__stdcall* DLL_isavi_GetnLostFrames)		(INT nAviID,unsigned long *nLostFrames);
typedef INT (__stdcall* DLL_isavi_ResetFrameCounters)	(INT nAviID);

typedef INT (__stdcall* DLL_isavi_InitEvent)		(INT nAviID, HANDLE hEv, INT which);
typedef INT (__stdcall* DLL_isavi_EnableEvent)		(INT nAviID, INT which);
typedef INT (__stdcall* DLL_isavi_DisableEvent)		(INT nAviID, INT which);
typedef INT (__stdcall* DLL_isavi_ExitEvent)		(INT nAviID, INT which);


public:
    CDynamicuc480Tools ();
    virtual ~CDynamicuc480Tools ();

    bool Exit ();
    bool Init ();

    DECLARE_FUNCTION(isavi_InitAVI);
	DECLARE_FUNCTION(isavi_ExitAVI);
	DECLARE_FUNCTION(isavi_SetImageSize);
	DECLARE_FUNCTION(isavi_OpenAVI);
	DECLARE_FUNCTION(isavi_StartAVI);
	DECLARE_FUNCTION(isavi_CloseAVI);
	DECLARE_FUNCTION(isavi_StopAVI);
	DECLARE_FUNCTION(isavi_AddFrame);
	DECLARE_FUNCTION(isavi_SetFrameRate);
	DECLARE_FUNCTION(isavi_SetImageQuality);
	DECLARE_FUNCTION(isavi_GetAVISize);
	DECLARE_FUNCTION(isavi_GetAVIFileName);
	DECLARE_FUNCTION(isavi_GetnCompressedFrames);
	DECLARE_FUNCTION(isavi_GetnLostFrames);	
	DECLARE_FUNCTION(isavi_ResetFrameCounters);	

	DECLARE_FUNCTION(isavi_InitEvent);	
	DECLARE_FUNCTION(isavi_EnableEvent);	
	DECLARE_FUNCTION(isavi_DisableEvent);
	DECLARE_FUNCTION(isavi_ExitEvent);
    

    bool IsLoaded () const          { return hDll != NULL; }

private:
    bool      GetFunctions     ();
    void      ReleaseFunctions ();
	HINSTANCE LoadLib          ()   { return ::LoadLibrary ("uc480_tools.dll"); }
    HINSTANCE hDll;
};

#undef DECLARE_FUNCTION


