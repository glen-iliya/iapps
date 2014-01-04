//
//  getPharms.h
//  iapps
//
//  Created by iliya on 1/3/14.
//  Copyright (c) 2014 iliya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
//#import "NSObject+SBJSON.h"

@protocol getPharmsDelegate <NSObject>

-(void) getPharmsRequestSuccess:(NSArray*)arrayOfPharms;
-(void) getPharmsRequestFailure;

@end


@interface getPharms : NSObject

@property (nonatomic, strong)  ASIHTTPRequest *asiRequest;
@property (nonatomic, weak) id <getPharmsDelegate> delegate;

-(void) getPharmsRequest;


@end
