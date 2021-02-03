//
//  HistoryEndpoint.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation
import Ivorywhite

class HistoryEndpoint: Endpoint, NetworkRequest {

    typealias ModelType = HistoryResponse
    typealias ErrorModelType = ErrorResponse

    init?(apiConfiguration: ApiConfiguration, ticket: String, period: String) {
        super.init()

        guard let baseURL = URL(string: apiConfiguration.baseUrl) else {
            return nil
        }

        self.baseURL = baseURL
        self.path = "/stable/stock/\(ticket)/chart/\(period)"
        self.httpMethod = .get
        self.encoding = .urlEnconding
        self.httpHeaders = [
            "Content-Type": "application/json;charset=utf-8"
        ]
        self.parameters = [
            "token": "\(apiConfiguration.apiToken)"
        ]
    }

    func parse(data: Data) -> ModelType? {
        let response = try? JSONDecoder().decode(ModelType.self, from: data)
        return response
    }

    func parseError(data: Data) -> ErrorModelType? {
        let response = try? JSONDecoder().decode(ErrorModelType.self, from: data)
        return response
    }
}
