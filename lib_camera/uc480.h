/*
######################################################################
#                                                                    #
# File:    uc480.h                                                   #
# Project: Library interface for the uc480 USB Camera family         #
#          exported API functions                                    #
#                                                                    #
#                                                                    #
######################################################################
*/

#ifndef __UC480_HEADER__
#define __UC480_HEADER__

#pragma pack(push, 8)

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

#if defined (_WIN64)
    #define DRIVER_DLL_NAME     "uc480_64.dll"
#else
    #define DRIVER_DLL_NAME     "uc480.dll"
#endif

#ifdef _WIN32_WCE
  typedef TCHAR IS_CHAR;
#else
  typedef char IS_CHAR;
#endif
// ----------------------------------------Color modes----------------------------------------------
//
#define IS_COLORMODE_INVALID        0
#define IS_COLORMODE_MONOCHROME     1
#define IS_COLORMODE_BAYER          2
//
// -------------------------------------------------------------------------------------------------

// CCD
#define KODAK_KAI1020M_NAME     UC"D1024G23M\0"     // ccd, 1024x1024, global, 2/3", mono
#define KODAK_KAI1020C_NAME     UC"D1024G23C\0"     // ccd, 1024x1024, global, 2/3", color
// ----------------------------------------Sensor Types---------------------------------------------
//
#define IS_SENSOR_INVALID       0x0000

// CMOS Sensors
#define IS_SENSOR_C0640R13M     0x0001		// cmos, 0640x0480, rolling, 1/3", mono, 
#define IS_SENSOR_C0640R13C     0x0002		// cmos, 0640x0480, rolling, 1/3", color, 

#define IS_SENSOR_C1280R23M     0x0003		// cmos, 1280x1024, rolling, 1/1.8", mono, 
#define IS_SENSOR_C1280R23C     0x0004		// cmos, 1280x1024, rolling, 1/1.8", color, 

#define IS_SENSOR_C1600R12C     0x0008		// cmos, 1600x1200, rolling, 1/2", color, 
#define IS_SENSOR_C2048R12C		0x000a		// cmos, 2048x1536, rolling, 1/2", color, 
#define IS_SENSOR_C2592R12C     0x000c      // cmos, 2592x1944, rolling, 1/2", color

#define IS_SENSOR_C0640G12M     0x0010		// cmos, 0640x0480, global,  1/2", mono, 
#define IS_SENSOR_C0640G12C     0x0011		// cmos, 0640x0480, global,  1/2", color, 

#define IS_SENSOR_C0752G13M		0x0012		// cmos, 0752x0480, global,  1/3", mono, 
#define IS_SENSOR_C0752G13C		0x0013		// cmos, 0752x0480, global,  1/3", color, 

#define IS_SENSOR_C1282R13C		0x0015		// cmos, 1280x1024, rolling, 1/3", color,
#define IS_SENSOR_C1601R13C		0x0017		// cmos, 1600x1200, rolling  1/3", color,

#define IS_SENSOR_C0753G13M		0x0018		// cmos, 0752x0480, global,  1/3", mono, single board
#define IS_SENSOR_C0753G13C		0x0019		// cmos, 0752x0480, global,  1/3", color, single board

#define IS_SENSOR_C0754G13M		0x0022		// cmos, 0752x0480, global,  1/3", mono,  LE Model
#define IS_SENSOR_C0754G13C     0x0023		// cmos, 0752x0480, global,  1/3", color, LE Model

#define IS_SENSOR_C1284R13C		0x0025		// cmos, 1280x1024, rolling, 1/3", color, LE Model
#define IS_SENSOR_C1604R13C		0x0027		// cmos, 1600x1200, rolling, 1/3", color, LE Model

#define IS_SENSOR_C1285R12M		0x0028		// cmos, 1280x1024, rolling, 1/2", mono,  LE Model
#define IS_SENSOR_C1285R12C		0x0029		// cmos, 1280x1024, rolling, 1/2", color, LE Model

#define IS_SENSOR_C1605R12C		0x002B		// cmos, 1600x1200, rolling, 1/2", color, LE Model
#define IS_SENSOR_C2055R12C		0x002D		// cmos, 2048x1536, rolling, 1/2", color, LE Model
#define IS_SENSOR_C2595R12C		0x002F		// cmos, 2592x1944, rolling, 1/2", color, LE Model

#define IS_SENSOR_C1280R12M		0x0030		// cmos, 1280x1024, rolling, 1/2", mono, 
#define IS_SENSOR_C1280R12C		0x0031		// cmos, 1280x1024, rolling, 1/2", color,

#define IS_SENSOR_C1283R12M		0x0032		// cmos, 1280x1024, rolling, 1/2", mono,  single board
#define IS_SENSOR_C1283R12C		0x0033		// cmos, 1280x1024, rolling, 1/2", color, single board

#define IS_SENSOR_C1603R12C      0x0035      // cmos, 1600x1200, rolling, 1/2", color, single board
#define IS_SENSOR_C2053R12C      0x0037      // cmos, 2048x1536, rolling, 1/2", color, single board
#define IS_SENSOR_C2593R12C      0x0039      // cmos, 2592x1944, rolling, 1/2", color, single board
#define IS_SENSOR_C1286R12C		0x003B		// cmos, 1280x1024, rolling, 1/2", color, single board
#define IS_SENSOR_C2053R12M_WO   0x003C      // cmos, 2048x1536, rolling, 1/2", mono,  single board
#define IS_SENSOR_C2053R12C_WO   0x003D      // cmos, 2048x1536, rolling, 1/2", color, single board
#define IS_SENSOR_C1603R12M_WO   0x0044      // cmos, 1600x1200, rolling, 1/2", mono,  single board
#define IS_SENSOR_C1603R12C_WO   0x0045      // cmos, 1600x1200, rolling, 1/2", color, single board

// CCD Sensors
#define IS_SENSOR_D1024G13M     0x0080      // ccd, 1024x0768, global, 1/3", mono, 
#define IS_SENSOR_D1024G13C		0x0081      // ccd, 1024x0768, global, 1/3", color, 

#define IS_SENSOR_D0640G13M     0x0082      // ccd, 0640x0480, global, 1/3", mono, 
#define IS_SENSOR_D0640G13C     0x0083      // ccd, 0640x0480, global, 1/3", color,

#define IS_SENSOR_D1281G12M     0x0084      // ccd, 1280x1024, global, 1/2", mono, 
#define IS_SENSOR_D1281G12C     0x0085      // ccd, 1280x1024, global, 1/2", color, 

#define IS_SENSOR_D1024G23M     0x0086      // ccd, 1024x1024, global, 2/3", mono, 
#define IS_SENSOR_D1024G23C     0x0087      // ccd, 1024x1024, global, 2/3", color, 

#define IS_SENSOR_D0640G12M     0x0088      // ccd, 0640x0480, global, 1/2", mono, 
#define IS_SENSOR_D0640G12C     0x0089      // ccd, 0640x0480, global, 1/2", color,

#define IS_SENSOR_D0640G14M     0x0090      // ccd, 0640x0480, global, 1/4", mono, 
#define IS_SENSOR_D0640G14C     0x0091      // ccd, 0640x0480, global, 1/4", color,

#define IS_SENSOR_D0768G12M     0x0092      // ccd, 0768x0582, global, 1/2", mono, 
#define IS_SENSOR_D0768G12C     0x0093      // ccd, 0768x0582, global, 1/2", color,

#define IS_SENSOR_D1280G12M     0x0096      // ccd, 1280x1024, global, 1/2", mono, 
#define IS_SENSOR_D1280G12C		0x0097      // ccd, 1280x1024, global, 1/2", color,

#define IS_SENSOR_D1600G12M     0x0098      // ccd, 1600x1200, global, 1/1.8", mono, 
#define IS_SENSOR_D1600G12C     0x0099      // ccd, 1600x1200, global, 1/1.8", color, 
//
// -------------------------------------------------------------------------------------------------



// ------------------------------------------
// error codes
// ------------------------------------------
#define IS_NO_SUCCESS                      -1
#define IS_SUCCESS                          0 
#define IS_INVALID_CAMERA_HANDLE            1
#define IS_INVALID_HANDLE                   1

#define IS_IO_REQUEST_FAILED                2
#define IS_CANT_OPEN_DEVICE                 3
#define IS_CANT_CLOSE_DEVICE                4
#define IS_CANT_SETUP_MEMORY                5
#define IS_NO_HWND_FOR_ERROR_REPORT         6
#define IS_ERROR_MESSAGE_NOT_CREATED        7
#define IS_ERROR_STRING_NOT_FOUND           8
#define IS_HOOK_NOT_CREATED                 9
#define IS_TIMER_NOT_CREATED               10
#define IS_CANT_OPEN_REGISTRY              11
#define IS_CANT_READ_REGISTRY              12
#define IS_CANT_VALIDATE_BOARD             13
#define IS_CANT_GIVE_BOARD_ACCESS          14
#define IS_NO_IMAGE_MEM_ALLOCATED          15
#define IS_CANT_CLEANUP_MEMORY             16
#define IS_CANT_COMMUNICATE_WITH_DRIVER    17
#define IS_FUNCTION_NOT_SUPPORTED_YET      18
#define IS_OPERATING_SYSTEM_NOT_SUPPORTED  19

#define IS_INVALID_VIDEO_IN                20
#define IS_INVALID_IMG_SIZE                21
#define IS_INVALID_ADDRESS                 22
#define IS_INVALID_VIDEO_MODE              23
#define IS_INVALID_AGC_MODE                24
#define IS_INVALID_GAMMA_MODE              25
#define IS_INVALID_SYNC_LEVEL              26
#define IS_INVALID_CBARS_MODE              27
#define IS_INVALID_COLOR_MODE              28
#define IS_INVALID_SCALE_FACTOR            29
#define IS_INVALID_IMAGE_SIZE              30
#define IS_INVALID_IMAGE_POS               31
#define IS_INVALID_CAPTURE_MODE            32
#define IS_INVALID_RISC_PROGRAM            33
#define IS_INVALID_BRIGHTNESS              34
#define IS_INVALID_CONTRAST                35
#define IS_INVALID_SATURATION_U            36
#define IS_INVALID_SATURATION_V            37
#define IS_INVALID_HUE                     38
#define IS_INVALID_HOR_FILTER_STEP         39
#define IS_INVALID_VERT_FILTER_STEP        40
#define IS_INVALID_EEPROM_READ_ADDRESS     41
#define IS_INVALID_EEPROM_WRITE_ADDRESS    42
#define IS_INVALID_EEPROM_READ_LENGTH      43
#define IS_INVALID_EEPROM_WRITE_LENGTH     44
#define IS_INVALID_BOARD_INFO_POINTER      45
#define IS_INVALID_DISPLAY_MODE            46
#define IS_INVALID_ERR_REP_MODE            47
#define IS_INVALID_BITS_PIXEL              48
#define IS_INVALID_MEMORY_POINTER          49

#define IS_FILE_WRITE_OPEN_ERROR           50
#define IS_FILE_READ_OPEN_ERROR            51
#define IS_FILE_READ_INVALID_BMP_ID        52
#define IS_FILE_READ_INVALID_BMP_SIZE      53
#define IS_FILE_READ_INVALID_BIT_COUNT     54
#define IS_WRONG_KERNEL_VERSION            55

#define IS_RISC_INVALID_XLENGTH            60
#define IS_RISC_INVALID_YLENGTH            61
#define IS_RISC_EXCEED_IMG_SIZE            62

// DirectDraw Mode Errors
#define IS_DD_MAIN_FAILED                  70
#define IS_DD_PRIMSURFACE_FAILED           71
#define IS_DD_SCRN_SIZE_NOT_SUPPORTED      72
#define IS_DD_CLIPPER_FAILED               73
#define IS_DD_CLIPPER_HWND_FAILED          74
#define IS_DD_CLIPPER_CONNECT_FAILED       75 
#define IS_DD_BACKSURFACE_FAILED           76
#define IS_DD_BACKSURFACE_IN_SYSMEM        77
#define IS_DD_MDL_MALLOC_ERR               78
#define IS_DD_MDL_SIZE_ERR                 79
#define IS_DD_CLIP_NO_CHANGE               80
#define IS_DD_PRIMMEM_NULL                 81
#define IS_DD_BACKMEM_NULL                 82
#define IS_DD_BACKOVLMEM_NULL              83
#define IS_DD_OVERLAYSURFACE_FAILED        84
#define IS_DD_OVERLAYSURFACE_IN_SYSMEM     85
#define IS_DD_OVERLAY_NOT_ALLOWED          86
#define IS_DD_OVERLAY_COLKEY_ERR           87
#define IS_DD_OVERLAY_NOT_ENABLED          88
#define IS_DD_GET_DC_ERROR                 89
#define IS_DD_DDRAW_DLL_NOT_LOADED         90
#define IS_DD_THREAD_NOT_CREATED           91
#define IS_DD_CANT_GET_CAPS                92
#define IS_DD_NO_OVERLAYSURFACE            93
#define IS_DD_NO_OVERLAYSTRETCH            94
#define IS_DD_CANT_CREATE_OVERLAYSURFACE   95
#define IS_DD_CANT_UPDATE_OVERLAYSURFACE   96
#define IS_DD_INVALID_STRETCH              97

#define IS_EV_INVALID_EVENT_NUMBER        100
#define IS_INVALID_MODE                   101
#define IS_CANT_FIND_HOOK                 102
#define IS_CANT_GET_HOOK_PROC_ADDR        103
#define IS_CANT_CHAIN_HOOK_PROC           104
#define IS_CANT_SETUP_WND_PROC            105
#define IS_HWND_NULL                      106
#define IS_INVALID_UPDATE_MODE            107
#define IS_NO_ACTIVE_IMG_MEM              108
#define IS_CANT_INIT_EVENT                109
#define IS_FUNC_NOT_AVAIL_IN_OS           110
#define IS_CAMERA_NOT_CONNECTED           111
#define IS_SEQUENCE_LIST_EMPTY            112
#define IS_CANT_ADD_TO_SEQUENCE           113
#define IS_LOW_OF_SEQUENCE_RISC_MEM       114
#define IS_IMGMEM2FREE_USED_IN_SEQ        115
#define IS_IMGMEM_NOT_IN_SEQUENCE_LIST    116
#define IS_SEQUENCE_BUF_ALREADY_LOCKED    117
#define IS_INVALID_DEVICE_ID              118
#define IS_INVALID_BOARD_ID               119
#define IS_ALL_DEVICES_BUSY               120
#define IS_HOOK_BUSY                      121
#define IS_TIMED_OUT                      122
#define IS_NULL_POINTER                   123
#define IS_WRONG_HOOK_VERSION             124
#define IS_INVALID_PARAMETER              125
#define IS_NOT_ALLOWED                    126
#define IS_OUT_OF_MEMORY                  127
#define IS_INVALID_WHILE_LIVE             128
#define IS_ACCESS_VIOLATION               129
#define IS_UNKNOWN_ROP_EFFECT             130
#define IS_INVALID_RENDER_MODE            131
#define IS_INVALID_THREAD_CONTEXT         132
#define IS_NO_HARDWARE_INSTALLED          133
#define IS_INVALID_WATCHDOG_TIME          134
#define IS_INVALID_WATCHDOG_MODE          135
#define IS_INVALID_PASSTHROUGH_IN         136
#define IS_ERROR_SETTING_PASSTHROUGH_IN   137
#define IS_FAILURE_ON_SETTING_WATCHDOG    138
#define IS_NO_USB20						  139
#define IS_CAPTURE_RUNNING				  140

