//
//  BVAnimatorProvider.h
//  SOLPresentingFun
//
//  Created by smart on 2018/12/11.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, BVAnimatorOption) {
    BVAnimatorOptionPresent = 1 << 0,
    BVAnimatorOptionDismisal = 1 << 1,
    BVAnimatorOptionPush = 1 << 2,
    BVAnimatorOptionPop = 1 << 3,

};

typedef NS_OPTIONS(NSUInteger, BVInteractorOption) {
    BVInteractorOptionPresent = 1 << 0,
    BVInteractorOptionDismisal = 1 << 1,
    BVInteractorOptionPush = 1 << 2,
    BVInteractorOptionPop = 1 << 3,
};
NS_ASSUME_NONNULL_BEGIN

@interface BVAnimatorProvider : NSObject <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
- (void)attachAnimator:(id<UIViewControllerAnimatedTransitioning>)animator
               options:(BVAnimatorOption)options;
- (void)attachInteractiveAnimator:(id<UIViewControllerInteractiveTransitioning>)animator
                          options:(BVInteractorOption)options;
@end

NS_ASSUME_NONNULL_END
