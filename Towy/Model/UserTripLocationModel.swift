//
//  UserTripLocationModel.swift
//  Towy
//
//  Created by Usman on 20/09/2022.
//

import Foundation
import CoreLocation

struct UserTripLocationModel:Codable{
    var sourceLat : Double
    var sourceLng : Double
    var destinationLat : Double
    var destinationLng : Double
}
