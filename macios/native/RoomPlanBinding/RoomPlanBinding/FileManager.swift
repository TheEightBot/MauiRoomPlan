//
//  FileManager.swift
//  NewBinding
//
//  Created by Michael Stonis on 12/13/24.
//

import Foundation

extension FileManager {

    class func directoryUrl() -> URL? {
        let paths = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }

    class func allScannedModels() -> [URL]? {
        if let documentsUrl = FileManager.directoryUrl() {
            do {
                let directoryContents = try FileManager.default
                    .contentsOfDirectory(
                        at: documentsUrl, includingPropertiesForKeys: nil)
                return directoryContents.filter { $0.pathExtension == "usdz" }
            } catch {
                return nil
            }
        }
        return nil
    }
}
