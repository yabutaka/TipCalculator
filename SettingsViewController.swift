//
//  SettingsViewController.swift
//  tippy
//
//  Created by 薮田隆司 on 08/11/2018.
//  Copyright © 2018 Takashi.Co. All rights reserved.
//

import UIKit
import os.log

class SettingsViewController: UIViewController {

    
    //MARK: Properties
    
    var tipsSetting = Tips(newTipPercentages: [0.15, 0.2, 0.25])
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipPercentageField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var explanation: UILabel!
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up views for the existing tips.
        for i in 1...tipControl.numberOfSegments{
            let newPercentage = tipsSetting.tipPercentages[i-1]
            tipControl.setTitle(String(format: "%.0f%%", newPercentage * 100), forSegmentAt: i-1)
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func tipPercentageChange(_ sender: Any) {
        let newPercentage = (Double(tipPercentageField.text!) ?? 20) / 100
        
        tipsSetting.tipPercentages[tipControl.selectedSegmentIndex] = Double(newPercentage)
        tipControl.setTitle(String(format: "%.0f%%", newPercentage * 100), forSegmentAt: tipControl.selectedSegmentIndex)
    }
    
    
    
    // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
    
}
    


