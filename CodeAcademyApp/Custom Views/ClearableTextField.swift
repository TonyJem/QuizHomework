//
//  ClearableTextField.swift
//  CodeAcademyApp
//
//  Created by Arnas Sleivys on 2021-02-01.
//

import UIKit

typealias VoidCompletion = () -> Void

protocol ClearableTextFieldDelegate: AnyObject {
    func didTapClearIcon(_ icon: UIImageView)
}

final class ClearableTextField: UITextField {

    private let TextInset: CGFloat = 10
    private let IconFrame = CGRect(x: .zero, y: .zero, width: 20, height: 10)

    weak var clearableTextFieldDelegate: ClearableTextFieldDelegate?
    var onDidTap: VoidCompletion?

    private lazy var clearIconView: UIImageView = {
        let clearIcon =  #imageLiteral(resourceName: "clear-icon").withTintColor(.placeholderText)
        let imageView = UIImageView(image: clearIcon)

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(clearIconWasTapped)
        )
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return imageView
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureView()
    }
}

// MARK: - Helpers

extension ClearableTextField {

    private func configureView() {
        rightViewMode = .whileEditing
        rightView = clearIconView
        backgroundColor = .white
    }

    @objc private func clearIconWasTapped() {
        text = nil
        clearableTextFieldDelegate?.didTapClearIcon(clearIconView)
        onDidTap?()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: .zero, left: TextInset, bottom: .zero, right: .zero)
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insets = UIEdgeInsets(top: .zero, left: TextInset, bottom: .zero, right: .zero)
        return bounds.inset(by: insets)
    }
}
