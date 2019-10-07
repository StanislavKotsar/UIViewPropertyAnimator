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
  
  static func jiggle(view: UIView) -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.33, delay: 0, animations: {
        UIView.animateKeyframes(withDuration: 1, delay: 0,
          animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.0,
              relativeDuration: 0.25) {
              view.transform = CGAffineTransform(rotationAngle: -.pi/8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25,
              relativeDuration: 0.75) {
              view.transform = CGAffineTransform(rotationAngle: +.pi/8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75,
              relativeDuration: 1.0) {
              view.transform = CGAffineTransform.identity
            }
          },
          completion: nil
        )
      },
      completion: {_ in
        view.transform = .identity
      }
    )
  }
  
  static func fade(in view: UIView, _ visible: Bool) {
    UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.5, delay: 0.1, options: .curveEaseOut,
      animations: {
        view.alpha = visible ? 1 : 0
      },
      completion: nil
    )
  }
  
}
