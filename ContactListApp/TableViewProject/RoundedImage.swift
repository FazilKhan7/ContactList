//
//  RoundedImage.swift
//  TableViewProject
//
//  Created by Bakhtiyarov Fozilkhon on 02.10.2022.
//
import UIKit
import Foundation

extension UIImageView {
    func setRounded() {
        self.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.layer.cornerRadius = (self.frame.width / 4)
        self.layer.masksToBounds = true
    }
}
