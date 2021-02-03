//
//  ApiConfiguration.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation

public enum ApiEnvironment {
    case development
    case staging
    case production
}

public protocol ApiConfiguration {
    var environment: ApiEnvironment { get set }
    var baseUrl: String { get set }
    var apiToken: String { get set }
    var debugMode: Bool { get set }
}
