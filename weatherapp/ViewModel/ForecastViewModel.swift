//
//  ForecastViewModel.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import Foundation


class ForecastViewModel : ObservableObject {
    
    let apiClient:Networkable
    @Published var repos: [List] = []

    init(apiClient: Networkable = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func getForecastResults(CityName: String, completion :  @escaping([List]?, Bool)->Void) {
        // Call the function that make the API call
        guard let key = UserDefaults.standard.object(forKey: "appKey") as? String else{
            completion([], true)
            return}
        apiClient.loadData(from:Constants.baseUrl, path: Constants.searchPath, params: key+"units=imperial&q="+CityName) { result in
            switch result {
            case .success(let forecast):
                completion(forecast.list, false)
            case .failure( _):
                    self.repos = []
                completion([], true)
            }
        }
    }
}
