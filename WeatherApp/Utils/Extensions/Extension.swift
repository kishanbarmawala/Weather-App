//
//  Extension.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 20/10/24.
//

import UIKit

extension Data {
    
    var toPrettyJSON: String {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: prettyPrintedData, encoding: .utf8) ?? ""
        } catch {
            print("Error converting Data to pretty-printed JSON: \(error)")
            return ""
        }
    }
    
}

extension String? {
    
    func changeDateFormat(_ input: String?, output: String?) -> String? {
        
        guard let dateString = self else {
            return nil
        }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = input
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
                
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = output
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.timeZone = TimeZone.current
        
        guard let date = inputFormatter.date(from: dateString) else {
            print("Invalid date format")
            return nil
        }
        
        return outputFormatter.string(from: date)
    }
    
}

extension Encodable {
    
    var toPrettyJSON: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print("Error encoding model to JSON: \(error)")
            return ""
        }
    }
    
}

extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter { $0.isMember(of: type) }
            .forEach { $0.removeFromSuperview() }
    }
    
}

extension UIWindow {
    
    static func keyWindow() -> UIWindow? {
        UIApplication.shared.windows.filter({$0.isKeyWindow}).first
    }
    
}

extension Double {
    
    var kelvinToCelcius: String {
        let finalTemp = Int(self - 273.15)
        return "\(finalTemp)°"
    }
    
}