#define IS_MEMORY_BOARD_ACTIVATED		  141
#define	IS_MEMORY_BOARD_DEACTIVATED		  142
#define IS_NO_MEMORY_BOARD_CONNECTED	  143
#define IS_TOO_LESS_MEMORY				  144
#define	IS_IMAGE_NOT_PRESENT			  145
#define IS_MEMORY_MODE_RUNNING			  146
#define IS_MEMORYBOARD_DISABLED			  147

#define IS_TRIGGER_ACTIVATED			  148
#define IS_WRONG_KEY                      150
#define IS_CRC_ERROR                      151
#define IS_NOT_YET_RELEASED               152
#define IS_NOT_CALIBRATED                 153
#define IS_WAITING_FOR_KERNEL             154   // a request to the kernel exceeded
#define IS_NOT_SUPPORTED                  155   // operation mode is not supported
#define IS_TRIGGER_NOT_ACTIVATED          156   // operation could not execute while trigger is disabled
#define IS_OPERATION_ABORTED              157
#define IS_BAD_STRUCTURE_SIZE             158
#define IS_INVALID_BUFFER_SIZE            159
#define IS_INVALID_PIXEL_CLOCK            160
#define IS_INVALID_EXPOSURE_TIME          161
#define IS_AUTO_EXPOSURE_RUNNING          162
#define IS_CANNOT_CREATE_BB_SURF          163 // error creating backbuffer surface  
#define IS_CANNOT_CREATE_BB_MIX           164 // backbuffer mixer surfaces can not be created
#define IS_BB_OVLMEM_NULL                 165 // backbuffer overlay mem could not be locked  
#define IS_CANNOT_CREATE_BB_OVL           166 // backbuffer overlay mem could not be created  
#define IS_NOT_SUPP_IN_OVL_SURF_MODE      167 // function not supported in overlay surface mode  
#define IS_INVALID_SURFACE                168 // surface invalid
#define IS_SURFACE_LOST                   169 // surface hase been lost  
#define IS_RELEASE_BB_OVL_DC              170 // error releasing backbuffer overlay DC  
#define IS_BB_TIMER_NOT_CREATED           171 // backbuffer timer could not be created  
#define IS_BB_OVL_NOT_EN                  172 // backbuffer overlay has not been enabled  
#define IS_ONLY_IN_BB_MODE                173 // only possible in backbuffer mode 
#define IS_INVALID_COLOR_FORMAT           174 // invalid color format
#define IS_INVALID_WB_BINNING_MODE        175
#define IS_INVALID_I2C_DEVICE_ADDRESS     176
#define IS_COULD_NOT_CONVERT              177 // current image couldn't be converted
#define IS_TRANSFER_ERROR                 178 // transfer failed
#define IS_PARAMETER_SET_NOT_PRESENT      179 // the parameter set is not present
#define IS_INVALID_CAMERA_TYPE            180 // the camera type in the ini file doesn't match
#define IS_INVALID_HOST_IP_HIBYTE         181 // HIBYTE of host address is invalid
#define IS_CM_NOT_SUPP_IN_CURR_DISPLAYMODE  182   // color mode is not supported in the current display mode
#define IS_NO_IR_FILTER                   183
#define IS_STARTER_FW_UPLOAD_NEEDED         184   // device starter firmware is not compatible    

#define IS_DR_LIBRARY_NOT_FOUND             185   // the DirectRender library could not be found
#define IS_DR_DEVICE_OUT_OF_MEMORY          186   // insufficient graphics adapter video memory
#define IS_DR_CANNOT_CREATE_SURFACE         187   // the image or overlay surface could not be created
#define IS_DR_CANNOT_CREATE_VERTEX_BUFFER   188   // the vertex buffer could not be created
#define IS_DR_CANNOT_CREATE_TEXTURE         189   // the texture could not be created  
#define IS_DR_CANNOT_LOCK_OVERLAY_SURFACE   190   // the overlay surface could not be locked
#define IS_DR_CANNOT_UNLOCK_OVERLAY_SURFACE 191   // the overlay surface could not be unlocked
#define IS_DR_CANNOT_GET_OVERLAY_DC         192   // cannot get the overlay surface DC 
#define IS_DR_CANNOT_RELEASE_OVERLAY_DC     193   // cannot release the overlay surface DC
#define IS_DR_DEVICE_CAPS_INSUFFICIENT      194   // insufficient graphics adapter capabilities


// ----------------------------------------------
// common definitions
// ----------------------------------------------
#define IS_OFF                      0
#define IS_ON                       1
#define IS_IGNORE_PARAMETER         -1


// ----------------------------------------------
//  device enumeration
// ----------------------------------------------
#define IS_USE_DEVICE_ID                0x8000L
#define IS_ALLOW_STARTER_FW_UPLOAD      0x10000L


// ----------------------------------------------
// AutoExit enable/disable
// ----------------------------------------------
#define IS_GET_AUTO_EXIT_ENABLED    0x8000
#define IS_DISABLE_AUTO_EXIT        0
#define IS_ENABLE_AUTO_EXIT         1


// ----------------------------------------------
// live/freeze parameters
// ----------------------------------------------
#define IS_GET_LIVE                 0x8000

#define IS_WAIT                     0x0001
#define IS_DONT_WAIT                0x0000
#define IS_FORCE_VIDEO_STOP         0x4000
#define IS_FORCE_VIDEO_START        0x4000
#define IS_USE_NEXT_MEM             0x8000


// ----------------------------------------------
// video finish constants
// ----------------------------------------------
#define IS_VIDEO_NOT_FINISH         0
#define IS_VIDEO_FINISH             1


// ----------------------------------------------
// bitmap render modes
// ----------------------------------------------
#define IS_GET_RENDER_MODE          0x8000

#define IS_RENDER_DISABLED          0
#define IS_RENDER_NORMAL            1
#define IS_RENDER_FIT_TO_WINDOW     2
#define IS_RENDER_DOWNSCALE_1_2     4
#define IS_RENDER_MIRROR_UPDOWN     16
#define IS_RENDER_DOUBLE_HEIGHT     32
#define IS_RENDER_HALF_HEIGHT       64


// ----------------------------------------------
// external trigger modes
// ----------------------------------------------
#define IS_GET_EXTERNALTRIGGER			    0x8000
#define IS_GET_TRIGGER_STATUS			    0x8001
#define IS_GET_TRIGGER_MASK				    0x8002
#define IS_GET_TRIGGER_INPUTS			    0x8003
#define IS_GET_SUPPORTED_TRIGGER_MODE	    0x8004 
#define IS_GET_TRIGGER_COUNTER			    0x8000

// old defines for compatibility 
#define IS_SET_TRIG_OFF                     0x0000
#define IS_SET_TRIG_HI_LO                   0x0001
#define IS_SET_TRIG_LO_HI                   0x0002
#define IS_SET_TRIG_SOFTWARE                0x0008
#define IS_SET_TRIG_HI_LO_SYNC              0x0010
#define IS_SET_TRIG_LO_HI_SYNC              0x0020

#define IS_SET_TRIG_MASK                    0x0100

// New defines
#define IS_SET_TRIGGER_CONTINUOUS           0x1000
#define IS_SET_TRIGGER_OFF                  IS_SET_TRIG_OFF
#define IS_SET_TRIGGER_HI_LO                (IS_SET_TRIGGER_CONTINUOUS | IS_SET_TRIG_HI_LO) 
#define IS_SET_TRIGGER_LO_HI                (IS_SET_TRIGGER_CONTINUOUS | IS_SET_TRIG_LO_HI) 
#define IS_SET_TRIGGER_SOFTWARE             (IS_SET_TRIGGER_CONTINUOUS | IS_SET_TRIG_SOFTWARE) 
#define IS_SET_TRIGGER_HI_LO_SYNC           IS_SET_TRIG_HI_LO_SYNC
#define IS_SET_TRIGGER_LO_HI_SYNC           IS_SET_TRIG_LO_HI_SYNC

#define IS_GET_TRIGGER_DELAY                0x8000
#define IS_GET_MIN_TRIGGER_DELAY            0x8001
#define IS_GET_MAX_TRIGGER_DELAY            0x8002
#define IS_GET_TRIGGER_DELAY_GRANULARITY    0x8003


// ----------------------------------------------
// Timing
// ----------------------------------------------
// pixelclock
#define IS_GET_PIXEL_CLOCK          0x8000
#define IS_GET_DEFAULT_PIXEL_CLK    0x8001
// framerate
#define IS_GET_FRAMERATE            0x8000
#define IS_GET_DEFAULT_FRAMERATE    0x8001
// exposure
#define IS_GET_EXPOSURE_TIME        0x8000
#define IS_GET_DEFAULT_EXPOSURE     0x8001


// ----------------------------------------------
// Gain definitions
// ----------------------------------------------
#define IS_GET_MASTER_GAIN          0x8000
#define IS_GET_RED_GAIN             0x8001
#define IS_GET_GREEN_GAIN           0x8002
#define IS_GET_BLUE_GAIN            0x8003
#define IS_GET_DEFAULT_MASTER       0x8004
#define IS_GET_DEFAULT_RED          0x8005
#define IS_GET_DEFAULT_GREEN        0x8006
#define IS_GET_DEFAULT_BLUE         0x8007
#define IS_GET_GAINBOOST            0x8008
#define IS_SET_GAINBOOST_ON         0x0001
#define IS_SET_GAINBOOST_OFF        0x0000
#define IS_GET_SUPPORTED_GAINBOOST  0x0002
#define IS_MIN_GAIN                 0
#define IS_MAX_GAIN                 100


// ----------------------------------------------
// Gain factor definitions
// ----------------------------------------------
#define IS_GET_MASTER_GAIN_FACTOR          0x8000
#define IS_GET_RED_GAIN_FACTOR             0x8001
#define IS_GET_GREEN_GAIN_FACTOR           0x8002
#define IS_GET_BLUE_GAIN_FACTOR            0x8003
#define IS_SET_MASTER_GAIN_FACTOR          0x8004
#define IS_SET_RED_GAIN_FACTOR             0x8005
#define IS_SET_GREEN_GAIN_FACTOR           0x8006
#define IS_SET_BLUE_GAIN_FACTOR            0x8007
#define IS_GET_DEFAULT_MASTER_GAIN_FACTOR  0x8008
#define IS_GET_DEFAULT_RED_GAIN_FACTOR     0x8009
#define IS_GET_DEFAULT_GREEN_GAIN_FACTOR   0x800a
#define IS_GET_DEFAULT_BLUE_GAIN_FACTOR    0x800b
#define IS_INQUIRE_MASTER_GAIN_FACTOR      0x800c
#define IS_INQUIRE_RED_GAIN_FACTOR         0x800d
#define IS_INQUIRE_GREEN_GAIN_FACTOR       0x800e
#define IS_INQUIRE_BLUE_GAIN_FACTOR        0x800f


// ----------------------------------------------
// Global Shutter definitions
// ----------------------------------------------
#define IS_SET_GLOBAL_SHUTTER_ON            0x0001
#define IS_SET_GLOBAL_SHUTTER_OFF           0x0000
#define IS_GET_GLOBAL_SHUTTER               0x0010
#define IS_GET_SUPPORTED_GLOBAL_SHUTTER     0x0020


// ----------------------------------------------
// Black level definitions
// ----------------------------------------------
#define IS_GET_BL_COMPENSATION      0x8000
#define IS_GET_BL_OFFSET            0x8001
#define IS_GET_BL_DEFAULT_MODE      0x8002
#define IS_GET_BL_DEFAULT_OFFSET    0x8003
#define IS_GET_BL_SUPPORTED_MODE    0x8004

#define IS_BL_COMPENSATION_DISABLE  0
#define IS_BL_COMPENSATION_ENABLE   1
#define IS_BL_COMPENSATION_OFFSET   32

#define IS_MIN_BL_OFFSET            0
#define IS_MAX_BL_OFFSET            255


// ----------------------------------------------
// hardware gamma definitions
// ----------------------------------------------
#define IS_GET_HW_GAMMA             0x8000
#define IS_GET_HW_SUPPORTED_GAMMA   0x8001

#define IS_SET_HW_GAMMA_OFF         0x0000
#define IS_SET_HW_GAMMA_ON          0x0001


// ----------------------------------------------
// camera LUT
// ----------------------------------------------
#define IS_ENABLE_CAMERA_LUT        0x0001
#define IS_SET_CAMERA_LUT_VALUES    0x0002
#define IS_ENABLE_RGB_GRAYSCALE     0x0004
#define IS_GET_CAMERA_LUT_USER      0x0008
#define IS_GET_CAMERA_LUT_COMPLETE  0x0010

// ----------------------------------------------
// camera LUT presets
// ----------------------------------------------
#define IS_CAMERA_LUT_IDENTITY      0x00000100
#define IS_CAMERA_LUT_NEGATIV       0x00000200
#define IS_CAMERA_LUT_GLOW1         0x00000400
#define IS_CAMERA_LUT_GLOW2         0x00000800
#define IS_CAMERA_LUT_ASTRO1        0x00001000
#define IS_CAMERA_LUT_RAINBOW1      0x00002000
#define IS_CAMERA_LUT_MAP1          0x00004000
#define IS_CAMERA_LUT_COLD_HOT      0x00008000
#define IS_CAMERA_LUT_SEPIC         0x00010000
#define IS_CAMERA_LUT_ONLY_RED      0x00020000
#define IS_CAMERA_LUT_ONLY_GREEN    0x00040000
#define IS_CAMERA_LUT_ONLY_BLUE     0x00080000

