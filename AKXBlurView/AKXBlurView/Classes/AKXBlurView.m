//
//  AKXBlurView.m
//  AKXBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

#import "AKXBlurView.h"
#import "UIImage+ImageEffects.h"


@interface AKXBlurView ()

@property (nonatomic, weak) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

- (void)commonInit;
- (void)blurBackground;
- (void)onDisplayLink:(CADisplayLink *)displayLink;

@end


@implementation AKXBlurView

- (void)commonInit {
  self.backgroundColor = nil;
  self.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];

  self.queue = dispatch_queue_create("com.alexkolov.AKXBlurView.queue", DISPATCH_QUEUE_SERIAL);
  self.semaphore = dispatch_semaphore_create(1);

  self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
  self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:self.imageView];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self commonInit];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  if (newSuperview) {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
    displayLink.frameInterval = 2;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    self.displayLink = displayLink;
  }
  else {
    [self.displayLink invalidate];
  }
}

- (void)blurBackground {
  if (!self.parentView) {
    return;
  }

  if (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW) != 0) {
    return;
  }

  __block UIImage *snapshot;

  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.25f);
  CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -self.frame.origin.x, -self.frame.origin.y);
  [self.parentView drawViewHierarchyInRect:self.parentView.frame afterScreenUpdates:YES];
  snapshot = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  dispatch_async(self.queue, ^{
    snapshot = [snapshot applyBlurWithRadius:self.blurRadius
                                   tintColor:self.tintColor
                       saturationDeltaFactor:self.saturation
                                   maskImage:self.maskImage];

    dispatch_sync(dispatch_get_main_queue(), ^{
      self.imageView.image = snapshot;
      dispatch_semaphore_signal(self.semaphore);
    });
  });
}

- (void)onDisplayLink:(CADisplayLink *)displayLink {
  [self blurBackground];
}

@end
