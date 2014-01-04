//
//  SinglePharmViewController.h
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePharmViewController : UIViewController{
    NSDictionary *pharm;
    UIImage *imageToLoad;
}
@property (strong, nonatomic) IBOutlet UIImageView *pharmImageView;
@property (strong, nonatomic) IBOutlet UILabel *pharmName;
@property (strong, nonatomic) IBOutlet UILabel *pharmAddress;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
- (IBAction)callPhoneTapped:(id)sender;
- (IBAction)openMapTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *pharmNameText;
@property (strong, nonatomic) IBOutlet UILabel *pharmAddressText;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberText;
@property (strong, nonatomic) IBOutlet UITextView *extraDetailTextField;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil details:(NSDictionary*)currentPharm image:(UIImage*)currentImage;
@end
