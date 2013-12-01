//
//  EMViewController.m
//  EMPopoverAnimationTest
//
//  Created by Erik Midander on 28/11/13.
//  Copyright (c) 2013 Erik Midander. All rights reserved.
//

#import "EMViewController.h"
#import "EMPopoverViewController.h"
#import "EMBounceTransitioning.h"
#import "EMFillWithTextView.h"

@interface EMViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) UIPopoverController *popover;
@property (nonatomic) UIView *buttonBackground;
@end

@implementation EMViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  EMFillWithTextView *fillView = [[EMFillWithTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
  fillView.message = @"Test";
  fillView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:fillView];
  
  self.buttonBackground = [[UIView alloc] init];
  self.buttonBackground.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.buttonBackground];
  
  _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  _button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
  [_button setTitle:@"Pop!" forState:UIControlStateNormal];
  [self.buttonBackground addSubview:_button];
  
  [_button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated {
  self.buttonBackground.frame = CGRectMake(0.0, 0.0, 200.0, 200.0);
  self.buttonBackground.center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
  
  self.button.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
  self.button.center = CGPointMake(self.buttonBackground.bounds.size.width / 2.0, self.buttonBackground.bounds.size.height / 2.0);
}

- (void)buttonTouched {
  EMPopoverViewController *popoverViewController = [[EMPopoverViewController alloc] initWithNibName:nil bundle:nil];
  popoverViewController.transitioningDelegate = self;
  popoverViewController.modalPresentationStyle = UIModalPresentationCustom;
  [self presentViewController:popoverViewController animated:YES completion:^{
    ;
  }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  return [[EMBounceTransitioning alloc] initWithDirectionPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return [[EMBounceTransitioning alloc] initWithDirectionPresenting:NO];
}

- (void)dismissFakePopover {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
