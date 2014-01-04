//
//  AllPharmViewController.m
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "AllPharmViewController.h"

@interface AllPharmViewController ()

@end

@implementation AllPharmViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andPharms:(NSArray*)allPharms
{
    self = [super initWithStyle:style];
    if (self) {
        pharmsArray = [[NSArray alloc]initWithArray:allPharms];
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    filteredArray = [[NSMutableArray alloc]init];
    distanceIsOn = false;
    NSLog(@"all pharms view did load");
    buttonForRightNavigation = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [buttonForRightNavigation setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateNormal];
    [buttonForRightNavigation setTitle:@"Set Distance" forState:UIControlStateNormal];
    [buttonForRightNavigation setTitle:@"Set Distance" forState:UIControlStateHighlighted];
    buttonForRightNavigation.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15 ];
    buttonForRightNavigation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [buttonForRightNavigation addTarget:self action:@selector(setDistance) forControlEvents:UIControlEventTouchUpInside];
    buttonForRightNavigation.frame = CGRectMake(0, 0, 85, 33);
    buttonForRightNavigation.backgroundColor=[UIColor blackColor];
    //create a UIBarButtonItem with the button as a custom view
    rightNavigationButton = [[UIBarButtonItem alloc] initWithCustomView:buttonForRightNavigation];
    
    self.navigationItem.rightBarButtonItem = rightNavigationButton;

 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) setDistance{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Distance" message:@"Please enter # of Km" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", @"Turn Off", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        NSLog(@"Cancel");
    }
    if (buttonIndex ==1){
        NSLog(@"ok");
        filteredArray = [[NSMutableArray alloc]init];
        distanceIsOn = true;
        UITextField *temp = [actionSheet textFieldAtIndex:0];
        numOfKm = temp.text.floatValue;
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        
    }
    if (buttonIndex ==2){
        NSLog(@"turn off");
        distanceIsOn = false;
        numOfKm = 99999999;
        [self.tableView reloadData];

    }
        

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        [locationManager stopUpdatingLocation];
        NSString * lat = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
        NSString * lon = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
        NSLog(@"%@", lat);
        NSLog(@"%@", lon);
        CLLocation *tempLocation;
        for (int i=0;i<[pharmsArray count];i++){
            float lat= [[[pharmsArray objectAtIndex:i]objectForKey:@"latitude"]floatValue];
            float lon =[[[pharmsArray objectAtIndex:i]objectForKey:@"longtitude"]floatValue];
            tempLocation = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
            float distance =[currentLocation distanceFromLocation:tempLocation]/1000;
            NSLog(@"%f",distance);
            if (distance<numOfKm){
                [filteredArray addObject:[pharmsArray objectAtIndex:i]];
            }
        }
        [self.tableView reloadData];
        
    }
    else{
        NSLog(@"bad location");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (distanceIsOn){
        return [filteredArray count];
    }
    return [pharmsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString* urlString;
    if (!distanceIsOn){
        cell.textLabel.text = [[pharmsArray objectAtIndex:indexPath.row]objectForKey:@"name"];
        urlString = [[pharmsArray objectAtIndex:indexPath.row]objectForKey:@"photo"];
    }
    else{
        cell.textLabel.text = [[filteredArray objectAtIndex:indexPath.row]objectForKey:@"name"];
        urlString = [[filteredArray objectAtIndex:indexPath.row]objectForKey:@"photo"];
    }
    
    cell.imageView.image = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
    //it's better to cache it than reload it every time
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        UITableViewCell *blockCell = [tableView cellForRowAtIndexPath:indexPath];
        blockCell.imageView.image = image;
        [blockCell setNeedsLayout];
        });
    });

    

    return cell;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage* tempImage = [tableView cellForRowAtIndexPath:indexPath].imageView.image;
    if (!distanceIsOn)
        singlePharmViewController  = [[SinglePharmViewController alloc]initWithNibName:@"SinglePharmViewController" bundle:nil details:[pharmsArray objectAtIndex:indexPath.row] image:tempImage] ;
    else
        singlePharmViewController  = [[SinglePharmViewController alloc]initWithNibName:@"SinglePharmViewController" bundle:nil details:[filteredArray objectAtIndex:indexPath.row] image:tempImage] ;

    [self.navigationController pushViewController:singlePharmViewController animated:YES];
}
 


@end
