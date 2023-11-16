package com.example.whats_app_status_saver

import android.annotation.SuppressLint
import android.app.Activity
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.DocumentsContract
import android.util.Log
import com.example.whats_app_status_saver.utils.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.File


class MainActivity : FlutterActivity() {
    private val channelName = PLATFORM_CHANNEL_NAME
    private var methodChannel: MethodChannel? = null
    private var resultCallback: MethodChannel.Result? = null
    private var methodCall: MethodCall? = null
    private var util: WsUtils? = null
    private lateinit var sharedPreferences: SharedPreferences
    private lateinit var prefEditor: SharedPreferences.Editor
    private var directoryUri: Uri? = null


    private fun initData(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        util = WsUtils(this)
        sharedPreferences = getSharedPreferences(SHARED_PREF_NAME, MODE_PRIVATE)
        prefEditor = sharedPreferences.edit()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        initData(flutterEngine)
        methodHandlerCalls()
    }


    //Method handler to manage platform calls
    private fun methodHandlerCalls() {
        //Receive data from flutter
        methodChannel?.setMethodCallHandler { call, result ->
            methodCall = call
            resultCallback = result
            when (call.method) {
                CHECK_IF_PERMISSION_ALLOWED -> {
                    isPermissionAllowed()
                }

                GET_DIR_PERMISSION -> {
                    openDirectory()
                }

                GET_FILES -> {
                    buildDocumentContract(directoryUri!!, FILE_TYPE, call.method)
                }

                GET_CACHE_FILES -> {
                    getCacheFiles()
                }
            }

        }
    }

    //Method to check if permission of the directory is already allowed
    private fun isPermissionAllowed() {
        val uri = sharedPreferences.getString(PERMISSION_URI_KEY, "")
        if (uri != null && uri != "") {
            resultCallback?.success(true)
        } else {
            resultCallback?.success(false)
        }
    }

    private fun getCacheFiles() {
//        val args = call.arguments as Map<String, String>
        val uri = sharedPreferences.getString(PERMISSION_URI_KEY, "")

        if (!uri.isNullOrEmpty()) {
            directoryUri = Uri.parse(uri)
            println("afterDirUri = $directoryUri")
            buildAndGetCacheFiles(
                directoryUri!!,
                FILE_TYPE,
                wsCacheDirectory,
                resultCallback,
                this,
                util
            )
        } else {
            print("uri is :--$uri")
        }
    }

