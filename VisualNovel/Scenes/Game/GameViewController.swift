//
//  GameViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    private let promptLabel = UILabel()
    private let choicesStackView = UIStackView()
    
    private enum Constants {
        enum PromptLabel {
            static let height: CGFloat = 50
            static let insetBottom: CGFloat = 25
        }
        
        enum ChoicesStackView {
            static let spacing: CGFloat = 35
            static let marginTop: CGFloat = 35
            static let marginBottom: CGFloat = 17
            static let ratioHeight: CGFloat = 0.38
        }
    }

    private var viewModel: GameViewModelType
    
    init(with viewModel: GameViewModelType) {
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
    
    @objc
    private func handleChoiceTap(_ gesture: UITapGestureRecognizer) {
        viewModel.moveOn(for: gesture.view?.tag)
    }
    
    private func makeChoiceLabel(style: DialogueLabelStyle, text: String?, tag: Int) {
        let choiceLabel = DialogueLabel(style: style)
        choiceLabel.text = text
        choiceLabel.tag = tag
        
        let choiceTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleChoiceTap))
        choiceLabel.isUserInteractionEnabled = true
        choiceLabel.addGestureRecognizer(choiceTapGesture)
        
        choicesStackView.addArrangedSubview(choiceLabel)
    }
    
    private func setup() {
        setupSuperView()
        setupChoicesStackView()
        setupPromptLabel()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupChoicesStackView() {
        view.addSubview(choicesStackView)
        
        choicesStackView.axis = .vertical
        choicesStackView.backgroundColor = .clear
        choicesStackView.distribution = .fillEqually
        choicesStackView.isLayoutMarginsRelativeArrangement = true
        choicesStackView.spacing = Constants.ChoicesStackView.spacing
        choicesStackView.layoutMargins.top = Constants.ChoicesStackView.marginTop
        choicesStackView.layoutMargins.bottom = Constants.ChoicesStackView.marginBottom
        
        choicesStackView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Constants.ChoicesStackView.ratioHeight)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.textColor = .appText
        promptLabel.backgroundColor = .promptLabel
        promptLabel.textAlignment = .center
        promptLabel.font = .gamePrompt
        promptLabel.adjustsFontSizeToFitWidth = true
        
        promptLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.PromptLabel.height)
            make.width.equalToSuperview()
            make.bottom.equalTo(choicesStackView.snp.top)
        }
    }
}

private extension GameViewController {
    func bindViewModel() {
        viewModel.didUpdatePrompt = { [weak self] prompt in
            self?.promptLabel.text = prompt
        }
        
        viewModel.didUpdateChoice = { [weak self] style, text, tag in
            self?.makeChoiceLabel(style: style, text: text, tag: tag)
        }
    }
}
