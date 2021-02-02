//
//  AlertView.swift
//  CodeAcademyApp
//
//  Created by Petras Janulevicius on 26/1/21.
//

import UIKit

typealias AlertDismissCompletion = (AlertView, UIButton) -> Void

@objc protocol AlertViewDelegate: class {
    @objc optional func didTapAgreeButton(alertView: AlertView, button: UIButton)
    @objc optional func didTapCancelButton(alertView: AlertView, button: UIButton)
}

final class AlertView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    private weak var delegate: AlertViewDelegate?
    private var dismissCompletion: AlertDismissCompletion?
    
    func configureView(
        title: String,
        message: String,
        cancelButtonTitle: String? = nil,
        agreeButtonTitle: String,
        delegate: AlertViewDelegate? = nil,
        completion: AlertDismissCompletion? = nil
    ) {
        titleLabel.text = title
        messageLabel.text = message
        agreeButton.setTitle(agreeButtonTitle, for: .normal)
        self.delegate = delegate
        dismissCompletion = completion
        
        if let cancelButtonTitle = cancelButtonTitle {
            cancelButton.setTitle(cancelButtonTitle, for: .normal)
        } else {
            cancelButton.isHidden = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.didTapCancelButton?(alertView: self, button: sender)
        dismissCompletion?(self, sender)
        removeFromSuperview()
    }
    
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        delegate?.didTapAgreeButton?(alertView: self, button: sender)
        dismissCompletion?(self, sender)
        removeFromSuperview()
    }
}
