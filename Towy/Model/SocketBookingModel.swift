//
//  SocketBookingModel.swift
//  Towy
//
//  Created by Usman on 17/09/2022.
//

import Foundation
/*
struct SocketBookingModelElement: Codable {
    let result, message: String?
    let data: SocketDataClass
}

// MARK: - DataClass
struct SocketDataClass: Codable {
    let passengerCommentFromDriver, dropOffArea, driverLastName, peakFactorRate: String?
    let pickUpLongitude: String?
    let passengerRating, passengerID, rideStatus: Int?
    let pickUpArea, p2PBeforePickUpDistance, dropOffLongitude, dropOffLatitude: String?
    let bookingType, vehicleRegistrationNumber, initialDistanceRate: String?
    let driverRating: Int?
    let passengerImage, driverWaitingTime, totalDistance, totalCalculatedDistance: String?
    let estimatedFare, createdAt, paymentType: String?
    let minVehicleFare: Int?
    let otp, driverRatingFromPassenger, rideEndTime: String?
    let id: Int?
    let createdAgo, passengerRatingFromDriver, actualFare, initialTimeRate: String?
    let franchiseID, rideStartTime, bookingUniqueID, passengerMobileNo: String?
    let pickUpLatitude: String?
    let vehicleTax: Int?
    let p2PAfterPickUpDistance, pickUpTime: String?
    let vehiclePerMinRate, waitingPricePerMin: Int?
    let pickUpDate, driverCommentFromPassenger: String?
    let driverStatus, driverID: Int?
    let totalMinutesToReachPickUpPoint, totalRideMinutes, driverImage, passengerLastName: String?
    let ridePickUpTime: String?
    let isPassengerRatingGiven, vehicleTypeID: Int?
    let driverFirstName: String?
    let vehiclePerKMRate: Int?
    let passengerFirstName: String?
    let bookingDetailID: Int?
    let driverMobileNo: String?
    let isDriverRatingGiven: Int?
    let vehicleName: String?

    enum CodingKeys: String, CodingKey {
        case passengerCommentFromDriver = "passenger_comment_from_driver"
        case dropOffArea = "drop_off_area"
        case driverLastName = "driver_last_name"
        case peakFactorRate = "peak_factor_rate"
        case pickUpLongitude = "pick_up_longitude"
        case passengerRating = "passenger_rating"
        case passengerID = "passenger_id"
        case rideStatus = "ride_status"
        case pickUpArea = "pick_up_area"
        case p2PBeforePickUpDistance = "p2p_before_pick_up_distance"
        case dropOffLongitude = "drop_off_longitude"
        case dropOffLatitude = "drop_off_latitude"
        case bookingType = "booking_type"
        case vehicleRegistrationNumber = "vehicle_registration_number"
        case initialDistanceRate = "initial_distance_rate"
        case driverRating = "driver_rating"
        case passengerImage = "passenger_image"
        case driverWaitingTime = "driver_waiting_time"
        case totalDistance = "total_distance"
        case totalCalculatedDistance = "total_calculated_distance"
        case estimatedFare = "estimated_fare"
        case createdAt = "created_at"
        case paymentType = "payment_type"
        case minVehicleFare = "min_vehicle_fare"
        case otp
        case driverRatingFromPassenger = "driver_rating_from_passenger"
        case rideEndTime = "ride_end_time"
        case id
        case createdAgo = "created_ago"
        case passengerRatingFromDriver = "passenger_rating_from_driver"
        case actualFare = "actual_fare"
        case initialTimeRate = "initial_time_rate"
        case franchiseID = "franchise_id"
        case rideStartTime = "ride_start_time"
        case bookingUniqueID = "booking_unique_id"
        case passengerMobileNo = "passenger_mobile_no"
        case pickUpLatitude = "pick_up_latitude"
        case vehicleTax = "vehicle_tax"
        case p2PAfterPickUpDistance = "p2p_after_pick_up_distance"
        case pickUpTime = "pick_up_time"
        case vehiclePerMinRate = "vehicle_per_min_rate"
        case waitingPricePerMin = "waiting_price_per_min"
        case pickUpDate = "pick_up_date"
        case driverCommentFromPassenger = "driver_comment_from_passenger"
        case driverStatus = "driver_status"
        case driverID = "driver_id"
        case totalMinutesToReachPickUpPoint = "total_minutes_to_reach_pick_up_point"
        case totalRideMinutes = "total_ride_minutes"
        case driverImage = "driver_image"
        case passengerLastName = "passenger_last_name"
        case ridePickUpTime = "ride_pick_up_time"
        case isPassengerRatingGiven = "is_passenger_rating_given"
        case vehicleTypeID = "vehicle_type_id"
        case driverFirstName = "driver_first_name"
        case vehiclePerKMRate = "vehicle_per_km_rate"
        case passengerFirstName = "passenger_first_name"
        case bookingDetailID = "booking_detail_id"
        case driverMobileNo = "driver_mobile_no"
        case isDriverRatingGiven = "is_driver_rating_given"
        case vehicleName = "vehicle_name"
    }
}

typealias SocketBookingModel = [SocketBookingModelElement]
*/
struct SocketBookingModelElement: Codable {
    let data: SocketDataClass
    let message, result: String
}