#define IS_CAMERA_LUT_64            64
#define IS_CAMERA_LUT_128           128


// ----------------------------------------------
// image parameters
// ----------------------------------------------
// brightness
#define IS_GET_BRIGHTNESS           0x8000
#define IS_MIN_BRIGHTNESS           0
#define IS_MAX_BRIGHTNESS           255
#define IS_DEFAULT_BRIGHTNESS       -1
// contrast
#define IS_GET_CONTRAST             0x8000
#define IS_MIN_CONTRAST             0
#define IS_MAX_CONTRAST             511
#define IS_DEFAULT_CONTRAST         -1
// gamma
#define IS_GET_GAMMA                0x8000
#define IS_MIN_GAMMA                1
#define IS_MAX_GAMMA                1000
#define IS_DEFAULT_GAMMA            -1
// saturation
#define IS_GET_SATURATION_U         0x8000
#define IS_MIN_SATURATION_U         0
#define IS_MAX_SATURATION_U         200
#define IS_DEFAULT_SATURATION_U     100
#define IS_GET_SATURATION_V         0x8001
#define IS_MIN_SATURATION_V         0
#define IS_MAX_SATURATION_V         200
#define IS_DEFAULT_SATURATION_V     100
// hue
#define IS_GET_HUE                  0x8000
#define IS_MIN_HUE                  0
#define IS_MAX_HUE                  255
#define IS_DEFAULT_HUE              128


// ----------------------------------------------
// Image pos and size
// ----------------------------------------------
#define IS_GET_IMAGE_SIZE_X         0x8000
#define IS_GET_IMAGE_SIZE_Y         0x8001
#define IS_GET_IMAGE_SIZE_X_INC     0x8002
#define IS_GET_IMAGE_SIZE_Y_INC     0x8003
#define IS_GET_IMAGE_SIZE_X_MIN     0x8004
#define IS_GET_IMAGE_SIZE_Y_MIN     0x8005
#define IS_GET_IMAGE_SIZE_X_MAX     0x8006
#define IS_GET_IMAGE_SIZE_Y_MAX     0x8007

#define IS_GET_IMAGE_POS_X          0x8001
#define IS_GET_IMAGE_POS_Y          0x8002
#define IS_GET_IMAGE_POS_X_ABS      0xC001
#define IS_GET_IMAGE_POS_Y_ABS      0xC002
#define IS_GET_IMAGE_POS_X_INC      0xC003
#define IS_GET_IMAGE_POS_Y_INC      0xC004
#define IS_GET_IMAGE_POS_X_MIN      0xC005
#define IS_GET_IMAGE_POS_Y_MIN      0xC006
#define IS_GET_IMAGE_POS_X_MAX      0xC007
#define IS_GET_IMAGE_POS_Y_MAX      0xC008

#define IS_SET_IMAGE_POS_X_ABS      0x00010000
#define IS_SET_IMAGE_POS_Y_ABS      0x00010000

// Compatibility
#define IS_SET_IMAGEPOS_X_ABS       0x8000
#define IS_SET_IMAGEPOS_Y_ABS       0x8000


// ----------------------------------------------
// ROP effect constants
// ----------------------------------------------
#define IS_GET_ROP_EFFECT               0x8000
#define IS_GET_SUPPORTED_ROP_EFFECT     0x8001

#define IS_SET_ROP_NONE                 0
#define IS_SET_ROP_MIRROR_UPDOWN        8
#define IS_SET_ROP_MIRROR_UPDOWN_ODD    16
#define IS_SET_ROP_MIRROR_UPDOWN_EVEN   32
#define IS_SET_ROP_MIRROR_LEFTRIGHT     64


// ----------------------------------------------
// Subsampling
// ----------------------------------------------
#define IS_GET_SUBSAMPLING                      0x8000
#define IS_GET_SUPPORTED_SUBSAMPLING            0x8001
#define IS_GET_SUBSAMPLING_TYPE                 0x8002
#define IS_GET_SUBSAMPLING_FACTOR_HORIZONTAL    0x8004
#define IS_GET_SUBSAMPLING_FACTOR_VERTICAL      0x8008

#define IS_SUBSAMPLING_DISABLE          0x00

// HVHVHVHV
// 55334422

#define IS_SUBSAMPLING_2X_VERTICAL      0x0001
#define IS_SUBSAMPLING_2X_HORIZONTAL    0x0002
#define IS_SUBSAMPLING_4X_VERTICAL      0x0004
#define IS_SUBSAMPLING_4X_HORIZONTAL    0x0008
#define IS_SUBSAMPLING_3X_VERTICAL      0x0010
#define IS_SUBSAMPLING_3X_HORIZONTAL    0x0020
#define IS_SUBSAMPLING_5X_VERTICAL      0x0040
#define IS_SUBSAMPLING_5X_HORIZONTAL    0x0080
#define IS_SUBSAMPLING_6X_VERTICAL      0x0100
#define IS_SUBSAMPLING_6X_HORIZONTAL    0x0200
#define IS_SUBSAMPLING_8X_VERTICAL      0x0400
#define IS_SUBSAMPLING_8X_HORIZONTAL    0x0800
#define IS_SUBSAMPLING_16X_VERTICAL     0x1000
#define IS_SUBSAMPLING_16X_HORIZONTAL   0x2000

#define IS_SUBSAMPLING_COLOR            0x01
#define IS_SUBSAMPLING_MONO             0x02

#define IS_SUBSAMPLING_MASK_VERTICAL    (IS_SUBSAMPLING_2X_VERTICAL | IS_SUBSAMPLING_4X_VERTICAL | IS_SUBSAMPLING_3X_VERTICAL | IS_SUBSAMPLING_5X_VERTICAL | IS_SUBSAMPLING_6X_VERTICAL | IS_SUBSAMPLING_8X_VERTICAL | IS_SUBSAMPLING_16X_VERTICAL)
#define IS_SUBSAMPLING_MASK_HORIZONTAL  (IS_SUBSAMPLING_2X_HORIZONTAL | IS_SUBSAMPLING_4X_HORIZONTAL | IS_SUBSAMPLING_3X_HORIZONTAL | IS_SUBSAMPLING_5X_HORIZONTAL | IS_SUBSAMPLING_6X_HORIZONTAL | IS_SUBSAMPLING_8X_HORIZONTAL | IS_SUBSAMPLING_16X_HORIZONTAL)

// Compatibility
#define IS_SUBSAMPLING_VERT             IS_SUBSAMPLING_2X_VERTICAL
#define IS_SUBSAMPLING_HOR              IS_SUBSAMPLING_2X_HORIZONTAL


// ----------------------------------------------
// Binning
// ----------------------------------------------
#define IS_GET_BINNING                      0x8000
#define IS_GET_SUPPORTED_BINNING            0x8001
#define IS_GET_BINNING_TYPE                 0x8002
#define IS_GET_BINNING_FACTOR_HORIZONTAL    0x8004
#define IS_GET_BINNING_FACTOR_VERTICAL      0x8008

#define IS_BINNING_DISABLE              0x00

// --HVHVHV
// --334422

#define IS_BINNING_2X_VERTICAL          0x0001
#define IS_BINNING_2X_HORIZONTAL        0x0002
#define IS_BINNING_4X_VERTICAL          0x0004
#define IS_BINNING_4X_HORIZONTAL        0x0008
#define IS_BINNING_3X_VERTICAL          0x0010
#define IS_BINNING_3X_HORIZONTAL        0x0020
#define IS_BINNING_5X_VERTICAL          0x0040
#define IS_BINNING_5X_HORIZONTAL        0x0080
#define IS_BINNING_6X_VERTICAL          0x0100
#define IS_BINNING_6X_HORIZONTAL        0x0200
#define IS_BINNING_8X_VERTICAL          0x0400
#define IS_BINNING_8X_HORIZONTAL        0x0800
#define IS_BINNING_16X_VERTICAL         0x1000
#define IS_BINNING_16X_HORIZONTAL       0x2000

#define IS_BINNING_COLOR                0x01
#define IS_BINNING_MONO                 0x02

#define IS_BINNING_MASK_VERTICAL        (IS_BINNING_2X_VERTICAL | IS_BINNING_3X_VERTICAL | IS_BINNING_4X_VERTICAL | IS_BINNING_5X_VERTICAL | IS_BINNING_6X_VERTICAL | IS_BINNING_8X_VERTICAL | IS_BINNING_16X_VERTICAL)
#define IS_BINNING_MASK_HORIZONTAL      (IS_BINNING_2X_HORIZONTAL | IS_BINNING_3X_HORIZONTAL | IS_BINNING_4X_HORIZONTAL | IS_BINNING_5X_HORIZONTAL | IS_BINNING_6X_HORIZONTAL | IS_BINNING_8X_HORIZONTAL | IS_BINNING_16X_HORIZONTAL)

// Compatibility
#define IS_BINNING_VERT                 IS_BINNING_2X_VERTICAL
#define IS_BINNING_HOR                  IS_BINNING_2X_HORIZONTAL

// ----------------------------------------------
// Auto Control Parameter
// ----------------------------------------------
#define IS_SET_ENABLE_AUTO_GAIN                 0x8800
#define IS_GET_ENABLE_AUTO_GAIN                 0x8801
#define IS_SET_ENABLE_AUTO_SHUTTER              0x8802
#define IS_GET_ENABLE_AUTO_SHUTTER              0x8803
#define IS_SET_ENABLE_AUTO_WHITEBALANCE         0x8804
#define IS_GET_ENABLE_AUTO_WHITEBALANCE         0x8805
#define IS_SET_ENABLE_AUTO_FRAMERATE            0x8806
#define IS_GET_ENABLE_AUTO_FRAMERATE            0x8807
#define IS_SET_ENABLE_AUTO_SENSOR_GAIN		    0x8808
#define IS_GET_ENABLE_AUTO_SENSOR_GAIN		    0x8809
#define IS_SET_ENABLE_AUTO_SENSOR_SHUTTER	    0x8810
#define IS_GET_ENABLE_AUTO_SENSOR_SHUTTER       0x8811
#define IS_SET_ENABLE_AUTO_SENSOR_GAIN_SHUTTER	0x8812
#define IS_GET_ENABLE_AUTO_SENSOR_GAIN_SHUTTER  0x8813
#define IS_SET_ENABLE_AUTO_SENSOR_FRAMERATE     0x8814
#define IS_GET_ENABLE_AUTO_SENSOR_FRAMERATE     0x8815

#define IS_SET_AUTO_REFERENCE                   0x8000
#define IS_GET_AUTO_REFERENCE                   0x8001
#define IS_SET_AUTO_GAIN_MAX                    0x8002
#define IS_GET_AUTO_GAIN_MAX                    0x8003
#define IS_SET_AUTO_SHUTTER_MAX                 0x8004
#define IS_GET_AUTO_SHUTTER_MAX                 0x8005
#define IS_SET_AUTO_SPEED                       0x8006
#define IS_GET_AUTO_SPEED                       0x8007
#define IS_SET_AUTO_WB_OFFSET                   0x8008
#define IS_GET_AUTO_WB_OFFSET                   0x8009
#define IS_SET_AUTO_WB_GAIN_RANGE               0x800A
#define IS_GET_AUTO_WB_GAIN_RANGE               0x800B
#define IS_SET_AUTO_WB_SPEED                    0x800C
#define IS_GET_AUTO_WB_SPEED                    0x800D
#define IS_SET_AUTO_WB_ONCE                     0x800E
#define IS_GET_AUTO_WB_ONCE                     0x800F
#define IS_SET_AUTO_BRIGHTNESS_ONCE             0x8010
#define IS_GET_AUTO_BRIGHTNESS_ONCE             0x8011
#define IS_SET_AUTO_HYSTERESIS				    0x8012
#define IS_GET_AUTO_HYSTERESIS				    0x8013
#define IS_GET_AUTO_HYSTERESIS_RANGE		    0x8014
#define IS_SET_AUTO_WB_HYSTERESIS			    0x8015
#define IS_GET_AUTO_WB_HYSTERESIS			    0x8016
#define IS_GET_AUTO_WB_HYSTERESIS_RANGE		    0x8017
#define IS_SET_AUTO_SKIPFRAMES				    0x8018
#define IS_GET_AUTO_SKIPFRAMES				    0x8019
#define IS_GET_AUTO_SKIPFRAMES_RANGE		    0x801A
#define IS_SET_AUTO_WB_SKIPFRAMES			    0x801B
#define IS_GET_AUTO_WB_SKIPFRAMES			    0x801C
#define IS_GET_AUTO_WB_SKIPFRAMES_RANGE		    0x801D

// ----------------------------------------------
// Auto Control definitions
// ----------------------------------------------
#define IS_MIN_AUTO_BRIGHT_REFERENCE          0
#define IS_MAX_AUTO_BRIGHT_REFERENCE        255
#define IS_DEFAULT_AUTO_BRIGHT_REFERENCE    128
#define IS_MIN_AUTO_SPEED                     0
#define IS_MAX_AUTO_SPEED                   100
#define IS_DEFAULT_AUTO_SPEED                50

#define IS_DEFAULT_AUTO_WB_OFFSET             0
#define IS_MIN_AUTO_WB_OFFSET               -50
#define IS_MAX_AUTO_WB_OFFSET                50
#define IS_DEFAULT_AUTO_WB_SPEED             50
#define IS_MIN_AUTO_WB_SPEED                  0
#define IS_MAX_AUTO_WB_SPEED                100
#define IS_MIN_AUTO_WB_REFERENCE              0
#define IS_MAX_AUTO_WB_REFERENCE            255


// ----------------------------------------------
// AOI types to set/get
// ----------------------------------------------
#define IS_SET_AUTO_BRIGHT_AOI      0x8000
#define IS_GET_AUTO_BRIGHT_AOI      0x8001
#define IS_SET_IMAGE_AOI            0x8002
#define IS_GET_IMAGE_AOI            0x8003
#define IS_SET_AUTO_WB_AOI          0x8004
#define IS_GET_AUTO_WB_AOI          0x8005


// ----------------------------------------------
// color modes
// ----------------------------------------------
#define IS_GET_COLOR_MODE           0x8000

