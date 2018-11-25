//
//  ViewController.swift
//  tippy
//
//  Created by 薮田隆司 on 07/11/2018.
//  Copyright © 2018 Takashi.Co. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    //MARK: Properties
    
    var tips = Tips(newTipPercentages: [0.15, 0.2, 0.25])

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1

        })
        
        let bill = Double(billField.text!) ?? 0
        billField.text = String(format: "$%.0f", bill)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tips.tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func unwindToTipCalculator(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? SettingsViewController {
            
            let newTips = sourceViewController.tipsSetting
            
            // Update a new tips.
            tips = newTips
            
            // Update tips percentages' titles.
            for i in 1...tipControl.numberOfSegments{
                let newPercentage = tips.tipPercentages[i-1]
                tipControl.setTitle(String(format: "%.0f%%", newPercentage * 100), forSegmentAt: i-1)
            }
        }
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        guard let settingsViewController = segue.destination as? SettingsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        settingsViewController.tipsSetting = tips

    }
}

