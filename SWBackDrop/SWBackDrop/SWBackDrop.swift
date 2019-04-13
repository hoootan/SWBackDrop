//
//  SWBackDrop.swift
//  BackDrop Example
//
//  Created by Hootan Moradi on 4/13/19.
//  Copyright © 2019 Hootan Moradi. All rights reserved.
//

import Foundation
import UIKit

public struct SWBackDrop {
    
    var parentViewController: UIViewController!
    var backDropController: UIViewController!
    var dropInset: CGFloat!
    var topInset: CGFloat?
    var dropCornerRadius: CGFloat = 20
    
    var containerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.roundCorners([.topRight,.topLeft], radius: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
        
    }()
    
    var embeddedView: UIView?
    var embeddedViewController: UIViewController?
    
    var isFocusedEmbeddedController: Bool = false {
        didSet {
            
            let weakSelf = self
            UIView.animate(withDuration: 0.2) {
                weakSelf.containerView.frame = weakSelf.frameForEmbeddedController(view: weakSelf.parentViewController.view)
            }
            
        }
    }
    
    init(parentViewController: UIViewController,
         backDropController: UIViewController,
         dropInset: CGFloat,topInset:CGFloat? = 50) {
        
        self.parentViewController = parentViewController
        self.backDropController = backDropController
        self.dropInset = dropInset
        self.topInset = topInset
    }
    
    func frameForEmbeddedController(view:UIView) -> CGRect {
        
        var embeddedFrame = view.bounds
        var insetHeader = UIEdgeInsets()
        insetHeader.top = topInset!
        embeddedFrame = embeddedFrame.inset(by: insetHeader)
        
        if !isFocusedEmbeddedController {
            embeddedFrame.origin.y = dropInset
        }
        
        if (embeddedView == nil) {
            embeddedFrame.origin.y = dropInset
        }
        
        return embeddedFrame
    }
    
    mutating func setupBackDroppedController() {
        self.parentViewController.view.addSubview(self.containerView)
        self.insert(self.backDropController)
    }
    
    mutating func viewDidLayoutSubviews(){
        
        let embeddedFrame = frameForEmbeddedController(view: self.parentViewController.view)
        self.containerView.frame = embeddedFrame
        self.embeddedView?.frame = self.containerView.bounds
        
    }
    
}

extension SWBackDrop {
    
    mutating func insert(_ controller: UIViewController) {
        
        if let controller = self.embeddedViewController, let view = self.embeddedView {
            
            controller.willMove(toParent: nil)
            controller.removeFromParent()
            self.embeddedViewController = nil
            
            view.removeFromSuperview()
            self.embeddedView = nil
            
            isFocusedEmbeddedController = false
        }
        
        controller.willMove(toParent: self.parentViewController)
        self.parentViewController.addChild(controller)
        self.embeddedViewController = controller
        
        self.containerView.addSubview(controller.view)
        self.embeddedView = controller.view
        
        isFocusedEmbeddedController = true
    }
    
    mutating func removeController() {
        
        if let controller = self.embeddedViewController, let view = self.embeddedView {
            
            controller.willMove(toParent: nil)
            controller.removeFromParent()
            self.embeddedViewController = nil
            
            view.removeFromSuperview()
            self.embeddedView = nil
            
            isFocusedEmbeddedController = false
            
        }
    }
    
}

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
