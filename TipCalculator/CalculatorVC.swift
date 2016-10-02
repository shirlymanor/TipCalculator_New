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
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    var updateAmountDate: Double?
    
    override func viewWillAppear(_ animated: Bool) {
        
        amount.becomeFirstResponder()
        setGlobalparam()
        getGlobalparam()
        setAnimation()
        setTip()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setGlobalparam()
        getGlobalparam()
        
    }
    
    @IBAction func editChange(_ sender: AnyObject) {
        guard amount.text == "" else {
            setTip()
            updateAmountDate = 600
            return
        }
        
    }
    
    @IBAction func tipChanged(_ sender: AnyObject) {
        setAnimation()
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
                tipText    = tipText * 100 //change to cents
                group.text = "\(tipText / Float(selectedGroupNumber)) Cents"
                tip.text   = "\(tipText) Cents"
                
            }
            else {
                tip.text = "\(tipText.asLocaleCurrency) "
                let tipPerPerson: Float = tipText / Float(selectedGroupNumber)
                group.text = "\(tipPerPerson.asLocaleCurrency) "
            }
            
            return
        }
        
    }
    
    func setAnimation() {
        
        self.firstView.alpha  = 0
        self.secondView.alpha = 2
        print(view.bounds.width)
        UIView.animate(withDuration: 0.4, animations: {
            self.secondView.alpha = 0
            },completion: nil)
        
    }
    
    func getGlobalparam() {
        
        let defaults = UserDefaults.standard
        print(defaults.integer(forKey: "default_tip_index"))
        // Declare global varibles that can be change in the setting page
        tipSegment.selectedSegmentIndex   = defaults.integer(forKey: "default_tip_index")
        groupSegment.selectedSegmentIndex = defaults.integer(forKey: "default_group_number")
        updateAmountDate                  = defaults.double(forKey: "update_amount_date")
        amount.text                       = defaults.string(forKey: "last_amount")
        
    }
    
    func setGlobalparam() {
        let defaults = UserDefaults.standard
        
        //Save the last bill amount
        defaults.set(amount!.text, forKey:"last_amount")
        defaults.set(NSDate().timeIntervalSince1970,forKey: "update_amount_date")
        defaults.synchronize()

    }
    
}
// Add extension to float to get the currency from the setting (region)
extension Float {
    var asLocaleCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        return formatter.string(from: NSNumber(value: self))!
    }
}
