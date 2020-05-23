//
//  PDFViewController.swift
//  mpges.lk
//
//  Created by Timur on 18.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PDFKit
import Alamofire

class PDFViewController: UIViewController {
    
    public var urlToPdf: URL!
    public weak var delegate: InvoicesTableViewControllerUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        showPdf()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.hiddenAI()
    }
}

extension PDFViewController {
    
    private func showPdf() {
        let pdfView = self.createPdfView(withFrame: self.view.bounds)
        print(self.urlToPdf!)
        self.view.addSubview(pdfView)
        if let pdfDocument = PDFDocument(url: self.urlToPdf!) {
            pdfView.document = pdfDocument
        }
    }
    
    private func createPdfView(withFrame frame: CGRect) -> PDFView {
        let pdfView = PDFView(frame: frame)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        return pdfView
    }
    
    private func configure() {
        self.navigationItem.title = "Просмотр PDF"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.leftBarButtonItems = [cancelBtn]
        let sharedBtn = getCustomUIBarButtonItem(image: myImage.shared.rawValue, target: self, action: #selector(shareButton))
        self.navigationItem.rightBarButtonItems = [sharedBtn]
    }
    
    @objc func shareButton() {
        let text = "Квитанция для оплаты"
        if let document = PDFDocument.init(url: self.urlToPdf!) {
            let activityVC = UIActivityViewController(activityItems: [document.documentURL!, text], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.excludedActivityTypes = [
                UIActivity.ActivityType.airDrop,
                UIActivity.ActivityType.markupAsPDF,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.copyToPasteboard,
                UIActivity.ActivityType.mail,
                UIActivity.ActivityType.message,
                UIActivity.ActivityType.openInIBooks,
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.print
            ]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