// MARK: - DataClass
struct SocketDataClass: Codable {
    let driverImage, initialDistanceRate, dropOffArea, bookingType: String
    let totalRideMinutes, pickUpDate: String
    let bookingDetailID, rideStatus: Int
    let passengerRatingFromDriver, rideStartTime, vehicleName, estimatedFare: String
    let driverID, vehicleTax: Int
    let passengerFirstName, totalCalculatedDistance, actualFare, otp: String
    let p2PBeforePickUpDistance, passengerMobileNo: String
    let passengerID: Int
    let driverFirstName: String
    let isPassengerRatingGiven: Int
    let passengerLastName, driverLastName, dropOffLongitude: String
    let driverStatus: Int
    let peakFactorRate, passengerCommentFromDriver, passengerImage: String
    let driverWaitingTime: Int
    let driverRatingFromPassenger, pickUpLongitude, ridePickUpTime, driverMobileNo: String
    let waitingPricePerMin: Int
    let totalDistance, paymentType, dropOffLatitude, createdAgo: String
    let isDriverRatingGiven: Int
    let pickUpTime: String
    let passengerRating, vehiclePerMinRate: Int
    let franchiseID: String
    let vehicleTypeID, id, driverRating: Int
    let p2PAfterPickUpDistance: String
    let minVehicleFare, vehiclePerKMRate: Int
    let totalMinutesToReachPickUpPoint, initialTimeRate, createdAt, driverCommentFromPassenger: String
    let rideEndTime, vehicleRegistrationNumber, bookingUniqueID, pickUpArea: String
    let pickUpLatitude: String

    enum CodingKeys: String, CodingKey {
        case driverImage = "driver_image"
        case initialDistanceRate = "initial_distance_rate"
        case dropOffArea = "drop_off_area"
        case bookingType = "booking_type"
        case totalRideMinutes = "total_ride_minutes"
        case pickUpDate = "pick_up_date"
        case bookingDetailID = "booking_detail_id"
        case rideStatus = "ride_status"
        case passengerRatingFromDriver = "passenger_rating_from_driver"
        case rideStartTime = "ride_start_time"
        case vehicleName = "vehicle_name"
        case estimatedFare = "estimated_fare"
        case driverID = "driver_id"
        case vehicleTax = "vehicle_tax"
        case passengerFirstName = "passenger_first_name"
        case totalCalculatedDistance = "total_calculated_distance"
        case actualFare = "actual_fare"
        case otp
        case p2PBeforePickUpDistance = "p2p_before_pick_up_distance"
        case passengerMobileNo = "passenger_mobile_no"
        case passengerID = "passenger_id"
        case driverFirstName = "driver_first_name"
        case isPassengerRatingGiven = "is_passenger_rating_given"
        case passengerLastName = "passenger_last_name"
        case driverLastName = "driver_last_name"
        case dropOffLongitude = "drop_off_longitude"
        case driverStatus = "driver_status"
        case peakFactorRate = "peak_factor_rate"
        case passengerCommentFromDriver = "passenger_comment_from_driver"
        case passengerImage = "passenger_image"
        case driverWaitingTime = "driver_waiting_time"
        case driverRatingFromPassenger = "driver_rating_from_passenger"
        case pickUpLongitude = "pick_up_longitude"
        case ridePickUpTime = "ride_pick_up_time"
        case driverMobileNo = "driver_mobile_no"
        case waitingPricePerMin = "waiting_price_per_min"
        case totalDistance = "total_distance"
        case paymentType = "payment_type"
        case dropOffLatitude = "drop_off_latitude"
        case createdAgo = "created_ago"
        case isDriverRatingGiven = "is_driver_rating_given"
        case pickUpTime = "pick_up_time"
        case passengerRating = "passenger_rating"
        case vehiclePerMinRate = "vehicle_per_min_rate"
        case franchiseID = "franchise_id"
        case vehicleTypeID = "vehicle_type_id"
        case id
        case driverRating = "driver_rating"
        case p2PAfterPickUpDistance = "p2p_after_pick_up_distance"
        case minVehicleFare = "min_vehicle_fare"
        case vehiclePerKMRate = "vehicle_per_km_rate"
        case totalMinutesToReachPickUpPoint = "total_minutes_to_reach_pick_up_point"
        case initialTimeRate = "initial_time_rate"
        case createdAt = "created_at"
        case driverCommentFromPassenger = "driver_comment_from_passenger"
        case rideEndTime = "ride_end_time"
        case vehicleRegistrationNumber = "vehicle_registration_number"
        case bookingUniqueID = "booking_unique_id"
        case pickUpArea = "pick_up_area"
        case pickUpLatitude = "pick_up_latitude"
    }
}

typealias SocketBookingModel = [SocketBookingModelElement]
