//
//  AKXBlurView.h
//  AKXBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKXBlurView : UIView

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, assign) CGFloat blurRadius;
@property (nonatomic, assign) CGFloat saturation;

@end
