//
//  AXKBlurView.m
//  AXKBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

#import "AXKBlurView.h"
#import "UIImage+ImageEffects.h"

@interface AXKBlurView ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, weak) CADisplayLink *displayLink;

- (void)commonInit;
- (void)update;
- (void)onDisplayLink:(CADisplayLink *)displayLink;

@end

@implementation AXKBlurView

- (void)commonInit {
  self.backgroundColor = nil;
  self.frameInterval = 2;
  self.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f];

  self.queue = dispatch_queue_create("com.alexkolov.AXKBlurView.queue", DISPATCH_QUEUE_SERIAL);
  self.semaphore = dispatch_semaphore_create(1);

  self.blurView = [[UIImageView alloc] initWithFrame:self.bounds];
  self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:self.blurView];
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
    if (self.dynamic) {
      CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
      displayLink.frameInterval = self.frameInterval;
      [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

      self.displayLink = displayLink;
    }
  }
  else {
    [self.displayLink invalidate];
  }
}

- (void)update {
  if (!self.parentView) {
    return;
  }

  if (self.dynamic && dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW) != 0) {
    return;
  }

  __block UIImage *snapshot;

  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.25f);
  CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -self.frame.origin.x, -self.frame.origin.y);
  [self.parentView drawViewHierarchyInRect:self.parentView.frame afterScreenUpdates:NO];
  snapshot = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  if (self.dynamic) {
    dispatch_async(self.queue, ^{
      snapshot = [snapshot applyBlurWithRadius:self.blurRadius
                                     tintColor:self.tintColor
                         saturationDeltaFactor:self.saturation
                                     maskImage:self.maskImage];

      dispatch_sync(dispatch_get_main_queue(), ^{
        self.blurView.image = snapshot;
        dispatch_semaphore_signal(self.semaphore);
      });
    });
  }
  else {
    self.blurView.image = [snapshot applyBlurWithRadius:self.blurRadius
                                              tintColor:self.tintColor
                                  saturationDeltaFactor:self.saturation
                                              maskImage:self.maskImage];
  }
}

- (void)onDisplayLink:(CADisplayLink *)displayLink {
  [self update];
}

#pragma mark - Getters and Setters

- (void)setFrameInterval:(NSInteger)frameInterval {
  _frameInterval = frameInterval;
  self.displayLink.frameInterval = frameInterval;
}

@end
