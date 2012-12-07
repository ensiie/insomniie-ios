//
//  ActionsTableViewController.m
//  Insomniie
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import "ActionsTableViewController.h"
#import "ModelController.h"
#import "Trip.h"
#import "TripDetail.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface ActionsTableViewController ()
@property (nonatomic, strong) Trip *trip;
@property (nonatomic) BOOL shouldReload;
@end

@implementation ActionsTableViewController

#pragma mark - Properties

@synthesize city = _city;
@synthesize trip = _trip;

- (void)setCity:(NSString *)city
{
    _city = city;
    self.shouldReload = YES;
}

#pragma mark - UIViewController lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setModelController:)]) {
        [segue.destinationViewController performSelector:@selector(setModelController:) withObject:[[ModelController alloc] initWithArray:self.trip.details]];
    }
    if ([segue.destinationViewController respondsToSelector:@selector(setIndex:)]) {
         NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [segue.destinationViewController performSelector:@selector(setIndex:) withObject:[NSNumber numberWithInt:indexPath.section]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = self.city;
    if (self.shouldReload) {
        NSString *resourcePath = [NSString stringWithFormat:@"/journey?city=%@", self.city];
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath
                                                     objectMapping:[Trip mapping]
                                                          delegate:self];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Chargement...";
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[RKObjectManager sharedManager].client.requestQueue cancelAllRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*NSString *resourcePath = [NSString stringWithFormat:@"/journey?city=%@", self.city];
     [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath
     objectMapping:[Trip mapping]
     delegate:self];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - RKRequest Delegate

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"[%@ %@] RESPONSE:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [response bodyAsString]);
}

#pragma mark - RKObjectLoader Delegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    self.trip = object;
    self.shouldReload = NO;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.tableView reloadData];
    self.title = self.trip.city;
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"[%@ %@] ERROR", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.trip) {
        return self.trip.details.count;
    }
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.trip.details.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell"];
    
    TripDetail *tripDetail = [self.trip.details objectAtIndex:indexPath.section];

    // Text
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    cell.textLabel.text = tripDetail.venueName;
    cell.detailTextLabel.text = tripDetail.category;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TripDetail *tripDetail = [self.trip.details objectAtIndex:section];
    return tripDetail.time;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripDetail *tripDetail = [self.trip.details objectAtIndex:indexPath.section];

    NSString *cellText = tripDetail.venueName;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
