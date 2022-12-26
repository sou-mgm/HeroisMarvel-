//
//  HeroTableViewCell.swift
//  MarvelHerois
//
//  Created by Matheus Matias on 26/12/22.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivThumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(with hero: Hero) {
        lbName.text = hero.name
        lbDescription.text = hero.description
        if let url = URL(string: hero.thumbnail.url){
            //Utilizando a dependencia KingFisher, a partir da URL, as imagens sao baixadas sem a necessidade de criar sessoes
            // Cria um active indicator enquanto a imagem carrega
            ivThumb.kf.indicatorType = .activity
            //carrega a imagem conforme o url
            ivThumb.kf.setImage(with: url)
            
        }else{
            ivThumb.image = nil
        }
        // Deixa a imagem redonda
        ivThumb.layer.cornerRadius = ivThumb.frame.size.height/2
        // Configura para que a borda fique vermelha
        ivThumb.layer.borderColor = UIColor.red.cgColor
        ivThumb.layer.borderWidth = 2
    }

}



