//
//  HistoryRespoonse.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation

typealias HistoryResponse = [HistoryResponseElement]

struct HistoryResponseElement: Codable {
    let close, high, low, historyResponseOpen: Double
    let symbol: String
    let volume: Int
    let id: String
    let key: String
    let subkey, date: String
    let updated: Int
    let changeOverTime, marketChangeOverTime, uOpen, uClose: Double
    let uHigh, uLow: Double
    let uVolume: Int
    let fOpen, fClose, fHigh, fLow: Double
    let fVolume: Int
    let label: String
    let change, changePercent: Double

    enum CodingKeys: String, CodingKey {
        case close, high, low
        case historyResponseOpen = "open"
        case symbol, volume, id, key, subkey, date, updated, changeOverTime, marketChangeOverTime, uOpen, uClose, uHigh, uLow, uVolume, fOpen, fClose, fHigh, fLow, fVolume, label, change, changePercent
    }
}
