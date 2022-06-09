//
//  Shimmer.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 08/06/22.
//

import Foundation
import UIKit

extension UIView {
    // MARK: Constants
    fileprivate struct Constants {
        static let shimmerAnimationKey = "shimmer"
        static let locationsKeyPath = "locations"
        static let defaultGradientPoisitionsAnimation: [NSNumber] = [0.4, 0.5, 0.6]
        static let startGradientPoisitionsAnimation = [0.0, 0.1, 0.2]
        static let finalGradientPoisitionsAnimation = [0.8, 0.9, 1.0]
        static let animationDuration = 1.5
        static let startPosition = CGPoint(x: 0.0, y: 0.5)
        static let endPosition = CGPoint(x: 1.0, y: 0.525)
    }
    func startShimmering() {
        var layerMask = layer.mask
        
        let dark = UIColor.black.cgColor
        let light = UIColor(white: 0, alpha: 0.1).cgColor
        let gradient = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        let boundsSize = bounds.size
        let boundsWidth = boundsSize.width
        gradient.frame = CGRect(x: -boundsWidth, y: 0, width: 3 * boundsWidth, height: boundsSize.height)
        gradient.startPoint = Constants.startPosition
        gradient.endPoint = Constants.endPosition
        gradient.locations = Constants.defaultGradientPoisitionsAnimation
        layerMask = gradient
        
        let view:UIView = UIView()
        let view2:UIView = UIView()
        view.layer.mask = layerMask
        view.backgroundColor = .lightGray
        view2.backgroundColor = .white
        self.addSubview(view2)
        
        view2.frame = self.bounds
        view2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view2.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        if layerMask?.animation(forKey: Constants.shimmerAnimationKey) == nil {
            let animation = CABasicAnimation(keyPath: Constants.locationsKeyPath)
            animation.fromValue = Constants.startGradientPoisitionsAnimation
            animation.toValue = Constants.finalGradientPoisitionsAnimation
            animation.duration = Constants.animationDuration
            animation.repeatCount = .infinity
            layerMask?.add(animation, forKey: Constants.shimmerAnimationKey)
        }
    }
    
    func stopShimmering() {
        if !subviews.isEmpty && !(subviews.last?.subviews.isEmpty ?? false) {
            self.subviews.last?.removeFromSuperview()
        }
    }
}

extension CACornerMask{
    static let bottomRight:CACornerMask = .layerMaxXMaxYCorner
    static let bottomLeft:CACornerMask = .layerMinXMaxYCorner
    static let topRight:CACornerMask = .layerMaxXMinYCorner
    static let topLeft:CACornerMask = .layerMinXMinYCorner
}
