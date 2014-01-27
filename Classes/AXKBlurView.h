//
//  AXKBlurView.h
//  AXKBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

@import UIKit;


@interface AXKBlurView : UIView

@property (nonatomic, strong, readonly) UIImageView *blurView;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, assign) CGFloat blurRadius;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) BOOL dynamic;

- (void)update;

@end
