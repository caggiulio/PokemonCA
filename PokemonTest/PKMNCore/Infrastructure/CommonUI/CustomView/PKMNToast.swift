//
//  PKMNToast.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation
import Anchorage

public class PKMNToast: UIView {
    private var color: UIColor
    private var text: String
    
    fileprivate let panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        return gestureRecognizer
    }()
    
    private var initialCenter: CGPoint = .zero
    
    /// Actions
    var dismiss: (() -> ())?
    
    private var background: UIView = {
        var view = UIView(frame: .zero)
        
        return view
    }()
    
    private var textLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    public init(frame: CGRect, color: UIColor, text: String) {
        self.color = color
        self.text = text
        
        super.init(frame: frame)
        /// Configure gesture
        self.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.addTarget(self, action: #selector(handleGestureDragging(_:)))
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func configureUI() {
        /// Adds blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = color.withAlphaComponent(0.95)
        blurEffectView.alpha = 0.85
        blurEffectView.frame = background.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        background.addSubview(blurEffectView)
        
        addSubview(background)
        addSubview(textLabel)
        textLabel.text = text
        LabelStyles.toastLabel.apply(to: textLabel)
    }
    
    func configureConstraints() {
        background.edgeAnchors /==/ edgeAnchors
        textLabel.edgeAnchors /==/ background.edgeAnchors
    }
    
    @objc dynamic func handleGestureDragging(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)

        switch gestureRecognizer.state {
            case .began:
                initialCenter = center
            
            case .changed:
            center = CGPoint(x: initialCenter.x, y: initialCenter.y + translation.y)
        
            case .ended, .cancelled:
            if abs(initialCenter.y + translation.y) > (bounds.height / 2) {
                dismiss?()
            }
            
            default:
                break
            }
    }
}

