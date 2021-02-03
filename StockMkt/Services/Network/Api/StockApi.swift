//
//  IEXCloudApi.swift
//  StockMkt
//
//  Created by Marcio Garcia on 03/02/21.
//  Copyright © 2021 Oxltech. All rights reserved.
//

protocol StockApi {
    func requestHistory(ticket: String, period: String, completion: @escaping (HistoryResponse?, Error?) -> Void)
}
