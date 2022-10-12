//
//  RideStatusModel.swift
//  Towy
//
//  Created by Usman on 10/09/2022.
//

import Foundation

// MARK: - BookingStatusModel
/*
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

*/
struct BookingStatusCheckModel : Codable {
    let result : String?
    let message : String?
    let data : BookingDataClass?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(BookingDataClass.self, forKey: .data)
    }

}
struct Passenger : Codable {
    let user_id : Int?
    let email : String?
    let mobile_no : String?
    let fcm_token : String?
    let user_type : Int?
    let is_verified : Int?
    let referral_code : String?
    let steps : Int?
    let provider : String?
    let image : String?
    let first_name : String?
    let last_name : String?
    let wallet_balance : Int?
    let rating : Int?
    let stripe_customer_id : String?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case email = "email"
        case mobile_no = "mobile_no"
        case fcm_token = "fcm_token"
        case user_type = "user_type"
        case is_verified = "is_verified"
        case referral_code = "referral_code"
        case steps = "steps"
        case provider = "provider"
        case image = "image"
        case first_name = "first_name"
        case last_name = "last_name"
        case wallet_balance = "wallet_balance"
        case rating = "rating"
        case stripe_customer_id = "stripe_customer_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        is_verified = try values.decodeIfPresent(Int.self, forKey: .is_verified)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        steps = try values.decodeIfPresent(Int.self, forKey: .steps)
        provider = try values.decodeIfPresent(String.self, forKey: .provider)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        wallet_balance = try values.decodeIfPresent(Int.self, forKey: .wallet_balance)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        stripe_customer_id = try values.decodeIfPresent(String.self, forKey: .stripe_customer_id)
    }

}
struct BookingDataClass : Codable {
    let booking : Booking?
    let passenger : Passenger?

    enum CodingKeys: String, CodingKey {

