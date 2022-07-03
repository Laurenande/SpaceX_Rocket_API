//
//  SettingsVC.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 06.06.2022.
//

import UIKit


class SettingsVC: UIViewController {


    @IBOutlet weak var heightMorFt: UISegmentedControl!
    @IBOutlet weak var diameterMorFt: UISegmentedControl!
    @IBOutlet weak var weightKgOrLb: UISegmentedControl!
    @IBOutlet weak var loadKgOrLb: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ApiManager.shared.isHeightM )
        {
            heightMorFt.selectedSegmentIndex = 0
        }else{
            heightMorFt.selectedSegmentIndex = 1
        }
        
        if(ApiManager.shared.isDiameterM )
        {
            diameterMorFt.selectedSegmentIndex = 0
        }else{
            diameterMorFt.selectedSegmentIndex = 1
        }
        
        if(ApiManager.shared.isWeightKg )
        {
            weightKgOrLb.selectedSegmentIndex = 0
        }else{
            weightKgOrLb.selectedSegmentIndex = 1
        }
        
        if(ApiManager.shared.isLoadKg )
        {
            loadKgOrLb.selectedSegmentIndex = 0
        }else{
            loadKgOrLb.selectedSegmentIndex = 1
        }

    }
    

    @IBAction func heightMorFt(_ sender: Any) {
        ApiManager.shared.isHeightM = !ApiManager.shared.isHeightM
    }
    
    @IBAction func diameter(_ sender: Any) {
        ApiManager.shared.isDiameterM = !ApiManager.shared.isDiameterM
    }
    
    @IBAction func weight(_ sender: Any) {
        ApiManager.shared.isWeightKg = !ApiManager.shared.isWeightKg
    }
    
    @IBAction func load(_ sender: Any) {
        ApiManager.shared.isLoadKg = !ApiManager.shared.isLoadKg
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }


    
    
}
