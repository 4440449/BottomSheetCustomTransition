//
//  OrderPresentAnimator.swift
//  TestCustomTransition
//
//  Created by Maxim on 23.07.2022.
//

import UIKit


//MARK: Present

final class OrderPresentAnimator: NSObject,
                                  UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let to = transitionContext.viewController(forKey: .to)?.view
        else { return }
        to.frame = to.frame.offsetBy(dx: 0,
                                     dy: to.frame.height)
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: [.curveEaseOut],
                       animations: {
            to.frame = to.frame.offsetBy(dx: 0,
                                         dy: -to.frame.height / 3)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}


//MARK: Dismiss

final class OrderDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from)?.view
        else { return }
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: [.curveEaseOut],
                       animations: {
            from.frame = from.frame.offsetBy(dx: 0,
                                             dy: from.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
