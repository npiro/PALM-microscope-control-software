//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///
//###########################################################################//
//#                                                                         #//
//#     (c) 2006 - 2009                                                     #//
//#                                                                         #//
//###########################################################################//
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\///


#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include "Dynamicuc480tools.h"


CDynamicuc480Tools::CDynamicuc480Tools ()
{
    hDll = NULL;
    ReleaseFunctions ();
}


CDynamicuc480Tools::~CDynamicuc480Tools ()
{
    ReleaseFunctions ();
}

/*#############################################################################
    GET_FUNCTION macro
    loads a function from the DLL.
    If loading fails, false is stored in ret. If lodaing is successfull,
    ret is not changed.
#############################################################################*/

    #define GET_FUNCTION(ret,name) if((name=(DLL_##name)GetProcAddress(hDll,#name))==NULL)ret=false

/*#############################################################################
    GetFunctions
    Load all the functions in the DLL
#############################################################################*/
bool CDynamicuc480Tools::GetFunctions ()
{
    if (IsLoaded ())
        ReleaseFunctions ();


    if ((hDll = LoadLib ()) == NULL)
        return false;

	

    bool ret = true;
	
	GET_FUNCTION(ret, isavi_InitAVI);
	GET_FUNCTION(ret, isavi_ExitAVI);
	GET_FUNCTION(ret, isavi_SetImageSize);
	GET_FUNCTION(ret, isavi_OpenAVI);
	GET_FUNCTION(ret, isavi_CloseAVI);
	GET_FUNCTION(ret, isavi_StartAVI);
	GET_FUNCTION(ret, isavi_StopAVI);
	GET_FUNCTION(ret, isavi_AddFrame);
	GET_FUNCTION(ret, isavi_SetFrameRate);
	GET_FUNCTION(ret, isavi_SetImageQuality);
	GET_FUNCTION(ret, isavi_GetAVISize);
	GET_FUNCTION(ret, isavi_GetAVIFileName);
	GET_FUNCTION(ret, isavi_GetnCompressedFrames);
	GET_FUNCTION(ret, isavi_GetnLostFrames);	
	GET_FUNCTION(ret, isavi_ResetFrameCounters);

	GET_FUNCTION(ret, isavi_InitEvent);
	GET_FUNCTION(ret, isavi_EnableEvent);
	GET_FUNCTION(ret, isavi_DisableEvent);
	GET_FUNCTION(ret, isavi_ExitEvent);
    
    return ret;
}

#undef GET_FUNCTION

/*#############################################################################
    RELEASE_FUNCTION macro
    Set the function pointer back to 0
#############################################################################*/
#define RELEASE_FUNCTION(name) name=NULL;

/*#############################################################################
    ReleaseFunctions
    Release all loaded functions and free the DLL
#############################################################################*/
void CDynamicuc480Tools::ReleaseFunctions ()
{
    RELEASE_FUNCTION(isavi_InitAVI);
	RELEASE_FUNCTION(isavi_ExitAVI);
	RELEASE_FUNCTION(isavi_SetImageSize);
	RELEASE_FUNCTION(isavi_OpenAVI);
	RELEASE_FUNCTION(isavi_CloseAVI);
	RELEASE_FUNCTION(isavi_StartAVI);
	RELEASE_FUNCTION(isavi_StopAVI);
	RELEASE_FUNCTION(isavi_AddFrame);
	RELEASE_FUNCTION(isavi_SetFrameRate);
	RELEASE_FUNCTION(isavi_SetImageQuality);
	RELEASE_FUNCTION(isavi_GetAVISize);
	RELEASE_FUNCTION(isavi_GetAVIFileName);
	RELEASE_FUNCTION(isavi_GetnCompressedFrames);
	RELEASE_FUNCTION(isavi_GetnLostFrames);	
	RELEASE_FUNCTION(isavi_ResetFrameCounters);

	RELEASE_FUNCTION(isavi_InitEvent);
	RELEASE_FUNCTION(isavi_EnableEvent);
	RELEASE_FUNCTION(isavi_DisableEvent);
	RELEASE_FUNCTION(isavi_ExitEvent);

    if (hDll != NULL)
        FreeLibrary (hDll);
    hDll = NULL;

}

#undef RELEASE_FUNCTION


/*#############################################################################
    Init
    Try to load the functions, it it fails, abort and release all loaded
    functions
#############################################################################*/
bool CDynamicuc480Tools::Init ()
{
    if (!GetFunctions())
    {
        ReleaseFunctions();
        return false;
    }
    return true;
}

/*#############################################################################
    Exit
    Release all loaded functions and free the DLL
#############################################################################*/
bool CDynamicuc480Tools::Exit()
{
    ReleaseFunctions();
    return true;
}

