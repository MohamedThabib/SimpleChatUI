//
//  ViewController.h
//  SimpleChatUI
//
//  Created by Thabib on 30/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    //App user UI Outlets
    IBOutlet UILabel *userTimeStamp;
    IBOutlet UILabel *userMessage;
    IBOutlet UIImageView *userDP;
    
    //Reciver UI Outlets
    IBOutlet UILabel *recieverTimeStamp;
    IBOutlet UILabel *recieverMessage;
    IBOutlet UILabel *recieverName;
    IBOutlet UIImageView *recieverDP;
    
    //Chat UI Outlets
    IBOutlet UITableView *tblChatMsg;
    IBOutlet UITextField *tfUserTextPlaceHolder;
    
    IBOutlet UIView *bgTextPlaceholder;
    IBOutlet NSLayoutConstraint *PlaceHolderViewBottomSpaceConstraint;
}

-(IBAction)sendActionPressed:(id)sender;

-(IBAction)receiverActionPressed:(id)sender;

@end

