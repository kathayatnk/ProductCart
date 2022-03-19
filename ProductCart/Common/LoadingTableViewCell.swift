//
//  LoadingTableViewCell.swift
//  ProductCart
//
//  Created by Narendra Kathayat on 18.03.22.
//

import Foundation
import UIKit

final class LoadingTableViewCell: UITableViewCell {
    
    private var rotatingLayer: CAShapeLayer?
    
    override func prepareForReuse() {
        rotatingLayer = nil
    }
    
    private func setLayer() {
        
        let diameter = 50.0
        let xFromCenter = (contentView.bounds.width / 2.0 - diameter / 2.0)
        let yFromCenter = (contentView.bounds.height - diameter) / 2.0
        let smallRect = CGRect(x: xFromCenter, y: yFromCenter, width: diameter, height: diameter)
        let path = UIBezierPath(arcCenter: CGPoint(x: smallRect.width / 2.0, y: smallRect.height / 2.0), radius: diameter / 2.0, startAngle: .pi , endAngle:  2.5 * .pi, clockwise: true)
        rotatingLayer = CAShapeLayer()
        guard let rotatingLayer = rotatingLayer else { return }
        rotatingLayer.frame = smallRect
        rotatingLayer.path = path.cgPath
        rotatingLayer.fillColor = UIColor.clear.cgColor
        rotatingLayer.strokeColor = UIColor.red.cgColor
        rotatingLayer.lineWidth = 2.0
        rotatingLayer.add(getRotatingAnimation(), forKey: "Rotor")
        contentView.layer.addSublayer(rotatingLayer)
        selectionStyle = .none
    }
    
    /// The basic rotating animation
        private func getRotatingAnimation() -> CABasicAnimation {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = 1.0
            rotateAnimation.repeatCount = Float.infinity
            rotateAnimation.isRemovedOnCompletion = false
            return rotateAnimation
        }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setLayer()
    }
}
