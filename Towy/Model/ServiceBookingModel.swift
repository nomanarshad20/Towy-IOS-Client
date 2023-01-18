//
//  ServiceBookingModel.swift
//  Towy
//
//  Created by Usman on 09/12/2022.
//

import Foundation

struct ServiceBookingModel : Codable {
    let services : [SelectedServices]?
    let pick_up_area : AnyCodableValue?
    let pick_up_lat : AnyCodableValue?
    let pick_up_lng : AnyCodableValue?

    enum CodingKeys: String, CodingKey {

        case services = "services"
        case pick_up_area = "pick_up_area"
        case pick_up_lat = "pick_up_lat"
        case pick_up_lng = "pick_up_lng"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        services = try values.decodeIfPresent([SelectedServices].self, forKey: .services)
//        pick_up_area = try values.decodeIfPresent(String.self, forKey: .pick_up_area)
//        pick_up_lat = try values.decodeIfPresent(Double.self, forKey: .pick_up_lat)
//        pick_up_lng = try values.decodeIfPresent(Double.self, forKey: .pick_up_lng)
//    }

}
struct SelectedServices : Codable {
    let id : AnyCodableValue?
    let quantity : AnyCodableValue?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case quantity = "quantity"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
//    }

}
struct ServiceBookingRequestModel: Codable {
    let services: [Service]
    let driver: Driver
    let bookingID: AnyCodableValue?

    enum CodingKeys: String, CodingKey {
        case services, driver
        case bookingID = "booking_id"
    }
}

// MARK: - Driver
struct Driver: Codable {
    let driverID: AnyCodableValue?
    let firstName, lastName, email: AnyCodableValue?
    let distance, distanceFare, serviceFare, totalFare: AnyCodableValue?

    enum CodingKeys: String, CodingKey {
        case driverID = "driver_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, distance, distanceFare
        case serviceFare = "service_fare"
        case totalFare = "total_fare"
    }
}

// MARK: - Service
struct Service: Codable {
    let id, quantity: Int
}


struct ServiceBookingCreatedModel:Codable{
    let result : String?
    let message : String?
    let data : ServiceData?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ServiceData.self, forKey: .data)
    }

}

