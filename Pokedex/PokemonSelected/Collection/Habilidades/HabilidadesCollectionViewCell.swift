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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesTableViewCell.identifier, for: indexPath) as? AbilitiesTableViewCell
        return cell ?? UITableViewCell()
    }
    
}
