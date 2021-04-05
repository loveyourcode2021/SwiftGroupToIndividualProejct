//
//  PinnedViewController.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-03-07.
//

import UIKit
import CoreData

class PinnedViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var items:[FoodTruck]?
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(UITableViewCell.self, forCellWithReuseIdentifier: "pincell")
        users = fetchUsers(truck: items![0])
        
        nameLabel.text = items?[0].name
        contactLabel.text = items?[0].phoneNumber
        descLabel.text = items?[0].truckDescription
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout1()
    }
    func layout1() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.4)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
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
    
    func fetchUsers(truck: FoodTruck) -> [User] {
      let request: NSFetchRequest<User> = User.fetchRequest()
      
        request.predicate = NSPredicate(format: "foodtruck = %@", truck)

      var fetched: [User] = []
      
      do {
        fetched = try context.fetch(request)
      } catch {
        print("Error fetching users")
      }
      
      return fetched
    }
}

extension PinnedViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pincell", for: indexPath) as! PinCollectionCollectionViewCell
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        cell.dateLabel.text =  timestamp
        let user = users[indexPath.row]
        cell.comment.text = user.comment
        return cell
    }
    
    
}
