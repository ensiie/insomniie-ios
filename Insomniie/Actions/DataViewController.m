//
//  DataViewController.m
//  TESTTT
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import "DataViewController.h"
#import "TripDetail.h"
#import "MyLocation.h"

@interface DataViewController ()

@end

@implementation DataViewController

//@synthesize mapView = _mapView;
- (IBAction)galleryPressed:(id)sender
{
    FGalleryPhoto *networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushViewController:networkGallery animated:YES];
}

#pragma mark - FGalleryViewControllerDelegate Methods

- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    TripDetail *tripDetail = self.dataObject;
	return tripDetail.venuePictures.count;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    return nil;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    TripDetail *tripDetail = self.dataObject;
    NSString *url = [tripDetail.venuePictures objectAtIndex:index];
    NSLog(@"[%@ %@] ARRAY: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), tripDetail.venuePictures);
    NSLog(@"[%@ %@] URL: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), url);
    return url;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    TripDetail *tripDetail = self.dataObject;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [tripDetail.venueLat doubleValue];
    coordinate.longitude = [tripDetail.venueLng doubleValue];
    self.mapView.centerCoordinate = coordinate;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);
    [self.mapView setRegion:region animated:YES];
    MyLocation *annotation = [[MyLocation alloc] initWithName:tripDetail.venueName
                                                      address:tripDetail.category
                                                   coordinate:coordinate];
    [self.mapView addAnnotation:annotation];
    [self.mapView setSelectedAnnotations:[NSArray arrayWithObject:annotation]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TripDetail *tripDetail = self.dataObject;
    self.dataLabel.text = tripDetail.venueName;
}

@end
