//
//  ViewController.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import UIKit

class ForecastViewController: UIViewController {
    static let identifier = String(describing: ForecastViewController.self)
    
    var forecastViewModel = ForecastViewModel()
    var cityName = ""
    var forecastList = [List]()

    @IBOutlet weak var forecastTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableview.delegate = self
        forecastTableview.dataSource = self
        forecastViewModel.getForecastResults(CityName: cityName){ (response, error) in
            if (!error){
                DispatchQueue.main.async {
                    self.forecastList = response ?? []
                    self.forecastTableview.reloadData()
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        // Do any additional setup after loading the view.
    }


}

extension ForecastViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableviewCell", for: indexPath) as! ForecastTableviewCell
        cell.weatherlbl.text =  forecastList[indexPath.row].weather[0].main
        cell.tempLbl.text  = "temp : \(forecastList[indexPath.row].main.temp) F"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: DetailViewController.identifier) as!  DetailViewController
        vc.detailForecast = forecastList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

