//
//  HistoryContentView.swift
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Charts

protocol HistoryContentViewProtocol: UIView {
    func updateHistory(history: HistoryModel)
}

class HistoryContentView: UIView, ViewCodingProtocol {

    // MARK: Layout properties

    private lazy var chartView = LineChartView()
    private lazy var activityIndicatorView = UIActivityIndicatorView()

    // MARK: Properties

    private weak var viewController: HistoryViewController?

    // MARK: Object lifecycle
    
    init(viewController: HistoryViewController?) {
        super.init(frame: CGRect.zero)
        self.viewController = viewController
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view is meant to be used with view coding")
    }
    
    // MARK: ViewCodingProtocol
    
    func buildViewHierarchy() {
        addSubview(chartView)
        addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        chartView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]}

        activityIndicatorView.constraint {[
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            $0.widthAnchor.constraint(equalToConstant: 24),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}
    }
    
    func configureViews() {
        activityIndicatorView.startAnimating()
    }
    
    // MARK: Data
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        viewController?.fetchHistory()
    }

//    private func buildEmtpyView() -> UIView {
//        HistoryEmptyView(messageText: "Sorry, no data found.", actionTitle: "Retry") { [weak self] sender in
//            self?.viewController?.fetchFirstAuthors()
//        }
//    }

}

// MARK: HistoryContentViewProtocol

extension HistoryContentView: HistoryContentViewProtocol {
    func updateHistory(history: HistoryModel) {
//        guard let dataSource = listingDataSource else { return }
//        let updatedDataList = dataSource.updateDataList(with: authors)
//        DispatchQueue.main.async {
//            self.activityIndicatorView.stopAnimating()
//            self.refreshControl.endRefreshing()
//
//            if updatedDataList.isEmpty {
//                self.tableView.backgroundView = self.buildEmtpyView()
//            } else {
//                if !authors.isEmpty {
//                    self.tableView.reloadData()
//                }
//            }
//            self.listingDelegate?.endFetching()
//        }
    }
}
