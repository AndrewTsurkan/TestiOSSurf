//
//  SkillsCollectionView.swift
//  iOSTestSurf
//
//  Created by Андрей Цуркан on 01.08.2023.
//

import UIKit

class SkillsCollectionView: UICollectionView {
    private let collectionLayout = UICollectionViewFlowLayout()
    var skillsArray: [String] = ["MCV","MVVM","UIKit", "WebView", "Realm", "GCD","ООП и SOLID"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        setupLayout()
        configure()
        setDalegate()
        register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: SkillCollectionViewCell.reusedId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumLineSpacing = 3
        
    }
    
    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        
    }
    
    private func setDalegate() {
        delegate = self
        dataSource = self
    }
}

//MARK: - UICollectionViewDataSource
extension SkillsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillCollectionViewCell.reusedId, for: indexPath) as? SkillCollectionViewCell else { return UICollectionViewCell() }
        let skill = skillsArray[indexPath.row]
        cell.skillsArray = skill
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SkillsCollectionView: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SkillsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let itemWidth = screenWidth / 5
        return CGSize.init(width: itemWidth, height: 50)
    }
}
