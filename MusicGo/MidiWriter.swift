//
//  MidiWriter.swift
//  MusicGo
//
//  Created by YiHuang on 3/16/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import Foundation

class MidiWriter {
    let data: NSMutableData?
    let track: NSMutableData?
    var trackLength: UInt32 = 0
    
    init() {
        data = NSMutableData()
        track = NSMutableData()
    }
    
    
    func headerWriter() {
        if let data = data {
            var goesIn: [UInt32] = [UInt32(bigEndian: 0x4d546864), UInt32(bigEndian: 0x00000006), UInt32(bigEndian: 0x00000001)]
            data.appendBytes(&goesIn, length: sizeof(UInt32) * goesIn.count)
            var twobyte: UInt16 = UInt16(bigEndian: 0x01e0)
            data.appendBytes(&twobyte, length: sizeof(UInt16))
            //now write global track
            
            print(data)
            
        }
        
        
    }
    
    func writeTrackInfo() {
        let lenOfEvents: UInt32 = UInt32(littleEndian: trackLength)
        var goesIn: [UInt32] = [UInt32(bigEndian: 0x4d54726b), UInt32(bigEndian: lenOfEvents)]
        data?.appendBytes(&goesIn, length: sizeof(UInt32) * goesIn.count)
                var pianoBytes: [UInt32] = [UInt32(bigEndian: 0x00ff2001)]
        var lastByte: UInt8 = UInt8(0x0A)
        data?.appendBytes(&pianoBytes, length: sizeof(UInt32) * pianoBytes.count)
        data?.appendBytes(&lastByte, length: sizeof(UInt8))
        data?.appendData(track!)
        var endMark: UInt32 = UInt32(bigEndian: 0x00ff2f00)
        data?.appendBytes(&endMark, length: sizeof(UInt32))
        
    }
    
    func writeEvent(tick: UInt8, note: UInt8, velocity: UInt8) {
        let tickByte: UInt8 = UInt8(tick)
        let functionByte:UInt8 = UInt8(0x99)
        let noteByte: UInt8 = UInt8(note)
        let velocityByte: UInt8 = UInt8(velocity)
        var bytes: [UInt8] = [tickByte, functionByte, noteByte, velocityByte]
        track?.appendBytes(&bytes, length: sizeof(UInt8) * bytes.count)
        trackLength += UInt32(sizeof(UInt8) * bytes.count)
    }
    
    
    func output() {
//        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/\(NSDate().timeIntervalSince1970).midi"
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/asd.midi"
        print(data)
        print(path)
        print("Output to midi file")
        data?.writeToFile(path, atomically: true)
        
    }
}