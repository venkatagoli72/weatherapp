//
//  DetailViewController.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weatherDescLbl: UILabel!
    @IBOutlet weak var actualTempLbl: UILabel!
    
    @IBOutlet weak var feelsLikeTempLbl: UILabel!
    
    var detailForecast: List?
    static let identifier = String(describing: DetailViewController.self)
    override func viewDidLoad() {
        self.actualTempLbl.text = "\(detailForecast!.main.temp) F"
        self.feelsLikeTempLbl.text = "Feels like: \(detailForecast!.main.feels_like) F"
        self.weatherLbl.text = detailForecast?.weather[0].main
        self.weatherDescLbl.text = detailForecast?.weather[0].description
    }
}
