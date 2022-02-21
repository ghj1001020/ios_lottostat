//
//  FileUtil.swift
//  ios_lottostat
//
//  Created by 권혁준 on 2021/09/22.
//

import Foundation

class FileUtil {
    
    // 앱샌드박스 내에 파일 있는지 확인
    public static func checkFileExist(filePath : String) -> Bool {
        do {
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(filePath)
            
            return FileManager.default.fileExists(atPath: url.path)
        }
        catch {
            return false
        }
    }
    
    // 앱내에 리소스 파일 있는지 확인
    public static func checkBundleFileExist(_ fileName: String, _ ext: String) -> Bool {
        do {
            let path = Bundle.main.path(forResource: fileName, ofType: ext)
            if path == nil || path!.isEmpty {
                return false
            }
            return FileManager.default.fileExists(atPath: path!)
        }
        catch {
            return false
        }
    }
    
    // 파일복사
    public static func copyFile(fromUrl: URL?, toUrl: URL?) -> Bool {
        guard let fromUrl = fromUrl, let toUrl = toUrl else {
            return false
        }
        
        if( !FileManager.default.fileExists(atPath: fromUrl.path) ) {
            return false
        }
        
        do {
            // 기존파일 삭제
            if( FileManager.default.fileExists(atPath: toUrl.path) ) {
                try FileManager.default.removeItem(at: toUrl)
            }
            
            // 파일복사
            try FileManager.default.copyItem(at: fromUrl, to: toUrl)
            return true
        }
        catch {
            LogUtil.p(error.localizedDescription)
            return false
        }
    }
}
