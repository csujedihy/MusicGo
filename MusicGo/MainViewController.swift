//
//  MainViewController.swift
//  MusicGo
//
//  Created by YiHuang on 3/15/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func createOnTap(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let createNavController = storyboard.instantiateViewControllerWithIdentifier("CreateNavController")
        self.presentViewController(createNavController, animated: true, completion: nil)
    
    }
    
    @IBAction func browseOnTap(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let browseNavController = storyboard.instantiateViewControllerWithIdentifier("BrowseNavController")
        self.presentViewController(browseNavController, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientLayer.frame = self.view.bounds
        gradientLayer.zPosition = -1
        let color1 = ColorTheme.sharedInstance.loginGradientFisrtColor.CGColor as CGColorRef
        let color2 = ColorTheme.sharedInstance.loginGradientSecondColor.CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.addSublayer(gradientLayer)
        
        titleLabel.textColor = ColorTheme.sharedInstance.loginTextColor
        // Do any additional setup after loading the view.
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
