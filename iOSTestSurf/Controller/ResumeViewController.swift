//
//  ViewController.swift
//  iOSTestSurf
//
//  Created by Андрей Цуркан on 01.08.2023.
//

import UIKit

class ResumeViewController: UIViewController {

    // MARK: - Types

    private enum Const {
        static let backgroundGrayColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1)
        static let primaryTextColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        static let secondaryTextColor = #colorLiteral(red: 0.5882352941, green: 0.5843137255, blue: 0.6078431373, alpha: 1)

        static let horizontalSpacing: CGFloat = 8
    }

    //MARK: - Private Properties
   private var skills: [String] = ["MCV","MVVM","UIKit", "WebView", "Realm", "GCD","ООП и SOLID"]

    private let scrollView = UIScrollView()
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Const.backgroundGrayColor
        return view
    }()

    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "myPhoto")
        view.layer.cornerRadius = 60
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Цуркан Андрей\nАндреевич"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Const.primaryTextColor
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Middle iOS-разработчик, опыт более 2-х лет"
        label.textColor = Const.secondaryTextColor
        return label
    }()
    private let locationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location")
        return image
    }()
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Const.secondaryTextColor
        label.text = "Краснодар"
        return label
    }()
    private let skillsBackgroundView = UIView()
    private let whiteBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let mySkillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = Const.primaryTextColor
        label.text = "Мои навыки"
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Edit"), for: .normal)
        button.addTarget(self, action: #selector(actionEditButton), for: .touchUpInside)
        return button
    }()
    
    private let skillStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = Const.primaryTextColor
        label.text = "О себе"
        return label    }()
    
    private let aboutMeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = Const.primaryTextColor
        label.numberOfLines = 2
        label.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        return label
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.backgroundGrayColor

        setupViews()
        setConstraints()
        fillSkills()
    }
    
    //MARK: - Private methods

    private func setupViews() {
        title = "Профиль"
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(whiteBackground)
        contentView.addSubview(skillsBackgroundView)
        contentView.addSubview(mySkillsLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(skillStackView)
        contentView.addSubview(aboutMeLabel)
        contentView.addSubview(aboutMeInfoLabel)
        contentView.addSubview(locationImage)


    }
    
    private func fillSkills() {
        let width = UIScreen.main.bounds.width - 32
        var remainingHorizontalSpace: CGFloat = 0

        for skill in skills {
            let tag = SkillTag(frame: .zero)
            tag.skill = skill

            let tagWidth = tag.getWidth() + Const.horizontalSpacing

            if tagWidth > remainingHorizontalSpace {
                let previousStack = skillStackView.arrangedSubviews.last as? UIStackView
                let spacer = UIView()
                previousStack?.addArrangedSubview(spacer)
                let newStack = createHorizontalStack()
                newStack.addArrangedSubview(tag)
                remainingHorizontalSpace = width - tagWidth - Const.horizontalSpacing
                skillStackView.addArrangedSubview(newStack)
            } else if let previousStack = skillStackView.arrangedSubviews.last as? UIStackView {
                previousStack.addArrangedSubview(tag)
                remainingHorizontalSpace -= (tagWidth + Const.horizontalSpacing)
            }
        }
        let previousStack = skillStackView.arrangedSubviews.last as? UIStackView
        let spacer = UIView()
        previousStack?.addArrangedSubview(spacer)
    }

    private func createHorizontalStack() -> UIStackView {
        let view = UIStackView()
        view.spacing = Const.horizontalSpacing
        view.alignment = .leading

        return view
    }

    @objc private func actionEditButton() {
        editButton.setImage(UIImage(named: "change"), for: .normal)
    }
}

//MARK: - Constraints

extension ResumeViewController {
    
    private func setConstraints() {
        [scrollView, contentView, avatarImageView, nameLabel, descriptionLabel, cityLabel, skillsBackgroundView, mySkillsLabel,editButton, skillStackView, aboutMeLabel, aboutMeInfoLabel, whiteBackground, locationImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            locationImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            locationImage.rightAnchor.constraint(equalTo: cityLabel.leftAnchor),

            skillsBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            skillsBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            skillsBackgroundView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            skillsBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            mySkillsLabel.topAnchor.constraint(equalTo: skillsBackgroundView.topAnchor, constant: 20),
            mySkillsLabel.leftAnchor.constraint(equalTo: skillsBackgroundView.leftAnchor, constant: 15),
            
            editButton.topAnchor.constraint(equalTo: skillsBackgroundView.topAnchor, constant: 20),
            editButton.rightAnchor.constraint(equalTo: skillsBackgroundView.rightAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            skillStackView.topAnchor.constraint(equalTo: mySkillsLabel.bottomAnchor, constant: 10),
            skillStackView.leftAnchor.constraint(equalTo: skillsBackgroundView.leftAnchor, constant: 15),
            skillStackView.rightAnchor.constraint(equalTo: skillsBackgroundView.rightAnchor, constant: -15),
            
            aboutMeLabel.topAnchor.constraint(equalTo: skillStackView.bottomAnchor, constant: 20),
            aboutMeLabel.leftAnchor.constraint(equalTo: skillsBackgroundView.leftAnchor, constant: 15),
            aboutMeLabel.rightAnchor.constraint(equalTo: skillsBackgroundView.rightAnchor, constant: -15),
            
            aboutMeInfoLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 10),
            aboutMeInfoLabel.leftAnchor.constraint(equalTo: skillsBackgroundView.leftAnchor, constant: 15),
            aboutMeInfoLabel.rightAnchor.constraint(equalTo: skillsBackgroundView.rightAnchor, constant: -15),
            aboutMeInfoLabel.bottomAnchor.constraint(equalTo: skillsBackgroundView.bottomAnchor),

            whiteBackground.topAnchor.constraint(equalTo: skillsBackgroundView.topAnchor),
            whiteBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            whiteBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            whiteBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
