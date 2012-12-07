//
//  RootViewController.h
//  TESTTT
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) ModelController *modelController;
@property (strong, nonatomic) NSNumber *index;

@end
