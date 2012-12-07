//
//  Trip.h
//  Insomniie
//
//  Created by Paul-Henri KOECK on 07/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripDetail.h"

@interface Trip : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSArray *details;
@property (nonatomic, strong) NSString *city;

+ (RKObjectMapping *)mapping;

@end
