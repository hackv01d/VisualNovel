//
//  WelcomeViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class WelcomeViewController: BaseViewController {
    
    private enum Constants {
            enum ContentView {
                static let ratioHeight: CGFloat = 0.38
            }
        
            enum PromptLabel {
                static let height: CGFloat = 50
                static let insetBottom: CGFloat = -25
            }
            
            enum UsernameTextField {
                static let ratioHeight: CGFloat = 0.23
                static let insetBottom: CGFloat = -37
                static let editModeInset: CGFloat = 20
            }
            
            enum ConfirmLabel {
                static let height: CGFloat = 50
                static let ratioInsetBottom: CGFloat = 0.67
            }
    }
    
    private var contentView = UIView()
    private let usernameTextField = UITextField()
    private let promptLabel = DialogueLabel(style: .prompt)
    private let confirmLabel = DialogueLabel(style: .prompt)
    
    private var usernameTextFieldBottomConstraint: Constraint?
    private var promptLabelKeyboardBottomConstraint: Constraint?
    
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
        viewModel.startGame(with: usernameTextField.text)
    }
    
    @objc
    private func keyboardWillHide() {
        promptLabelKeyboardBottomConstraint?.update(priority: .low)
        usernameTextFieldBottomConstraint?.update(offset: Constants.UsernameTextField.insetBottom)
        animate(with: .transitionCurlDown)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let lowerSpace = contentView.frame.height - confirmLabel.frame.minY - Constants.UsernameTextField.editModeInset
        let updatedOffset = lowerSpace - keyboardHeight
        
        promptLabelKeyboardBottomConstraint?.update(priority: .high)
        usernameTextFieldBottomConstraint?.update(offset: updatedOffset)
        animate(with: .transitionCurlUp)
    }
    
    private func animate(with option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 0.33, delay: 0,  options: [option]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setup() {
        setupContentView()
        setupConfirmLabel()
        setupUsernameTextField()
        setupPromptLabel()
        setupConfirmLabelTapGesture()
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.backgroundColor = .clear
        contentView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Constants.ContentView.ratioHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupConfirmLabel() {
        contentView.addSubview(confirmLabel)
        
        confirmLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.ConfirmLabel.height)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(Constants.ConfirmLabel.ratioInsetBottom)
        }
    }
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.font = .usernameText
        usernameTextField.leftPadding(17)
        usernameTextField.tintColor = .choiceLabel
        usernameTextField.textColor = .usernameText
        usernameTextField.placeholder = viewModel.placeholder
        usernameTextField.placeholderColor(.usernamePlaceholder)
        usernameTextField.backgroundColor = .usernameTextField
        usernameTextField.delegate = self

        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(contentView).multipliedBy(Constants.UsernameTextField.ratioHeight)
            make.leading.trailing.equalToSuperview()
            usernameTextFieldBottomConstraint = make.bottom.equalTo(confirmLabel.snp.top)
                                                           .offset(Constants.UsernameTextField.insetBottom)
                                                           .constraint
        }
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.PromptLabel.height)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top).priority(.medium)
            promptLabelKeyboardBottomConstraint = make.bottom.equalTo(usernameTextField.snp.top)
                                                             .offset(Constants.PromptLabel.insetBottom)
                                                             .priority(.low).constraint
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
        viewModel.didUpdateName = { [weak self] name in
            self?.usernameTextField.text = name
        }
        
        viewModel.didUpdateChoice = { [weak self] title in
            self?.confirmLabel.text = title
        }
        
        viewModel.didUpdatePrompt = { [weak self] textPrompt in
            self?.promptLabel.text = textPrompt
        }
    
        viewModel.didUpdateBackground = { [weak self] imageName in
            self?.setBackgroundImage(named: imageName)
        }
    }
}
