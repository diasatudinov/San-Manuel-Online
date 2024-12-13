//
//  DeviceInfo.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 13.12.2024.
//

import UIKit

class DeviceInfo {
    static let shared = DeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
