package com.example.whats_app_status_saver.utils

import android.annotation.SuppressLint
import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import android.os.Build
import android.provider.DocumentsContract
import android.util.Log

@SuppressLint("LongLogTag")
fun buildChildDocumentsUriUsingTree(treeUri: Uri, contentResolver: ContentResolver, context: Context): List<Uri>? {
    if(Build.VERSION.SDK_INT >= 21 && WsUtils(context).isTreeUri(treeUri)) {
        val parentUri = DocumentsContract.buildChildDocumentsUriUsingTree(treeUri, DocumentsContract.getTreeDocumentId(treeUri))
        var childrenUris = listOf<Uri>()
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
                val eachUri = DocumentsContract.buildChildDocumentsUriUsingTree(parentUri, docId).toString().replace("/children", "")
                childrenUris += Uri.parse(eachUri)
            }
            return childrenUris
        }
        catch(e: Exception) {
            Log.e("CONTENT_RESOLVER_EXCEPTION: ", e.message!!)
        }
        finally {
            if (cursor != null) {
                try {
                    cursor.close()
                } catch (re: RuntimeException) {

                }
            }
        }
    }
    return null
}