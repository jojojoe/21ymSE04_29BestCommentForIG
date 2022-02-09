//
//  DataEncoding.swift
//  BClYmBestCommm
//
//  Created by BestCommm on 2021/12/30.
//  Copyright © 2021 Commm. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

class ExchangeManage: NSObject {
    class func exchangeWithSSK(objcetID: String, completion: @escaping (PurchaseResult) -> Void) {        
        SwiftyStoreKit.purchaseProduct(objcetID) { a in
            completion(a)
        }
    }
}
