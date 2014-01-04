//
//  AppDelegate.h
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getPharms.h"
#import "AllPharmViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,getPharmsDelegate>{
    getPharms* _getPharms;
    AllPharmViewController* allPharmViewController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) UINavigationController *navController;
@end
