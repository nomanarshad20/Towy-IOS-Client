//
//  TripHistoryModel.swift
//  Towy
//
//  Created by Usman on 05/10/2022.
//

import Foundation
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
