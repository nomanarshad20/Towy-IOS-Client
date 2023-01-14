//
//  BookingCreatedModel.swift
//  Towy
//
//  Created by Usman on 06/09/2022.
//

import Foundation


// MARK: - RideCreatedModel
/*
struct BookingCreatedModel: Codable {
    let result, message: String
    let data: BookingCreatedDataClass
}

// MARK: - DataClass
struct BookingCreatedDataClass: Codable {
    let id: Int
    let bookingUniqueID: String?
    let passengerID: Int
    let franchiseID: String?
    let vehicleTypeID: Int
    let bookingType, pickUpArea, pickUpLatitude, pickUpLongitude: String?
    let pickUpDate, pickUpTime, dropOffArea, dropOffLatitude: String?
    let dropOffLongitude, totalDistance, paymentType, estimatedFare: String?
    let actualFare: String?
    let rideStatus: Int
    let createdAt, createdAgo: String?
    let bookingDetailID, waitingPricePerMin, vehicleTax, vehiclePerKMRate: Int
    let vehiclePerMinRate, minVehicleFare: Int
    let passengerFirstName, passengerLastName, driverFirstName, driverLastName: String?
    let driverStatus: Int
    let driverID, peakFactorRate, driverWaitingTime, ridePickUpTime: String?
    let rideStartTime, rideEndTime, totalMinutesToReachPickUpPoint, totalRideMinutes: String?
    let initialDistanceRate, initialTimeRate, totalCalculatedDistance, p2PBeforePickUpDistance: String?
    let p2PAfterPickUpDistance: String?
    let isPassengerRatingGiven, isDriverRatingGiven: Int
    let passengerImage, passengerMobileNo: String?
    let passengerRating: Int
    let driverImage, driverMobileNo: String?
    let driverRating: Int
    let vehicleName, vehicleRegistrationNumber, driverRatingFromPassenger, driverCommentFromPassenger: String?
    let passengerRatingFromDriver, passengerCommentFromDriver, otp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingUniqueID = "booking_unique_id"
        case passengerID = "passenger_id"
        case franchiseID = "franchise_id"
        case vehicleTypeID = "vehicle_type_id"
        case bookingType = "booking_type"
        case pickUpArea = "pick_up_area"
        case pickUpLatitude = "pick_up_latitude"
        case pickUpLongitude = "pick_up_longitude"
        case pickUpDate = "pick_up_date"
        case pickUpTime = "pick_up_time"
        case dropOffArea = "drop_off_area"
        case dropOffLatitude = "drop_off_latitude"
        case dropOffLongitude = "drop_off_longitude"
        case totalDistance = "total_distance"
        case paymentType = "payment_type"
        case estimatedFare = "estimated_fare"
        case actualFare = "actual_fare"
        case rideStatus = "ride_status"
        case createdAt = "created_at"
        case createdAgo = "created_ago"
        case bookingDetailID = "booking_detail_id"
        case waitingPricePerMin = "waiting_price_per_min"
        case vehicleTax = "vehicle_tax"
        case vehiclePerKMRate = "vehicle_per_km_rate"
        case vehiclePerMinRate = "vehicle_per_min_rate"
        case minVehicleFare = "min_vehicle_fare"
        case passengerFirstName = "passenger_first_name"
        case passengerLastName = "passenger_last_name"
        case driverFirstName = "driver_first_name"
        case driverLastName = "driver_last_name"
        case driverStatus = "driver_status"
        case driverID = "driver_id"
        case peakFactorRate = "peak_factor_rate"
        case driverWaitingTime = "driver_waiting_time"
        case ridePickUpTime = "ride_pick_up_time"
        case rideStartTime = "ride_start_time"
        case rideEndTime = "ride_end_time"
        case totalMinutesToReachPickUpPoint = "total_minutes_to_reach_pick_up_point"
        case totalRideMinutes = "total_ride_minutes"
        case initialDistanceRate = "initial_distance_rate"
        case initialTimeRate = "initial_time_rate"
        case totalCalculatedDistance = "total_calculated_distance"
        case p2PBeforePickUpDistance = "p2p_before_pick_up_distance"
        case p2PAfterPickUpDistance = "p2p_after_pick_up_distance"
        case isPassengerRatingGiven = "is_passenger_rating_given"
        case isDriverRatingGiven = "is_driver_rating_given"
        case passengerImage = "passenger_image"
        case passengerMobileNo = "passenger_mobile_no"
        case passengerRating = "passenger_rating"
        case driverImage = "driver_image"
        case driverMobileNo = "driver_mobile_no"
        case driverRating = "driver_rating"
        case vehicleName = "vehicle_name"
        case vehicleRegistrationNumber = "vehicle_registration_number"
        case driverRatingFromPassenger = "driver_rating_from_passenger"
        case driverCommentFromPassenger = "driver_comment_from_passenger"
        case passengerRatingFromDriver = "passenger_rating_from_driver"
        case passengerCommentFromDriver = "passenger_comment_from_driver"
        case otp
    }
}
*/
struct BookingCreatedModel : Codable {
    let result : String?
    let message : String?
    let data : BookingCreatedDataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(BookingCreatedDataClass.self, forKey: .data)
    }

}
struct BookingCreatedDataClass : Codable {
    let id : AnyCodableValue?
    let booking_unique_id : AnyCodableValue?
    let passenger_id : AnyCodableValue?
    let franchise_id : AnyCodableValue?
    let vehicle_type_id : AnyCodableValue?
    let booking_type : AnyCodableValue?
    let pick_up_area : AnyCodableValue?
    let pick_up_latitude : AnyCodableValue?
    let pick_up_longitude : AnyCodableValue?
    let pick_up_date : AnyCodableValue?
    let pick_up_time : AnyCodableValue?
    let drop_off_area : AnyCodableValue?
    let drop_off_latitude : AnyCodableValue?
    let drop_off_longitude : AnyCodableValue?
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
    let vehicle_per_km_rate : AnyCodableValue?
    let vehicle_per_min_rate : AnyCodableValue?
    let min_vehicle_fare : AnyCodableValue?
    let passenger_first_name : AnyCodableValue?
    let passenger_last_name : AnyCodableValue?
    let driver_first_name : AnyCodableValue?
    let driver_last_name : AnyCodableValue?
    let driver_status : AnyCodableValue?
    let driver_id : AnyCodableValue?
    let peak_factor_rate : AnyCodableValue?
    let driver_waiting_time : AnyCodableValue?
    let ride_pick_up_time : AnyCodableValue?
    let ride_start_time : AnyCodableValue?
    let ride_end_time : AnyCodableValue?
    let total_minutes_to_reach_pick_up_point : AnyCodableValue?
    let total_ride_minutes : AnyCodableValue?
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
    let vehicle_name : AnyCodableValue?
    let vehicle_registration_number : AnyCodableValue?
    let driver_rating_from_passenger : AnyCodableValue?
    let driver_comment_from_passenger : AnyCodableValue?
    let passenger_rating_from_driver : AnyCodableValue?
    let passenger_comment_from_driver : AnyCodableValue?
    let otp : AnyCodableValue?

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
        case pick_up_date = "pick_up_date"
        case pick_up_time = "pick_up_time"
        case drop_off_area = "drop_off_area"
        case drop_off_latitude = "drop_off_latitude"
        case drop_off_longitude = "drop_off_longitude"
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
        case vehicle_per_km_rate = "vehicle_per_km_rate"
        case vehicle_per_min_rate = "vehicle_per_min_rate"
        case min_vehicle_fare = "min_vehicle_fare"
        case passenger_first_name = "passenger_first_name"
        case passenger_last_name = "passenger_last_name"
        case driver_first_name = "driver_first_name"
        case driver_last_name = "driver_last_name"
        case driver_status = "driver_status"
        case driver_id = "driver_id"
        case peak_factor_rate = "peak_factor_rate"
        case driver_waiting_time = "driver_waiting_time"
        case ride_pick_up_time = "ride_pick_up_time"
        case ride_start_time = "ride_start_time"
        case ride_end_time = "ride_end_time"
        case total_minutes_to_reach_pick_up_point = "total_minutes_to_reach_pick_up_point"
        case total_ride_minutes = "total_ride_minutes"
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
        case vehicle_name = "vehicle_name"
        case vehicle_registration_number = "vehicle_registration_number"
        case driver_rating_from_passenger = "driver_rating_from_passenger"
        case driver_comment_from_passenger = "driver_comment_from_passenger"
        case passenger_rating_from_driver = "passenger_rating_from_driver"
        case passenger_comment_from_driver = "passenger_comment_from_driver"
        case otp = "otp"
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
        pick_up_date = try values.decodeIfPresent(AnyCodableValue.self, forKey: .pick_up_date)
        pick_up_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .pick_up_time)
        drop_off_area = try values.decodeIfPresent(AnyCodableValue.self, forKey: .drop_off_area)
        drop_off_latitude = try values.decodeIfPresent(AnyCodableValue.self, forKey: .drop_off_latitude)
        drop_off_longitude = try values.decodeIfPresent(AnyCodableValue.self, forKey: .drop_off_longitude)
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
        vehicle_per_km_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_per_km_rate)
        vehicle_per_min_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_per_min_rate)
        min_vehicle_fare = try values.decodeIfPresent(AnyCodableValue.self, forKey: .min_vehicle_fare)
        passenger_first_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_first_name)
        passenger_last_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_last_name)
        driver_first_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_first_name)
        driver_last_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_last_name)
        driver_status = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_status)
        driver_id = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_id)
        peak_factor_rate = try values.decodeIfPresent(AnyCodableValue.self, forKey: .peak_factor_rate)
        driver_waiting_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_waiting_time)
        ride_pick_up_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .ride_pick_up_time)
        ride_start_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .ride_start_time)
        ride_end_time = try values.decodeIfPresent(AnyCodableValue.self, forKey: .ride_end_time)
        total_minutes_to_reach_pick_up_point = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_minutes_to_reach_pick_up_point)
        total_ride_minutes = try values.decodeIfPresent(AnyCodableValue.self, forKey: .total_ride_minutes)
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
        vehicle_name = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_name)
        vehicle_registration_number = try values.decodeIfPresent(AnyCodableValue.self, forKey: .vehicle_registration_number)
        driver_rating_from_passenger = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_rating_from_passenger)
        driver_comment_from_passenger = try values.decodeIfPresent(AnyCodableValue.self, forKey: .driver_comment_from_passenger)
        passenger_rating_from_driver = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_rating_from_driver)
        passenger_comment_from_driver = try values.decodeIfPresent(AnyCodableValue.self, forKey: .passenger_comment_from_driver)
        otp = try values.decodeIfPresent(AnyCodableValue.self, forKey: .otp)
    }

}
