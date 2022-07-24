//
//  MapViewController.swift
//  TestCustomTransition
//
//  Created by Maxim on 22.07.2022.
//

import UIKit


final class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(parkingButton)
        setupLayout()
    }

    private lazy var parkingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "p.circle"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(parkingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func parkingButtonTapped() {
        let transitionDelegate = OrderTransitionDelegate()
        let orderVC = OrderViewController(transitionDelegate: transitionDelegate,
                                          nibName: nil,
                                          bundle: nil)
        orderVC.modalPresentationStyle = .custom
        orderVC.transitioningDelegate = transitionDelegate
        self.present(orderVC, animated: true, completion: nil)
    }

    private func setupLayout() {
        parkingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parkingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        parkingButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        parkingButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }

}

