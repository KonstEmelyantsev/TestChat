//
//  TCMessagesViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 9/7/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCMessagesViewController.h"
#import "PTParseUser.h"
#import "PTParseHeader.h"

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#define		COLOR_OUTGOING						HEXCOLOR(0x007AFFFF)
#define		COLOR_INCOMING						HEXCOLOR(0xE6E5EAFF)

@interface TCMessagesViewController ()

{
    BOOL _isLoading;
    JSQMessagesBubbleImage *bubbleImageOutgoing;
    JSQMessagesBubbleImage *bubbleImageIncoming;
    JSQMessagesAvatarImage *avatarImageBlank;
}

@property (weak, nonatomic) UIView *blockView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation TCMessagesViewController

@synthesize messagesList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messagesList = [NSMutableArray new];
    
    self.senderId = [PTParseUser currentUser].objectId;
    self.senderDisplayName = [PTParseUser currentUser].username;
    
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    bubbleImageOutgoing = [bubbleFactory outgoingMessagesBubbleImageWithColor:COLOR_OUTGOING];
    bubbleImageIncoming = [bubbleFactory incomingMessagesBubbleImageWithColor:COLOR_INCOMING];

    self.inputToolbar.contentView.leftBarButtonItem.hidden = YES;
    
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressAccessoryButton:(UIButton *)sender {
    
}

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    [self showBlockView];
    [[PTParseManager sharedManager] sendMassage:text toUser:self.curUser success:^{
        [self finishSendingMessage];
        [self hideBlockView];
    } errorBlock:^(NSError *error) {
        [self hideBlockView];
    }];
}

#pragma mark - JSQMessages CollectionView DataSource


- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.messagesList[indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView
             messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self outgoing:self.messagesList[indexPath.item]]) {
        return bubbleImageOutgoing;
    }
    else
        return bubbleImageIncoming;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = self.messagesList[indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    else
        return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = self.messagesList[indexPath.item];
    if ([self incoming:message]) {
        if (indexPath.item > 0) {
            JSQMessage *previous = self.messagesList[indexPath.item-1];
            if ([previous.senderId isEqualToString:message.senderId]) {
                return nil;
            }
        }
        return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
    }
    else
        return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.messagesList count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self outgoing:self.messagesList[indexPath.item]]) {
        cell.textView.textColor = [UIColor whiteColor];
    } else {
        cell.textView.textColor = [UIColor blackColor];
    }
     
    return cell;
}

#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    else return 0;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = self.messagesList[indexPath.item];
    if ([self incoming:message]) {
        if (indexPath.item > 0) {
            JSQMessage *previous = self.messagesList[indexPath.item-1];
            if ([previous.senderId isEqualToString:message.senderId]) {
                return 0;
            }
        }
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    else return 0;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender {
    NSLog(@"didTapLoadEarlierMessagesButton");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = self.messagesList[indexPath.item];
    if ([self incoming:message]) {
        
    }
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = self.messagesList[indexPath.item];
    if (message.isMediaMessage) {
        
    }
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation {
    NSLog(@"didTapCellAtIndexPath %@", NSStringFromCGPoint(touchLocation));
}

#pragma mark - Helper methods

- (BOOL)incoming:(JSQMessage *)message {
    return ([message.senderId isEqualToString:self.senderId] == NO);
}

- (BOOL)outgoing:(JSQMessage *)message {
    return ([message.senderId isEqualToString:self.senderId] == YES);
}

- (void)refreshData {
    [self loadMessagesFor:self.curUser];
}

- (void)loadMessagesFor:(PTParseUser *)user {
    self.curUser = user;
    if (!_isLoading) {
        _isLoading = YES;
        [[PTParseManager sharedManager] fetchMessageListForUser:user success:^(NSArray *objects) {
            self.automaticallyScrollsToMostRecentMessage = NO;
            BOOL incoming = NO;
            if([self.messagesList count] != [objects count]) {
                [self.messagesList removeAllObjects];
                for (PFObject *object in objects ) {
                    JSQMessage *message = [self addMessage:object];
                    if ([self incoming:message]) incoming = YES;
                }
                if ([objects count] != 0) {
                    //if (incoming)
                        //[JSQSystemSoundPlayer jsq_playMessageReceivedSound];
                    [self finishReceivingMessage];
                    [self scrollToBottomAnimated:NO];
                }
            }
            self.automaticallyScrollsToMostRecentMessage = YES;
            _isLoading = NO;
        } errorBlock:^(NSError *error) {
            _isLoading = NO;
        }];
    }
}

- (void)finishReceivingMessage {
    [self finishReceivingMessageAnimated:YES];
}

- (void)finishReceivingMessageAnimated:(BOOL)animated {
    
    self.showTypingIndicator = NO;
    
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView reloadData];
    
    /*if (self.automaticallyScrollsToMostRecentMessage && ![self jsq_isMenuVisible]) {
        [self scrollToBottomAnimated:animated];
    }*/
}

- (JSQMessage *)addMessage:(PFObject *)object {

    PTParseUser *sender = (PTParseUser *)object[@"sender"];
    
    NSString *senderId = (NSString *)sender.objectId;
    NSString *username = ([[PTParseUser currentUser].objectId isEqualToString:senderId]) ? [PTParseUser currentUser].username : self.curUser.username;
    
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:username date:object.createdAt text:object[@"text"]];

    [self.messagesList addObject:message];

    return message;
}

- (void)finishSendingMessage {
    [self finishSendingMessageAnimated:YES];
}

- (void)finishSendingMessageAnimated:(BOOL)animated {
    
    UITextView *textView = self.inputToolbar.contentView.textView;
    textView.text = nil;
    [textView.undoManager removeAllActions];
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];

    [self.inputToolbar toggleSendButtonEnabled];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
    
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView reloadData];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        [self scrollToBottomAnimated:animated];
    }
}

#pragma mark blocking ui function

- (void)showBlockView {
    if(!self.blockView) {
        UIViewController *curVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        UIView *blockView = [[UIView alloc]initWithFrame:curVC.view.bounds];
        blockView.backgroundColor = [UIColor clearColor];
        UIActivityIndicatorView *aInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aInd.hidden = NO;
        aInd.center = blockView.center;
        
        [aInd setColor:[UIColor grayColor]];
        
        [blockView addSubview:aInd];
        [aInd startAnimating];
        
        self.blockView = blockView;
        self.blockView.alpha = 0;
        self.blockView.hidden = NO;
        
        [curVC.view addSubview:self.blockView];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.blockView.alpha = 1;
        }];
    }
    
}

- (void)hideBlockView {
    self.blockView.alpha = 0.1;
    [UIView animateWithDuration:0.3 animations:^{
        self.blockView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [self.blockView removeFromSuperview];
            self.blockView = nil;
        }
    }];
}

@end
