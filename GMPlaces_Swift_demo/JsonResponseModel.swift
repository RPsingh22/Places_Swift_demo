//
//  JsonResponseModel.swift
//  GMPlaces_Swift_demo
//
//  Created by Cerebrum on 30/01/17.
//  Copyright © 2017 Cerebrum. All rights reserved.
//
//@Class: This class is use as model class for Json Response.

import UIKit

//This class is use as model for search results of Google API.
class JsonResponsePlaceModel: NSObject {
     var placeDescription : String?
     var placeId : String?
}

//This structure is use as model for place detail results of Google Place Detail API.

struct PlaceDetailObject {
    static var placeName : String? = ""
    static var placeUrl : String? = ""
    static var placeIcon : String? = ""
}
