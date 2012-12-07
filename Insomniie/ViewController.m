//
//  ViewController.m
//  Insomniie
//
//  Created by Paul-Henri KOECK on 06/12/12.
//  Copyright (c) 2012 Paul-Henri KOECK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Interface

- (IBAction)planMyTripPressed:(UIButton *)sender
{
    if (!self.textFieldCity.text.length > 0) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Erreur"
                                           message:@"Veuillez entrer le nom d'une ville"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else {
        [self performSegueWithIdentifier:@"atvSegue" sender:self];
    }
}

#pragma mark - UIViewController lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setCity:)]) {
        [segue.destinationViewController performSelector:@selector(setCity:) withObject:self.textFieldCity.text];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textFieldCity becomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextFieldCity:nil];
    [super viewDidUnload];
}
@end
