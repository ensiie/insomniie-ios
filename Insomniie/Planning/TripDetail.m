//
//  Venue.m
//  Insomniie
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import "TripDetail.h"

@implementation TripDetail

@synthesize time = _time;
@synthesize category = _category;
@synthesize venueName = _venueName;
@synthesize venueLat = _venueLat;
@synthesize venueLng = _venueLng;
@synthesize venueID = _venueID;
@synthesize venuePictures = _venuePictures;

+ (RKObjectMapping *)mapping
{
    RKObjectMapping *tripDetailMapping = [RKObjectMapping mappingForClass:[TripDetail class]];
    [tripDetailMapping mapKeyPath:@"time" toAttribute:@"time"];
    [tripDetailMapping mapKeyPath:@"category" toAttribute:@"category"];
    [tripDetailMapping mapKeyPath:@"venue_name" toAttribute:@"venueName"];
    [tripDetailMapping mapKeyPath:@"venue_lat" toAttribute:@"venueLat"];
    [tripDetailMapping mapKeyPath:@"venue_lng" toAttribute:@"venueLng"];
    [tripDetailMapping mapKeyPath:@"venue_id" toAttribute:@"venueID"];
    [tripDetailMapping mapKeyPath:@"photos.url" toAttribute:@"venuePictures"];
    
    return tripDetailMapping;
}

@end
