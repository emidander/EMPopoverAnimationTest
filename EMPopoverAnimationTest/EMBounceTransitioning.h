//
//  EMBounceTransitioning.h
//  EMPopoverAnimationTest
//
//  Created by Erik Midander on 28/11/13.
//  Copyright (c) 2013 Erik Midander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBounceTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
- (id)initWithDirectionPresenting:(BOOL)presenting;
@end
