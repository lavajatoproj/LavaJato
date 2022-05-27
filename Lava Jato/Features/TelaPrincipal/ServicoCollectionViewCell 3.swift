//
//  ServicoCollectionViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 12/03/22.
//

import UIKit


class ServicoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var servicoImageView: UIImageView!
    @IBOutlet weak var nameServicoLabel: UILabel!
    
    // Populando a collection
    // Igualando a label e image view da cell com o icone e title do array
    func setup(with servico:Servico){
        servicoImageView.image = servico.image
        nameServicoLabel.text = servico.title
    }
}


