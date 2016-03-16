//
//  Sound.swift
//  AVFoundationMIDIPlay
//
//  Created by Gene De Lisa on 1/12/16.
//  Copyright © 2016 Gene De Lisa. All rights reserved.
//

import Foundation
import AVFoundation

class Sound {
    
    var midiPlayer:AVMIDIPlayer!
    
    var timer:NSTimer?
    
    init() {
        createAVMIDIPlayerFromMIDIFIleDLS()
    }
    
    
    func createAVMIDIPlayerFromMIDIFIleDLS() {
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/asd.midi"

        
        guard let bankURL = NSBundle.mainBundle().URLForResource("gs_instruments", withExtension: "dls") else {
            fatalError("\"gs_instruments.dls\" file not found.")
        }
        
        print(path)
        do {
            try self.midiPlayer = AVMIDIPlayer(contentsOfURL: NSURL(fileURLWithPath: path), soundBankURL: bankURL)
            print("created midi player with sound bank url \(bankURL)")
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
        self.midiPlayer.prepareToPlay()

    }
    
    func play() {
        startTimer()
        self.midiPlayer.play({
            print("finished")
            //self.midiPlayer.currentPosition = 0
            self.timer?.invalidate()
        })
    }
    
    func pausePlaying() {
        if midiPlayer.playing {
            midiPlayer.stop()
            self.timer?.invalidate()
        }
    }
    
    func stopPlaying() {
        if midiPlayer.playing {
            midiPlayer.stop()
            self.midiPlayer.currentPosition = 0
            self.timer?.invalidate()
        }
    }
    
    func togglePlaying() {
        if midiPlayer.playing {
            pausePlaying()
        } else {
            play()
        }
    }
    
    @objc func updateTime() {
        print("\(midiPlayer.currentPosition)")
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target:self,
            selector: "updateTime",
            userInfo:nil,
            repeats:true)
    }
    
}

