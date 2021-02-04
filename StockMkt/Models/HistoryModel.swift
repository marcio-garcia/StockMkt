//
//  HistoryModel.swift
//  StockMkt
//
//  Created by Marcio Garcia on 04/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

import Foundation

typealias HistoryModel = [HistoryModelElement]

struct HistoryModelElement {
    let ticket: String
    let close: Double
    let date: Date
}
