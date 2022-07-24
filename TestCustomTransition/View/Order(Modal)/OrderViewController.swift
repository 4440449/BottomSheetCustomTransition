//
//  OrderViewController.swift
//  TestCustomTransition
//
//  Created by Maxim on 22.07.2022.
//

import UIKit


final class OrderViewController: UIViewController {
    
    private let transitionDelegate: UIViewControllerTransitioningDelegate
    
    init(transitionDelegate: UIViewControllerTransitioningDelegate,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.transitionDelegate = transitionDelegate
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dismissButton)
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        setupLayout()
    }
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.down"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func dismissButtonTapped() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
