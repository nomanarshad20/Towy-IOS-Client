//
//  RideStatusModel.swift
//  Towy
//
//  Created by Usman on 10/09/2022.
//

import Foundation

// MARK: - BookingStatusModel
struct BookingStatusModel: Codable {
    let result, message: String
    let data: BookingDataClass
}

// MARK: - DataClass
struct BookingDataClass: Codable {
    let id: Int
    let bookingUniqueID: String?
    let passengerID: Int?
    let franchiseID: String?
    let vehicleTypeID: Int?
    let bookingType, pickUpArea, pickUpLatitude, pickUpLongitude: String?
    let pickUpDate, pickUpTime: String?
    let dropOffArea, dropOffLatitude, dropOffLongitude, totalDistance: String?
    let paymentType, estimatedFare, actualFare: String?
    let rideStatus: Int?
    let createdAt, createdAgo: String?
    let bookingDetailID, waitingPricePerMin, vehicleTax, vehiclePerKMRate: Int?
    let vehiclePerMinRate, minVehicleFare: Int?
    let passengerFirstName, passengerLastName, driverFirstName, driverLastName: String?
    let driverStatus, driverID: Int?
    let peakFactorRate, driverWaitingTime, ridePickUpTime, rideStartTime: String?
    let rideEndTime, totalMinutesToReachPickUpPoint, totalRideMinutes: String?
    let initialDistanceRate, initialTimeRate: String?
    let totalCalculatedDistance, p2PBeforePickUpDistance, p2PAfterPickUpDistance: String?
    let isPassengerRatingGiven, isDriverRatingGiven: Int?
    let passengerImage: String?
    let passengerMobileNo: String?
    let passengerRating: Int?
    let driverImage, driverMobileNo: String?
    let driverRating: Int?
    let vehicleName, vehicleRegistrationNumber, driverRatingFromPassenger, driverCommentFromPassenger: String?
    let passengerRatingFromDriver, passengerCommentFromDriver: String?
    let otp: String?

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

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
struct BookingStatusCheckModel: Codable {
    let result, message: String?
    let data: BookingStatusDataClass
}

// MARK: - DataClass
struct BookingStatusDataClass: Codable {
    let booking: Booking?
    let passenger: Passenger?
}

// MARK: - Booking
struct Booking: Codable {
    let id: Int?
    let bookingUniqueID: String?
    let passengerID: Int?
    let franchiseID: String?
    let vehicleTypeID: Int?
    let bookingType, pickUpArea, pickUpLatitude, pickUpLongitude: String?
    let pickUpDate, pickUpTime, dropOffArea, dropOffLatitude: String?
    let dropOffLongitude, totalDistance, paymentType, estimatedFare: String?
    let actualFare: String?
    let rideStatus: Int?
    let createdAt, createdAgo: String?
    let bookingDetailID, waitingPricePerMin, vehicleTax, vehiclePerKMRate: Int?
    let vehiclePerMinRate, minVehicleFare: Int?
    let passengerFirstName, passengerLastName, driverFirstName, driverLastName: String?
    let driverStatus, driverID: Int?
    let peakFactorRate, driverWaitingTime, ridePickUpTime, rideStartTime: String?
    let rideEndTime, totalMinutesToReachPickUpPoint, totalRideMinutes, initialDistanceRate: String?
    let initialTimeRate, totalCalculatedDistance, p2PBeforePickUpDistance, p2PAfterPickUpDistance: String?
    let isPassengerRatingGiven, isDriverRatingGiven: Int?
    let passengerImage, passengerMobileNo: String?
    let passengerRating: Int?
    let driverImage, driverMobileNo: String?
    let driverRating: Int?
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

// MARK: - Passenger
struct Passenger: Codable {
    let userID: Int?
    let email, mobileNo, fcmToken: String?
    let userType, isVerified: Int?
    let referralCode: String?
    let steps: Int?
    let provider, image, firstName, lastName: String?
    let walletBalance, rating: Int?
    let stripeCustomerID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case mobileNo = "mobile_no"
        case fcmToken = "fcm_token"
        case userType = "user_type"
        case isVerified = "is_verified"
        case referralCode = "referral_code"
        case steps, provider, image
        case firstName = "first_name"
        case lastName = "last_name"
        case walletBalance = "wallet_balance"
        case rating
        case stripeCustomerID = "stripe_customer_id"
    }
}
