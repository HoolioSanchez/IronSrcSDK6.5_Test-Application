//
//  RVDelegate.m
//  SupersoniceDemoApp
//
//  Created by Yotam Ohayon on 08/12/2015.
//  Copyright © 2015 supersonic. All rights reserved.
//

#import "RVDelegate.h"

@interface RVDelegate ()
@property (nonatomic, strong) ViewController            *viewController;
@property (nonatomic, strong) ISPlacementInfo   *placementInfo;
@end

@implementation RVDelegate

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithViewController:(ViewController *)viewController {
    self = [super init];
    
    if (self) {
        _viewController = viewController;
    }
    
    return self;
}

#pragma mark -
#pragma mark SupersonicRVDelegate Functions


// This method lets you know whether or not there is a video
// ready to be presented. It is only after this method is invoked
// with 'hasAvailableAds' set to 'YES' that you can should 'showRV'.
- (void)rewardedVideoHasChangedAvailability:(BOOL)available {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.showRVButton setEnabled:available];
        
        if(available == YES){
            NSString *appendString = @"IronSource rewardedVideoHasChangedAvailability: True \n";
            self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
        }
        else{
            NSString *appendString = @"IronSource rewardedVideoHasChangedAvailability: False \n";
            self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
        }
        
    });
}

// This method gets invoked after the user has been rewarded.
- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.placementInfo = placementInfo;
    
    NSString *appendString = @"IronSource didReceiveRewardForPlacement \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,placementInfo];

}

// This method gets invoked when there is a problem playing the video.
// If it does happen, check out 'error' for more information and consult
// our knowledge center for help.
- (void)rewardedVideoDidFailToShowWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSString *appendString = @"IronSource rewardedVideoDidFailToShowWithError \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,error];
}

// This method gets invoked when we take control, but before
// the video has started playing.

- (void)rewardedVideoDidOpen {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSString *appendString = @"IronSource rewardedVideoDidOpen \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}

// This method gets invoked when we return controlback to your hands.
// We chose to notify you about rewards here and not in 'supersonicRVAdRewarded'.
// This is because reward can occur in the middle of the video.
- (void)rewardedVideoDidClose {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.placementInfo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Reward"
                                                        message:[NSString stringWithFormat:@"You have been rewarded %d \n%@", [self.placementInfo.rewardAmount intValue], self.placementInfo.rewardName]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        self.placementInfo = nil;
        
        NSString *appendString = @"IronSource rewardedVideoDidClose \n";
        self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
    }
}

// This method gets invoked when the video has started playing.
- (void)rewardedVideoDidStart {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource rewardedVideoDidStart\n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}

// This method gets invoked when the video has stopped playing.
- (void)rewardedVideoDidEnd {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource rewardedVideoDidEnd \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}

@end
