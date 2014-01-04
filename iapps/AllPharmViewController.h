//
//  AllPharmViewController.h
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePharmViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AllPharmViewController : UITableViewController<CLLocationManagerDelegate,UITextFieldDelegate>{
    NSArray* pharmsArray;
    NSMutableArray* filteredArray;
    SinglePharmViewController* singlePharmViewController;
    CLLocationManager *locationManager;
    UIBarButtonItem *rightNavigationButton;
    UIButton *buttonForRightNavigation;
    Boolean distanceIsOn;
    float numOfKm;
}

- (id)initWithStyle:(UITableViewStyle)style andPharms:(NSArray*)allPharms;

@end
