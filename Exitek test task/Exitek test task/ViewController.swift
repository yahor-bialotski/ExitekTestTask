//
//  ViewController.swift
//  Exitek test task
//
//  Created by Егор Белоцкий on 20.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileStorageError: Error {
    case doesNotExist
    case alreadyExist
}

class MobilePhoneMemory: MobileStorage {
    private var mobiles = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
        return mobiles
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        return mobiles.first(where: { $0.imei == imei })
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        guard exists(mobile) else {
            throw MobileStorageError.alreadyExist
        }
        
        mobiles.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if !exists(product) {
            throw MobileStorageError.doesNotExist
        }
        
        mobiles.remove(product)
    }
    
    func exists(_ product: Mobile) -> Bool {
        return mobiles.contains(product)
    }
}

