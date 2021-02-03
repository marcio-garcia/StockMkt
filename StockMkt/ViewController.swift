//
//  ViewController.swift
//  StockMkt
//
//  Created by Marcio Garcia on 02/02/21.
//

import UIKit

class ViewController: UIViewController {

    private var api: StockApi?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    init(api: StockApi) {
        super.init(nibName: nil, bundle: nil)
        self.api = api
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        api?.requestHistory(ticket: "aapl", period: "1y", completion: { history, error in
            if let history = history {
                print(history)
            }
        })
    }


}

