//
//  EMFillWithTextView.m
//  EMPopoverAnimationTest
//
//  Created by Erik Midander on 01/12/13.
//  Copyright (c) 2013 Erik Midander. All rights reserved.
//

#import "EMFillWithTextView.h"

static inline float randomColorValue() {
  return (float)arc4random() / (float)RAND_MAX;
}

@implementation EMFillWithTextView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  NSString *text = [NSString stringWithFormat:@"%@ ", self.message];
  UIFont *font = [UIFont systemFontOfSize:16.0];
  CGSize textSize = [text sizeWithFont:font];
  
  CGFloat x = -textSize.width / 2.0;
  CGFloat y = -textSize.height / 2.0;
  while (y < rect.size.height + textSize.height) {
    UIColor *color = [UIColor colorWithRed:randomColorValue() green:randomColorValue() blue:randomColorValue() alpha:1.0];
    [color set];
    
    [text drawAtPoint:CGPointMake(x, y) withFont:font];
    x += textSize.width;
    if (x > rect.size.width) {
      x = x - rect.size.width - textSize.width;
      y = y + textSize.height;
    }
  }
}

@end
