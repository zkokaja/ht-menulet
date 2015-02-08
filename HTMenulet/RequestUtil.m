//
//  RequestUtil.m
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import "RequestUtil.h"

@implementation RequestUtil

+(void) sendGet:(NSURL*)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
    [self sendAsyncRequest:request];
}

+(void) post:(NSURL*)url with:(NSData*)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    
    [self sendAsyncRequest:request];
}

+ (NSData*) get:(NSURL*)url
{
    NSURLResponse *response = [[NSURLResponse alloc] init];
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                    cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                timeoutInterval:0.1];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:NULL];
    return data;
}

+(void) sendAsyncRequest:(NSURLRequest*)request
{
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (data == nil || error != nil)
         {
             NSLog(@"failed %@", error);
         }
     }];
    
}


@end
