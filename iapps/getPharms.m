//
//  getPharms.m
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import "getPharms.h"
#import "ASIFormDataRequest.h"

@implementation getPharms
@synthesize asiRequest, delegate;

-(void) getPharmsRequest{
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://card.apiary.io/getPharms"]];
  
    asiRequest = [ASIFormDataRequest requestWithURL:url];
    [asiRequest setRequestMethod:@"POST"];
    [asiRequest addRequestHeader:@"Content-Type" value:@"application/json"];
    [asiRequest setShouldAttemptPersistentConnection:NO];
    [asiRequest setDelegate:self];
    [asiRequest startAsynchronous];
    
}

-(void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"get pharms request started");
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"get pharms request finished");
    if (request.responseStatusCode<220){
        if([request responseString] && ![[request responseString] isEqualToString:@""]){
            NSString *tempString = [request responseString];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[tempString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            if  ([[[result objectForKey:@"success"]stringValue] isEqualToString:@"1"]){
                NSArray *pharms = [result objectForKey:@"pharms"];
                [self.delegate getPharmsRequestSuccess:pharms];
            }
            else{
                [self.delegate getPharmsRequestFailure];
            }
        }
    }
    

}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"get pharms request failed");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your network and try again"
                                                    message:nil delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];


}


-(void)dealloc{
    asiRequest.delegate = nil;
}

@end
