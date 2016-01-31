//
//  MessageDTO.h
//  SimpleChatUI
//
//  Created by Thabib on 30/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDTO : NSObject
{
    NSDictionary *dictionaryData;
}

@property (nonatomic, strong)NSString *senderID;
@property (nonatomic, strong)NSString *senderName;
@property (nonatomic, strong)NSString *senderMessage;
@property (nonatomic, strong)NSString *senderTimeStamp;
@property (nonatomic, strong)NSString *senderDPName;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSString *)dataValueForKey:(NSString *)key;


@end
