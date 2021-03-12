//
//  BViewController.swift
//  Runner
//
//  Created by 张行 on 2021/3/11.
//

import UIKit
import ttorm

class BViewController: UIViewController, TtormModule {
    static func ttormMakeController(parameter: TtormParameter) -> UIViewController? {
        return BViewController()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
}
