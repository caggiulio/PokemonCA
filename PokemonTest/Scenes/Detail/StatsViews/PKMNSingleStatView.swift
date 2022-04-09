//
//  PKMNSingleStatView.swift
//  PokemonTest
//
//  Created on 25/01/22.
//

import Foundation
import UIKit
import Anchorage

class PKMNSingleStatView: PKMNView {
    private let progressView: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 7
        view.trackTintColor = PKMNThemeManager.currentTheme().tertiaryColor
        view.progressTintColor = PKMNThemeManager.currentTheme().primaryColor
        
        view.layer.sublayers?[1].cornerRadius = 5
        view.subviews[1].clipsToBounds = true
        
        return view
    }()
    
    private var statNameLabel: UILabel = {
        var label = UILabel()
        LabelStyles.primaryLabel.apply(to: label)
        
        return label
    }()
    
    private var statValueLabel: UILabel = {
        var label = UILabel()
        LabelStyles.primaryLabel.apply(to: label)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(progressView)
        addSubview(statValueLabel)
        addSubview(statNameLabel)
    }
    
    private func configureConstraints() {
        progressView.leadingAnchor /==/ leadingAnchor + 15
        progressView.topAnchor /==/ topAnchor + 5
        progressView.heightAnchor /==/ 20
        progressView.trailingAnchor /==/ statValueLabel.leadingAnchor - 20
        
        statValueLabel.centerYAnchor /==/ progressView.centerYAnchor
        statValueLabel.bottomAnchor /==/ bottomAnchor - 5
        statValueLabel.trailingAnchor /==/ trailingAnchor
        
        statNameLabel.topAnchor /==/ progressView.bottomAnchor
        statNameLabel.leadingAnchor /==/ progressView.leadingAnchor
        statNameLabel.trailingAnchor /==/ trailingAnchor
        statNameLabel.bottomAnchor /==/ bottomAnchor
    }
    
    func configure(stat: Stat) {
        configureUI()
        configureConstraints()
        
        statNameLabel.text = stat.name
        statValueLabel.text = "\(stat.baseStat)"
        self.progressView.setProgress(stat.percentStat, animated: false)
    }
    
    func configureColors(colors: UIImage.Colors?) {
        let progressViewPreviousProgress = progressView.progress
        progressView.trackTintColor = colors?.primary
        progressView.progressTintColor = colors?.background
        /// Reset progress
        progressView.progress = 0
        /// Adds delay to allow a better visualization
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .curveEaseOut) {
                self.progressView.setProgress(progressViewPreviousProgress, animated: true)
            }
        }
    }
}