    private fun openDirectory() {
        val androidDirPath = Environment.getExternalStorageDirectory().absolutePath

        val dirPath = androidDirPath + WS_DIRECTORY_PATH

        val docPathUri =
            util?.convertPathToUriString(WS_DIRECTORY_PATH, false)
        val docUri = Uri.parse(docPathUri)
        // Uri.parse("content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fmedia%2Fcom.whatsapp%2FWhatsApp%2FMedia%2F.Statuses")

        //To check if the given folder path exists or not

        if (File(dirPath).exists()) {
            Log.d("URL FOUND", "URL EXISTS:- $dirPath")
        } else {
            Log.d("URL NOT FOUND", "URL DOESN'T EXISTS:- $dirPath")
            resultCallback?.success(false)
            return
        }
        // Defining the Intent Action that will be triggered from the Page to open the tree to show the folder to the user to seek the permission for
        // that directory
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            if (Build.VERSION.SDK_INT >= API_26) {
                putExtra(DocumentsContract.EXTRA_INITIAL_URI, docUri)
            }
        }


//        docResultLauncherForResult.launch(intent)
        startActivityForResult(intent, ActivityRequestCode)
    }


    ///Method to wait for Activity result and perform actions on the activity result
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        try {
            if (requestCode == ActivityRequestCode
                && resultCode == Activity.RESULT_OK
            ) {
                // The result data contains a URI for the document or directory that
                // the user has selected.
                data?.data?.also { uri ->

                    val takeFlags: Int = Intent.FLAG_GRANT_READ_URI_PERMISSION

                    // Taking persisted permission for the selected directory path to avoid asking permission
                    // Once taken, the permission grant will be remembered across device reboots.
                    contentResolver.takePersistableUriPermission(uri, takeFlags)
                    directoryUri = uri

                    //saving the uri
                    prefEditor.putString(PERMISSION_URI_KEY, uri.toString())
                    prefEditor.commit()
                    resultCallback?.success(true)
                }
            }
        } catch (ex: Exception) {
            Log.d("OnActivity failure", "ON_ACTIVITY_RESULT FAILED WITH EXCEPTION\n$ex")
            resultCallback?.success(false)
        }
    }

    ///Method to build cache directory and return files from there
    private fun buildAndGetCacheFiles(
        uri: Uri,
        fileType: String,
        cacheDirectoryName: String,
        result: MethodChannel.Result?,
        context: Context,
        util: WsUtils?
    ) {
        if (Build.VERSION.SDK_INT >= API_21) {

            CoroutineScope(Dispatchers.IO).launch {
                cacheToExternalFilesDir(
                    uri,
                    fileType,
                    cacheDirectoryName,
                    result!!,
                    context,
                    util!!
                )
            }
//            Thread(
//                CacheToExternalFilesDir(
//                    uri,
//                    fileType,
//                    cacheDirectoryName,
//                    result!!,
//                    context,
//                    util!!
//                )
//            ).start()
        }
    }

    ///Method to build documents contract and filter files according to type
    @SuppressLint("LongLogTag")
    fun buildDocumentContract(sourceTreeUri: Uri, fileType: String = FILE_TYPE, method: String) {
        try {

            if (Build.VERSION.SDK_INT >= API_21) {
                val parentUri = DocumentsContract.buildChildDocumentsUriUsingTree(
                    sourceTreeUri,
                    DocumentsContract.getTreeDocumentId(sourceTreeUri)
                )
                val contentResolver: ContentResolver = this.context.contentResolver
                var childrenPaths = listOf<String>()
                val cursor = contentResolver.query(
                    parentUri, arrayOf(
                        DocumentsContract.Document.COLUMN_DOCUMENT_ID,
                        DocumentsContract.Document.COLUMN_MIME_TYPE,
                        DocumentsContract.Document.COLUMN_LAST_MODIFIED
                    ),
                    null, null, null
                )
                try {
                    while (cursor!!.moveToNext()) {
                        val docId = cursor.getString(0)
                        val mime = cursor.getString(1)
                        // val lastModified = cursor.getString(2)
                        if (FILETYPES.contains(mime) || fileType == FILE_TYPE) {
                            val child =
                                DocumentsContract.buildChildDocumentsUriUsingTree(
                                    parentUri,
                                    docId
                                ).toString().replace("/children", "")
                            childrenPaths += util?.getPath(Uri.parse(child))!!
                        }
                    }
                } catch (e: Exception) {
                    Log.e("CONTENT_RESOLVER_EXCEPTION: ", e.message!!)
                } finally {
                    if (cursor != null) {
                        try {
                            cursor.close()
                        } catch (re: RuntimeException) {
                            Log.e("RUNTIME_EXCEPTION", re.message!!)
                        }
                    }
                }
                resultCallback?.success(childrenPaths)
            } else {
                resultCallback?.notSupported(method, API_21)
            }
        } catch (e: Exception) {
            Log.e("BUILD_CHILD_DOCUMENTS_PATH_USING_TREE_EXCEPTION: ", e.message!!)
            resultCallback?.success(null)
        }
    }


    ///This class is used to build cache directory and return the files from given directory
    private fun cacheToExternalFilesDir(
        uriPath: Uri,
        fileType: String,
        cacheDirectoryName: String,
        result: MethodChannel.Result,
        context: Context,
        util: WsUtils
    ) {
        try {
            var cachedFilesPath = listOf<String>()

            val sourceTreeUri: Uri = uriPath
            val sourceChildDocumentsUri =
                buildChildDocumentsUriUsingTree(sourceTreeUri, context.contentResolver, context)
            for (uri in sourceChildDocumentsUri!!) {
                val fileName = util.nameFileFromUri(uri).toString()
                if (fileName.contains(fileType.toString()) || fileType == FILE_TYPE) {
                    val copiedPath: String? =
                        util.syncCopyFileToExternalStorage(uri, cacheDirectoryName, fileName)
                    if (copiedPath != null) cachedFilesPath += copiedPath.toString()
                }
            }
            result.success(cachedFilesPath)
        } catch (e: Exception) {
            Log.e("CACHING_EXCEPTION", "UNABLE TO BUILD CACHE DIR ${e.message!!}")
            result.success(null)
        }
    }


    ///Method to check if directory exists using contentURI
//    fun isDirExists( contentUri: String) : Boolean{
//        val cr : ContentResolver = getContentResolver()
////        val projection : ArrayList<String> = arrayListOf(MediaStore.MediaColumns.DATA)
//        val cur :Cursor? = cr.query(Uri.parse(contentUri),
//            arrayOf(MediaStore.MediaColumns.DATA), null, null, null);
//        if (cur != null) {
//            if (cur.moveToFirst()) {
//                val filePath :String = cur.getString(0);
//
//                return File(filePath).exists()
//            } else {
//                Log.d("NO Entry", "Uri was ok but no entry found")
//                return false
//            }
//            cur.close();
//        } else {
//            Log.d("Invalid URI", "content Uri was invalid or some other error occurred")
//            return false
//        }
//    }
}