#define IS_SET_CM_RGB32             0
#define IS_SET_CM_RGB24             1
#define IS_SET_CM_RGB16             2
#define IS_SET_CM_RGB15             3
#define IS_SET_CM_Y8                6
#define IS_SET_CM_RGB8              7
#define IS_SET_CM_BAYER             11
#define IS_SET_CM_UYVY              12
#define IS_SET_CM_UYVY_MONO			13
#define IS_SET_CM_UYVY_BAYER		14
#define IS_SET_CM_CBYCRY            23

#define IS_SET_CM_RGBY              24
#define IS_SET_CM_RGB30             25
#define IS_SET_CM_Y12               26
#define IS_SET_CM_BAYER12           27
#define IS_SET_CM_Y16               28
#define IS_SET_CM_BAYER16           29


#define IS_CM_MODE_MASK             0x007F

// planar vs packed format
#define IS_CM_FORMAT_PACKED         0x0000
#define IS_CM_FORMAT_PLANAR         0x2000
#define IS_CM_FORMAT_MASK           0x2000

// BGR vs. RGB order
#define IS_CM_ORDER_BGR             0x0000
#define IS_CM_ORDER_RGB             0x0080
#define IS_CM_ORDER_MASK            0x0080

// define compliant color format names
#define IS_CM_MONO8             IS_SET_CM_Y8                                                // occupies 8 Bit
#define IS_CM_MONO12            IS_SET_CM_Y12                                               // occupies 16 Bit
#define IS_CM_MONO16            IS_SET_CM_Y16                                               // occupies 16 Bit

#define IS_CM_BAYER_RG8         IS_SET_CM_BAYER                                             // occupies 8 Bit
#define IS_CM_BAYER_RG12        IS_SET_CM_BAYER12                                           // occupies 16 Bit
#define IS_CM_BAYER_RG16        IS_SET_CM_BAYER16                                           // occupies 16 Bit

#define IS_CM_BGR555_PACKED     (IS_SET_CM_RGB15 | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 16 Bit
#define IS_CM_BGR565_PACKED     (IS_SET_CM_RGB16 | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 16 Bit 

#define IS_CM_RGB8_PACKED       (IS_SET_CM_RGB24 | IS_CM_ORDER_RGB | IS_CM_FORMAT_PACKED)   // occupies 24 Bit
#define IS_CM_BGR8_PACKED       (IS_SET_CM_RGB24 | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 24 Bit  
#define IS_CM_RGBA8_PACKED      (IS_SET_CM_RGB32 | IS_CM_ORDER_RGB | IS_CM_FORMAT_PACKED)   // occupies 32 Bit
#define IS_CM_BGRA8_PACKED      (IS_SET_CM_RGB32 | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 32 Bit
#define IS_CM_RGBY8_PACKED      (IS_SET_CM_RGBY  | IS_CM_ORDER_RGB | IS_CM_FORMAT_PACKED)   // occupies 32 Bit
#define IS_CM_BGRY8_PACKED      (IS_SET_CM_RGBY  | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 32 Bit
#define IS_CM_RGB10V2_PACKED    (IS_SET_CM_RGB30 | IS_CM_ORDER_RGB | IS_CM_FORMAT_PACKED)   // occupies 32 Bit
#define IS_CM_BGR10V2_PACKED    (IS_SET_CM_RGB30 | IS_CM_ORDER_BGR | IS_CM_FORMAT_PACKED)   // occupies 32 Bit

#define IS_CM_YUV422_PACKED     //no compliant version      
#define IS_CM_UYVY_PACKED       (IS_SET_CM_UYVY | IS_CM_FORMAT_PACKED)                      // occupies 16 Bit
#define IS_CM_UYVY_MONO_PACKED  (IS_SET_CM_UYVY_MONO | IS_CM_FORMAT_PACKED)
#define IS_CM_UYVY_BAYER_PACKED (IS_SET_CM_UYVY_BAYER | IS_CM_FORMAT_PACKED)
#define IS_CM_CBYCRY_PACKED     (IS_SET_CM_CBYCRY | IS_CM_FORMAT_PACKED)                    // occupies 16 Bit

#define IS_CM_RGB8_PLANAR       //no compliant version
#define IS_CM_RGB12_PLANAR      //no compliant version
#define IS_CM_RGB16_PLANAR      //no compliant version

#define IS_CM_ALL_POSSIBLE          0xFFFF

// ----------------------------------------------
// Hotpixel correction
// ----------------------------------------------
#define IS_GET_BPC_MODE             0x8000
#define IS_GET_BPC_THRESHOLD        0x8001
#define IS_GET_BPC_SUPPORTED_MODE   0x8002

#define IS_BPC_DISABLE              0
#define IS_BPC_ENABLE_LEVEL_1       1
#define IS_BPC_ENABLE_LEVEL_2       2
#define IS_BPC_ENABLE_USER          4
#define IS_BPC_ENABLE_SOFTWARE      IS_BPC_ENABLE_LEVEL_2
#define IS_BPC_ENABLE_HARDWARE      IS_BPC_ENABLE_LEVEL_1

#define IS_SET_BADPIXEL_LIST        0x01
#define IS_GET_BADPIXEL_LIST        0x02
#define IS_GET_LIST_SIZE            0x03


// ----------------------------------------------
// color correction definitions
// ----------------------------------------------
#define IS_GET_CCOR_MODE               0x8000
#define IS_GET_SUPPORTED_CCOR_MODE     0x8001
#define IS_GET_DEFAULT_CCOR_MODE       0x8002
#define IS_GET_CCOR_FACTOR             0x8003
#define IS_GET_CCOR_FACTOR_MIN         0x8004
#define IS_GET_CCOR_FACTOR_MAX         0x8005
#define IS_GET_CCOR_FACTOR_DEFAULT     0x8006

#define IS_CCOR_DISABLE                0x0000
#define IS_CCOR_ENABLE                 0x0001
#define IS_CCOR_ENABLE_NORMAL          IS_CCOR_ENABLE
#define IS_CCOR_ENABLE_BG40_ENHANCED   0x0002
#define IS_CCOR_ENABLE_HQ_ENHANCED     0x0004
#define IS_CCOR_SET_IR_AUTOMATIC       0x0080
#define IS_CCOR_FACTOR                 0x0100

#define IS_CCOR_ENABLE_MASK (IS_CCOR_ENABLE_NORMAL | IS_CCOR_ENABLE_BG40_ENHANCED | IS_CCOR_ENABLE_HQ_ENHANCED)


// ----------------------------------------------
// bayer algorithm modes
// ----------------------------------------------
#define IS_GET_BAYER_CV_MODE        0x8000

#define IS_SET_BAYER_CV_NORMAL      0x0000
#define IS_SET_BAYER_CV_BETTER      0x0001
#define IS_SET_BAYER_CV_BEST        0x0002


// --------------------------------------------
// color converter modes
#define IS_CONV_MODE_NONE           0x0000
#define IS_CONV_MODE_SOFTWARE       0x0001
#define IS_CONV_MODE_SOFTWARE_3X3   0x0002
#define IS_CONV_MODE_SOFTWARE_5X5   0x0004
#define IS_CONV_MODE_HARDWARE_3X3   0x0008 
// --------------------------------------------


// ----------------------------------------------
// Edge enhancement
// ----------------------------------------------
#define IS_GET_EDGE_ENHANCEMENT     0x8000

#define IS_EDGE_EN_DISABLE          0
#define IS_EDGE_EN_STRONG           1
#define IS_EDGE_EN_WEAK             2


// ----------------------------------------------
// white balance modes
// ----------------------------------------------
#define IS_GET_WB_MODE              0x8000

#define IS_SET_WB_DISABLE           0x0000 
#define IS_SET_WB_USER              0x0001
#define IS_SET_WB_AUTO_ENABLE       0x0002
#define IS_SET_WB_AUTO_ENABLE_ONCE  0x0004

#define IS_SET_WB_DAYLIGHT_65       0x0101
#define IS_SET_WB_COOL_WHITE        0x0102
#define IS_SET_WB_U30               0x0103
#define IS_SET_WB_ILLUMINANT_A      0x0104
#define IS_SET_WB_HORIZON           0x0105


// ----------------------------------------------
// flash strobe constants
// ----------------------------------------------
#define IS_GET_FLASHSTROBE_MODE			0x8000
#define IS_GET_FLASHSTROBE_LINE			0x8001
#define IS_GET_SUPPORTED_FLASH_IO_PORTS	0x8002

#define IS_SET_FLASH_OFF					0
#define IS_SET_FLASH_ON						1
#define IS_SET_FLASH_LO_ACTIVE				IS_SET_FLASH_ON
#define IS_SET_FLASH_HI_ACTIVE				2
#define IS_SET_FLASH_HIGH					3
#define IS_SET_FLASH_LOW					4
#define IS_SET_FLASH_LO_ACTIVE_FREERUN      5
#define IS_SET_FLASH_HI_ACTIVE_FREERUN      6
#define IS_SET_FLASH_IO_1                   0x0010
#define IS_SET_FLASH_IO_2                   0x0020
#define IS_SET_FLASH_IO_3                   0x0040
#define IS_SET_FLASH_IO_4                   0x0080
#define IS_FLASH_IO_PORT_MASK  (IS_SET_FLASH_IO_1 | IS_SET_FLASH_IO_2 | IS_SET_FLASH_IO_3 | IS_SET_FLASH_IO_4)  

#define IS_GET_FLASH_DELAY					-1
#define IS_GET_FLASH_DURATION				-2
#define IS_GET_MAX_FLASH_DELAY				-3
#define IS_GET_MAX_FLASH_DURATION			-4
#define IS_GET_MIN_FLASH_DELAY              -5
#define IS_GET_MIN_FLASH_DURATION           -6
#define IS_GET_FLASH_DELAY_GRANULARITY      -7
#define IS_GET_FLASH_DURATION_GRANULARITY   -8


// ----------------------------------------------
// Digital IO constants
// ----------------------------------------------
#define IS_GET_IO                   0x8000
#define IS_GET_IO_MASK              0x8000
#define IS_GET_INPUT_MASK           0x8001
#define IS_GET_OUTPUT_MASK          0x8002
#define IS_GET_SUPPORTED_IO_PORTS   0x8004


// ----------------------------------------------
// EEPROM defines
// ----------------------------------------------
#define IS_EEPROM_MIN_USER_ADDRESS      0
#define IS_EEPROM_MAX_USER_ADDRESS      63
#define IS_EEPROM_MAX_USER_SPACE        64


// ----------------------------------------------
// error report modes
// ----------------------------------------------
#define IS_GET_ERR_REP_MODE         0x8000
#define IS_ENABLE_ERR_REP           1
#define IS_DISABLE_ERR_REP          0


// ----------------------------------------------
// display mode selectors
// ----------------------------------------------
#define IS_GET_DISPLAY_MODE         0x8000
#define IS_GET_DISPLAY_SIZE_X       0x8000
#define IS_GET_DISPLAY_SIZE_Y       0x8001
#define IS_GET_DISPLAY_POS_X        0x8000
#define IS_GET_DISPLAY_POS_Y        0x8001

#define IS_SET_DM_DIB               1
#define IS_SET_DM_DIRECTDRAW        2
#define IS_SET_DM_DIRECT3D          4
#define IS_SET_DM_ALLOW_SYSMEM      0x40
#define IS_SET_DM_ALLOW_PRIMARY     0x80



// -- overlay display mode ---
#define IS_GET_DD_OVERLAY_SCALE     0x8000

#define IS_SET_DM_ALLOW_OVERLAY     0x100  
#define IS_SET_DM_ALLOW_SCALING     0x200
#define IS_SET_DM_ALLOW_FIELDSKIP   0x400
#define IS_SET_DM_MONO              0x800
#define IS_SET_DM_BAYER             0x1000
#define IS_SET_DM_YCBCR             0x4000

// -- backbuffer display mode ---
#define IS_SET_DM_BACKBUFFER        0x2000

// ----------------------------------------------------------------------------
// DirectRenderer commands
// ----------------------------------------------------------------------------
#define DR_GET_OVERLAY_DC                       1
#define DR_GET_MAX_OVERLAY_SIZE                 2
#define DR_GET_OVERLAY_KEY_COLOR                3
#define DR_RELEASE_OVERLAY_DC                   4
#define DR_SHOW_OVERLAY                         5         
#define DR_HIDE_OVERLAY                         6               
#define DR_SET_OVERLAY_SIZE                     7                       
#define DR_SET_OVERLAY_POSITION                 8    
#define DR_SET_OVERLAY_KEY_COLOR                9 
#define DR_SET_HWND                             10 
#define DR_ENABLE_SCALING                       11
#define DR_DISABLE_SCALING                      12
#define DR_CLEAR_OVERLAY                        13
#define DR_ENABLE_SEMI_TRANSPARENT_OVERLAY      14
#define DR_DISABLE_SEMI_TRANSPARENT_OVERLAY     15
#define DR_CHECK_COMPATIBILITY                  16
#define DR_SET_VSYNC_OFF                        17
#define DR_SET_VSYNC_AUTO                       18
#define DR_SET_USER_SYNC                        19
#define DR_GET_USER_SYNC_POSITION_RANGE         20
#define DR_LOAD_OVERLAY_FROM_FILE               21
#define DR_STEAL_NEXT_FRAME                     22
#define DR_SET_STEAL_FORMAT                     23
#define DR_GET_STEAL_FORMAT                     24
#define DR_ENABLE_IMAGE_SCALING                 25
#define DR_GET_OVERLAY_SIZE                     26


// ----------------------------------------------
// DirectDraw keying color constants
// ----------------------------------------------
#define IS_GET_KC_RED               0x8000
#define IS_GET_KC_GREEN             0x8001
#define IS_GET_KC_BLUE              0x8002
#define IS_GET_KC_RGB               0x8003
#define IS_GET_KC_INDEX             0x8004
#define IS_GET_KEYOFFSET_X          0x8000
#define IS_GET_KEYOFFSET_Y          0x8001

// RGB-triple for default key-color in 15,16,24,32 bit mode
#define IS_SET_KC_DEFAULT           0xFF00FF   // 0xbbggrr    
// color index for default key-color in 8bit palette mode
#define IS_SET_KC_DEFAULT_8         253


// ----------------------------------------------
// Memoryboard
// ----------------------------------------------
#define IS_MEMORY_GET_COUNT         0x8000
#define IS_MEMORY_GET_DELAY         0x8001
#define IS_MEMORY_MODE_DISABLE      0x0000
#define IS_MEMORY_USE_TRIGGER       0xFFFF


