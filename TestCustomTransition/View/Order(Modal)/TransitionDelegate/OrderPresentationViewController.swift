//
//  OrderPresentationViewController.swift
//  TestCustomTransition
//
//  Created by Maxim on 23.07.2022.
//

import UIKit


final class OrderPresentationViewController: UIPresentationController {
    
    // MARK: dimmView
    
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(dimmViewTapGesture)
        view.addGestureRecognizer(dimmViewPanGesture)
        return view
    }()
    
    private lazy var dimmViewTapGesture = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dimmViewdidTap))
    private lazy var dimmViewPanGesture = UIPanGestureRecognizer(target: self,
                                                                 action: #selector(dimmViewdidPan))
    
    @objc private func dimmViewdidTap() {
        // Тап по карте - скрыть Bottom sheet до минимального значения (medium)
        // Как в Яндекс картах
        toMediumSheetAnimate()
    }
    
    @objc private func dimmViewdidPan(_ recognizer: UIPanGestureRecognizer) {
        // Свайп по карте - скрыть Bottom sheet до минимального значения (medium)
        // Как в Яндекс картах
        switch recognizer.state {
        case .began:
            toMediumSheetAnimate()
        default:
            return
        }
    }
    
    
    // MARK: UIPresentationController
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        let presentedViewSize = CGSize(width: container.bounds.width,
                                       height: container.bounds.height * 0.4)
        let presentedViewOrigin = CGPoint(x: container.bounds.minX,
                                          y: container.bounds.height - presentedViewSize.height)
        let rect = CGRect(origin: presentedViewOrigin,
                          size: presentedViewSize)
        return rect
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView,
              let presentedView = presentedView
        else { return }
        dimmView.frame = containerView.frame
        presentedView.frame = frameOfPresentedViewInContainerView
        presentedView.addGestureRecognizer(presentedViewPanGesture)
        containerView.addSubview(dimmView)
        containerView.addSubview(presentedView)
    }
    
    
    // MARK: PresentedView gesture
    
    private lazy var presentedViewPanGesture = UIPanGestureRecognizer(target: self,
                                                                      action: #selector(presentedViewDidPan) )
    
    private lazy var mediumSheetMinYPoint: CGFloat = {
        guard let superView = presentedViewController.view.superview else { return CGFloat(0) }
        let point = CGFloat(superView.frame.height - presentedViewController.view.frame.height / 3)
        return point
    }()
    
    private lazy var largeSheetMinYPoint: CGFloat = {
        guard let superView = presentedViewController.view.superview else { return CGFloat(0) }
        let point = CGFloat(superView.frame.height - presentedViewController.view.frame.height)
        return point
    }()
    
    private lazy var averageSheetMinYPoint: CGFloat = {
        let point = CGFloat((mediumSheetMinYPoint + largeSheetMinYPoint) / 2)
        return point
    }()
    
    @objc private func presentedViewDidPan(_ recognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else { return }
        let translation = recognizer.translation(in: presentedViewController.view.superview).y * 0.9
        let newPosition = presentedView.frame.offsetBy(dx: 0, dy: translation)
        // Ограничение перемещения BottomSheet размером в его максимальную высоту
        guard newPosition.minY > largeSheetMinYPoint else { return }
        presentedView.frame = newPosition
        recognizer.setTranslation(.zero, in: presentedView.superview)
        
        switch recognizer.state {
        case .ended:
            // Учитываю намерение пользователя через вычисление ожидаемого положения Вьюхи (умножаю координату смещения на коэффициент ускорения)
            let velocityCoeff = 1 + (recognizer.velocity(in: presentedViewController.view.superview).y / 1000)
            let projectedYLocation = newPosition.minY * velocityCoeff
            // Сравниваю ожидаемое положение Вьюхи с средней от двух состояний Вью (медиум / лардж)
            if projectedYLocation > averageSheetMinYPoint {
                toMediumSheetAnimate()
            } else {
                toLargeSheetAnimate()
            }
        default:
            break
        }
    }
    
    // didPanAnimations
    private func toLargeSheetAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [self] in
            presentedViewController.view.frame =
            CGRect(x: 0,
                   y: largeSheetMinYPoint,
                   width: (presentedViewController.view.frame.width),
                   height: (presentedViewController.view.frame.height))
        }, completion: nil)
    }
    
    private func toMediumSheetAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [self] in
            presentedViewController.view.frame =
            CGRect(x: 0,
                   y: mediumSheetMinYPoint,
                   width: (presentedViewController.view.frame.width),
                   height: (presentedViewController.view.frame.height))
        }, completion: nil)
    }
    
}
