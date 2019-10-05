//
//  AnimatorFactory.swift
//  Widgets
//
//  Created by Станислав Коцарь on 05/10/2019.
//  Copyright © 2019 Underplot ltd. All rights reserved.
//

import UIKit

class AnimatorFactory {
  
  static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
    let scale = UIViewPropertyAnimator(duration: 0.33,
      curve: .easeIn)
    scale.addAnimations {
      view.alpha = 1.0
    }
    scale.addAnimations({
      view.transform = CGAffineTransform.identity
    }, delayFactor: 0.33)
    scale.addCompletion {_ in
      print("ready")
    }
    return scale
  }
  
}
