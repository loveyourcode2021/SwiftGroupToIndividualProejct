//
//  AnnotationDetailViewController.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-04-03.
//

import UIKit

class AnnotationDetailViewController: UIViewController {
    var annotation:StreetFoodAnnotation!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items:[FoodTruck]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Something"
        contactLabel.text = "Something"
        urlLabel.text = "Something"
//        collectionView!.register(PinCollectionCollectionViewCell.nib(), forCellWithReuseIdentifier: "pincell")
        collectionView!.register(UITableViewCell.self, forCellWithReuseIdentifier: "pincell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout1()
    }

    
    func layout1() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 50
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 200
        layout.configuration = config
        
        
        return layout
    }
}

extension AnnotationDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 2
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pincell", for: indexPath) as! PinCollectionCollectionViewCell
        cell.comment.text = "blah blah"
        return cell
    }
    
    
}
