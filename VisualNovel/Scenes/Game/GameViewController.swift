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
//            static let spacing:
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
    
    private func createChoiceButton(with title: String, and tag: Int) -> UIButton {
        let button = UIButton()
//        butto
        button.backgroundColor = .black
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        return button
    }
    
    private func setup() {
        setupSuperView()
        setupPromptLabel()
        setupChoicesStackView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .systemIndigo
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.textColor = .white
        promptLabel.backgroundColor = .black
        promptLabel.textAlignment = .center
        promptLabel.font = .gamePrompt
        promptLabel.adjustsFontSizeToFitWidth = true
        
        promptLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.PromptLabel.height)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(300)
        }
    }
    
    private func setupChoicesStackView() {
        view.addSubview(choicesStackView)
        
        choicesStackView.axis = .vertical
        choicesStackView.spacing = 20
        
        for _ in 1...3 {
//            choicesStackView.addArrangedSubview()
        }
        
//        choicesStackView.arrangedSubviews[0].t
        
        choicesStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

}

private extension GameViewController {
    func bindViewModel() {
        viewModel.didUpdatePrompt = { [weak self] prompt in
            self?.promptLabel.text = prompt
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            print(title)
        }
    }
}