// ----------------------------------------------
// Test image modes
// ----------------------------------------------
#define IS_GET_TEST_IMAGE           0x8000

#define IS_SET_TEST_IMAGE_DISABLED  0x0000
#define IS_SET_TEST_IMAGE_MEMORY_1  0x0001
#define IS_SET_TEST_IMAGE_MEMORY_2  0x0002
#define IS_SET_TEST_IMAGE_MEMORY_3  0x0003


// ------------------------------------------
// Led settings
// ------------------------------------------
#define IS_SET_LED_OFF              0
#define IS_SET_LED_ON               1
#define IS_SET_LED_TOGGLE           2
#define IS_GET_LED                  0x8000


// ----------------------------------------------
// save options
// ----------------------------------------------
#define IS_SAVE_USE_ACTUAL_IMAGE_SIZE    0x00010000

// ----------------------------------------------
// renumeration modes
// ----------------------------------------------
#define IS_RENUM_BY_CAMERA                  0
#define IS_RENUM_BY_HOST                    1

// ----------------------------------------------
// event constants
// ----------------------------------------------
#define IS_SET_EVENT_FRAME						2
#define IS_SET_EVENT_EXTTRIG					3
#define IS_SET_EVENT_SEQ						5
#define IS_SET_EVENT_STEAL						6
#define IS_SET_EVENT_TRANSFER_FAILED			8
#define IS_SET_EVENT_DEVICE_RECONNECTED			9
#define IS_SET_EVENT_MEMORY_MODE_FINISH			10
#define IS_SET_EVENT_FRAME_RECEIVED				11
#define IS_SET_EVENT_WB_FINISHED				12
#define IS_SET_EVENT_AUTOBRIGHTNESS_FINISHED	13

#define IS_SET_EVENT_REMOVE                 128
#define IS_SET_EVENT_REMOVAL                129
#define IS_SET_EVENT_NEW_DEVICE             130


// ----------------------------------------------
// Window message defines
// ----------------------------------------------
#define IS_UC480_MESSAGE                (WM_USER + 0x0100)
  #define IS_FRAME                      0x0000
  #define IS_SEQUENCE                   0x0001
  #define IS_TRIGGER                    0x0002
  #define IS_TRANSFER_FAILED            0x0003
  #define IS_DEVICE_RECONNECTED         0x0004
  #define IS_MEMORY_MODE_FINISH         0x0005
  #define IS_FRAME_RECEIVED             0x0006
  #define IS_GENERIC_ERROR              0x0007
  #define IS_STEAL_VIDEO                0x0008
  #define IS_WB_FINISHED                0x0009
  #define IS_AUTOBRIGHTNESS_FINISHED    0x000A
  
  #define IS_DEVICE_REMOVED             0x1000
  #define IS_DEVICE_REMOVAL             0x1001
  #define IS_NEW_DEVICE                 0x1002
  
  
// ----------------------------------------------
// camera id constants
// ----------------------------------------------
#define IS_GET_CAMERA_ID                0x8000


// ----------------------------------------------
// camera info constants
// ----------------------------------------------
#define IS_GET_STATUS                   0x8000

#define IS_EXT_TRIGGER_EVENT_CNT        0
#define IS_FIFO_OVR_CNT                 1
#define IS_SEQUENCE_CNT                 2
#define IS_LAST_FRAME_FIFO_OVR          3
#define IS_SEQUENCE_SIZE                4
#define IS_STEAL_FINISHED               6
#define IS_BOARD_REVISION               9
#define IS_MIRROR_BITMAP_UPDOWN         10
#define IS_BUS_OVR_CNT                  11
#define IS_STEAL_ERROR_CNT              12
#define IS_LOW_COLOR_REMOVAL            13
#define IS_WAIT_TIMEOUT                 19
#define IS_TRIGGER_MISSED               20
#define IS_LAST_CAPTURE_ERROR           21
#define IS_PARAMETER_SET_1              22
#define IS_PARAMETER_SET_2              23
#define IS_STANDBY                      24
#define IS_STANDBY_SUPPORTED            25
#define IS_QUEUED_IMAGE_EVENT_CNT       26


// ----------------------------------------------------------------------------
// interface type defines
// ----------------------------------------------------------------------------
#define IS_INTERFACE_TYPE_USB           0x40
#define IS_INTERFACE_TYPE_ETH           0x80

// ----------------------------------------------
// board type defines
// ----------------------------------------------
#define IS_BOARD_TYPE_UC480_USB         (IS_INTERFACE_TYPE_USB + 0)     // 0x40
#define IS_BOARD_TYPE_UC480_USB_SE      IS_BOARD_TYPE_UC480_USB         // 0x40
#define IS_BOARD_TYPE_UC480_USB_RE      IS_BOARD_TYPE_UC480_USB         // 0x40
#define IS_BOARD_TYPE_UC480_USB_ME      (IS_INTERFACE_TYPE_USB + 0x01)  // 0x41
#define IS_BOARD_TYPE_UC480_USB_LE      (IS_INTERFACE_TYPE_USB + 0x02)  // 0x42
#define IS_BOARD_TYPE_UC480_ETH         IS_INTERFACE_TYPE_ETH           // 0x80
#define IS_BOARD_TYPE_UC480_ETH_HE      IS_BOARD_TYPE_UC480_ETH         // 0x80
#define IS_BOARD_TYPE_UC480_ETH_SE      (IS_INTERFACE_TYPE_ETH + 0x01)  // 0x81
#define IS_BOARD_TYPE_UC480_ETH_RE      IS_BOARD_TYPE_UC480_ETH_SE      // 0x81


// ----------------------------------------------------------------------------
// camera type defines
// ----------------------------------------------------------------------------
#define IS_CAMERA_TYPE_UC480_USB        IS_BOARD_TYPE_UC480_USB_SE
#define IS_CAMERA_TYPE_UC480_USB_SE     IS_BOARD_TYPE_UC480_USB_SE
#define IS_CAMERA_TYPE_UC480_USB_RE     IS_BOARD_TYPE_UC480_USB_RE
#define IS_CAMERA_TYPE_UC480_USB_ME     IS_BOARD_TYPE_UC480_USB_ME
#define IS_CAMERA_TYPE_UC480_USB_LE     IS_BOARD_TYPE_UC480_USB_LE
#define IS_CAMERA_TYPE_UC480_ETH        IS_BOARD_TYPE_UC480_ETH_HE
#define IS_CAMERA_TYPE_UC480_ETH_HE     IS_BOARD_TYPE_UC480_ETH_HE
#define IS_CAMERA_TYPE_UC480_ETH_SE     IS_BOARD_TYPE_UC480_ETH_SE
#define IS_CAMERA_TYPE_UC480_ETH_RE     IS_BOARD_TYPE_UC480_ETH_RE


// ----------------------------------------------
// readable operation system defines
// ----------------------------------------------
#define IS_OS_UNDETERMINED          0
#define IS_OS_WIN95                 1 
#define IS_OS_WINNT40               2 
#define IS_OS_WIN98                 3
#define IS_OS_WIN2000               4
#define IS_OS_WINXP                 5
#define IS_OS_WINME                 6
#define IS_OS_WINNET                7
#define IS_OS_WINSERVER2003         8
#define IS_OS_WINVISTA              9
#define IS_OS_WIN7                  12


// ----------------------------------------------
// Bus speed
// ----------------------------------------------
#define IS_USB_10                   0x0001  //  1,5 Mb/s
#define IS_USB_11                   0x0002  //   12 Mb/s
#define IS_USB_20                   0x0004  //  480 Mb/s
#define IS_USB_30                   0x0008  // 5000 Mb/s
#define IS_ETHERNET_10              0x0080  //   10 Mb/s
#define IS_ETHERNET_100             0x0100  //  100 Mb/s
#define IS_ETHERNET_1000            0x0200  // 1000 Mb/s
#define IS_ETHERNET_10000           0x0400  //10000 Mb/s

#define IS_USB_LOW_SPEED            1
#define IS_USB_FULL_SPEED           12
#define IS_USB_HIGH_SPEED           480
#define IS_USB_SUPER_SPEED          5000
#define IS_ETHERNET_10Base          10
#define IS_ETHERNET_100Base         100
#define IS_ETHERNET_1000Base        1000
#define IS_ETHERNET_10GBase         10000

// ----------------------------------------------
// HDR
// ----------------------------------------------
#define IS_HDR_NOT_SUPPORTED		0
#define IS_HDR_KNEEPOINTS			1
#define IS_DISABLE_HDR				0
#define IS_ENABLE_HDR				1

// ----------------------------------------------
// Test images
// ----------------------------------------------
#define IS_TEST_IMAGE_NONE                          0x00000000
#define IS_TEST_IMAGE_WHITE                         0x00000001
#define IS_TEST_IMAGE_BLACK                         0x00000002
#define IS_TEST_IMAGE_HORIZONTAL_GREYSCALE          0x00000004
#define IS_TEST_IMAGE_VERTICAL_GREYSCALE            0x00000008
#define IS_TEST_IMAGE_DIAGONAL_GREYSCALE            0x00000010
#define IS_TEST_IMAGE_WEDGE_GRAY                    0x00000020
#define IS_TEST_IMAGE_WEDGE_COLOR                   0x00000040
#define IS_TEST_IMAGE_ANIMATED_WEDGE_GRAY           0x00000080

#define IS_TEST_IMAGE_ANIMATED_WEDGE_COLOR          0x00000100
#define IS_TEST_IMAGE_MONO_BARS                     0x00000200
#define IS_TEST_IMAGE_COLOR_BARS1                   0x00000400
#define IS_TEST_IMAGE_COLOR_BARS2                   0x00000800
#define IS_TEST_IMAGE_GREYSCALE1                    0x00001000
#define IS_TEST_IMAGE_GREY_AND_COLOR_BARS           0x00002000
#define IS_TEST_IMAGE_MOVING_GREY_AND_COLOR_BARS    0x00004000
#define IS_TEST_IMAGE_ANIMATED_LINE                 0x00008000

#define IS_TEST_IMAGE_ALTERNATE_PATTERN             0x00010000
#define IS_TEST_IMAGE_VARIABLE_GREY                 0x00020000
#define IS_TEST_IMAGE_MONOCHROME_HORIZONTAL_BARS    0x00040000
#define IS_TEST_IMAGE_MONOCHROME_VERTICAL_BARS      0x00080000
#define IS_TEST_IMAGE_CURSOR_H                      0x00100000
#define IS_TEST_IMAGE_CURSOR_V                      0x00200000
#define IS_TEST_IMAGE_COLDPIXEL_GRID                0x00400000
#define IS_TEST_IMAGE_HOTPIXEL_GRID                 0x00800000

#define IS_TEST_IMAGE_VARIABLE_RED_PART             0x01000000
#define IS_TEST_IMAGE_VARIABLE_GREEN_PART           0x02000000
#define IS_TEST_IMAGE_VARIABLE_BLUE_PART            0x04000000
#define IS_TEST_IMAGE_SHADING_IMAGE                 0x08000000
//                                                  0x10000000
//                                                  0x20000000
//                                                  0x40000000
//                                                  0x80000000


// ----------------------------------------------------------------------------
// Sensor scaler
// ----------------------------------------------------------------------------
#define IS_ENABLE_SENSOR_SCALER     1
#define IS_ENABLE_ANTI_ALIASING     2

// ----------------------------------------------------------------------------
// Timeouts
// ----------------------------------------------------------------------------
#define IS_TRIGGER_TIMEOUT          0

// ----------------------------------------------
// Auto pixel clock modes
// ----------------------------------------------
#define IS_BEST_PCLK_RUN_ONCE		0

// ----------------------------------------------
// sequence flags
// ----------------------------------------------
#define IS_LOCK_LAST_BUFFER         0x8002

// ----------------------------------------------
// Image files types
// ----------------------------------------------
#define IS_IMG_BMP                  0
#define IS_IMG_JPG                  1
#define IS_IMG_PNG                  2
#define IS_IMG_RAW                  4
#define IS_IMG_TIF                  8

// ----------------------------------------------
// I2C defines
// nRegisterAddr | IS_I2C_16_BIT_REGISTER
// ----------------------------------------------
#define IS_I2C_16_BIT_REGISTER      0x10000000

// ----------------------------------------------
// DirectDraw steal video constants
// ----------------------------------------------
#define IS_INIT_STEAL_VIDEO         1
#define IS_EXIT_STEAL_VIDEO         2
#define IS_INIT_STEAL_VIDEO_MANUAL  3
#define IS_INIT_STEAL_VIDEO_AUTO    4
#define IS_SET_STEAL_RATIO          64
#define IS_USE_MEM_IMAGE_SIZE       128
#define IS_STEAL_MODES_MASK         7
#define IS_SET_STEAL_COPY           0x1000
#define IS_SET_STEAL_NORMAL         0x2000

// ----------------------------------------------
// AGC modes
// ----------------------------------------------
#define IS_GET_AGC_MODE             0x8000
#define IS_SET_AGC_OFF              0
#define IS_SET_AGC_ON               1


// ----------------------------------------------
// Gamma modes
// ----------------------------------------------
#define IS_GET_GAMMA_MODE           0x8000
#define IS_SET_GAMMA_OFF            0
#define IS_SET_GAMMA_ON             1


#include <windows.h>

#define USBCAMEXP    extern  __declspec(dllimport) INT   __cdecl
#define UC480CAMEXP  extern  __declspec(dllimport) INT   __cdecl
#define USBCAMEXPUL  extern  __declspec(dllimport) ULONG __cdecl


// ----------------------------------------------
// typedefs
// ----------------------------------------------
typedef DWORD HCAM;


// ----------------------------------------------
// info struct
// ----------------------------------------------
#define BOARDINFO   CAMINFO
#define PBOARDINFO  PCAMINFO 


typedef struct
{
  char          SerNo[12];    // (11 char)
  char          ID[20];       // e.g. "Company Name"
  char          Version[10];  // e.g. "V1.00"  (9 char)
  char          Date[12];     // e.g "11.03.2004" (11 char)
  unsigned char Select;       // 0 (contains camera select number for multi camera support)
  unsigned char Type;         // 1 (contains camera type)
  char          Reserved[8];  // (7 char)
} CAMINFO, *PCAMINFO;


