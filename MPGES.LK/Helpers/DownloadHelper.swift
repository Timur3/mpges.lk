//
//  DownloadHelper.swift
//  mpges.lk
//
//  Created by Timur on 21.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

func downloadPdf(url: String) -> URL {
    
    var urlFile: URL?
    do {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let pdfDocURL = documentsURL.appendingPathComponent("doc.pdf")
        let pdfData = try Data(contentsOf: URL(string: url)!)
        try pdfData.write(to: pdfDocURL)
        urlFile = pdfDocURL
    } catch {
        print(error.localizedDescription)
    }
    return urlFile!
    
}
