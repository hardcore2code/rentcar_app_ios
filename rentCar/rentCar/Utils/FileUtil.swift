//
//  FileUtil.swift
//  EasyStuff
//
//  Created by Static on 28/02/2018.
//  Copyright © 2018 Static1014. All rights reserved.
//

import Foundation

class FileUitl {
    
    /**
     判断文件或者文件夹是否存在
     */
    static func isFileOrDirExistedAt(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    /**
     复制文件
     */
    static func copyFile(fromFullPath fromPath: String, to toPath: String, fileName name: String) {
        do {
            if !isFileOrDirExistedAt(path: toPath) {
                createDir(dir: toPath)
            }
            try FileManager.default.copyItem(at: URL.init(fileURLWithPath: fromPath), to: URL.init(fileURLWithPath: toPath + name))
        } catch {
            NSLog.e("FileUtil 复制文件copyResourceFile failed : \(error)")
        }
    }
    
    /**
     创建目录
     */
    static func createDir(dir: String) {
        do {
            try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
        } catch {
            NSLog.e("FileUtile 创建目录createDir failed : \(error)")
        }
    }
    
    /**
     删除目录或者文件
     */
    static func deleteDirectoryOrFile(path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            NSLog.e("FileUtile 删除目录deleteDir failed : \(error)")
        }
    }
    
    
    /**
     删除目录下所有文件
     */
    static func deleteFilesAtDir(dir: String) {
        deleteDirectoryOrFile(path: dir)
        createDir(dir: dir)
    }
    
    
    /// 保存文件
    ///
    /// - Parameters:
    ///   - data: 文件
    ///   - to: 保存目录（Home/Documents）
    ///   - name: 保存文件名
    static func saveToFile(from data: Data, to: String, withName name: String) {
        let path = NSHomeDirectory() + "/Documents"
        createDir(dir: path)
        FileManager.default.createFile(atPath: path + name, contents: data, attributes: nil)
    }
}
