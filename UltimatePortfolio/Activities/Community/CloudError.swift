//
//  CloudError.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 04.10.2021.
//

import Foundation
import CloudKit
import SwiftUI

struct CloudError: Identifiable {
    var id: String { message }
    var message: String
    
    var localizedMessage: LocalizedStringKey {
        LocalizedStringKey(message)
    }
    
    init(_ error: Error) {
        guard let error = error as? CKError else {
            self.message = "An unknown error occurred: \(error.localizedDescription)"
            return
        }
        
        switch error.code {
        case .badContainer, .badDatabase, .invalidArguments:
            self.message = "A fatal error occurred: \(error.localizedDescription)"
        case .networkFailure, .networkUnavailable, .serverResponseLost, .serviceUnavailable:
            // swiftlint:disable:next line_length
            self.message = "There was a problem communicating with iCloud; please check your network connection and try again."
        case .notAuthenticated:
            self.message = "There was a problem with your iCloud account; please check that you're logged in to iCloud."
        case .requestRateLimited:
            self.message = "You've hit iCloud's rate limit; please wait a moment then try again."
        case .quotaExceeded:
            self.message = "You've exceeded your iCloud quota; please clear up some space then try again."
        default:
            self.message = "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
