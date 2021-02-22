//
//  ForecastStruct.swift
//  weatherapp
//
//  Created by Govardhan Goli on 2/22/21.
//

import Foundation

struct Forecast: Decodable {
    var cod : String
    var list : [List]
}

struct List: Decodable {
    var main : Main
    var weather : [Weather]
}

struct Main : Decodable {
    var temp : Double
    var feels_like : Double
}

struct Weather : Decodable {
    var main : String
    var description : String
}
