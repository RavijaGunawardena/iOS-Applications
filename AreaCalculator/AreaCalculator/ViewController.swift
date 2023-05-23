//
//  ViewController.swift
//  AreaCalculator
//
//  Created by Pubudu Mihiranga on 2023-01-27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var areaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaLabel.text = ""
    }

    @IBAction func didTapCalculateArea(_ sender: Any) {
        // assining values in the textfields
        let width = widthTextField.text
        let height = heightTextField.text
        
        // check if textfiled's have values or not
        guard let width = width, let height = height else { return }
        
        // typecast to FLOAT type
        guard let width = Float(width), let height = Float(height) else { return }
        
        let area = width * height
        
        // assign calculated area to label's text
        areaLabel.text = String(area)
        
        // removing vales in the textfiled's
        widthTextField.text = ""
        heightTextField.text = ""
        
        // alternative way with reduced steps
        /*
        guard let width = Float(widthTextField.text!),
              let height = Float(heightTextField.text!) else { return }
        
        areaLabel.text = String(width * height)
        widthTextField.text = ""
        heightTextField.text = ""
        */
    }
}

