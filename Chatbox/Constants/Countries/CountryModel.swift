//
//  CountryModel.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
public struct Country: Codable {
    let localizedKey: String
    let dialCode: String
    let code: String
    private var _flag: String? = nil

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case dialCode = "dialCode"
        case localizedKey = "name"
        case _flag = "flag"
    }
    
    var name: String {
        return NSLocalizedString(localizedKey, comment: "")  // Fix 3: Use Bundle.main
    }
    
    var flag: String {
        return _flag ?? dialCode.replacingOccurrences(of: "+", with: "")
    }
}

public struct Sections {
    let sectionName: String
    let countries: [Country]
}

// Example of a modified JSONTranslation class
class JSONTranslation {
    func parseJSON<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

// Example of a modified GetBundle class
class GetBundle {
    static func bundle() -> Bundle {
        return Bundle.main
    }
}
