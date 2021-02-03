//
//  Endpoint.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation
import Ivorywhite

class Endpoint {
    var baseURL: URL = URL(string: "https://empty.com")!
    var path: String = ""
    var httpMethod: HTTPMethod = .get
    var httpHeaders: HTTPHeader?
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    var timeoutInterval: TimeInterval = 10.0
}
