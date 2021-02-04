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

class HistoryContentView: UIView, ViewCodingProtocol, ChartViewDelegate {

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
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            $0.heightAnchor.constraint(equalToConstant: 200)
        ]}

        activityIndicatorView.constraint {[
            $0.centerYAnchor.constraint(equalTo: centerYAnchor),
            $0.centerXAnchor.constraint(equalTo: centerXAnchor),
            $0.widthAnchor.constraint(equalToConstant: 36),
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        ]}
    }
    
    func configureViews() {
        backgroundColor = .white

        chartView.delegate = self
        chartView.backgroundColor = .systemBlue
        chartView.layer.cornerRadius = 5
        chartView.clipsToBounds = true

        chartView.rightAxis.enabled = false
        chartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        //chartView.leftAxis.setLabelCount(5, force: false)
        chartView.leftAxis.labelTextColor = .white
        chartView.leftAxis.axisLineColor = .white
        chartView.leftAxis.axisMinimum = 0

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 8)
        chartView.xAxis.setLabelCount(5, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white

        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false

        chartView.isHidden = true

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

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

// MARK: HistoryContentViewProtocol

extension HistoryContentView: HistoryContentViewProtocol {
    func updateHistory(history: HistoryModel) {

        let valueFormatter = MyCustomBottomAxisFormatter(history: history)
        chartView.xAxis.valueFormatter = valueFormatter

        var index = 0.0
        let dataEntries = history.compactMap { (modelElement) -> ChartDataEntry? in
            let entry = ChartDataEntry(x: index, y: modelElement.close)
            index += 1
            return entry
        }

        var setLabel = "Prices"
        if let label = history.first?.ticket {
            setLabel = label
        }

        let set1 = LineChartDataSet(entries: dataEntries, label: setLabel)
        set1.drawCirclesEnabled = false
        set1.mode = .linear
        set1.lineWidth = 2
        set1.setColor(.white)
        set1.fill = ColorFill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.setDrawHighlightIndicators(true)
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        
        let lineChartData = LineChartData(dataSet: set1)
        lineChartData.setDrawValues(false)

        DispatchQueue.main.async {
            self.chartView.isHidden = false
            self.chartView.animate(xAxisDuration: 2.5)
            self.chartView.data = lineChartData
            self.activityIndicatorView.stopAnimating()
        }
    }
}

class MyCustomBottomAxisFormatter: NSObject, AxisValueFormatter {
    private var history: HistoryModel?

    convenience init(history: HistoryModel) {
        self.init()
        self.history = history
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)

        guard let history = history, index < history.count else {
            return "?"
        }

        let date = history[index].date

        //return dateFormatter.string(from: date)
        return Date.string(from: date, format: "MMM-yy")
    }
}
