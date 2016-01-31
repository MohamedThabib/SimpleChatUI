//
//  Utilities.m
//  SimpleChatUI
//
//  Created by Thabib on 30/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSString *)getCurrentTimeStamp
{
    NSDate *currentDateTime = [NSDate date];
    NSDateFormatter *dtFormater = [[NSDateFormatter alloc]init];
    [dtFormater setDateFormat:@"dd/MM/yyyy - hh:mm:ss a"];
    
    NSString *messageTimeStamp = [dtFormater stringFromDate:currentDateTime];
    
    return messageTimeStamp;
}

@end
