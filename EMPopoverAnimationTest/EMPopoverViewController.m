//
//  EMPopoverControllerViewController.m
//  EMPopoverAnimationTest
//
//  Created by Erik Midander on 28/11/13.
//  Copyright (c) 2013 Erik Midander. All rights reserved.
//

#import "EMPopoverViewController.h"
#import "EMFillWithTextView.h"

@interface EMPopoverViewController ()

@end

@implementation EMPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  EMFillWithTextView *fillView = [[EMFillWithTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
  fillView.message = @"Popover";
  fillView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:fillView];
}

@end
