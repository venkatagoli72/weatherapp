//
//  SearchViewController.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    static let identifier = String(describing: SearchViewController.self)
    
    @IBOutlet weak var cityNameInput: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if cityNameInput.text != ""{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: ForecastViewController.identifier) as!  ForecastViewController
            vc.cityName = cityNameInput.text!
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Enter city name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
