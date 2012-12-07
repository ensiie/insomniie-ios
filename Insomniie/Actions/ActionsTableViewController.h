//
//  ActionsTableViewController.h
//  Insomniie
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ActionsTableViewController : UITableViewController <RKObjectLoaderDelegate>

@property (nonatomic, copy) NSString *city;

@end
