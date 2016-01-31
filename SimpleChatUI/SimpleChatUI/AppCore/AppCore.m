//
//  AppCore.m
//  SimpleChatUI
//
//  Created by Thabib on 31/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import "AppCore.h"
#import "MessageDTO.h"

@implementation AppCore
@synthesize array_ChatHistory, array_ReceiverSentMessage;

#pragma Singleton Code

+(id)sharedAppCore
{
    return [self new];
}

- (id)init
{
    static AppCore *singletonInstance;
    
    static dispatch_once_t onceInstance;
    
    dispatch_once(&onceInstance, ^{
        singletonInstance = [super init];
        array_ChatHistory = [NSMutableArray new];
        array_ReceiverSentMessage = [NSMutableArray new];
    });
    
    return singletonInstance;
}

#pragma Mark - App initilization

- (void)loadChatMessages
{
    NSString *jsonFile  = [[NSBundle mainBundle]pathForResource:kJSON_FILENAME ofType:nil];
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:jsonFile];
    
    if (jsonData)
    {
        NSError *error = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
        
        if (!error)
        {
            //Loaded Chat History
            [self prepareMessageDataFromJson:jsonDictionary FromKey:kJSON_CHAT_MESSAGES];
            
            //Load Reciver Sending Data
            [self prepareMessageDataFromJson:jsonDictionary FromKey:kJSON_RECEIVER_Message];
        }
    }
}

- (void)prepareMessageDataFromJson:(NSDictionary *)dict_Messages FromKey:(NSString *)messageKey
{
    NSArray *chatHistory = [dict_Messages valueForKey:messageKey];
    
    for (NSDictionary *aMessage in chatHistory)
    {
        MessageDTO *message = [[MessageDTO alloc]initWithDictionary:aMessage];
        
        ([messageKey isEqualToString:kJSON_CHAT_MESSAGES]) ? [array_ChatHistory addObject:message] : [array_ReceiverSentMessage addObject:message];
    }
}


-(MessageDTO *)getRandomMessage
{
    if ([array_ReceiverSentMessage count] == 0)
        return nil;
    
    return [array_ReceiverSentMessage objectAtIndex: arc4random() % [array_ReceiverSentMessage count]];
}

@end
