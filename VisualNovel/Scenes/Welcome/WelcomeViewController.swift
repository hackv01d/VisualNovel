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
            enum PromptLabel {
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
    
    private let userNameTextField = UITextField()
    private let promptLabel = DialogueLabel(style: .prompt)
    private let confirmLabel = DialogueLabel(style: .prompt)
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
        viewModel.getSceneDetail()
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
    private func handleConfirmTap() {
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
        let lowerSpace = view.bounds.height - confirmLabel.frame.minY
        let updatedOffset = lowerSpace - keyboardHeight - Constants.UserNameTextField.editModeInset

        userNameTextFieldBottomConstraint?.update(offset: updatedOffset)
        animate(with: .transitionCurlUp)
    }
    
    private func animate(with option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 0.4, delay: 0,  options: [option]) {
            self.view.layoutIfNeeded()
        }
    }

    private func setup() {
        setupSuperView()
        setupConfirmLabel()
        setupUserNameTextField()
        setupPromptLabel()
        setupConfirmLabelTapGesture()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupConfirmLabel() {
        view.addSubview(confirmLabel)
        
        confirmLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.ConfirmButton.height)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.ConfirmButton.insetBottom)
        }
    }
    
    private func setupUserNameTextField() {
        view.addSubview(userNameTextField)
        
        userNameTextField.font = .userNameText
        userNameTextField.textColor = .userNameText
        userNameTextField.backgroundColor = .userNameTextField
        userNameTextField.placeholder = "Введите свое имя..."
        userNameTextField.delegate = self

        userNameTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.UserNameTextField.height)
            make.width.equalToSuperview()
            userNameTextFieldBottomConstraint = make.bottom.equalTo(confirmLabel.snp.top)
                                                            .offset(Constants.UserNameTextField.insetBottom)
                                                            .constraint
        }
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.PromptLabel.height)
            make.width.equalToSuperview()
            make.bottom.equalTo(userNameTextField.snp.top).offset(Constants.PromptLabel.insetBottom)
        }
    }
    
    private func setupConfirmLabelTapGesture() {
        let confirmTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleConfirmTap))
        confirmLabel.isUserInteractionEnabled = true
        confirmLabel.addGestureRecognizer(confirmTapGesture)
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
        viewModel.didUpdatePrompt = { [weak self] textPrompt in
            self?.promptLabel.text = textPrompt
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            self?.confirmLabel.text = title
        }
        
        viewModel.didUpdateName = { [weak self] name in
            self?.userNameTextField.text = name
        }
    }
}
