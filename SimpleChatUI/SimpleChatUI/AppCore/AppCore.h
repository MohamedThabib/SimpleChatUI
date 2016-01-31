//
//  AppCore.h
//  SimpleChatUI
//
//  Created by Thabib on 31/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageDTO;

@interface AppCore : NSObject

@property (nonatomic, strong)NSMutableArray *array_ChatHistory;

@property (nonatomic, strong)NSMutableArray *array_ReceiverSentMessage;

+ (id)sharedAppCore;

- (void)loadChatMessages;

- (MessageDTO *)getRandomMessage;

@end