typedef struct _SENSORINFO
{
  WORD          SensorID;           // e.g. IS_SENSOR_C0640R13M
  IS_CHAR       strSensorName[32];  // e.g. "C0640R13M"
  char          nColorMode;         // e.g. IS_COLORMODE_BAYER
  DWORD         nMaxWidth;          // e.g. 1280
  DWORD         nMaxHeight;         // e.g. 1024
  BOOL          bMasterGain;        // e.g. FALSE
  BOOL          bRGain;             // e.g. TRUE
  BOOL          bGGain;             // e.g. TRUE
  BOOL          bBGain;             // e.g. TRUE
  BOOL          bGlobShutter;       // e.g. TRUE
  char          Reserved[16];   // not used
} SENSORINFO, *PSENSORINFO;


typedef struct _REVISIONINFO
{
    WORD  size;                     // 2
    WORD  Sensor;                   // 2
    WORD  Cypress;                  // 2
    DWORD Blackfin;                 // 4
    WORD  DspFirmware;              // 2
                                    // --12
    WORD  USB_Board;                // 2
    WORD  Sensor_Board;             // 2
    WORD  Processing_Board;         // 2
    WORD  Memory_Board;             // 2
    WORD  Housing;                  // 2
    WORD  Filter;                   // 2
    WORD  Timing_Board;             // 2
    WORD  Product;                  // 2
                                    // --24
    BYTE reserved[100];             // --128
} REVISIONINFO, *PREVISIONINFO;


/************************************************************************/
/* Capture errors                                                       */
/************************************************************************/
typedef enum _UC480_CAPTURE_ERROR
{
    IS_CAPERR_API_NO_DEST_MEM=              0xa2,
    IS_CAPERR_API_CONVERSION_FAILED=        0xa3,
    IS_CAPERR_API_IMAGE_LOCKED=             0xa5,
    
    IS_CAPERR_DRV_OUT_OF_BUFFERS=           0xb2,
    IS_CAPERR_DRV_DEVICE_NOT_READY=         0xb4,

    IS_CAPERR_USB_TRANSFER_FAILED=          0xc7,

    IS_CAPERR_DEV_TIMEOUT=                  0xd6,

    IS_CAPERR_ETH_BUFFER_OVERRUN=           0xe4,
    IS_CAPERR_ETH_MISSED_IMAGES=            0xe5

} UC480_CAPTURE_ERROR;

typedef struct _UC480_CAPTURE_ERROR_INFO
{
    DWORD dwCapErrCnt_Total;

    BYTE  reserved[60];

    DWORD adwCapErrCnt_Detail[256]; // access via UC480_CAPTURE_ERROR

} UC480_CAPTURE_ERROR_INFO;


#ifndef UC480_CAMERA_INFO_STRUCT
#define UC480_CAMERA_INFO_STRUCT
typedef struct _UC480_CAMERA_INFO
{
  DWORD     dwCameraID;   // this is the user defineable camera ID
  DWORD     dwDeviceID;   // this is the systems enumeration ID
  DWORD     dwSensorID;   // this is the sensor ID e.g. IS_SENSOR_C0640R13M
  DWORD     dwInUse;      // flag, whether the camera is in use or not
  IS_CHAR   SerNo[16];    // serial numer of the camera
  IS_CHAR   Model[16];    // model name of the camera
  DWORD     dwStatus;     // various flags with camera status
  DWORD     dwReserved[15];
}UC480_CAMERA_INFO, *PUC480_CAMERA_INFO;
#endif //UC480_CAMERA_INFO_STRUCT

// usage of the list:
// 1. call the DLL with .dwCount = 0
// 2. DLL returns .dwCount = N  (N = number of available cameras)
// 3. call DLL with .dwCount = N and a pointer to UC480_CAMERA_LIST with
//    and array of UC480_CAMERA_INFO[N]
// 4. DLL will fill in the array with the camera infos and
//    will update the .dwCount member with the actual number of cameras
//    because there may be a change in number of cameras between step 2 and 3
// 5. check if there's a difference in actual .dwCount and formerly
//    reported value of N and call DLL again with an updated array size
#ifndef UC480_CAMERA_LIST_STRUCT
#define UC480_CAMERA_LIST_STRUCT
typedef struct _UC480_CAMERA_LIST
{
  ULONG     dwCount;
  UC480_CAMERA_INFO uci[1];
}UC480_CAMERA_LIST, *PUC480_CAMERA_LIST;
#endif //UC480_CAMERA_LIST_STRUCT

// ----------------------------------------------------------------------
// the  following defines are the status bits of the dwStatus member of
// the UC480_CAMERA_INFO structure
#define FIRMWARE_DOWNLOAD_NOT_SUPPORTED                 0x00000001
#define INTERFACE_SPEED_NOT_SUPPORTED                   0x00000002
#define INVALID_SENSOR_DETECTED                         0x00000004
#define AUTHORIZATION_FAILED                            0x00000008
#define DEVSTS_INCLUDED_STARTER_FIRMWARE_INCOMPATIBLE   0x00000010

// the following maco determines the 'availablility' of the camera based
// on the status flags
#define IS_CAMERA_AVAILABLE(_s_)     ( (((_s_) & FIRMWARE_DOWNLOAD_NOT_SUPPORTED) == 0) && \
                                       (((_s_) & INTERFACE_SPEED_NOT_SUPPORTED)   == 0) && \
                                       (((_s_) & INVALID_SENSOR_DETECTED)         == 0) && \
                                       (((_s_) & AUTHORIZATION_FAILED)            == 0) )

// ----------------------------------------------
// auto feature structs and definitions
// ----------------------------------------------
#define AC_SHUTTER              0x00000001
#define AC_GAIN                 0x00000002
#define AC_WHITEBAL             0x00000004
#define AC_WB_RED_CHANNEL       0x00000008
#define AC_WB_GREEN_CHANNEL     0x00000010
#define AC_WB_BLUE_CHANNEL      0x00000020
#define AC_FRAMERATE            0x00000040

#define AC_SENSOR_SHUTTER		0x00000080
#define AC_SENSOR_GAIN			0x00000100
#define AC_SENSOR_GAIN_SHUTTER	0x00000200
#define AC_SENSOR_FRAMERATE     0x00000400

#define ACS_ADJUSTING           0x00000001
#define ACS_FINISHED            0x00000002
#define ACS_DISABLED            0x00000004

typedef struct _AUTO_BRIGHT_STATUS
{
    DWORD curValue;             // current average greylevel
    long curError;              // current auto brightness error
    DWORD curController;        // current active brightness controller -> AC_x
    DWORD curCtrlStatus;        // current control status -> ACS_x
} AUTO_BRIGHT_STATUS, *PAUTO_BRIGHT_STATUS;



typedef struct _AUTO_WB_CHANNNEL_STATUS
{
    DWORD curValue;             // current average greylevel
    long curError;              // current auto wb error
    DWORD curCtrlStatus;        // current control status -> ACS_x
} AUTO_WB_CHANNNEL_STATUS, *PAUTO_WB_CHANNNEL_STATUS;

typedef struct _AUTO_WB_STATUS
{
    AUTO_WB_CHANNNEL_STATUS RedChannel;
    AUTO_WB_CHANNNEL_STATUS GreenChannel;
    AUTO_WB_CHANNNEL_STATUS BlueChannel;
    DWORD curController;        // current active wb controller -> AC_x
} AUTO_WB_STATUS, *PAUTO_WB_STATUS;

typedef struct _UC480_AUTO_INFO
{
    DWORD               AutoAbility;        // autocontrol ability
    AUTO_BRIGHT_STATUS  sBrightCtrlStatus;  // brightness autocontrol status
    AUTO_WB_STATUS      sWBCtrlStatus;      // white balance autocontrol status
    DWORD               reserved[12];
} UC480_AUTO_INFO, *PUC480_AUTO_INFO;


// ----------------------------------------------
// function exports
// ----------------------------------------------

