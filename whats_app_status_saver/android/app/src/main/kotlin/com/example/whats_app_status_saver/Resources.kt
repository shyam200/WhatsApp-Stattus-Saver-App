package com.example.whats_app_status_saver


object Resources {

    private var videoFiles: List<ByteArray?>? = null
    fun getVideoThumbnail() : List<ByteArray?>?{
            return videoFiles
        }

    fun setVideoThumbnailPath(videoThumbnail: ByteArray?) {
        this.videoFiles = this.videoFiles?.plus(videoThumbnail)
    }

}