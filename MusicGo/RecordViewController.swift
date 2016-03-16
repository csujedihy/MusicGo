//
//  RecordViewController.swift
//  MusicGo
//
//  Created by YiHuang on 3/15/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import CoreGraphics
import CoreImage
import CoreMotion


class RecordViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var midiFile: MidiWriter?
    //motion controller
    lazy var motionManager = CMMotionManager()
    var acc: Double?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var videoCaptureOutput = AVCaptureVideoDataOutput()
    let captureSession = AVCaptureSession()
    
    @IBOutlet weak var recordButton: YYZButton!
    @IBOutlet weak var cameraView: UIImageView!
    
    @IBAction func recordOnTap(sender: AnyObject) {
        
        if recordButton.imageView!.image == UIImage(named: "butt-off.png") {
            //recordButton.setTitle("Stop", forState: .Normal)
            recordButton.setImage(UIImage(named: "butt-on.png"), forState: UIControlState.Normal)
            captureSession.sessionPreset = AVCaptureSessionPreset640x480
            let devices = AVCaptureDevice.devices()
            midiFile = MidiWriter()
            midiFile?.headerWriter()
            for device in devices {
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if device.position == AVCaptureDevicePosition.Back {
                        captureDevice = device as? AVCaptureDevice
                        if captureDevice != nil {
                            beginSession()
                            return
                        } else {
                            print("Can't access camera")
                        }
                    }
                } else {
                    print("Can't access camera")
                }
            }
        
        } else {
            if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    captureSession.removeInput(input)
                }
            }
            
            midiFile?.writeTrackInfo()
            midiFile?.output()
            captureSession.stopRunning()
            //recordButton.setTitle("Record", forState: .Normal)
            recordButton.setImage(UIImage(named: "butt-off.png"), forState: .Normal)
        
        }

    }
    
    func beginSession() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            captureSession.addInput(input)
        }
        catch
        {
            print("can't access camera")
            return
        }
        
        
        // although we don't use this, it's required to get captureOutput invoked
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: dispatch_queue_create("sample buffer delegate", DISPATCH_QUEUE_SERIAL))
        if captureSession.canAddOutput(videoOutput)
        {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.startRunning()
    }
    
    
    
    
    // Frame buffer capture delegate. Write your image filtering algorithm here to get music characters.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(CVPixelBuffer: pixelBuffer!)
        let context = CIContext()
        
        let bufferedImage = UIImage(CGImage: context.createCGImage(cameraImage, fromRect: cameraImage.extent), scale: 1.0, orientation: UIImageOrientation.Right)
        
        //print(bufferedImage.getPixelColor(CGPoint(x: 5.0, y: 5.0)))
        
        let tmpColor:UIColor = bufferedImage.averageColor()
        let rValue = UInt8(CGColorGetComponents(tmpColor.CGColor)[0] * 128)
        let gValue = UInt8(CGColorGetComponents(tmpColor.CGColor)[1] * 250)
        midiFile!.writeEvent(127, note: rValue, velocity: gValue)
        dispatch_async(dispatch_get_main_queue()) {
            self.cameraView.image = bufferedImage
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.stopAccelerometerUpdates()
        if motionManager.accelerometerAvailable{
            let queue = NSOperationQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
                {data, error in
                    
                    guard let data = data else{
                        return
                    }
                    let acc = sqrt(data.acceleration.x * data.acceleration.x + data.acceleration.y * data.acceleration.y + data.acceleration.z * data.acceleration.z)
                    self.acc = acc
                    
                }
            )
        } else {
            print("Accelerometer is not available")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
