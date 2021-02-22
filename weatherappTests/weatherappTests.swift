//
//  weatherappTests.swift
//  weatherappTests
//
//  Created by Govardhan Goli on 2/22/21.
//

import XCTest
@testable import weatherapp

class weatherappTests: XCTestCase {
    var viewModel:ForecastViewModel!
    let apiClient = ApiClientMock()
    override func setUpWithError() throws {
        viewModel = ForecastViewModel(apiClient: apiClient)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAnimationResultSuccess() {
        apiClient.isSuccess = true
        viewModel.getForecastResults(CityName: "Dallas", completion: { [self] (response, error) in
            XCTAssertNotNil(viewModel.repos)
            XCTAssertEqual(viewModel.repos.count, 40, "Search API Success  failed")
        })
        
    }
    func testGetAnimationResultFailure() {
        apiClient.isSuccess = false
        viewModel.getForecastResults(CityName: "Dallas", completion: { [self] (response, error) in
            XCTAssertEqual(viewModel.repos.count, 0, "Search API failure  failed")
        })
       

    }

}

class ApiClientMock: Networkable {
    
    var isSuccess = true
    func loadData(from urlString: String, path: String, params: String, completionHandler: @escaping Completion) {
        if isSuccess {
            if let url = Bundle.main.url(forResource:"SearchSuccess", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let result = try? JSONDecoder().decode(Forecast.self, from: data) {
               completionHandler(.success(result))
            }
        }else {
            completionHandler(.failure(.badURL))
        }
    }
}

