//
//  SettingVC.swift
//  TipCalculator
//
//  Created by Shirly Manor on 9/16/16.
//  Copyright © 2016 manor. All rights reserved.
// Everytime that the segment change we save the index that it will be the same in all screens

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var defaultTipSetting: UISegmentedControl!
    
    @IBOutlet weak var defaultGroupNumber: UISegmentedControl!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveDefaultValues()
    }
    
    @IBAction func OnSegueTipChange(_ sender: AnyObject) {
        saveDefaultValues()
    }
    
    @IBAction func onGroupSettingChange(_ sender: AnyObject) {
        saveDefaultValues()
    }
    
    
    func saveDefaultValues() {
        let defaults = UserDefaults.standard
        
        defaults.set(defaultTipSetting.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.set(defaultGroupNumber.selectedSegmentIndex, forKey: "default_group_number")
        defaults.synchronize()
    }
    
}
