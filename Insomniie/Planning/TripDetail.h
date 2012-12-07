//
//  Venue.h
//  Insomniie
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface TripDetail : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSNumber *venueLat;
@property (nonatomic, strong) NSNumber *venueLng;
@property (nonatomic, strong) NSString *venueID;
@property (nonatomic, strong) NSArray *venuePictures;

+ (RKObjectMapping *)mapping;

@end
