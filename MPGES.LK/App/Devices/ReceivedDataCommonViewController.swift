//
//  ReceivedDataCommonViewController.swift
//  mpges.lk
//
//  Created by Timur on 08.06.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataCommonViewController: UIViewController {
    
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    private let segment = UISegmentedControl(items: ["Реестр","График"])
    private var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        self.segmentSwicht()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private lazy var receivedDataRegisterTVController: ReceivedDataRegisterTVController = {
        ActivityIndicatorViewService.shared.showView(form: self.view)	
        var viewController = ReceivedDataRegisterTVController()
        viewController.delegate = delegate
        viewController.device = device
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var receivedDataChartViewController: ReceivedDataChartViewController = {
        var viewController = ReceivedDataChartViewController()
        viewController.delegate = delegate
        viewController.device = device
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
}

extension ReceivedDataCommonViewController {
    func showReceivedDataAddNewTemplateTVPage() {
        self.delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: device!)
    }
    
    @objc func showMeterDataDevicePage() {
        self.showReceivedDataAddNewTemplateTVPage()
    }
    
    private func configuration() {
        let sendMeterDataDevice = getPlusUIBarButtonItem(target: self, action: #selector(showMeterDataDevicePage))
        self.navigationItem.rightBarButtonItems = [sendMeterDataDevice]
        
        segment.addTarget(self, action: #selector(segmentSwicht), for: UIControl.Event.valueChanged)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment        
        
        let window = UIWindow(frame: self.view.bounds)
        containerView.frame = window.frame
        containerView.center = window.center
        self.view.addSubview(containerView)
    }
    
    @objc func segmentSwicht(){
        if segment.selectedSegmentIndex == 0 {
            navigationItem.title = "Реестр показаний"
            remove(asChildViewController: receivedDataChartViewController)
            add(asChildViewController: receivedDataRegisterTVController)
        } else {
            navigationItem.title = "График объемов"
            remove(asChildViewController: receivedDataRegisterTVController)
            add(asChildViewController: receivedDataChartViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}
