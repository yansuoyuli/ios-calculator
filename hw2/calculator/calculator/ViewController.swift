//
//  ViewController.swift
//  calculator
//
//  Created by Songli Wu on 2022/9/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.displayLabel.text = ""
    }
    var digitOnDisplay:String{
        get{
            return self.displayLabel.text!
        }
        
        set{
            self.displayLabel.text!=newValue
        }
    }

    var inTypingMode = false
    
    @IBAction func numberTouched(_ sender: UIButton) {
        if inTypingMode{
            digitOnDisplay = digitOnDisplay+sender.currentTitle!
        }else{
            digitOnDisplay = sender.currentTitle!
            inTypingMode = true
        }
        
    }
    
    let calculators = calculator()
    @IBAction func operatorTouched(_ sender: UIButton) {
       // print("operator \(sender.currentTitle!) touched")
        if let op = sender.currentTitle{
            if let result = calculators.performOperation(operation: op, operand:Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
            }
            
            inTypingMode = false
        }
    }
}

