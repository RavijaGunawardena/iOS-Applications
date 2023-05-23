//
//  ViewController.swift
//  ColorMixer
//
//  Created by Ravija Gunawardana on 2023-02-03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorMixureView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    var red: Float = 0.0
    var green: Float = 0.0
    var blue: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        red = redSlider.value
        green = greenSlider.value
        blue = blueSlider.value
        
        updateColor()
    }

    @IBAction func didChangeRedSlider(_ sender: UISlider) {
        red = sender.value
        updateColor()
    }
    
    
    @IBAction func didChangeGreenSlider(_ sender: UISlider) {
        green = sender.value
        updateColor()
    }
    
    @IBAction func didChangeBlueSlider(_ sender: UISlider) {
        blue = sender.value
        updateColor()
    }
    
    func updateColor() {
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        colorMixureView.backgroundColor = color
    }
}

