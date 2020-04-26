//
//  ToastManager.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/24/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation
import UIKit

class ToastManager {
    //MARK: Properties
    static let shared = ToastManager()
    private var view: UIView = UIView()
    private var message: String = ""
    private var bottomConstraint: NSLayoutConstraint!
    private var toastViews: [ToastView?] = []
    
    //MARK: Methods
    private init() {}
    
    func showToast(message: String, view: UIView) {
        let toastView: ToastView? = ToastView()
        toastViews.forEach({hideToast(toastView: $0)})
        toastViews.append(toastView)
        self.view = view
        self.message = message
        createToastWithInitialPostition(toastView: toastView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.hideToast(toastView: toastView)
        }
    }
    
    private func createToastWithInitialPostition(toastView: ToastView?) {
        guard let toastView = toastView else { return }
        toastView.messageLabel.text = message
        toastView.layer.cornerRadius = 10
        toastView.layer.masksToBounds = true
        view.addSubview(toastView)
        let guide = view.safeAreaLayoutGuide
        toastView.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = toastView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 100)
        bottomConstraint.isActive = true
        toastView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        toastView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        toastView.heightAnchor.constraint(equalToConstant: toastView.toastHeight).isActive = true
        toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.layoutIfNeeded()
        animateToast()
    }
    
    private func animateToast() {
        if KeyboardStateManager.shared.isVisible {
            bottomConstraint.constant = -KeyboardStateManager.shared.keyboardOffset
        } else {
            bottomConstraint.constant = -20
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideToast(toastView: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            toastView?.alpha = 0
        }) { (_) in
            toastView?.removeFromSuperview()
        }
    }
}
