//
//  IDAuthentication.swift
//  ProjectOut
//
//  Created by Consultant on 9/16/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation
import LocalAuthentication

class BioMetricAuth {
    
    let context = LAContext()
    var loginReason = "Logging in with Touch/Face ID"
    func evaluatePolicy() -> Bool{
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    func biometricType() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            fatalError()
        }
    }
    func authenticateUser(completion: @escaping (String?) -> Void){
        guard evaluatePolicy() else {
            completion("Face/Touch ID is not avalable")
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.sync {
                    completion(nil)
                }
            } else {
                var message: String
                switch evaluateError {
                case LAError.authenticationFailed?:
                    message = "Fail to verify your identity"
                case LAError.userCancel?:
                    message = "You pressed Cancel"
                case LAError.userFallback?:
                    message = "You pressed backward"
                case LAError.biometryNotAvailable?:
                    message = "Face/Touch ID is not available"
                case LAError.biometryNotEnrolled?:
                    message = "Face/Touch ID is not set up"
                case LAError.biometryLockout?:
                    message = "Face/Touch ID is locked"
                default:
                    message = "Face/Touch ID may not be configured"
                }
                completion(message)
            }
            
            
        }
        
    }
}
