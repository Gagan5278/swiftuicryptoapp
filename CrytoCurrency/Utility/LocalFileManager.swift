//
//  LocalFileManager.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let fileManagerInstance = LocalFileManager()
    private let fileManager = FileManager.default
    // MARK: - init
    private init() { }
    
    func save(image: UIImage, imageName: String, folderName: String) {
        createFolderIfNotExist(for: folderName)
        
        if let imageData =  image.pngData(), let fileImageURL = getUrlFor(imageName: imageName, folderName: folderName) {
            do {
                try imageData.write(to: fileImageURL)
            } catch {
                print("Could not saved image: \(imageName) in folder: \(folderName)")
            }
        }
    }
    
    func getImageFor(imageName: String, folderName: String) -> UIImage? {
        guard let imageURL = getUrlFor(imageName: imageName, folderName: folderName), fileManager.fileExists(atPath: imageURL.path) else {return nil}
        return UIImage(contentsOfFile: imageURL.path)
    }
    
    private func getUrlFor(imageName: String, folderName: String) -> URL? {
        guard let folderURL = localFileManagerURLFor(folderName: folderName) else {return nil}
        return folderURL.appendingPathComponent(imageName)
    }
    
    private func localFileManagerURLFor(folderName: String) -> URL? {
        guard let fileCacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil}
        return fileCacheURL.appendingPathComponent(folderName)
    }
    
    private func createFolderIfNotExist(for folderName: String) {
        guard let folderURL = localFileManagerURLFor(folderName: folderName) else { return }
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
