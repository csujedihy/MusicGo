//
//  ViewController.swift
//  Player
//
//  Created by Katrina on 3/16/16.
//  Copyright © 2016 K. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class playerController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var midiPlayer = AVMIDIPlayer!()
    var timer:NSTimer?
    
    var sound:Sound!
    var sampler:MIDISampler!
    var engine:AVAudioEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*guard let midiFileURL = NSBundle.mainBundle().URLForResource("midi", withExtension: "mid") else {
            fatalError("\"sibeliusGMajor.mid\" file not found.")
        }
        
        guard let bankURL = NSBundle.mainBundle().URLForResource("gs_instruments", withExtension: "dls") else {
            fatalError("\"gs_instruments.dls\" file not found.")
        }
        
        do {
            try self.midiPlayer = AVMIDIPlayer(contentsOfURL: midiFileURL, soundBankURL: bankURL)
            print("created midi player with sound bank url \(bankURL)")
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
        self.midiPlayer.prepareToPlay()
        self.midiPlayer.rate = 1.0*/
        
        self.sound = Sound()
        //self.sampler = MIDISampler()
        //self.engine = AVAudioEngine()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playAudio(sender: AnyObject) {
        
        if playButton.imageView!.image == UIImage(named: "play.png") {
            //recordButton.setTitle("Stop", forState: .Normal)
            playButton.setImage(UIImage(named: "pause.png"), forState: UIControlState.Normal)
        } else {
            playButton.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
        }
        
        /*var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = 1000
        engine.attachNode(pitchPlayer)
        engine.attachNode(timePitch)
        engine.connect(pitchPlayer, to: timePitch, format: nil)
        engine.connect(timePitch, to: engine.outputNode, format: nil)*/
        
        
        sound.togglePlaying()
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
//            target:self,
//            selector: "updateTime",
//            userInfo:nil,
//            repeats:true)
//        self.midiPlayer.play({
//            print("finished")
//            self.midiPlayer.currentPosition = 0
//            self.timer?.invalidate()
//        })
        
    }
  
   @IBAction func stopPlaying(sender: AnyObject) {
        
        sound.stopPlaying()
    }
}

