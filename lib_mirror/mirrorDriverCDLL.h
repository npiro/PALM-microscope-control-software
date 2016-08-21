/***********************************************************************
*
*	mirrorDriverCDLL.h
*
*	C-like interface to Mirror Driver 
*
*	this interface can be directly imported in the Matlab environment
*	by using "importLibrary" ...
*
*	copyright (c) ADAPTICA 2008
*
***********************************************************************/


#ifndef _MIRROR_DRIVER_CDLL_H
#define _MIRROR_DRIVER_CDLL_H


// function prototypes
#ifdef __cplusplus
extern "C" {
#endif


	// define glue functs


	/*********************************************************
	 *	connect to mirror
	 *
	 * entry:
	 *		none
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 /*********************************************************/
	__declspec(dllexport) int	mirrorDriverInit(void);


	/*********************************************************
	 *	set a single mirror channel
	 *
	 * entry:
	 *		val = value
	 *		chnum = channel num.
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 /*********************************************************/
	__declspec(dllexport) int	setMirrorSingleChannel(float val,int chnum);


	/*********************************************************
	/*	set mirror channels
	 *
	 * entry:
	 *		val = pointer to float array
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) int	setMirrorChannels(float *val);


	/*********************************************************
	/*	get mirror channels current status
	 *
	 * entry:
	 *		vals = pointer to float array
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) int	getMirrorChannelsStatus(float* vals);


	/*********************************************************
	/*	get mirror single channel current status
	 *
	 * entry:
	 *		chn = channel num.
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) float getMirrorSingleChannelStatus(int chn);


	/*********************************************************
	/*	get number of mirror channels
	 *
	 * entry:
	 *		none
	 * exit:
	 *		num of channels
	 **********************************************************/
	__declspec(dllexport) int	getNumMirrorChannels(void);


	/*********************************************************
	/*	get mirror driver current version 
	 *
	 * entry:
	 *		none
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) float getDriverVersion(void);

	/*********************************************************
	/*	get ip address
	 *
	 * entry:
	 *		none
	 * exit:
	 *		Returns the local ip address.
	 **********************************************************/
	__declspec(dllexport) char*	getServerIPAddress(void);

		/*********************************************************
	/*	set ip address
	 *
	 * entry:
	 *		char* ip address
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) int	configIPAddress(char* ip);



	/*********************************************************
	/*	close the connection with mirror
	 *
	 * entry:
	 *		none
	 * exit:
	 *		Returns TRUE for success, and FALSE for failure.
	 **********************************************************/
	__declspec(dllexport) int	mirrorDriverClose(void);


#ifdef __cplusplus
}
#endif

#endif






