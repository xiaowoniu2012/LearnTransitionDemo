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

NS_ASSUME_NONNULL_BEGIN

@protocol UIViewControllerInteractiveTransitioningExtend <UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign, getter = isInteracting) BOOL interacting;

@end

@protocol UIViewControllerAnimatedTransitioningExtend <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign, getter = isAppearing) BOOL appearing;

@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioningExtend> interactor;
@end





@interface BVAnimatorProvider : NSObject <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic,assign) BOOL enable;
- (void)attachAnimator:(id<UIViewControllerAnimatedTransitioningExtend>)animator
               options:(BVAnimatorOption)options;
//- (void)attachInteractiveAnimator:(id<UIViewControllerInteractiveTransitioning>)animator
//                          options:(BVInteractorOption)options;
@end

NS_ASSUME_NONNULL_END
