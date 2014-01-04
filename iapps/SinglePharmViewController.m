//
//  SinglePharmViewController.m
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "SinglePharmViewController.h"
#import <MapKit/MapKit.h>

@interface SinglePharmViewController ()

@end

@implementation SinglePharmViewController
@synthesize pharmAddressText, pharmNameText, pharmImageView, phoneNumberText, extraDetailTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil details:(NSDictionary*)currentPharm image:(UIImage*)currentImage
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pharm = [[NSDictionary alloc]initWithDictionary:currentPharm];
        imageToLoad = currentImage;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"single pharm view did load");
    // Do any additional setup after loading the view from its nib.
    phoneNumberText.text = [pharm objectForKey:@"phone"];
    pharmAddressText.text = [pharm objectForKey:@"address"];
    pharmNameText.text = [pharm objectForKey:@"name"];
    extraDetailTextField.text = [pharm objectForKey:@"details"];
    pharmImageView.image = imageToLoad;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callPhoneTapped:(id)sender {
    NSString *stringToCall = [NSString stringWithFormat:@"tel://%@", phoneNumberText.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringToCall ]];
}

- (IBAction)openMapTapped:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:pharmAddressText.text
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode error: %@", error);
                         return;
                     }
                     NSLog(@"%@",pharmAddressText.text);
                     if(placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         MKPlacemark *place = [[MKPlacemark alloc] initWithPlacemark:placemark];
                         MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
                         [mapItem openInMapsWithLaunchOptions:nil];
                     }
                 }
     ];

}
@end
