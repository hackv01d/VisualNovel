//
//  WelcomeViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    private enum Constants {
            enum HeaderLabel {
                static let height: CGFloat = 50
                static let insetBottom: CGFloat = -50
            }
            
            enum UserNameTextField {
                static let height: CGFloat = 70
                static let insetBottom: CGFloat = -30
                static let editModeInset: CGFloat = 20
            }
            
            enum ConfirmButton {
                static let height: CGFloat = 50
                static let insetBottom: CGFloat = 150
            }
    }
    
    private let headerLabel = UILabel()
    private let userNameTextField = UITextField()
    private let confirmButton = UIButton(type: .system)
    private var userNameTextFieldBottomConstraint: Constraint?
    
    private var viewModel: WelcomeViewModelType
    
    init(with viewModel: WelcomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindViewModel()
        viewModel.getStageDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func handleConfirmButton() {
        viewModel.startGame(with: userNameTextField.text)
    }
    
    @objc
    private func keyboardWillHide() {
        userNameTextFieldBottomConstraint?.update(offset: Constants.UserNameTextField.insetBottom)
        animate(with: .transitionCurlDown)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let lowerSpace = view.bounds.height - confirmButton.frame.minY
        let updatedOffset = lowerSpace - keyboardHeight - Constants.UserNameTextField.editModeInset
        
        userNameTextFieldBottomConstraint?.update(offset: updatedOffset)
        animate(with: .transitionCurlUp)
    }
    
    private func animate(with option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 0.4, delay: 0,  options: [option]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func setup() {
        setupSuperView()
        setupConfirmButton()
        setupUserNameTextField()
        setupHeaderLabel()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupConfirmButton() {
        view.addSubview(confirmButton)
        
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        confirmButton.backgroundColor = .black
        confirmButton.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.ConfirmButton.height)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.ConfirmButton.insetBottom)
        }
    }
    
    private func setupUserNameTextField() {
        view.addSubview(userNameTextField)
        
        userNameTextField.placeholder = "Введите свое имя..."
        userNameTextField.font = UIFont.systemFont(ofSize: 20)
        userNameTextField.textColor = .black
        userNameTextField.backgroundColor = .green
        userNameTextField.delegate = self

        userNameTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.UserNameTextField.height)
            make.width.equalToSuperview()
            userNameTextFieldBottomConstraint = make.bottom.equalTo(confirmButton.snp.top)
                                                            .offset(Constants.UserNameTextField.insetBottom)
                                                            .constraint
        }
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 1
        headerLabel.backgroundColor = .black
        headerLabel.adjustsFontSizeToFitWidth = true
        
        headerLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.HeaderLabel.height)
            make.width.equalToSuperview()
            make.bottom.equalTo(userNameTextField.snp.top).offset(Constants.HeaderLabel.insetBottom)
        }
    }
}

extension WelcomeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.checkLengthValid(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension WelcomeViewController {
    func bindViewModel() {
        viewModel.didUpdateHeader = { [weak self] header in
            self?.headerLabel.text = header
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            self?.confirmButton.setTitle(title, for: .normal)
        }
        
        viewModel.didUpdateName = { [weak self] name in
            self?.userNameTextField.text = name
        }
    }
}
