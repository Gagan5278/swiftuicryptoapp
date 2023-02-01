//
//  String+Extension.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/02/01.
//

import Foundation

extension String {
    
    func findLastupdateDate() -> Date   {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func removeHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
             return nil
         }
     
         let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
             .documentType: NSAttributedString.DocumentType.html,
             .characterEncoding: String.Encoding.utf8.rawValue
         ]
     
         let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
         return attributedString?.string
    }

}
