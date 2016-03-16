//
//  ImageExt.swift
//  MusicGo
//
//  Created by YiHuang on 3/15/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        if pixelData == nil {
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }  
}