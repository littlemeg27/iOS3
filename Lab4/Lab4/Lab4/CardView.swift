//
//  CardView.swift
//  Lab4
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import UIKit

struct MemoryTile: Identifiable
{
    let id = UUID()
    let imageName: String
    var isFaceUp = false
    var isMatched = false
    
    init(imageName: String)
    {
        self.imageName = imageName
    }
}

class CardView: UIView
{

    private let iconImageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let backgroundView: UIView =
    {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 8
        return view
    }()
    
    var tile: MemoryTile?
    {
        didSet
        {
            updateView()
        }
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView()
    {
        addSubview(backgroundView)
        addSubview(iconImageView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor)
        ])
    }

    private func updateView()
    {
        guard let tile = tile else { return }
        
        iconImageView.isHidden = !(tile.isFaceUp || tile.isMatched)
        backgroundView.isHidden = tile.isFaceUp || tile.isMatched

        if let icon = UIImage(named: tile.imageName)
        {
            iconImageView.image = icon
        }
        else
        {
            iconImageView.image = nil // or set a default image
        }
    }
}
