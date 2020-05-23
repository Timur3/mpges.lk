//
//  PDFViewController.swift
//  mpges.lk
//
//  Created by Timur on 18.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    private func createPdfView(withFrame frame: CGRect) -> PDFView {
        let pdfView = PDFView(frame: frame)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        
        return pdfView
    }
    
    private func displayPdf() {
        let pdfView = self.createPdfView(withFrame: self.view.bounds)
        self.navigationItem.title = "Просмотр PDF"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        if let pdfDocument = self.createPdfDocument(forFileName: "heaps") {
            self.view.addSubview(pdfView)
            pdfView.document = pdfDocument
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.displayPdf()
    }
    
    private func createPdfDocument(forFileName fileName: String) -> PDFDocument? {
        if let resourceUrl = URL(string: "http://school3-hm.ru/images/Polojeni/03.05.2018/3Polozhenie_ob_obshchem_sobranii_rabotneykov.pdf") {
            return PDFDocument(url: resourceUrl)
        }
        
        return nil
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
