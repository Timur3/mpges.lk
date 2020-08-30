//
//  LinksOfBuildingToDevices.swift
//  mpges.lk
//
//  Created by Timur on 28.08.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

public struct LinksOfBuildingToDevicesModel: Decodable {
    var id: Int
    var buildingId: Int
    var deviceId: Int
    var calculated: Bool
    var numberAKt: String?
    var numberPlomby: String?
    var dateSet: String
    var dateRemove: String?
    var note: String?
}
