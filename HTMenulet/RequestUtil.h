//
//  RequestUtil.h
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestUtil : NSObject

+ (NSData*)get:(NSURL*)url;
+ (void)sendGet:(NSURL*)url;

@end
