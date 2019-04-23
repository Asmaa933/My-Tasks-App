//
//  DateExtention.swift
//  My Tasks App
//
//  Created by AsMaa on 4/23/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
extension Date {
    func convertDateToString(format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
       return dateFormatter.string(from: self)
    }
}
