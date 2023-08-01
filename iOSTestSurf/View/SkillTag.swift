//
//  SkillTag.swift
//  iOSTestSurf
//
//  Created by Андрей Цуркан on 01.08.2023.
//

import UIKit

class SkillTag: UIView {
    var skill: String = "" {
        didSet{
            label.text = skill
        }
    }
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1)
        layer.cornerRadius = 12
        addSubview(label)
        layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)])
    }
    
    func getWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 14)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (skill as NSString).size(withAttributes: fontAttributes)
        return size.width + 48
    }
}
