//
//  HabilidadesCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class HabilidadesCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var abilitiesTableView: UITableView!
    
    static let identifier: String = "HabilidadesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        abilitiesTableView.delegate = self
        abilitiesTableView.dataSource = self
        abilitiesTableView.register(AbilitiesTableViewCell.nib(), forCellReuseIdentifier: AbilitiesTableViewCell.identifier)
        initialConfig()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesTableViewCell.identifier, for: indexPath) as? AbilitiesTableViewCell
        cell?.contentView.layer.cornerRadius = 20
        cell?.contentView.layer.borderWidth = 1.5
        cell?.contentView.layer.borderColor = UIColor.black.cgColor
        return cell ?? UITableViewCell()
        
    }
    
    func initialConfig() {
        
        contentView.backgroundColor = .clear
        layer.masksToBounds = false
        abilitiesTableView.layer.borderColor = UIColor.black.cgColor
        abilitiesTableView.clipsToBounds = true
        }
}


