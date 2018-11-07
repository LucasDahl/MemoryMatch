//
//  SoundManager.swift
//  MemoryMatch
//
//  Created by Lucas Dahl on 11/7/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    // Properties
    static var audioPlayer:AVAudioPlayer?
    
    // this is for each sound effect
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
        
    }
    
    // This will play the sounds
    static func playSound(_ effect:SoundEffect) {
        
        // For the soundfile name
        var soundFilename = ""
        
        
        // Determine the sound effect we want to play
        // And set it to the property to the right filename
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        
        // This returns the the soundfile
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        // Return the bundlepath incase of a nil value
        guard bundlePath != nil else {
            print("Couldn't find sound file name \(soundFilename)")
            return
        }
        
        // Create a URL object from the string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        // Create audioPlayer object
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            // Plays the audiosound
            audioPlayer?.play()
            
        } catch {
            
            // Couldn't create the audio player object
            print("Couldn't get the sound file...\(error)")
            return
            
        }
        
        
    }
    
}
