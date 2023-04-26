//
//  Theme.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 24/04/23.
//

import UIKit

enum Theme {
    enum Color {
        static let white = UIColor(hex: "#ffffff")
        static let black = UIColor(hex: "#000000")
        
        static let gray100 = UIColor(hex: "#E1E1E6")
        static let gray300 = UIColor(hex: "#C4C4CC")
        static let gray400 = UIColor(hex: "#8D8D99")
        static let gray500 = UIColor(hex: "#7C7C8A")
        static let gray600 = UIColor(hex: "#323238")
        static let gray700 = UIColor(hex: "#29292E")
        static let gray800 = UIColor(hex: "#202024")
        static let gray900 = UIColor(hex: "#121214")
        
        static let green300 = UIColor(hex: "#00B37E")
        static let green500 = UIColor(hex: "#00875F")
        static let green700 = UIColor(hex: "#015F43")
        
        static let red300 = UIColor(hex: "#f75a68")
        static let red500 = UIColor(hex: "#AB222E")
        static let red700 = UIColor(hex: "#7A1921")
        
        static let yellow500 = UIColor(hex: "#FBA94C")
    }
    
    enum Size {
        private static let base = CGFloat(4)
        static let small = base * 2
        static let mid = base * 4
        static let large = base * 8
    }
}

private extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
