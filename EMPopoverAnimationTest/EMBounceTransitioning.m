//
//  EMBounceTransitioning.m
//  EMPopoverAnimationTest
//
//  Created by Erik Midander on 28/11/13.
//  Copyright (c) 2013 Erik Midander. All rights reserved.
//

#import "EMBounceTransitioning.h"

#define kTransitionDuration 0.5

@interface EMBounceTransitioning ()
@property (nonatomic) BOOL presenting;
@end

@implementation EMBounceTransitioning 

- (id)initWithDirectionPresenting:(BOOL)presenting {
  if (self = [super init]) {
    self.presenting = presenting;
  }
  return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  if (self.presenting) {
    UIView *darkenView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, fromViewController.view.frame.size.width, fromViewController.view.frame.size.height)];
    darkenView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [darkenView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:fromViewController action:@selector(dismissFakePopover)]];
    
    [transitionContext.containerView addSubview:fromViewController.view];
    [transitionContext.containerView addSubview:darkenView];
    [transitionContext.containerView addSubview:toViewController.view];

    CGFloat popoverWidth = 200.0;
    CGFloat popoverHeight = 400.0;

    toViewController.view.frame = CGRectMake((fromViewController.view.frame.size.width - popoverWidth) / 2.0, (fromViewController.view.frame.size.height - popoverHeight) / 2.0, popoverWidth, popoverHeight);
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
      [transitionContext completeTransition:YES];
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
    [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [animation setDuration:kTransitionDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.5 :1.5 :1 :1]];
    [toViewController.view.layer addAnimation:animation forKey:nil];
    
    [CATransaction commit];
    
    [UIView animateWithDuration:0.2 animations:^{
      darkenView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    } completion:nil];
  } else {
    UIView *darkenView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, toViewController.view.frame.size.width, toViewController.view.frame.size.height)];
    darkenView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [transitionContext.containerView addSubview:toViewController.view];
    [transitionContext.containerView addSubview:darkenView];
    [transitionContext.containerView addSubview:fromViewController.view];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
      [transitionContext completeTransition:YES];
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
    [animation setDuration:kTransitionDuration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [fromViewController.view.layer addAnimation:animation forKey:nil];
    
    [CATransaction commit];

    [UIView animateWithDuration:0.2 animations:^{
      darkenView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    } completion:nil];

  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return kTransitionDuration;
}

- (void)hidePopup {
  
}

@end
