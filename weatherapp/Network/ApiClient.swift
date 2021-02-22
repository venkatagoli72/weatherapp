//
//  ApiClient.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badNetwork
    case parsingFailed
    case malformedURL(message:String)
    case errorWith(response:URLResponse?)
    case dataParsinFailed
}

typealias Completion =  (Result<Forecast, NetworkError>) -> Void

protocol  Networkable {
    func loadData(from urlString: String, path:String, params:String, completionHandler:@escaping Completion)
}

class ApiClient : Networkable {
    
    //Call the API and parse the Json data.
    
    func loadData(from urlString: String, path:String, params:String = "", completionHandler:@escaping Completion) {
        
        guard var urlComponents = URLComponents(string:urlString + path) else {
            DispatchQueue.main.async {
              completionHandler(.failure(.malformedURL(message:"URL is not correct")))
            }
            return
        }
        urlComponents.query = "\(params)"
        guard let url = urlComponents.url else {
            DispatchQueue.main.async {
             completionHandler(.failure(.malformedURL(message:"URL is nil")))
            }
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , let _responce = response as? HTTPURLResponse , _responce.statusCode == 200 else {
                DispatchQueue.main.async {
                 completionHandler(.failure(.errorWith(response: response)))
                }
                return
            }
            do {
                let response_obj = try JSONDecoder().decode(Forecast.self, from: data)
                //Return the details to the main thread after completion of the call.
                DispatchQueue.main.async {
                    completionHandler(.success(response_obj))
                }
            }catch {
                DispatchQueue.main.async {
                 completionHandler(.failure(.parsingFailed))
                }
            }
        }.resume()
    }
    
    
}
