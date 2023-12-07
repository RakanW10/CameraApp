//
//  AuthorizationChecker.swift
//  CameraApp
//
//  Created by Rakan Alotaibi on 23/05/1445 AH.
//

import AVFoundation

struct AuthorizationChecker {
    
    static func checkCaptureAuthorizationStatus() async -> Status {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .authorized:
            return .permitted
            
        case .notDetermined:
            let isPermissionGranted = await AVCaptureDevice.requestAccess(for: .video)
            if isPermissionGranted {
                return .permitted
            } else {
                return .notPermitted
            }
            
        case .denied:
            fallthrough
            
        case .restricted:
            fallthrough
            
        @unknown default:
            return .notPermitted
        }
    }
}

extension AuthorizationChecker {
    enum Status {
        case permitted
        case notPermitted
    }
}



