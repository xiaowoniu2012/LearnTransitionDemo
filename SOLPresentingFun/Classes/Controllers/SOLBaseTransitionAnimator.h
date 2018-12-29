//
//  SOLBaseTransitionAnimator.h
//  PresentingFun
//
//  Created by Jesse Wolff on 10/31/13.
//  Copyright (c) 2013 Soleares, Inc. All rights reserved.
//

@import Foundation;

#import "BVAnimatorProvider.h"
@interface SOLBaseTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioningExtend>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;
@property (nonatomic, assign, getter = isInteracting) BOOL interacting;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioningExtend> interactor;

@end
