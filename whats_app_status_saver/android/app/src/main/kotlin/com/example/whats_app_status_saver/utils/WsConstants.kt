package com.example.whats_app_status_saver.utils

import android.os.Build

const val PLATFORM_CHANNEL_NAME = "com.example.whats_app_status_saver/wsData"
const val FILETYPES = "media image audio video any"
const val EXCEPTION_NOT_SUPPORTED = "EXCEPTION_NOT_SUPPORTED"
const val GET_FILES = "getFiles"
const val GET_CACHE_FILES = "getCacheFiles"
const val GET_DIR_PERMISSION = "getDirectoryPermission"
const val SHARED_PREF_NAME = "wsSharedFile"
const val CHECK_IF_PERMISSION_ALLOWED = "checkedDirPermission"
const val WS_DIRECTORY_PATH = "/Android/media/com.whatsapp/WhatsApp/Media/.Statuses"

//Numeric constants
const val ActivityRequestCode = 2000;

///storage constants
const val wsCacheDirectory = "wsCacheDirectory"

////status directory path for android 9 and below
//const val WS_DIR_OLDER_PATH = "/WhatsApp/Media/.Statuses";

///Keys
const val PERMISSION_KEY = "isPermissionGranted"
const val PERMISSION_URI_KEY = "permissionUriKey"

///Android versions
const val API_21 = Build.VERSION_CODES.LOLLIPOP
const val API_26 = Build.VERSION_CODES.O