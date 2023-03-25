//
//  BaseViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 26.03.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func setBackgroundImage(named imageName: String) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
