//
//  UIViewController+BVAnimator.h
//  SOLPresentingFun
//
//  Created by smart on 2018/12/11.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVAnimatorProvider.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BVAnimator)
@property (nonatomic,strong) BVAnimatorProvider *bv_animatorProvider;
@end

NS_ASSUME_NONNULL_END