        case booking = "booking"
        case passenger = "passenger"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking = try values.decodeIfPresent(Booking.self, forKey: .booking)
        passenger = try values.decodeIfPresent(Passenger.self, forKey: .passenger)
    }

}
struct Booking : Codable {
    let id : Int?
    let booking_unique_id : String?
    let passenger_id : Int?
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
    let created_ago : String?
    let booking_detail_id : Int?
    let waiting_price_per_min : Int?
    let vehicle_tax : Int?
    let vehicle_per_km_rate : Int?
    let vehicle_per_min_rate : Int?
    let min_vehicle_fare : Int?
    let passenger_first_name : String?
    let passenger_last_name : String?
    let driver_first_name : String?
    let driver_last_name : String?
    let driver_status : Int?
    let driver_id : Int?
    let peak_factor_rate : String?
    let driver_waiting_time : String?
    let ride_pick_up_time : String?
    let ride_start_time : String?
    let ride_end_time : String?
    let total_minutes_to_reach_pick_up_point : String?
    let total_ride_minutes : String?
    let initial_distance_rate : String?
    let initial_time_rate : String?
    let total_calculated_distance : String?
    let p2p_before_pick_up_distance : String?
    let p2p_after_pick_up_distance : String?
    let is_passenger_rating_given : Int?
    let is_driver_rating_given : Int?
    let passenger_image : String?
    let passenger_mobile_no : String?
    let passenger_rating : Int?
    let driver_image : String?
    let driver_mobile_no : String?
    let driver_rating : Int?
    let vehicle_name : String?
    let vehicle_registration_number : String?
    let driver_rating_from_passenger : Int?
    let driver_comment_from_passenger : String?
    let passenger_rating_from_driver : String?
    let passenger_comment_from_driver : String?
    let otp : String?

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
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_unique_id = try values.decodeIfPresent(String.self, forKey: .booking_unique_id)
        passenger_id = try values.decodeIfPresent(Int.self, forKey: .passenger_id)
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
        created_ago = try values.decodeIfPresent(String.self, forKey: .created_ago)
        booking_detail_id = try values.decodeIfPresent(Int.self, forKey: .booking_detail_id)
        waiting_price_per_min = try values.decodeIfPresent(Int.self, forKey: .waiting_price_per_min)
        vehicle_tax = try values.decodeIfPresent(Int.self, forKey: .vehicle_tax)
        vehicle_per_km_rate = try values.decodeIfPresent(Int.self, forKey: .vehicle_per_km_rate)
        vehicle_per_min_rate = try values.decodeIfPresent(Int.self, forKey: .vehicle_per_min_rate)
        min_vehicle_fare = try values.decodeIfPresent(Int.self, forKey: .min_vehicle_fare)
        passenger_first_name = try values.decodeIfPresent(String.self, forKey: .passenger_first_name)
        passenger_last_name = try values.decodeIfPresent(String.self, forKey: .passenger_last_name)
        driver_first_name = try values.decodeIfPresent(String.self, forKey: .driver_first_name)
        driver_last_name = try values.decodeIfPresent(String.self, forKey: .driver_last_name)
        driver_status = try values.decodeIfPresent(Int.self, forKey: .driver_status)
        driver_id = try values.decodeIfPresent(Int.self, forKey: .driver_id)
        peak_factor_rate = try values.decodeIfPresent(String.self, forKey: .peak_factor_rate)
        driver_waiting_time = try values.decodeIfPresent(String.self, forKey: .driver_waiting_time)
        ride_pick_up_time = try values.decodeIfPresent(String.self, forKey: .ride_pick_up_time)
        ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
        ride_end_time = try values.decodeIfPresent(String.self, forKey: .ride_end_time)
        total_minutes_to_reach_pick_up_point = try values.decodeIfPresent(String.self, forKey: .total_minutes_to_reach_pick_up_point)
        total_ride_minutes = try values.decodeIfPresent(String.self, forKey: .total_ride_minutes)
        initial_distance_rate = try values.decodeIfPresent(String.self, forKey: .initial_distance_rate)
        initial_time_rate = try values.decodeIfPresent(String.self, forKey: .initial_time_rate)
        total_calculated_distance = try values.decodeIfPresent(String.self, forKey: .total_calculated_distance)
        p2p_before_pick_up_distance = try values.decodeIfPresent(String.self, forKey: .p2p_before_pick_up_distance)
        p2p_after_pick_up_distance = try values.decodeIfPresent(String.self, forKey: .p2p_after_pick_up_distance)
        is_passenger_rating_given = try values.decodeIfPresent(Int.self, forKey: .is_passenger_rating_given)
        is_driver_rating_given = try values.decodeIfPresent(Int.self, forKey: .is_driver_rating_given)
        passenger_image = try values.decodeIfPresent(String.self, forKey: .passenger_image)
        passenger_mobile_no = try values.decodeIfPresent(String.self, forKey: .passenger_mobile_no)
        passenger_rating = try values.decodeIfPresent(Int.self, forKey: .passenger_rating)
        driver_image = try values.decodeIfPresent(String.self, forKey: .driver_image)
        driver_mobile_no = try values.decodeIfPresent(String.self, forKey: .driver_mobile_no)
        driver_rating = try values.decodeIfPresent(Int.self, forKey: .driver_rating)
        vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
        vehicle_registration_number = try values.decodeIfPresent(String.self, forKey: .vehicle_registration_number)
        driver_rating_from_passenger = try values.decodeIfPresent(Int.self, forKey: .driver_rating_from_passenger)
        driver_comment_from_passenger = try values.decodeIfPresent(String.self, forKey: .driver_comment_from_passenger)
        passenger_rating_from_driver = try values.decodeIfPresent(String.self, forKey: .passenger_rating_from_driver)
        passenger_comment_from_driver = try values.decodeIfPresent(String.self, forKey: .passenger_comment_from_driver)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
    }

}
