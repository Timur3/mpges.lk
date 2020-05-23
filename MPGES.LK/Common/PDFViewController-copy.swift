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

class PDFViewController1: UIViewController {
    
   //public var urlToPdfFile1 = "http://school3-hm.ru/images/Polojeni/03.05.2018/3Polozhenie_ob_obshchem_sobranii_rabotneykov.pdf"
   public var urlToPdfFile = "file:///Users/Tima/Library/Developer/CoreSimulator/Devices/2B93A9CD-C450-4307-8C11-39A8E840B7C5/data/Containers/Data/Application/D6273EAB-0602-49B7-BFD1-76FB7FA94098/Documents/3Polozhenie_ob_obshchem_sobranii_rabotneykov.pdf"
    
    private var pdf: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.downloadPDF(urlFile: urlToPdfFile1)
        self.configure()
    }
}

extension PDFViewController1 {
    
    private func createPdfView(withFrame frame: CGRect) -> PDFView {
        let pdfView = PDFView(frame: frame)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        return pdfView
    }
    
    private func showPdf() {
        let pdfView = self.createPdfView(withFrame: self.view.bounds)
        
        if let pdfDocument = createPdfDocument(for: self.urlToPdfFile) {
            self.view.addSubview(pdfView)
            pdfView.document = pdfDocument
        }
        
        ActivityIndicatorViewService.shared.hideView()
    }
    
    private func createPdfDocument(for UrlToFile: String) -> PDFDocument? {
        //if let resourceUrl = URL(string: UrlToFile) {
           // return PDFDocument(url: resourceUrl)
      //  }
      //  return nil
        
        return PDFDocument(url: pdf)
    }
    
    func configure() {
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        self.navigationItem.title = "Просмотр PDF"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.leftBarButtonItems = [cancelBtn]
        let sharedBtn = getCustomUIBarButtonItem(image: myImage.shared.rawValue, target: self, action: #selector(shareButton))
        self.navigationItem.rightBarButtonItems = [sharedBtn]
    }
    
    @objc func shareButton() {
        
        if let document = PDFDocument(url: pdf!) {
            
            let activityVC = UIActivityViewController(activityItems: [document], applicationActivities: nil)
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
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.print
            ]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func downloadPDF(urlFile: String) {
        guard let url = URL(string: urlFile) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
}

extension PDFViewController1:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdf = destinationURL
            print("location:", destinationURL)
            self.showPdf()
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
