//
//  OrderTransitionDelegate.swift
//  TestCustomTransition
//
//  Created by Maxim on 22.07.2022.
//

import UIKit


final class OrderTransitionDelegate: NSObject,
                                     UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OrderPresentationViewController(presentedViewController: presented,
                                               presenting: presenting ?? source)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OrderPresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OrderDismissAnimator()
    }
    
}
