//
//  Trip.m
//  Insomniie
//
//  Created by Paul-Henri KOECK on 07/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import "Trip.h"

@implementation Trip

@synthesize id = _id;
@synthesize date = _date;
@synthesize city = _city;
@synthesize details = _details;

+ (RKObjectMapping *)mapping
{
    RKObjectMapping *tripMapping = [RKObjectMapping mappingForClass:[Trip class]];
    [tripMapping mapAttributes:@"id", @"date", @"city", nil];
    [tripMapping mapRelationship:@"details" withMapping:[TripDetail mapping]];
    
    return tripMapping;
}

@end
