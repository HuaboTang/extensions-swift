//
//  FiltUtils.swift
//  UWifi
//
//  Created by 唐华嶓 on 1/6/15.
//  Copyright (c) 2015 piKey. All rights reserved.
//

import Foundation

enum FileType: Int {
    /** 告警图片 */
    case cacheImages = 1
    /** 告警视频 */
    case cacheVideos = 2
    case userChatImages = 3
    case userAlarmVideo = 4
    case userAvatar = 5
    /** 摄像机固件 */
    case cameraFirmware = 6
}

public class FileUtils {
    private var filemanager: NSFileManager
    private var cacheImagesPath: String
    private var cacheVideosPath: String
    private var userChatImagesPath: String
    private var userAlarmVideoPath: String
    private var userAvatarPath: String
    private var cameraFirmwarePath: String

    public class func shareInstance() -> FileUtils {
        struct tmp {
            static var shared:FileUtils?
            static var once:dispatch_once_t = 0
        }
        dispatch_once(&tmp.once, {()->() in
            tmp.shared = FileUtils()
        })
        return tmp.shared!
    }

    init() {
        filemanager = NSFileManager.defaultManager()
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as NSString
        cacheImagesPath = documents.stringByAppendingPathComponent("imageCache")
        cacheVideosPath = documents.stringByAppendingPathComponent("alarmVedios")
        userChatImagesPath = documents.stringByAppendingPathComponent("userChatImagesPath")
        userAlarmVideoPath = documents.stringByAppendingPathComponent("userAlarmVideoPath")
        userAvatarPath = documents.stringByAppendingPathComponent("userAvatarPath")
        cameraFirmwarePath = documents.stringByAppendingPathComponent("cameraFirmwarePath")

        for path in [cacheImagesPath,cacheVideosPath, userChatImagesPath, userAlarmVideoPath,
            userAvatarPath, cameraFirmwarePath] {
            mkdirIfNotExist(path)
        }
    }

    func mkdirIfNotExist(path: String) {
        if !filemanager.fileExistsAtPath(path) {
            println("\(__FILE__)(\(__FUNCTION__)):Create path \(path)")
            filemanager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
    }

    func realFilepathForFile(filename: String, fileType: FileType) -> String {
        return self.dictoryPath(fileType).stringByAppendingPathComponent(filename)
    }

    func fileExists(filename: String, fileType: FileType) -> Bool {
        let realFilepath = realFilepathForFile(filename, fileType: fileType)
        return filemanager.fileExistsAtPath(realFilepath)
    }

    func fileExistsForURL(url: NSURL, fileType: FileType) -> Bool {
        return fileExists(filenameWithUrl(url), fileType: fileType)
    }

    func filenameWithUrl(url: NSURL) -> String {
        return StringUtils.notNullString(url.absoluteString).replaceAll("[^a-zA-Z0-9]", replacement: "_")
    }

    func dictoryPath(filetype: FileType) -> String {
        switch (filetype) {
        case .cacheImages:
            return cacheImagesPath
        case .cacheVideos:
            return cacheVideosPath
        case .userChatImages:
            return userChatImagesPath
        case .userAlarmVideo:
            return userAlarmVideoPath
        case .userAvatar:
            return userAvatarPath
        case .cameraFirmware:
            return cameraFirmwarePath
        default:
            assertionFailure()
            return ""
        }
    }

    func saveFile(file: NSData, name filename: String, fileType: FileType) {
        let rfilename = realFilepathForFile(filename, fileType: fileType)
        println("\(__FILE__)(\(__FUNCTION__)\(__LINE__)):\(rfilename)")
        filemanager.createFileAtPath(rfilename, contents: file, attributes: nil)
    }

    func saveFile(file: NSData, url urlOfFile: NSURL, fileType: FileType) {
        let filename = filenameWithUrl(urlOfFile);
        saveFile(file, name: filename, fileType: fileType)
    }

    func fileNameForUrl(url: NSURL, fileType: FileType) -> String {
        let file = realFilepathForFile(filenameWithUrl(url), fileType: fileType)
        return file
    }

    func fileNameForName(filename: String, fileType: FileType) -> String {
        return realFilepathForFile(filename, fileType: fileType)
    }

    func copyFileWithUrl(url:NSURL, atType atFileType: FileType, toType toFileType: FileType) -> Bool {
        if (atFileType == toFileType) {
            return false
        }

        let atFilename = fileNameForUrl(url, fileType: atFileType)
        if !filemanager.fileExistsAtPath(atFilename) {
            return false
        }

        let toFilename = fileNameForUrl(url, fileType: toFileType)

        var err: NSError?
        return filemanager.copyItemAtPath(atFilename, toPath:toFilename, error:&err)
    }

    func removeFileForUrl(url:NSURL, fileType: FileType) -> Bool {
        var result = false
        var err: NSError?
        let filename = fileNameForUrl(url, fileType: fileType)
        if filemanager.fileExistsAtPath(filename) {
            result = filemanager.removeItemAtPath(filename, error:&err)
        }
        if !result {
            println("\(__FILE__)(\(__FUNCTION__)):文件删除失败\(filename)\(err)")
        }
        return result
    }

    func removeFileForName(filename: String, fileType: FileType) -> Bool {
        var result = false
        var err: NSError?
        let realFilename = fileNameForName(filename, fileType: fileType)
        if filemanager.fileExistsAtPath(realFilename) {
            result = filemanager.removeItemAtPath(realFilename, error: &err)
        }
        if !result {
            println("\(__FILE__)(\(__FUNCTION__)):文件删除失败\(filename)\(err)")
        }
        return result
    }

    class func convertBytesToReadString(size: Int) -> String {
        var f = Double(size) / (1024.0 * 1024.0)
        if f > 1 {
            return NSString(format: "%.2fMB", f)
        } else {
            f = Double(size) / (1024.0 * 1024.0)
            return NSString(format: "%.2fKB", f)
        }
    }

    public func fileSize(filename: NSString) -> Int? {
        var err: NSError?
        var dict = filemanager.attributesOfItemAtPath(filename, error: &err)
        if err != nil {
            println("\(__FILE__)(\(__FUNCTION__)):\(err)")
            return nil
        }
        let key = NSFileSize
        let obj: AnyObject? = dict![key]
        return obj as? Int
    }

    func clearCache(completion: ((readSize: String?) -> ())) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {()->() in
            let contents = self.filemanager.contentsOfDirectoryAtPath(self.cacheImagesPath, error: nil)
            var totalSize: UInt64 = 0
            if ArrayUtils.notEmpty(contents) {
                for item in contents! {
                    let filename = (self.cacheImagesPath as NSString).stringByAppendingPathComponent(item as String)
                    let dict = self.filemanager.attributesOfItemAtPath(filename, error:nil)

                    let size = (dict! as NSDictionary).fileSize()
                    totalSize += size
                    println("remove cache:\(filename), size:\(size)")
                    self.filemanager.removeItemAtPath(filename, error:nil)
                }
            }

            completion(readSize: self.convertBytesToReadString(totalSize))
        })
    }

    func convertBytesToReadString(size: UInt64) -> String? {
        if size == 0 {
            return nil
        }
        var f: Float = Float(size) / (1024.0 * 1024.0)
        if f > 1 {
            return NSString(format: "%.2fMB", f)
        } else {
            return NSString(format:"%.2fKB", f)
        }
    }
}