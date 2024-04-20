//
//  ModelAPI.swift
//  RandomUserAPI
//
//  Created by Егоров Михаил on 26.02.2023.
//

import Foundation

// MARK: - User
struct User {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: Dob?
    let registered: Registered?
    let phone: String?
    let cell: String?
    let id: Id?
    let picture: Picture?
    let nat: String?
// model properties initialisation according JSON dictionary
    init(value: [String: Any]) {
        gender = value["gender"] as? String
        
// create dictionary for "Name" type
        let nameDict = value["name"] as? [String: String] ?? [:]
// "name" properties initialisation
        name = Name(value: nameDict)
        
        let locationDict = value["location"] as? [String: Any] ?? [:]
        location = Location(value: locationDict)
        
        email = value["email"] as? String
        
        let loginDict = value["login"] as? [String: String] ?? [:]
        login = Login(value: loginDict)
        
        let dobDict = value["dob"] as? [String: Any] ?? [:]
        dob = Dob(value: dobDict)
        
        let registeredDict = value["registered"] as? [String: Any] ?? [:]
        registered = Registered(value: registeredDict)
        
        phone = value["phone"] as? String
        
        cell = value["cell"] as? String
        
        let idDict = value["id"] as? [String: String] ?? [:]
        id = Id(value: idDict)
        
        let pictureDict = value["picture"] as? [String: String] ?? [:]
        picture = Picture(value: pictureDict)
        
        nat = value["nat"] as? String
        
    }
    
    static func getRandomUsers(from value: Any) -> [User]? {
        guard let value = value as? [String : Any] else {return [] }
        guard let results = value["results"] as? [[String: Any]] else {return [] }
        return results.compactMap { User(value: $0)}
    }
}

// MARK: - User.Name
struct Name {
    let title, first, last: String?
    
    init(value: [String: String]) {
        title = value["title"]
        first = value["first"]
        last = value["last"]
    }
}

// MARK: - User.Location
struct Location {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    init(value: [String: Any]) {
        let streetDict = value["street"] as? [String: Any] ?? [:]
        street = Street(value: streetDict)
        
        city = value["city"] as? String
        state = value["state"] as? String
        country = value["country"] as? String
        postcode = value["postcode"] as? Int
        
        let coordinatesDict = value["coordinates"] as? [String: String] ?? [:]
        coordinates = Coordinates(value: coordinatesDict)
        
        let timezoneDict = value["timezone"] as? [String: String] ?? [:]
        timezone = Timezone(value: timezoneDict)
    }
}
// MARK: - User.Location.Street
struct Street {
    let number: Int?
    let name: String?
    
    init(value: [String: Any]) {
        number = value["number"] as? Int
        name = value["number"] as? String
    }
}
// MARK: - User.Location.Coordinates
struct Coordinates {
    let latitude, longitude: String?
    
    init(value: [String: String]) {
        latitude = value["latitude"]
        longitude = value["longitude"]
    }
}
// MARK: - User.Location.Timezone
struct Timezone {
    let offset, description: String?
    
    init(value: [String: String]) {
        offset = value["offset"]
        description = value["description"]
    }
}

// MARK: - User.Login
struct Login {
    let uuid, username, password, salt, md5, sha1, sha256: String?
    
    init(value: [String: String]) {
        uuid = value["uuid"]
        username = value["username"]
        password = value["password"]
        salt = value["salt"]
        md5 = value["md5"]
        sha1 = value["sha1"]
        sha256 = value["sha256"]
    }
}

// MARK: - User.Dob
struct Dob {
    let date: String?
    let age: Int?
    init(value: [String: Any]) {
        date = value["date"] as? String
        age = value["age"] as? Int
    }
}

// MARK: - User.Registered
struct Registered {
    let date: String?
    let age: Int?
    
    init(value: [String: Any]) {
        date = value["date"] as? String
        age = value["age"] as? Int
    }
}

// MARK: - User.Id
struct Id {
    let name, value: String?
    
    init(value: [String: String]) {
        name = value["name"]
        self.value = value["value"]
    }
}

// MARK: - User.Picture
struct Picture {
    let large, medium, thumbnail: String?
    
    init(value: [String: String]) {
        large = value["large"]
        medium = value["medium"]
        thumbnail = value["thumbnail"]
    }
}
