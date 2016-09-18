//
//  CalculatorVC.swift
//  TipCalculator
//
//  Created by Shirly Manor on 9/16/16.
//  Copyright © 2016 manor. All rights reserved.
//  Every time that event fire the tip will be set to the new tip

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet weak var tip: UILabel!
    
    @IBOutlet weak var group: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var groupSegment: UISegmentedControl!
    
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        // Declare global varibles that can be change in the setting page
        tipSegment.selectedSegmentIndex = defaults.integer(forKey: "default_tip_index")
        groupSegment.selectedSegmentIndex = defaults.integer(forKey: "default_group_number")
        
        setTip()
    }
    
    @IBAction func editChange(_ sender: AnyObject) {
        guard amount.text == "" else {
            setTip()
            return
        }
        
    }
    
    @IBAction func tipChanged(_ sender: AnyObject) {
        
        setTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTip()
    }
    
    @IBAction func onGroupChange(_ sender: AnyObject) {
        setTip()
    }
    
    func setTip()
    {
        guard (Int(amount.text!)!<0) else {
            let tipPercentages = [0.1,0.15,0.18,0.2]
            let amountPeople = [1,2,3,4]
            let selectedTipPercentage = Float(tipPercentages[tipSegment.selectedSegmentIndex])
            let selectedGroupNumber = amountPeople[groupSegment.selectedSegmentIndex]
            var tipText =  Float(amount.text!)! * selectedTipPercentage
            
            if(tipText < 1 && tipText > 0) {
                tipText = tipText * 100 //change to cents
                group.text = "\(tipText / Float(selectedGroupNumber)) Cents"
                tip.text = "\(tipText) Cents"
                
            }
            else {
                tip.text = "\(tipText) $"
                group.text = "\(tipText / Float(selectedGroupNumber)) $"
            }
            
            return
        }
        
    }
}
