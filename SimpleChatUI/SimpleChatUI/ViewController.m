//
//  ViewController.m
//  SimpleChatUI
//
//  Created by Thabib on 30/01/16.
//  Copyright © 2016 Thabib. All rights reserved.
//

#import "ViewController.h"
#import "AppCore.h"
#import "MessageDTO.h"

@interface ViewController ()
{
    float rowHeight;
    NSMutableArray *array_tblDS;
}
@end

@implementation ViewController

#pragma mark - Life cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registerKeyboardNotification];
    array_tblDS = [NSMutableArray new];
    [[AppCore sharedAppCore] loadChatMessages];
    [array_tblDS addObjectsFromArray: [[AppCore sharedAppCore] array_ChatHistory]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotification];
}

#pragma mark - Keyboard Notification methods

-(void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)unregisterKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View DataSource & Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array_tblDS count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChatInterface" owner:self options:nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    MessageDTO *message = [array_tblDS objectAtIndex:indexPath.row];
    
    BOOL shouldShowDP = NO;
    
    {
        if (indexPath.row == 0)
        {
            shouldShowDP = YES;
        }
        else
        {
            MessageDTO *previousMessage = [array_tblDS objectAtIndex:indexPath.row - 1];
            
            shouldShowDP = [message.senderID isEqualToString:previousMessage.senderID] ? NO : YES;
        }
        
    }
    
    if ([message.senderID isEqualToString:kUSER_CHAT_ID])
    {
        cell = [topLevelObjects objectAtIndex:0];
        userMessage.text = message.senderMessage;
        [userMessage sizeToFit];
        rowHeight = userMessage.frame.size.height;
        userTimeStamp.text = message.senderTimeStamp;
        userDP.image = (shouldShowDP) ? [UIImage imageNamed:message.senderDPName] : nil;
        ;
    }
    else
    {
        cell = [topLevelObjects objectAtIndex:1];
        recieverMessage.text = message.senderMessage;
        [recieverMessage sizeToFit];
        rowHeight = recieverMessage.frame.size.height;
        recieverTimeStamp.text = message.senderTimeStamp;
        recieverDP.image = (shouldShowDP) ? [UIImage imageNamed:message.senderDPName] : nil;
        recieverName.text = (shouldShowDP) ? message.senderName : @"";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0 + rowHeight;
}

#pragma IBAction Methods

-(IBAction)sendActionPressed:(id)sender
{
    if (tfUserTextPlaceHolder.text.length > 0)
    {
        MessageDTO *currentMessage      = [MessageDTO new];
        currentMessage.senderID         = kUSER_CHAT_ID;
        currentMessage.senderMessage    = tfUserTextPlaceHolder.text;
        currentMessage.senderName       = kUSER_NAME;
        currentMessage.senderTimeStamp  = [Utilities getCurrentTimeStamp];
        currentMessage.senderDPName     = kUSER_DP_NAME;
        
        tfUserTextPlaceHolder.text = @"";
        
        [array_tblDS addObject:currentMessage];
        [tblChatMsg setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        [tblChatMsg reloadData];
        
       
    }
}

-(IBAction)receiverActionPressed:(id)sender
{
    MessageDTO *receiverMessage     = [[AppCore sharedAppCore] getRandomMessage];
    if (receiverMessage)
    {
        receiverMessage.senderTimeStamp  = [Utilities getCurrentTimeStamp];
        [array_tblDS addObject:receiverMessage];
        [tblChatMsg setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        [tblChatMsg reloadData];
    }
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [tblChatMsg setContentInset:UIEdgeInsetsZero];
    PlaceHolderViewBottomSpaceConstraint.constant = 0;
    return YES;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    
    PlaceHolderViewBottomSpaceConstraint.constant = keyboardEndFrame.size.height;
    
    
    [tblChatMsg setContentInset:UIEdgeInsetsMake(0.0, 0.0, keyboardEndFrame.size.height, 0.0)];
    
    [UIView commitAnimations];
}


@end
