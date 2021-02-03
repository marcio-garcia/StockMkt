//
//  NetworkConfiguration.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation

class NetworkConfiguration: ApiConfiguration {
    var environment: ApiEnvironment = .production
    var baseUrl: String = ""
    var apiToken: String = ""
    var debugMode = false

    init(baseUrl: String, apiToken: String) {
        self.baseUrl = baseUrl
        self.apiToken = apiToken
    }

    func setEnvironment(from environment: EnvironmentType) {
        switch environment {
        case .development:
            self.environment = .development
        case .staging:
            self.environment = .staging
        case .production:
            self.environment = .production
        }
    }
}
