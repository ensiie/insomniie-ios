//
//  DataViewController.h
//  TESTTT
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FGalleryViewController.h"

@interface DataViewController : UIViewController <FGalleryViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) id dataObject;

@end
