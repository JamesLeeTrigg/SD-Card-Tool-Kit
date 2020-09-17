//
//  CDCardTools.swift
//  SD Card Tool Kit
//
//  Created by James Trigg on 12/09/2020.
//  Copyright © 2020 James Trigg. All rights reserved.
//

import Foundation
import Cocoa

struct Drive : Identifiable {
    var id = UUID()
    var name : String
    var path : String
    var drive : NSURL
}

class SDCardTools {
    
    static public func getDrives()-> [Drive]? {
        let fileManager = FileManager()
        let keys = [URLResourceKey.volumeNameKey, URLResourceKey.volumeIsRemovableKey, URLResourceKey.volumeIsEjectableKey]
        let fileOptions = FileManager.VolumeEnumerationOptions(rawValue: 0)
        let paths = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: fileOptions )
        let urls = paths! as [NSURL]
        var drives = [Drive]()
        for url in urls {
            if (url.pathComponents?.count)! > 1 {
                if url.pathComponents?[1] == "Volumes" {
                    let urlstring : String = url.absoluteString ?? ""
                    if(!urlstring.contains("com.apple.TimeMachine.localsnapshots")) {
                        let name = url.lastPathComponent ?? "Unkown"
                        print(name)
                        if let path = url.resourceSpecifier {
                            drives.append(
                               Drive(
                                   name: name,
                                   path: path,
                                   drive :url
                               )
                           )
                        }
                    }
                }
            }
        }
        return drives
    }
    
    static public func getDriveInfo()  {
        print("-> getDriveInfo {")
        if let session = DASessionCreate(kCFAllocatorDefault) {
            let mountedVolumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil)!
            for volumeURL in mountedVolumeURLs {
                if let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, volumeURL as CFURL) {
                    if let bsdName = DADiskGetBSDName(disk) {
                        var bsdString = ""
                        bsdString = String(cString : bsdName)
                        print(volumeURL.path, bsdString)
                    }
                }
            }
        }
        print("} \n\n")
    }
}
    

