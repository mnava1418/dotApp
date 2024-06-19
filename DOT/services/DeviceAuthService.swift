//
//  DeviceAuthService.swift
//  DOT
//
//  Created by Martin Nava on 19/06/24.
//

import Foundation
import Speech

struct DeviceAuthService {
    
    public static func requestSpeechRecognition(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                completion(true)
            case .denied, .restricted, .notDetermined:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }
    
    public static func requestMicrophone(completion: @escaping (Bool) -> Void) {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { granted in
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
