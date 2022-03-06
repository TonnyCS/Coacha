//
//  CLPlacemark+.swift
//  Coacha
//
//  Created by Anthony Šimek on 06.03.2022.
//

import CoreLocation
import Contacts

extension CLPlacemark {
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: postalAddress)
    }
}