// ----------------------------------------------
// common function
// ----------------------------------------------



  USBCAMEXP   is_StopLiveVideo          (HCAM hf, INT Wait);
  USBCAMEXP   is_FreezeVideo            (HCAM hf, INT Wait);
  USBCAMEXP   is_CaptureVideo           (HCAM hf, INT Wait);
  USBCAMEXP   is_IsVideoFinish          (HCAM hf, BOOL* pbo);
  USBCAMEXP   is_HasVideoStarted        (HCAM hf, BOOL* pbo);
  
  USBCAMEXP   is_SetBrightness          (HCAM hf, INT Bright);
  USBCAMEXP   is_SetContrast            (HCAM hf, INT Cont);
  USBCAMEXP   is_SetGamma               (HCAM hf, INT nGamma);
  
  USBCAMEXP   is_AllocImageMem          (HCAM hf, INT width, INT height, INT bitspixel, char** ppcImgMem, int* pid);
  USBCAMEXP   is_SetImageMem            (HCAM hf, char* pcMem, int id);
  USBCAMEXP   is_FreeImageMem           (HCAM hf, char* pcMem, int id);
  USBCAMEXP   is_GetImageMem            (HCAM hf, VOID** pMem);   
  USBCAMEXP   is_GetActiveImageMem      (HCAM hf, char** ppcMem, int* pnID);
  USBCAMEXP   is_InquireImageMem        (HCAM hf, char* pcMem, int nID, int* pnX, int* pnY, int* pnBits, int* pnPitch);  
  USBCAMEXP   is_GetImageMemPitch       (HCAM hf, INT* pPitch);
  
  USBCAMEXP   is_SetAllocatedImageMem   (HCAM hf, INT width, INT height, INT bitspixel, char* pcImgMem, int* pid);
  USBCAMEXP   is_SaveImageMem           (HCAM hf, const IS_CHAR* File, char* pcMem, int nID);
  USBCAMEXP   is_CopyImageMem           (HCAM hf, char* pcSource, int nID, char* pcDest);
  USBCAMEXP   is_CopyImageMemLines      (HCAM hf, char* pcSource, int nID, int nLines, char* pcDest);
  
  USBCAMEXP   is_AddToSequence          (HCAM hf, char* pcMem, INT nID);
  USBCAMEXP   is_ClearSequence          (HCAM hf);
  USBCAMEXP   is_GetActSeqBuf           (HCAM hf, INT* pnNum, char** ppcMem, char** ppcMemLast);
  USBCAMEXP   is_LockSeqBuf             (HCAM hf, INT nNum, char* pcMem);
  USBCAMEXP   is_UnlockSeqBuf           (HCAM hf, INT nNum, char* pcMem);
   
  USBCAMEXP   is_SetImageSize           (HCAM hf, INT x, INT y);
  USBCAMEXP   is_SetImagePos            (HCAM hf, INT x, INT y);
  
  USBCAMEXP   is_GetError               (HCAM hf, INT* pErr, IS_CHAR** ppcErr);
  USBCAMEXP   is_SetErrorReport         (HCAM hf, INT Mode);
  
  USBCAMEXP   is_ReadEEPROM             (HCAM hf, INT Adr, char* pcString, INT Count);
  USBCAMEXP   is_WriteEEPROM            (HCAM hf, INT Adr, char* pcString, INT Count);
  USBCAMEXP   is_SaveImage              (HCAM hf, const IS_CHAR* File);
  
  USBCAMEXP   is_SetColorMode           (HCAM hf, INT Mode);
  USBCAMEXP   is_GetColorDepth          (HCAM hf, INT* pnCol, INT* pnColMode);
  // bitmap display function
  USBCAMEXP   is_RenderBitmap           (HCAM hf, INT nMemID, HWND hwnd, INT nMode);
  
  USBCAMEXP   is_SetDisplayMode         (HCAM hf, INT Mode);
  USBCAMEXP   is_GetDC                  (HCAM hf, HDC* phDC);
  USBCAMEXP   is_ReleaseDC              (HCAM hf, HDC hDC);
  USBCAMEXP   is_UpdateDisplay          (HCAM hf);
  USBCAMEXP   is_SetDisplaySize         (HCAM hf, INT x, INT y);
  USBCAMEXP   is_SetDisplayPos          (HCAM hf, INT x, INT y);
  
  USBCAMEXP   is_LockDDOverlayMem       (HCAM hf, VOID** ppMem, INT* pPitch);
  USBCAMEXP   is_UnlockDDOverlayMem     (HCAM hf);
  USBCAMEXP   is_LockDDMem              (HCAM hf, VOID** ppMem, INT* pPitch);
  USBCAMEXP   is_UnlockDDMem            (HCAM hf);
  USBCAMEXP   is_GetDDOvlSurface        (HCAM hf, void** ppDDSurf);
  USBCAMEXP   is_SetKeyColor            (HCAM hf, INT r, INT g, INT b);
  USBCAMEXP   is_StealVideo             (HCAM hf, int Wait);
  USBCAMEXP   is_SetHwnd                (HCAM hf, HWND hwnd);
    
  USBCAMEXP   is_SetDDUpdateTime        (HCAM hf, int ms);
  USBCAMEXP   is_EnableDDOverlay        (HCAM hf);
  USBCAMEXP   is_DisableDDOverlay       (HCAM hf);
  USBCAMEXP   is_ShowDDOverlay          (HCAM hf);
  USBCAMEXP   is_HideDDOverlay          (HCAM hf);
    
  USBCAMEXP   is_GetVsyncCount          (HCAM hf, long* pIntr, long* pActIntr);
  USBCAMEXP   is_GetOsVersion           (void);
  // version information
  USBCAMEXP   is_GetDLLVersion          (void);
  
  USBCAMEXP   is_InitEvent              (HCAM hf, HANDLE hEv, INT which);
  USBCAMEXP   is_ExitEvent              (HCAM hf, INT which);
  USBCAMEXP   is_EnableEvent            (HCAM hf, INT which);
  USBCAMEXP   is_DisableEvent           (HCAM hf, INT which);
  
  USBCAMEXP   is_SetIO                  (HCAM hf, INT nIO);
  USBCAMEXP   is_SetFlashStrobe         (HCAM hf, INT nMode, INT nLine);
  USBCAMEXP   is_SetExternalTrigger     (HCAM hf, INT nTriggerMode);
  USBCAMEXP   is_SetTriggerCounter      (HCAM hf, INT nValue);
  USBCAMEXP   is_SetRopEffect           (HCAM hf, INT effect, INT param, INT reserved);

  // Camera functions
  USBCAMEXP is_InitCamera                  (HCAM* phf, HWND hWnd);
  USBCAMEXP is_ExitCamera                  (HCAM hf);
  USBCAMEXP is_GetCameraInfo               (HCAM hf, PCAMINFO pInfo);
  USBCAMEXPUL is_CameraStatus              (HCAM hf, INT nInfo, ULONG ulValue);
  USBCAMEXP is_GetCameraType               (HCAM hf);
  USBCAMEXP is_GetNumberOfCameras          (INT* pnNumCams);
  
  // PixelClock
  USBCAMEXP is_GetPixelClockRange          (HCAM hf, INT *pnMin, INT *pnMax);
  USBCAMEXP is_SetPixelClock               (HCAM hf, INT Clock);
  USBCAMEXP is_GetUsedBandwidth            (HCAM hf);
  // Set/Get Framerate
  USBCAMEXP is_GetFrameTimeRange           (HCAM hf, double *min, double *max, double *intervall);
  USBCAMEXP is_SetFrameRate                (HCAM hf, double FPS, double* newFPS);
  // Set/Get Exposure
  USBCAMEXP is_GetExposureRange            (HCAM hf, double *min, double *max, double *intervall);
  USBCAMEXP is_SetExposureTime             (HCAM hf, double EXP, double* newEXP);
  // get frames per second
  USBCAMEXP is_GetFramesPerSecond          (HCAM hf, double *dblFPS);

  // is_SetIOMask
  USBCAMEXP is_SetIOMask                   (HCAM hf, INT nMask);
  
  // Get Sensorinfo
  USBCAMEXP is_GetSensorInfo               (HCAM hf, PSENSORINFO pInfo);
  // Get RevisionInfo
  USBCAMEXP is_GetRevisionInfo             (HCAM hf, PREVISIONINFO prevInfo);

  // enable/disable AutoExit after device remove
  USBCAMEXP is_EnableAutoExit              (HCAM hf, INT nMode);
  // Message
  USBCAMEXP is_EnableMessage               (HCAM hf, INT which, HWND hWnd);
    
  // hardware gain settings
  USBCAMEXP is_SetHardwareGain             (HCAM hf, INT nMaster, INT nRed, INT nGreen, INT nBlue);

  // set render mode
  USBCAMEXP is_SetRenderMode               (HCAM hf, INT Mode);

  // enable/disable WhiteBalance
  USBCAMEXP is_SetWhiteBalance             (HCAM hf, INT nMode);
  USBCAMEXP is_SetWhiteBalanceMultipliers  (HCAM hf, double dblRed, double dblGreen, double dblBlue);
  USBCAMEXP is_GetWhiteBalanceMultipliers  (HCAM hf, double *pdblRed, double *pdblGreen, double *pdblBlue);
 
  // Edge enhancement
  USBCAMEXP is_SetEdgeEnhancement          (HCAM hf, INT nEnable);

  // Sensor features
  USBCAMEXP is_SetColorCorrection          (HCAM hf, INT nEnable, double *factors);
  USBCAMEXP is_SetBlCompensation           (HCAM hf, INT nEnable, INT offset, INT reserved);

  // Hotpixel
  USBCAMEXP is_SetBadPixelCorrection       (HCAM hf, INT nEnable, INT threshold);
  USBCAMEXP is_LoadBadPixelCorrectionTable (HCAM hf, const IS_CHAR* File);
  USBCAMEXP is_SaveBadPixelCorrectionTable (HCAM hf, const IS_CHAR* File);
  USBCAMEXP is_SetBadPixelCorrectionTable  (HCAM hf, INT nMode, WORD *pList);

  // Memoryboard
  USBCAMEXP is_SetMemoryMode               (HCAM hf, INT nCount, INT nDelay);
  USBCAMEXP is_TransferImage               (HCAM hf, INT nMemID, INT seqID, INT imageNr, INT reserved);
  USBCAMEXP is_TransferMemorySequence      (HCAM hf, INT seqID, INT StartNr, INT nCount, INT nSeqPos);
  USBCAMEXP is_MemoryFreezeVideo           (HCAM hf, INT nMemID, INT Wait);
  USBCAMEXP is_GetLastMemorySequence       (HCAM hf, INT *pID);
  USBCAMEXP is_GetNumberOfMemoryImages     (HCAM hf, INT nID, INT *pnCount);
  USBCAMEXP is_GetMemorySequenceWindow     (HCAM hf, INT nID, INT *left, INT *top, INT *right, INT *bottom);
  USBCAMEXP is_IsMemoryBoardConnected      (HCAM hf, BOOL *pConnected);
  USBCAMEXP is_ResetMemory                 (HCAM hf, INT nReserved);
      
  USBCAMEXP is_SetSubSampling              (HCAM hf, INT mode);
  USBCAMEXP is_ForceTrigger                (HCAM hf);
  
  // new with driver version 1.12.0006
  USBCAMEXP is_GetBusSpeed                 (HCAM hf);
  
  // new with driver version 1.12.0015
  USBCAMEXP is_SetBinning                  (HCAM hf, INT mode);  
   
  // new with driver version 1.12.0017
  USBCAMEXP is_ResetToDefault              (HCAM hf);
  USBCAMEXP is_LoadParameters              (HCAM hf, const IS_CHAR* pFilename);
  USBCAMEXP is_SaveParameters              (HCAM hf, const IS_CHAR* pFilename);
   
  // new with driver version 1.14.0001
  USBCAMEXP is_GetGlobalFlashDelays        (HCAM hf, ULONG *pulDelay, ULONG *pulDuration);
  USBCAMEXP is_SetFlashDelay               (HCAM hf, ULONG ulDelay, ULONG ulDuration);         
  // new with driver version 1.14.0002
  USBCAMEXP is_LoadImage                   (HCAM hf, const IS_CHAR* File);  
  
  // new with driver version 1.14.0008
  USBCAMEXP is_SetImageAOI                 (HCAM hf, INT xPos, INT yPos, INT width, INT height);
  USBCAMEXP is_SetCameraID                 (HCAM hf, INT nID);
  USBCAMEXP is_SetBayerConversion          (HCAM hf, INT nMode);
  USBCAMEXP is_SetTestImage                (HCAM hf, INT nMode);
  // new with driver version 1.14.0009
  USBCAMEXP is_SetHardwareGamma            (HCAM hf, INT nMode);
  
  // new with driver version 2.00.0001
  USBCAMEXP is_GetCameraList               (PUC480_CAMERA_LIST pucl);
  
  // new with driver version 2.00.0011
  USBCAMEXP is_SetAOI                      (HCAM hf, INT type, INT *pXPos, INT *pYPos, INT *pWidth, INT *pHeight);
  USBCAMEXP is_SetAutoParameter            (HCAM hf, INT param, double *pval1, double *pval2);
  USBCAMEXP is_GetAutoInfo                 (HCAM hf, UC480_AUTO_INFO *pInfo);  

  // new with driver version 2.20.0001
  USBCAMEXP is_SetSaturation			         (HCAM hf, INT ChromU, INT ChromV);
  USBCAMEXP is_ConvertImage                (HCAM hf, char* pcSource, int nIDSource, char** pcDest, INT *nIDDest, INT *reserved);
  USBCAMEXP is_SetConvertParam             (HCAM hf, BOOL ColorCorrection, INT BayerConversionMode, INT ColorMode, INT Gamma, double* WhiteBalanceMultipliers);
  
  USBCAMEXP is_SaveImageEx                 (HCAM hf, const IS_CHAR* File, INT fileFormat, INT Param);
  USBCAMEXP is_SaveImageMemEx              (HCAM hf, const IS_CHAR* File, char* pcMem, INT nID, INT FileFormat, INT Param);
  USBCAMEXP is_LoadImageMem                (HCAM hf, const IS_CHAR* File, char** ppcImgMem, INT* pid);
  
  USBCAMEXP is_GetImageHistogram           (HCAM hf, int nID, INT ColorMode, DWORD* pHistoMem);
  USBCAMEXP is_SetTriggerDelay             (HCAM hf, INT nTriggerDelay);

  // new with driver version 2.21.0000
  USBCAMEXP is_SetGainBoost                (HCAM hf, INT mode);
  USBCAMEXP is_SetLED                      (HCAM hf, INT nValue);

  USBCAMEXP is_SetGlobalShutter            (HCAM hf, INT mode );
  USBCAMEXP is_SetExtendedRegister         (HCAM hf, INT index,WORD value);

  // new with driver version 2.22.0002
  USBCAMEXP is_SetHWGainFactor             (HCAM hf, INT nMode, INT nFactor);

  // camera renumeration
  USBCAMEXP is_Renumerate                  (HCAM hf, INT nMode);

  USBCAMEXP is_GetExtendedRegister         (HCAM hf, INT index, WORD *pwValue);

  USBCAMEXP is_WriteI2C                    (HCAM hf, INT nDeviceAddr, INT nRegisterAddr, BYTE* pbData, INT nLen);
  USBCAMEXP is_ReadI2C                     (HCAM hf, INT nDeviceAddr, INT nRegisterAddr, BYTE* pbData, INT nLen);
  
  typedef struct _KNEEPOINT
  {
	  double x;
	  double y;
  } KNEEPOINT, *PKNEEPOINT;


  typedef struct _KNEEPOINTARRAY
  {
	  INT NumberOfUsedKneepoints;
	  KNEEPOINT Kneepoint[10];
  } KNEEPOINTARRAY, *PKNEEPOINTARRAY;


  typedef struct _KNEEPOINTINFO
  {
	  INT NumberOfSupportedKneepoints;
	  INT NumberOfUsedKneepoints;
	  double MinValueX;
	  double MaxValueX;
	  double MinValueY;
	  double MaxValueY;
	  KNEEPOINT DefaultKneepoint[10];
	  INT Reserved[10];
  } KNEEPOINTINFO, *PKNEEPOINTINFO;

  
  // HDR functions
  USBCAMEXP is_GetHdrMode				   (HCAM hf, INT *Mode);
  USBCAMEXP is_EnableHdr				   (HCAM hf, INT Enable);
  USBCAMEXP is_SetHdrKneepoints			   (HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize);
  USBCAMEXP is_GetHdrKneepoints			   (HCAM hf, KNEEPOINTARRAY *KneepointArray, INT KneepointArraySize);
  USBCAMEXP is_GetHdrKneepointInfo         (HCAM hf, KNEEPOINTINFO *KneepointInfo, INT KneepointInfoSize);
  
  // Auto PCLK function
  USBCAMEXP is_SetOptimalCameraTiming	   (HCAM hf, INT Mode, INT Timeout, INT *pMaxPxlClk, double *pMaxFrameRate);

  USBCAMEXP is_GetSupportedTestImages	   (HCAM hf, INT *SupportedTestImages);
  USBCAMEXP is_GetTestImageValueRange	   (HCAM hf, INT TestImage, INT *TestImageValueMin, INT *TestImageValueMax);
  USBCAMEXP is_SetSensorTestImage		   (HCAM hf, INT Param1, INT Param2);

  USBCAMEXP is_SetCameraLUT                (HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue);
  USBCAMEXP is_GetCameraLUT                (HCAM hf, UINT Mode, UINT NumberOfEntries, double *pRed_Grey, double *pGreen, double *pBlue);

  USBCAMEXP is_GetColorConverter           (HCAM hf, INT ColorMode, INT *pCurrentConvertMode, INT *pDefaultConvertMode, INT *pSupportedConvertModes);
  USBCAMEXP is_SetColorConverter           (HCAM hf, INT ColorMode, INT ConvertMode);


  typedef enum  eUC480_GET_ESTIMATED_TIME_MODE
  {
      IS_SE_STARTER_FW_UPLOAD =   0x00000001, /*!< get estimated duration of GigE SE starter firmware upload in milliseconds */

  } UC480_GET_ESTIMATED_TIME_MODE;    
  
  
  USBCAMEXP is_GetDuration                 (HCAM hf, UINT nMode, INT* pnTime);


  // new with driver version 3.50.0000
  typedef struct eSENSORSCALERINFO
  {
      INT       nCurrMode;
      INT       nNumberOfSteps;
      double    dblFactorIncrement;
      double    dblMinFactor;
      double    dblMaxFactor;
      double    dblCurrFactor;
      BYTE      bReserved[88];
  } SENSORSCALERINFO;


  USBCAMEXP is_GetSensorScalerInfo  (HCAM hf, SENSORSCALERINFO *pSensorScalerInfo, INT nSensorScalerInfoSize); 
  USBCAMEXP is_SetSensorScaler      (HCAM hf, UINT nMode, double dblFactor); 

  typedef struct eUC480TIME
  {
      WORD      wYear;
      WORD      wMonth;
      WORD      wDay;
      WORD      wHour;
      WORD      wMinute;
      WORD      wSecond;
      WORD      wMilliseconds;
      BYTE      byReserved[10];
  } UC480TIME;


  typedef struct eUC480IMAGEINFO
  {
      DWORD                 dwFlags;
      BYTE                  byReserved1[4];
      UINT64                u64TimestampDevice;
      UC480TIME             TimestampSystem;
      DWORD                 dwIoStatus;
      BYTE                  byReserved2[4];
      UINT64                u64FrameNumber;
      DWORD                 dwImageBuffers;
      DWORD                 dwImageBuffersInUse;
      DWORD                 dwReserved3;
      DWORD                 dwImageHeight;
      DWORD                 dwImageWidth;
  } UC480IMAGEINFO;


  USBCAMEXP is_GetImageInfo (HCAM hf, INT nImageBufferID, UC480IMAGEINFO *pImageInfo, INT nImageInfoSize);


  // ---------------------------------------------------
  // new functions and datatypes only valid for uc480 ETH
  // ---------------------------------------------------

