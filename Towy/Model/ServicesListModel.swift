//
//  ServicesListModel.swift
//  Towy
//
//  Created by Usman on 15/11/2022.
//

import Foundation

struct ServicesListModel : Codable {
    let result : String?
    let message : String?
    let data : [Services]?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Services].self, forKey: .data)
    }

}
struct Services : Codable {
    let id : AnyCodableValue?
    let name : AnyCodableValue?
    let base_rate : AnyCodableValue?
    let description : AnyCodableValue?
    let image : AnyCodableValue?
    let is_quantity_allowed : AnyCodableValue?
    var quantity : Int = 1
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case base_rate = "base_rate"
        case description = "description"
        case image = "image"
        case is_quantity_allowed = "is_quantity_allowed"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .id)
        name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .name)
        base_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .base_rate)
        description = try values.decodeIfPresent(AnyCodableValue.self, forKey: .description)
        image = try values.decodeIfPresent(AnyCodableValue.self, forKey: .image)
        is_quantity_allowed = try values.decodeIfPresent(AnyCodableValue.self, forKey: .is_quantity_allowed)
    }

}
