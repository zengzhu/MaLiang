//
//  PaintingGestureRecognizer.swift
//  MaLiang_Example
//
//  Created by Harley.xk on 2018/5/3.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass


class PaintingGestureRecognizer: UIPanGestureRecognizer {

    private var targetView: UIView
    
    init(addTo target: UIView, action: Selector?) {
        targetView = target
        super.init(target: target, action: action)
        maximumNumberOfTouches = 1
        target.addGestureRecognizer(self)
    }
    
    /// 当前压力值，启用压力感应时，使用真实的压力，否则使用模拟压感
    var force: CGFloat = 1
    
    /// 是否启用压力感应，默认关闭
    var pressEnabled = false
    
    private func updateForceFromTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        if pressEnabled, touch.force > 0 {
            force = touch.force
            return
        }
        
        let vel = velocity(in: targetView)
        var length = vel.distance(to: .zero)
        length = min(length, 5000)
        length = max(50, length)
        let speed = 500 / length
        print("Gesture Speed: ", String(format: "%.1f", speed))
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        updateForceFromTouches(touches)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        updateForceFromTouches(touches)
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        updateForceFromTouches(touches)
        super.touchesEnded(touches, with: event)
    }
}
