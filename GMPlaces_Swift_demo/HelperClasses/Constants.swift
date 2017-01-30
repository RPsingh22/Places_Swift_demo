//
//  Constants.swift
//  GMPlaces_Swift_demo
//
//  Created by Seasia on 30/01/17.
//  Copyright © 2017 Seasia. All rights reserved.
//
//@Class: This is use to save constants & Google API Methods
import Foundation
import Alamofire


let GooglePlaceAPIKey = "AIzaSyBn4xYyBZPWNmmxwVKTTj8IX6-GHKNFaM0"

//MARK:- API to Get Places for custom string
func UrlForGoogleAPI(inputString : String, key: String) -> String
{
    return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(inputString)&types=geocode&language=en&key=\(GooglePlaceAPIKey)"
}
//MARK:- API to Get Places Detail for particular placeId

func UrlForGooglePlaceDetailAPI(inputString : String, key: String) -> String
{
    return "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(inputString)&key=\(GooglePlaceAPIKey)"
}
