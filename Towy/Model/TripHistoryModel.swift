//
//  TripHistoryModel.swift
//  Towy
//
//  Created by Usman on 05/10/2022.
//

import Foundation
/*
struct TripHistoryModel: Codable {
    let result, message: String?
    var data: tripHistoryDataClass
}

// MARK: - DataClass
struct tripHistoryDataClass: Codable {
    let upcomingBooking: [String]?
    var pastBooking: [PastBooking]

    enum CodingKeys: String, CodingKey {
        case upcomingBooking = "upcoming_booking"
        case pastBooking = "past_booking"
    }
}

// MARK: - PastBooking
struct PastBooking: Codable {
    let id: Int?
    let bookingUniqueID, franchiseID: String?
    let vehicleTypeID: Int?
    let bookingType, pickUpArea, pickUpLatitude, pickUpLongitude: String?
    let pickUpDate, pickUpTime, dropOffArea, dropOffLatitude: String?
    let dropOffLongitude, totalDistance, paymentType, estimatedFare: String?
    let actualFare: String?
    let rideStatus: Int?
    let createdAt, driverFirstName, driverLastName: String?
    let driverID, isPassengerRatingGiven, isDriverRatingGiven: Int?
    let driverImage, driverMobileNo: String?
    let driverRating: Int?
    let vehicleName, vehicleRegistrationNumber, driverRatingFromPassenger, driverCommentFromPassenger: String?
    let passengerRatingFromDriver, passengerCommentFromDriver, otp, cancelReason: String?
    let fineAmount: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingUniqueID = "booking_unique_id"
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
        case driverFirstName = "driver_first_name"
        case driverLastName = "driver_last_name"
        case driverID = "driver_id"
        case isPassengerRatingGiven = "is_passenger_rating_given"
        case isDriverRatingGiven = "is_driver_rating_given"
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
        case cancelReason = "cancel_reason"
        case fineAmount = "fine_amount"
    }
}
*/
struct TripHistoryModel : Codable {
    let result : String?
    let message : String?
    let data : tripHistoryDataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(tripHistoryDataClass.self, forKey: .data)
    }

}
struct tripHistoryDataClass : Codable {
    let upcoming_booking : [String]?
    let past_booking : [PastBooking]?

    enum CodingKeys: String, CodingKey {

        case upcoming_booking = "upcoming_booking"
        case past_booking = "past_booking"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        upcoming_booking = try values.decodeIfPresent([String].self, forKey: .upcoming_booking)
        past_booking = try values.decodeIfPresent([PastBooking].self, forKey: .past_booking)
    }

}
struct PastBooking : Codable {
    let id : Int?
    let booking_unique_id : String?
    let franchise_id : String?
    let vehicle_type_id : Int?
    let booking_type : String?
    let pick_up_area : String?
    let pick_up_latitude : String?
    let pick_up_longitude : String?
    let pick_up_date : String?
    let pick_up_time : String?
    let drop_off_area : String?
    let drop_off_latitude : String?
    let drop_off_longitude : String?
    let total_distance : String?
    let payment_type : String?
    let estimated_fare : String?
    let actual_fare : String?
    let ride_status : Int?
    let created_at : String?
    let driver_first_name : String?
    let driver_last_name : String?
    let driver_id : Int?
    let is_passenger_rating_given : Int?
    let is_driver_rating_given : Int?
    let driver_image : String?
    let driver_mobile_no : String?
    let driver_rating : Int?
    let vehicle_name : String?
    let vehicle_registration_number : String?
    let driver_rating_from_passenger : Int?
    let driver_comment_from_passenger : String?
    let passenger_rating_from_driver : Int?
    let passenger_comment_from_driver : String?
    let otp : String?
    let cancel_reason : String?
    let fine_amount : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case booking_unique_id = "booking_unique_id"
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
        case driver_first_name = "driver_first_name"
        case driver_last_name = "driver_last_name"
        case driver_id = "driver_id"
        case is_passenger_rating_given = "is_passenger_rating_given"
        case is_driver_rating_given = "is_driver_rating_given"
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
        case cancel_reason = "cancel_reason"
        case fine_amount = "fine_amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_unique_id = try values.decodeIfPresent(String.self, forKey: .booking_unique_id)
        franchise_id = try values.decodeIfPresent(String.self, forKey: .franchise_id)
        vehicle_type_id = try values.decodeIfPresent(Int.self, forKey: .vehicle_type_id)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        pick_up_area = try values.decodeIfPresent(String.self, forKey: .pick_up_area)
        pick_up_latitude = try values.decodeIfPresent(String.self, forKey: .pick_up_latitude)
        pick_up_longitude = try values.decodeIfPresent(String.self, forKey: .pick_up_longitude)
        pick_up_date = try values.decodeIfPresent(String.self, forKey: .pick_up_date)
        pick_up_time = try values.decodeIfPresent(String.self, forKey: .pick_up_time)
        drop_off_area = try values.decodeIfPresent(String.self, forKey: .drop_off_area)
        drop_off_latitude = try values.decodeIfPresent(String.self, forKey: .drop_off_latitude)
        drop_off_longitude = try values.decodeIfPresent(String.self, forKey: .drop_off_longitude)
        total_distance = try values.decodeIfPresent(String.self, forKey: .total_distance)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        estimated_fare = try values.decodeIfPresent(String.self, forKey: .estimated_fare)
        actual_fare = try values.decodeIfPresent(String.self, forKey: .actual_fare)
        ride_status = try values.decodeIfPresent(Int.self, forKey: .ride_status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        driver_first_name = try values.decodeIfPresent(String.self, forKey: .driver_first_name)
        driver_last_name = try values.decodeIfPresent(String.self, forKey: .driver_last_name)
        driver_id = try values.decodeIfPresent(Int.self, forKey: .driver_id)
        is_passenger_rating_given = try values.decodeIfPresent(Int.self, forKey: .is_passenger_rating_given)
        is_driver_rating_given = try values.decodeIfPresent(Int.self, forKey: .is_driver_rating_given)
        driver_image = try values.decodeIfPresent(String.self, forKey: .driver_image)
        driver_mobile_no = try values.decodeIfPresent(String.self, forKey: .driver_mobile_no)
        driver_rating = try values.decodeIfPresent(Int.self, forKey: .driver_rating)
        vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
        vehicle_registration_number = try values.decodeIfPresent(String.self, forKey: .vehicle_registration_number)
        driver_rating_from_passenger = try values.decodeIfPresent(Int.self, forKey: .driver_rating_from_passenger)
        driver_comment_from_passenger = try values.decodeIfPresent(String.self, forKey: .driver_comment_from_passenger)
        passenger_rating_from_driver = try values.decodeIfPresent(Int.self, forKey: .passenger_rating_from_driver)
        passenger_comment_from_driver = try values.decodeIfPresent(String.self, forKey: .passenger_comment_from_driver)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        cancel_reason = try values.decodeIfPresent(String.self, forKey: .cancel_reason)
        fine_amount = try values.decodeIfPresent(String.self, forKey: .fine_amount)
    }

}