struct ServiceData : Codable {
    let id : AnyCodableValue?
    let booking_unique_id : AnyCodableValue?
    let passenger_id : AnyCodableValue?
    let franchise_id : AnyCodableValue?
    let vehicle_type_id : AnyCodableValue?
    let booking_type : AnyCodableValue?
    let pick_up_area : AnyCodableValue?
    let pick_up_latitude : AnyCodableValue?
    let pick_up_longitude : AnyCodableValue?
    let total_distance : AnyCodableValue?
    let payment_type : AnyCodableValue?
    let estimated_fare : AnyCodableValue?
    let actual_fare : AnyCodableValue?
    let ride_status : AnyCodableValue?
    let created_at : AnyCodableValue?
    let created_ago : AnyCodableValue?
    let booking_detail_id : AnyCodableValue?
    let waiting_price_per_min : AnyCodableValue?
    let vehicle_tax : AnyCodableValue?
    let service_per_km_rate : AnyCodableValue?
    let service_per_min_rate : AnyCodableValue?
    let base_fare_service : AnyCodableValue?
    let passenger_first_name : AnyCodableValue?
    let passenger_last_name : AnyCodableValue?
    let driver_first_name : AnyCodableValue?
    let driver_last_name : AnyCodableValue?
    let driver_status : AnyCodableValue?
    let driver_id : AnyCodableValue?
    let peak_factor_rate : AnyCodableValue?
    let driver_waiting_time : AnyCodableValue?
    let ride_pick_up_time : AnyCodableValue?
    let service_start_time : AnyCodableValue?
    let service_end_time : AnyCodableValue?
    let total_minutes_to_reach_pick_up_point : AnyCodableValue?
    let total_service_minutes : AnyCodableValue?
    let initial_distance_rate : AnyCodableValue?
    let initial_time_rate : AnyCodableValue?
    let total_calculated_distance : AnyCodableValue?
    let p2p_before_pick_up_distance : AnyCodableValue?
    let p2p_after_pick_up_distance : AnyCodableValue?
    let is_passenger_rating_given : AnyCodableValue?
    let is_driver_rating_given : AnyCodableValue?
    let passenger_image : AnyCodableValue?
    let passenger_mobile_no : AnyCodableValue?
    let passenger_rating : AnyCodableValue?
    let driver_image : AnyCodableValue?
    let driver_mobile_no : AnyCodableValue?
    let driver_rating : AnyCodableValue?
    let driver_rating_from_passenger : AnyCodableValue?
    let driver_comment_from_passenger : AnyCodableValue?
    let passenger_rating_from_driver : AnyCodableValue?
    let passenger_comment_from_driver : AnyCodableValue?
    let services : [ServicesList]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case booking_unique_id = "booking_unique_id"
        case passenger_id = "passenger_id"
        case franchise_id = "franchise_id"
        case vehicle_type_id = "vehicle_type_id"
        case booking_type = "booking_type"
        case pick_up_area = "pick_up_area"
        case pick_up_latitude = "pick_up_latitude"
        case pick_up_longitude = "pick_up_longitude"
        case total_distance = "total_distance"
        case payment_type = "payment_type"
        case estimated_fare = "estimated_fare"
        case actual_fare = "actual_fare"
        case ride_status = "ride_status"
        case created_at = "created_at"
        case created_ago = "created_ago"
        case booking_detail_id = "booking_detail_id"
        case waiting_price_per_min = "waiting_price_per_min"
        case vehicle_tax = "vehicle_tax"
        case service_per_km_rate = "service_per_km_rate"
        case service_per_min_rate = "service_per_min_rate"
        case base_fare_service = "base_fare_service"
        case passenger_first_name = "passenger_first_name"
        case passenger_last_name = "passenger_last_name"
        case driver_first_name = "driver_first_name"
        case driver_last_name = "driver_last_name"
        case driver_status = "driver_status"
        case driver_id = "driver_id"
        case peak_factor_rate = "peak_factor_rate"
        case driver_waiting_time = "driver_waiting_time"
        case ride_pick_up_time = "ride_pick_up_time"
        case service_start_time = "service_start_time"
        case service_end_time = "service_end_time"
        case total_minutes_to_reach_pick_up_point = "total_minutes_to_reach_pick_up_point"
        case total_service_minutes = "total_service_minutes"
        case initial_distance_rate = "initial_distance_rate"
        case initial_time_rate = "initial_time_rate"
        case total_calculated_distance = "total_calculated_distance"
        case p2p_before_pick_up_distance = "p2p_before_pick_up_distance"
        case p2p_after_pick_up_distance = "p2p_after_pick_up_distance"
        case is_passenger_rating_given = "is_passenger_rating_given"
        case is_driver_rating_given = "is_driver_rating_given"
        case passenger_image = "passenger_image"
        case passenger_mobile_no = "passenger_mobile_no"
        case passenger_rating = "passenger_rating"
        case driver_image = "driver_image"
        case driver_mobile_no = "driver_mobile_no"
        case driver_rating = "driver_rating"
        case driver_rating_from_passenger = "driver_rating_from_passenger"
        case driver_comment_from_passenger = "driver_comment_from_passenger"
        case passenger_rating_from_driver = "passenger_rating_from_driver"
        case passenger_comment_from_driver = "passenger_comment_from_driver"
        case services = "services"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .id)
        booking_unique_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .booking_unique_id)
        passenger_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_id)
        franchise_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .franchise_id)
        vehicle_type_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_type_id)
        booking_type = try values.decodeIfPresent(AnyCodableValue.self, forKey: .booking_type)
        pick_up_area = try values.decodeIfPresent(AnyCodableValue.self, forKey: .pick_up_area)
        pick_up_latitude = try values.decodeIfPresent(AnyCodableValue.self, forKey: .pick_up_latitude)
        pick_up_longitude = try values.decodeIfPresent(AnyCodableValue.self, forKey: .pick_up_longitude)
        total_distance = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_distance)
        payment_type = try values.decodeIfPresent(AnyCodableValue.self, forKey: .payment_type)
        estimated_fare = try values.decodeIfPresent(AnyCodableValue.self, forKey: .estimated_fare)
        actual_fare = try values.decodeIfPresent(AnyCodableValue.self, forKey: .actual_fare)
        ride_status = try values.decodeIfPresent(AnyCodableValue.self, forKey: .ride_status)
        created_at = try values.decodeIfPresent(AnyCodableValue.self, forKey: .created_at)
        created_ago = try values.decodeIfPresent(AnyCodableValue.self, forKey: .created_ago)
        booking_detail_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .booking_detail_id)
        waiting_price_per_min = try values.decodeIfPresent(AnyCodableValue.self, forKey: .waiting_price_per_min)
        vehicle_tax = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_tax)
        service_per_km_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .service_per_km_rate)
        service_per_min_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .service_per_min_rate)
        base_fare_service = try values.decodeIfPresent(AnyCodableValue.self, forKey: .base_fare_service)
        passenger_first_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_first_name)
        passenger_last_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_last_name)
        driver_first_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_first_name)
        driver_last_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_last_name)
        driver_status = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_status)
        driver_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_id)
        peak_factor_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .peak_factor_rate)
        driver_waiting_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_waiting_time)
        ride_pick_up_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .ride_pick_up_time)
        service_start_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .service_start_time)
        service_end_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .service_end_time)
        total_minutes_to_reach_pick_up_point = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_minutes_to_reach_pick_up_point)
        total_service_minutes = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_service_minutes)
        initial_distance_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .initial_distance_rate)
        initial_time_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .initial_time_rate)
        total_calculated_distance = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_calculated_distance)
        p2p_before_pick_up_distance = try values.decodeIfPresent(AnyCodableValue.self, forKey: .p2p_before_pick_up_distance)
        p2p_after_pick_up_distance = try values.decodeIfPresent(AnyCodableValue.self, forKey: .p2p_after_pick_up_distance)
        is_passenger_rating_given = try values.decodeIfPresent(AnyCodableValue.self, forKey: .is_passenger_rating_given)
        is_driver_rating_given = try values.decodeIfPresent(AnyCodableValue.self, forKey: .is_driver_rating_given)
        passenger_image = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_image)
        passenger_mobile_no = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_mobile_no)
        passenger_rating = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_rating)
        driver_image = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_image)
        driver_mobile_no = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_mobile_no)
        driver_rating = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_rating)
        driver_rating_from_passenger = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_rating_from_passenger)
        driver_comment_from_passenger = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_comment_from_passenger)
        passenger_rating_from_driver = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_rating_from_driver)
        passenger_comment_from_driver = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_comment_from_driver)
        services = try values.decodeIfPresent([ServicesList].self, forKey: .services)
    }

}
