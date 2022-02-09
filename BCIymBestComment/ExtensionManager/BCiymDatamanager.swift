//
//  BCiymDatamanager.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//

import Foundation

import Foundation
import SwifterSwift
import UIKit

 
struct HPCymStickerItem: Codable {
    var thumbName: String?
    var bigName: String?
    var isPro: Bool?
    
}


class BCiymDataManager: NSObject {
    static let `default` = BCiymDataManager()
     
    
    var commentList : [String] {
        return BCiymDataManager.default.loadJson([String].self, name: "comment") ?? []
    }
    
    var captionList : [String] {
        return BCiymDataManager.default.loadJson([String].self, name: "caption") ?? []
    }
    
    var comboList : [String] {
        return BCiymDataManager.default.loadJson([String].self, name: "combo") ?? []
    }
    
    
    
    override init() {
        super.init()
         
        
    }
     
    
}

extension BCiymDataManager {
    
}


extension BCiymDataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}



public func MyColorFunc(_ red:CGFloat,_ gren:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor? {
    let color:UIColor = UIColor(red: red/255.0, green: gren/255.0, blue: blue/255.0, alpha: alpha)
    return color
}


 
