//
//  StockNerworkService.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation
import Ivorywhite

public class StockNerworkService: StockApi {

    private var apiConfiguration: ApiConfiguration
    private var networkService: NetworkService

    init(apiConfiguration: ApiConfiguration, networkService: NetworkService) {
        self.apiConfiguration = apiConfiguration
        self.networkService = networkService
    }

    func requestHistory(ticket: String, period: String, completion: @escaping (HistoryResponse?, Error?) -> Void) {
        guard let endpoint = HistoryEndpoint(apiConfiguration: apiConfiguration, ticket: ticket, period: period) else {
            completion(nil, nil)
            return
        }
        performRequest(request: endpoint, completion: completion)
    }

    private func performRequest<T: NetworkRequest>(request: T,
                                                   completion: @escaping (T.ModelType?, Error?) -> Void) {

        _ = networkService.request(request) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    private func performRequest(with url: URL,
                                completion: @escaping (Data?, Error?) -> Void) {

        _ = networkService.request(with: url) { result in
            switch result {
            case .success(let response):
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
