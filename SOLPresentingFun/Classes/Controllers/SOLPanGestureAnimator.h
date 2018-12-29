//
//  SOLPanGestureAnimator.h
//  SOLPresentingFun
//
//  Created by smart on 2018/12/7.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVAnimatorProvider.h"
NS_ASSUME_NONNULL_BEGIN

@interface SOLPanGestureAnimator : UIPercentDrivenInteractiveTransition <UIViewControllerInteractiveTransitioningExtend>
- (instancetype)initWithView:(UIView *)view
             recognizerBlock:(void(^ __nullable)(void))block;
@property (nonatomic,getter=isPresenting) BOOL presenting;
@property (nonatomic,getter=isInteracting) BOOL interacting;
@end

NS_ASSUME_NONNULL_END
