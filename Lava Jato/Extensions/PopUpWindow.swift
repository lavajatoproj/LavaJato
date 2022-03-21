//
//  PopUpWindow.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 16/03/22.
//

import Foundation
import UIKit

public class PopUpWindowView: UIView{
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    
    let BorderWidth: CGFloat = 1.0
    
    init(){
        super.init(frame: CGRect.zero)
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // Fundo do popup
        popupView.backgroundColor = UIColor.white
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
        popupView.layer.cornerRadius = 20.0
        
        // Titulo do popup
        popupTitle.textColor = UIColor.black
        popupTitle.backgroundColor = UIColor.white
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        popupTitle.numberOfLines = 0
        popupTitle.textAlignment = .center
        popupTitle.layer.cornerRadius = 20.0
        
        
        // Texto do popup
        popupText.textColor = UIColor.black
        popupText.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        popupText.numberOfLines = 0
        popupText.textAlignment = .center
        
        // Botão do popup
        popupButton.setTitleColor(UIColor.systemBlue, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        popupButton.backgroundColor = UIColor.white
        popupButton.layer.cornerRadius = 5.0
        popupButton.layer.borderWidth = 1.0
        popupButton.layer.borderColor = UIColor.lightGray.cgColor
        
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupText)
        popupView.addSubview(popupButton)
        
        //Adicionando o popupView no PopupWindowView com o fundo semi transparente
        addSubview(popupView)
        
        
        // PopupView constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 293),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // PopupTitle constraints
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
            popupTitle.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        
        // PopupText constraints
        popupText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupText.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            popupText.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            popupText.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
        ])
        
        
        // PopupButton constraints
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
        ])
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
