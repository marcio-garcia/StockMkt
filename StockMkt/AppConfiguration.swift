//
//  AppConfiguration.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation

public enum PlistKey: String {
    case environment    = "Environment"
    case bundleId       = "CFBundleIdentifier"
    case appVersion     = "CFBundleShortVersionString"
    case baseUrl        = "BaseUrl"
    case httpScheme     = "HttpScheme"
    case apiToken       = "ApiToken"
    case apiSecret      = "ApiSecret"
}

public enum EnvironmentType: String {
    case development    =  "development"
    case staging        =  "staging"
    case production     =  "production"
}

public struct AppConfiguration {

    static let shared = AppConfiguration()

    private init() { }

    public var environment: EnvironmentType {
        let envString = self.value(for: .environment)
        if let envType = EnvironmentType(rawValue: envString) {
            return envType
        }
        return EnvironmentType.production
    }

    public func value(for key: PlistKey) -> String {
        guard let val = self.infoDictionary[key.rawValue] as? String else { return "" }
        let finalValue = val.replacingOccurrences(of: "\\", with: "")
        return finalValue
    }

    private var infoDictionary: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }
            else {
                fatalError("plist file not found")
            }
        }
    }
}
