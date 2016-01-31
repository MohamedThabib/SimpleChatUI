//
//  MessageDTO.m
//  SimpleChatUI
//
//  Created by Thabib on 30/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import "MessageDTO.h"

@implementation MessageDTO

@synthesize senderID,senderName,senderTimeStamp,senderDPName,senderMessage;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    
    if (self)
    {
        dictionaryData = dict;
        
        self.senderID           = [self dataValueForKey:kJSON_SENDER_ID];
        self.senderName         = [self dataValueForKey:kJSON_SENDER_NAME];
        self.senderTimeStamp    = [self dataValueForKey:kJSON_SENDER_TIMESTAMP];
        self.senderDPName       = [self dataValueForKey:kJSON_SENDER_DPNAME];
        self.senderMessage      = [self dataValueForKey:kJSON_SENDER_MESSAGE];
    }
    
    return self;
}





- (NSString *)dataValueForKey:(NSString *)key
{
    if ([dictionaryData objectForKey:key] && ([dictionaryData objectForKey:key] != [NSNull null]))
    {
        return [NSString stringWithFormat:@"%@", [dictionaryData objectForKey:key]];
    }
    else
    {
        return @"";
    }
}

@end
