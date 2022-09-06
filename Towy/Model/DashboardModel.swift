//
//  DashboardModel.swift
//  Towy
//
//  Created by Usman on 05/09/2022.
//

import Foundation
import Foundation

// MARK: - DashBoardModel
struct DashBoardModel: Codable {
    let result, message: String
    let data: DashBoardDataClass
}

// MARK: - DataClass
struct DashBoardDataClass: Codable {
    let bannerImage: [String] = []
    let vehicleTypes: [VehicleType]

    enum CodingKeys: String, CodingKey {
        case bannerImage = "banner_image"
        case vehicleTypes = "vehicle_types"
    }
}

// MARK: - VehicleType
struct VehicleType: Codable {
    let name, image: String
}
