//
//  PresentTransition.swift
//  Widgets
//
//  Created by Станислав Коцарь on 04.11.2019.
//  Copyright © 2019 Underplot ltd. All rights reserved.
//

import UIKit

class PresentTransition:
  UIPercentDrivenInteractiveTransition,
  UIViewControllerAnimatedTransitioning {
  
  var context: UIViewControllerContextTransitioning?
  var animator: UIViewPropertyAnimator?
  
  var auxAnimations: (()-> Void)?
  
  func transitionDuration(using transitionContext:
    UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
  }

  func animateTransition(using transitionContext:
    UIViewControllerContextTransitioning) {
    transitionAnimator(using: transitionContext).startAnimation()
  }
  
  func transitionAnimator(using transitionContext:
    UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    let duration = transitionDuration(using: transitionContext)

    let container = transitionContext.containerView
    let to = transitionContext.view(forKey: .to)!

    container.addSubview(to)
    to.transform = CGAffineTransform(translationX: 0.0, y: 100)
    to.alpha = 0
    let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut)

    animator.addAnimations({
      
      to.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        .concatenating(CGAffineTransform(translationX: 0.0, y: 200.0))
      
    }, delayFactor: 0.15)

    animator.addAnimations({
      to.alpha = 1.0
    }, delayFactor: 0.5)
    
    animator.addCompletion { position in
      switch position {
      case .end:
        to.alpha = 1.0
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      default:
        transitionContext.completeTransition(true)
      }
    }
    
    if let auxAnimations = auxAnimations {
      animator.addAnimations(auxAnimations)
    }
    
    self.animator = animator
    self.context = transitionContext
    
    animator.addCompletion { [unowned self] _ in
      self.animator = nil
      self.context = nil
    }
    
    animator.isUserInteractionEnabled = true
    
    return animator
  }
  
  func interruptibleAnimator(using transitionContext:
    UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    return transitionAnimator(using: transitionContext)
  }
  
  func interruptTransition() {
    guard let context = context else {
      return
    }
    context.pauseInteractiveTransition()
    pause()
  }
}
