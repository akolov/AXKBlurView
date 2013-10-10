//
//  AKXViewController.m
//  AKXBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

#import "AKXViewController.h"


@interface AKXViewController () <UITableViewDataSource, UITableViewDelegate>

@end


@implementation AKXViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.blurView.blurRadius = 5.0f;
  self.blurView.saturation = 1.8f;
  self.blurView.tintColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
  self.blurView.parentView = self.tableView;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

#pragma mark - Gesture recognizer

- (IBAction)onGesture:(UIGestureRecognizer *)recognizer {
  if (recognizer.view == self.blurView) {
    self.blurView.hidden = YES;
  }
  else if (recognizer.view == self.tableView) {
    self.blurView.hidden = NO;
  }
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  NSString *imageName = [NSString stringWithFormat:@"%d.jpg", indexPath.row];

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  imageView.image = [UIImage imageNamed:imageName];

  cell.backgroundView = imageView;

  return cell;
}

@end