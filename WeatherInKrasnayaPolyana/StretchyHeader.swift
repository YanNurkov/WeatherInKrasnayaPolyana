//
//  StretchyHeader.swift
//  WeatherInKrasnayaPolyana
//
//  Created by Ян Нурков on 20.09.2022.
//

import Foundation
import UIKit

final class StretchyTableHeaderView: UIView {
    
// MARK: - Elements
    
    public let imageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var conteinerView = UIView()
    private var conteinerViewHeight = NSLayoutConstraint()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Settings
    
    private func createViews() {
        addSubview(self.conteinerView)
        self.conteinerView.addSubview(self.imageView)
    }
    
    func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: self.conteinerView.widthAnchor),
            centerXAnchor.constraint(equalTo: self.conteinerView.centerXAnchor),
            heightAnchor.constraint(equalTo: self.conteinerView.heightAnchor)
        ])
        
        self.conteinerView.translatesAutoresizingMaskIntoConstraints = false
        self.conteinerView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor).isActive = true
        self.conteinerViewHeight = conteinerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        self.conteinerViewHeight.isActive = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageViewBottom = imageView.bottomAnchor.constraint(equalTo: self.conteinerView.bottomAnchor)
        self.imageViewBottom.isActive = true
        self.imageViewHeight = imageView.heightAnchor.constraint(equalTo: self.conteinerView.heightAnchor)
        self.imageViewHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        self.conteinerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        self.conteinerView.clipsToBounds = offsetY <= 0
        self.imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        self.imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