#pragma pack( push, 1)

  // IP V4 address
  typedef union _UC480_ETH_ADDR_IPV4
  {
      struct
      {
          BYTE	by1;
          BYTE	by2;
          BYTE	by3;
          BYTE	by4;
      } by;

      DWORD dwAddr;

  } UC480_ETH_ADDR_IPV4, *PUC480_ETH_ADDR_IPV4;

  // ethernet address
  typedef struct _UC480_ETH_ADDR_MAC
  {
      BYTE abyOctet[6];

  } UC480_ETH_ADDR_MAC, *PUC480_ETH_ADDR_MAC;

  // ip configuration
  typedef struct _UC480_ETH_IP_CONFIGURATION
  {
      UC480_ETH_ADDR_IPV4	ipAddress;		/*!< IP address */
      UC480_ETH_ADDR_IPV4	ipSubnetmask;	/*!< IP subnetmask */

      BYTE					reserved[4];	/*!< reserved */

  } UC480_ETH_IP_CONFIGURATION, *PUC480_ETH_IP_CONFIGURATION;

  // values for UC480_ETH_DEVICE_INFO_HEARTBEAT::dwDeviceStatusFlags
  typedef enum _UC480_ETH_DEVICESTATUS
  {
      IS_ETH_DEVSTATUS_READY_TO_OPERATE=			0x00000001,	/*!< device is ready to operate */
      IS_ETH_DEVSTATUS_TESTING_IP_CURRENT=			0x00000002,	/*!< device is (arp-)probing its current ip */
      IS_ETH_DEVSTATUS_TESTING_IP_PERSISTENT=		0x00000004,	/*!< device is (arp-)probing its persistent ip */
      IS_ETH_DEVSTATUS_TESTING_IP_RANGE=			0x00000008,	/*!< device is (arp-)probing the autocfg ip range */

      IS_ETH_DEVSTATUS_INAPPLICABLE_IP_CURRENT=		0x00000010,	/*!< current ip is inapplicable */
      IS_ETH_DEVSTATUS_INAPPLICABLE_IP_PERSISTENT=	0x00000020,	/*!< persistent ip is inapplicable */
      IS_ETH_DEVSTATUS_INAPPLICABLE_IP_RANGE=		0x00000040,	/*!< autocfg ip range is inapplicable */

      IS_ETH_DEVSTATUS_UNPAIRED=					0x00000100,	/*!< device is unpaired */
      IS_ETH_DEVSTATUS_PAIRING_IN_PROGRESS=			0x00000200,	/*!< device is being paired */
      IS_ETH_DEVSTATUS_PAIRED=						0x00000400,	/*!< device is paired */

      IS_ETH_DEVSTATUS_FORCE_100MBPS=               0x00001000, /*!< device phy is configured to 100 Mbps */
      IS_ETH_DEVSTATUS_NO_COMPORT=                  0x00002000, /*!< device does not support uc480 eth comport */

      IS_ETH_DEVSTATUS_RECEIVING_FW_STARTER=		0x00010000,	/*!< device is receiving the starter firmware */
      IS_ETH_DEVSTATUS_RECEIVING_FW_RUNTIME=		0x00020000,	/*!< device is receiving the runtime firmware */
      IS_ETH_DEVSTATUS_INAPPLICABLE_FW_RUNTIME=		0x00040000,	/*!< runtime firmware is inapplicable */
      IS_ETH_DEVSTATUS_INAPPLICABLE_FW_STARTER=		0x00080000,	/*!< starter firmware is inapplicable */

      IS_ETH_DEVSTATUS_REBOOTING_FW_RUNTIME=		0x00100000,	/*!< device is rebooting to runtime firmware */
      IS_ETH_DEVSTATUS_REBOOTING_FW_STARTER=		0x00200000,	/*!< device is rebooting to starter firmware */
      IS_ETH_DEVSTATUS_REBOOTING_FW_FAILSAFE=		0x00400000,	/*!< device is rebooting to failsafe firmware */

      IS_ETH_DEVSTATUS_RUNTIME_FW_ERR0=				0x80000000,	/*!< checksum error runtime firmware */

  } UC480_ETH_DEVICESTATUS;

  // heartbeat info transmitted periodically by a device
  // contained in UC480_ETH_DEVICE_INFO
  typedef struct _UC480_ETH_DEVICE_INFO_HEARTBEAT
  {
      BYTE					abySerialNumber[12];		/*!< camera's serial number (string) */

      BYTE					byDeviceType;				/*!< device type / board type, 0x80 for ETH */

      BYTE					byCameraID;					/*!< camera id */

      WORD					wSensorID;					/*!< camera's sensor's id */

      WORD					wSizeImgMem_MB;				/*!< size of camera's image memory in MB */

      BYTE					reserved_1[2];				/*!< reserved */

      DWORD					dwVerStarterFirmware;		/*!< starter firmware version */

      DWORD					dwVerRuntimeFirmware;		/*!< runtime firmware version */

      DWORD					dwStatus;					/*!< camera status flags */

      BYTE					reserved_2[4];				/*!< reserved */

      WORD					wTemperature;				/*!< camera temperature */

      WORD					wLinkSpeed_Mb;				/*!< link speed in Mb */

      UC480_ETH_ADDR_MAC	macDevice;					/*!< camera's MAC address */

      WORD					wComportOffset;				/*!< comport offset from 100, valid range -99 to +156 */

      UC480_ETH_IP_CONFIGURATION	ipcfgPersistentIpCfg;	/*!< persistent IP configuration */

      UC480_ETH_IP_CONFIGURATION	ipcfgCurrentIpCfg;		/*!< current IP configuration */

      UC480_ETH_ADDR_MAC	macPairedHost;				/*!< paired host's MAC address */

      BYTE					reserved_4[2];				/*!< reserved */

      UC480_ETH_ADDR_IPV4	ipPairedHostIp;				/*!< paired host's IP address */

      UC480_ETH_ADDR_IPV4	ipAutoCfgIpRangeBegin;		/*!< begin of IP address range */

      UC480_ETH_ADDR_IPV4	ipAutoCfgIpRangeEnd;		/*!< end of IP address range */

      BYTE					abyUserSpace[8];			/*!< user space data (first 8 bytes) */

      BYTE					reserved_5[84];				/*!< reserved */

      BYTE					reserved_6[64];				/*!< reserved */

  } UC480_ETH_DEVICE_INFO_HEARTBEAT, *PUC480_ETH_DEVICE_INFO_HEARTBEAT;

  // values for UC480_ETH_DEVICE_INFO_CONTROL::dwControlStatus
  typedef enum _UC480_ETH_CONTROLSTATUS
  {
      IS_ETH_CTRLSTATUS_AVAILABLE=				0x00000001,	/*!< device is available TO US */
      IS_ETH_CTRLSTATUS_ACCESSIBLE1=			0x00000002,	/*!< device is accessible BY US, i.e. directly 'unicastable' */
      IS_ETH_CTRLSTATUS_ACCESSIBLE2=			0x00000004,	/*!< device is accessible BY US, i.e. not on persistent ip and adapters ip autocfg range is valid */

      IS_ETH_CTRLSTATUS_PERSISTENT_IP_USED=		0x00000010,	/*!< device is running on persistent ip configuration */
      IS_ETH_CTRLSTATUS_COMPATIBLE=				0x00000020,	/*!< device is compatible TO US */
      IS_ETH_CTRLSTATUS_ADAPTER_ON_DHCP=		0x00000040,	/*!< adapter is configured to use dhcp */

      IS_ETH_CTRLSTATUS_UNPAIRING_IN_PROGRESS=	0x00000100,	/*!< device is being unpaired FROM US */
      IS_ETH_CTRLSTATUS_PAIRING_IN_PROGRESS=	0x00000200,	/*!< device is being paired TO US */

      IS_ETH_CTRLSTATUS_PAIRED=					0x00001000,	/*!< device is paired TO US */

      IS_ETH_CTRLSTATUS_FW_UPLOAD_STARTER=		0x00010000,	/*!< device is receiving the starter firmware */
      IS_ETH_CTRLSTATUS_FW_UPLOAD_RUNTIME=		0x00020000,	/*!< device is receiving the runtime firmware */

      IS_ETH_CTRLSTATUS_REBOOTING=				0x00100000,	/*!< device is rebooting */

      IS_ETH_CTRLSTATUS_INITIALIZED=			0x08000000,	/*!< device object is initialized */

      IS_ETH_CTRLSTATUS_TO_BE_DELETED=          0x40000000, /*!< device object is being deleted */
      IS_ETH_CTRLSTATUS_TO_BE_REMOVED=			0x80000000,	/*!< device object is being removed */

  } UC480_ETH_CONTROLSTATUS;

  // control info for a listed device
  // contained in UC480_ETH_DEVICE_INFO
  typedef struct _UC480_ETH_DEVICE_INFO_CONTROL
  {
      DWORD		dwDeviceID;			/*!< device's unique id */

      DWORD		dwControlStatus;	/*!< device control status */

      BYTE		reserved_1[80];		/*!< reserved */

      BYTE		reserved_2[64];		/*!< reserved */

  } UC480_ETH_DEVICE_INFO_CONTROL, *PUC480_ETH_DEVICE_INFO_CONTROL;

  // ethernet configuration
  typedef struct _UC480_ETH_ETHERNET_CONFIGURATION
  {
      UC480_ETH_IP_CONFIGURATION	ipcfg;
      UC480_ETH_ADDR_MAC			mac;

  } UC480_ETH_ETHERNET_CONFIGURATION, *PUC480_ETH_ETHERNET_CONFIGURATION;

  // autocfg ip setup
  typedef struct _UC480_ETH_AUTOCFG_IP_SETUP
  {
      UC480_ETH_ADDR_IPV4	ipAutoCfgIpRangeBegin;		/*!< begin of ip address range for devices */
      UC480_ETH_ADDR_IPV4	ipAutoCfgIpRangeEnd;		/*!< end of ip address range for devices */

      BYTE					reserved[4];	/*!< reserved */

  } UC480_ETH_AUTOCFG_IP_SETUP, *PUC480_ETH_AUTOCFG_IP_SETUP;

  // values for incoming packets filter setup
  typedef enum _UC480_ETH_PACKETFILTER_SETUP
  {
      // notice: arp and icmp (ping) packets are always passed!

      IS_ETH_PCKTFLT_PASSALL=		0,	/*!< pass all packets to OS */
      IS_ETH_PCKTFLT_BLOCKUEGET=	1,	/*!< block UEGET packets to the OS */
      IS_ETH_PCKTFLT_BLOCKALL=		2	/*!< block all packets to the OS */

  } UC480_ETH_PACKETFILTER_SETUP;

  // control info for a device's network adapter
  // contained in UC480_ETH_DEVICE_INFO
  typedef struct _UC480_ETH_ADAPTER_INFO
  {
      DWORD								dwAdapterID;	/*!< adapter's unique id */

      BYTE								reserved_1[4];	/*!< reserved */

      UC480_ETH_ETHERNET_CONFIGURATION	ethcfg;			/*!< adapter's eth configuration */
      BYTE								reserved_2[2];	/*!< reserved */
      BOOL								bIsEnabledDHCP;	/*!< adapter's dhcp enabled flag */

      UC480_ETH_AUTOCFG_IP_SETUP			autoCfgIp;					/*!< the setup for the ip auto configuration */
      BOOL								bIsValidAutoCfgIpRange;		/*!<	the given range is valid when: 
                                                                    - begin and end are valid ip addresses
                                                                    - begin and end are in the subnet of the adapter
                                                                    - */

      DWORD								dwCntDevicesKnown;		/*!< count of listed Known devices */
      DWORD								dwCntDevicesPaired;		/*!< count of listed Paired devices */

      WORD								wPacketFilter;			/*!< Setting for the Incoming Packets Filter. see UC480_ETH_PACKETFILTER_SETUP enum above. */

      BYTE								reserved_3[38];			/*!< reserved */
      BYTE								reserved_4[64];			/*!< reserved */

  } UC480_ETH_ADAPTER_INFO, *PUC480_ETH_ADAPTER_INFO;

  // driver info
  // contained in UC480_ETH_DEVICE_INFO
  typedef struct _UC480_ETH_DRIVER_INFO
  {
      DWORD		dwMinVerStarterFirmware;	/*!< minimum version compatible starter firmware */
      DWORD		dwMaxVerStarterFirmware;	/*!< maximum version compatible starter firmware */

      BYTE		reserved_1[8];				/*!< reserved */
      BYTE		reserved_2[64];				/*!< reserved */

  } UC480_ETH_DRIVER_INFO, *PUC480_ETH_DRIVER_INFO;



  // use is_GetEthDeviceInfo() to obtain this data.
  typedef struct _UC480_ETH_DEVICE_INFO
  {
      UC480_ETH_DEVICE_INFO_HEARTBEAT	infoDevHeartbeat;

      UC480_ETH_DEVICE_INFO_CONTROL		infoDevControl;

      UC480_ETH_ADAPTER_INFO				infoAdapter;

      UC480_ETH_DRIVER_INFO				infoDriver;

  } UC480_ETH_DEVICE_INFO, *PUC480_ETH_DEVICE_INFO;


  typedef struct _UC480_COMPORT_CONFIGURATION
  {
      WORD wComportNumber;

  } UC480_COMPORT_CONFIGURATION, *PUC480_COMPORT_CONFIGURATION;


#pragma pack(pop)

  UC480CAMEXP is_GetEthDeviceInfo	( HCAM hf, UC480_ETH_DEVICE_INFO* pDeviceInfo, UINT uStructSize);
  UC480CAMEXP is_SetPersistentIpCfg	( HCAM hf, UC480_ETH_IP_CONFIGURATION* pIpCfg, UINT uStructSize);
  UC480CAMEXP is_SetStarterFirmware	( HCAM hf, const CHAR* pcFilepath, UINT uFilepathLen);

  UC480CAMEXP is_SetAutoCfgIpSetup	( INT iAdapterID, const UC480_ETH_AUTOCFG_IP_SETUP* pSetup, UINT uStructSize);
  UC480CAMEXP is_SetPacketFilter	( INT iAdapterID, UINT uFilterSetting);

  UC480CAMEXP is_GetComportNumber   ( HCAM hf, UINT *ComportNumber);

  UC480CAMEXP is_GetCaptureErrorInfo   ( HCAM hf, UC480_CAPTURE_ERROR_INFO *pCaptureErrorInfo, UINT SizeCaptureErrorInfo);
  UC480CAMEXP is_ResetCaptureErrorInfo ( HCAM hf );

  UC480CAMEXP is_WaitForNextImage   ( HCAM hf, UINT timeout, char **ppcMem, INT *imageID);
  UC480CAMEXP is_InitImageQueue     ( HCAM hf, INT nMode);
  UC480CAMEXP is_ExitImageQueue     ( HCAM hf);

  UC480CAMEXP is_SetTimeout         ( HCAM hf, UINT nMode, UINT Timeout);
  UC480CAMEXP is_GetTimeout         ( HCAM hf, UINT nMode, UINT *pTimeout);

  UC480CAMEXP is_DirectRenderer      (HCAM hf, UINT nMode, void *pParam, UINT SizeOfParam);


#ifdef __cplusplus
};
#endif  /* __cplusplus */

#pragma pack(pop)

#endif  //__UC480_HEADER__



