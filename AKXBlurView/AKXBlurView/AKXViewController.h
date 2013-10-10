//
//  AKXViewController.h
//  AKXBlurView
//
//  Created by Alexander Kolov on 10/10/13.
//  Copyright (c) 2013 Alexander Kolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKXBlurView.h"

@interface AKXViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet AKXBlurView *blurView;

@end
