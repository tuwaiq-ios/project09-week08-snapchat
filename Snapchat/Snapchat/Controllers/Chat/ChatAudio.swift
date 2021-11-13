//
//  ChatAudio.swift
//  Snapchat
//
//  Created by Fno Khalid on 08/04/1443 AH.
//

import UIKit
import AVFoundation

class ChatAudio {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    var timer: Timer!
    var timePassed = 0
}
