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
    
    
    func averageColor() -> UIColor {
        
//        print(self.size.width)
//        print(self.size.height)
        var width:Int = 0
        var height:Int = 0
        width = Int(CGFloat(self.size.width) / CGFloat(1.0))
        height = Int(CGFloat(self.size.height) / CGFloat(1.0))
        
        var sum_r:CGFloat = 0
        var sum_g:CGFloat = 0
        var sum_b:CGFloat = 0
        var sum_a:CGFloat = 0
        
        var tmpColor:UIColor
        for var i = 0; i < height; i = i + 10 {
            for var j = 0; j < width; j = j + 10 {
                        tmpColor = self.getPixelColor(CGPoint(x: j, y: i))
                        sum_r += CGColorGetComponents(tmpColor.CGColor)[0]
                        sum_g += CGColorGetComponents(tmpColor.CGColor)[1]
                        sum_b += CGColorGetComponents(tmpColor.CGColor)[2]
                        sum_a += CGColorGetComponents(tmpColor.CGColor)[3]
                    }
                }
        
        sum_r = sum_r / CGFloat(width * height / 100)
//        print(sum_r)
        sum_g = sum_g / CGFloat(width * height / 100)
        sum_b = sum_b / CGFloat(width * height / 100)
        sum_a = sum_a / CGFloat(width * height / 100)
        
        
        return UIColor(red: sum_r, green: sum_g, blue: sum_b, alpha: sum_a)
        
    }
    
    
}