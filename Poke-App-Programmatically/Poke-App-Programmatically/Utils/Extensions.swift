//
//  Extensions.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 25.04.2023.
//

import Foundation
import UIKit

extension UILabel {
    func detailLabel(size: CGFloat, color: UIColor, alpha: CGFloat? = 1, textAlign: NSTextAlignment, numberoFLines: Int? = 1) {
        font = UIFont(name: "Chalkduster", size: size)
        textAlignment = textAlign
        textColor = color.withAlphaComponent(alpha!)
        adjustsFontSizeToFitWidth = true
        numberOfLines = numberoFLines!
        minimumScaleFactor = 0.5
    }
}
