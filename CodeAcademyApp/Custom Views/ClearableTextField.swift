import UIKit

typealias VoidCompletion = () -> Void

protocol ClearableTextFieldDelegate: AnyObject {
    func didTapClearIcon(_ icon: UIImageView)
}
class ClearableTextField: UITextField {

    private let TextInset: CGFloat = 10
    private let IconFrame = CGRect(x: .zero, y: .zero, width: 20, height: 10)

    weak var clearableTextFieldDelegate: ClearableTextFieldDelegate?
    var onDidTap: VoidCompletion?
    
    private var clearIconViewIsHidden = true {
        didSet {
            clearIconView.isHidden = clearIconViewIsHidden
        }
    }

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
        delegate = self
        rightViewMode = .whileEditing
        rightView = clearIconView
        backgroundColor = .white
    }

    @objc private func clearIconWasTapped() {
        text = nil
        clearableTextFieldDelegate?.didTapClearIcon(clearIconView)
        onDidTap?()
        textFieldDidBeginEditing(self)
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

extension ClearableTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {        
        guard let currentText = text else {
            clearIconViewIsHidden = true
            return }
        clearIconViewIsHidden = currentText.isEmpty
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        clearIconViewIsHidden = string.isEmpty
        return true
    }
}
