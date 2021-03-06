//
//  CalculatorVC.swift
//  TipCalculator
//
//  Created by Shirly Manor on 9/16/16.
//  Copyright © 2016 manor. All rights reserved.
//  Every time that event fire the tip will be set to the new tip

import UIKit

class CalculatorVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tip: UILabel!
    
    @IBOutlet weak var group: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var groupSegment: UISegmentedControl!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    var updateAmountDate: Double?
    
    let limitCharactersFotAmount: Int = 7
    
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
        guard (!amount.hasText)  else {
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
        self.hideKeyboardWhenTappedAround() // Add extention to hide the keyboard when tapping in diffrent location
        amount.delegate = self
        amount.keyboardType = UIKeyboardType.numbersAndPunctuation
        setTip()
        }
    
    @IBAction func onGroupChange(_ sender: AnyObject) {
        setTip()
    }
   
    func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String)
            -> Bool
        {
            // We still return true to allow the change to take place.
            if string.characters.count == 0 {
                clearTip()
                return true
            }
            
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            switch textField {
                
            case amount:
                return prospectiveText.isNumeric() &&
                    prospectiveText.characters.count <= limitCharactersFotAmount
                
              
            default:
                return true
            }
            
        }
        
    
    
    func setTip()
    {
        guard (!amount.hasText) else {
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
    func clearTip()
    {
        tip.text = ""
        group.text = ""
    }
    func setAnimation() {
        
        self.firstView.alpha  = 0
        self.secondView.alpha = 2
        UIView.animate(withDuration: 0.4, animations: {
            self.secondView.alpha = 0
            },completion: nil)
        
    }
    
    func getGlobalparam() {
        
        let defaults = UserDefaults.standard  // Declare global varibles that can be change in the setting page
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

// Add extension to hide keyboard when touching the screen
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
// add extension to check if a string is number
extension String {
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        scanner.locale = Locale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }

}
