//
//  OWdelegate.m
//  SupersoniceDemoApp
//
//  Created by Yotam Ohayon on 08/12/2015.
//  Copyright © 2015 supersonic. All rights reserved.
//

#import "OWdelegate.h"

@interface OWdelegate ()
@property (nonatomic, strong) ViewController *viewController;
@end

@implementation OWdelegate

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
#pragma mark SupersonicOWDelegate Methods

// This method gets invoked after a successful initialization of the Offerwall.
-(void)offerwallHasChangedAvailability:(BOOL)available{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.showOWButton setEnabled:YES];
        
        if(available == YES){
            NSString *appendString = @"IronSource offerwallHasChangedAvailability: True \n";
            self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
        }
        else{
            NSString *appendString = @"IronSource offerwallHasChangedAvailability: False \n";
            self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
        }
        
    });


}

- (void)offerwallDidShow {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource offerwallDidShow \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];

}


// This method gets invoked after a failed attempt to load the Offerwall.
// If it does happen, check out 'error' for more information and consult our
// Knowledge center.
- (void)offerwallDidFailToShowWithError:(NSError *)error {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSString *appendString = @"IronSource offerwallDidFailToShowWithError\n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,error];
}

// This method gets invoked after the user had clicked the little
// 'x' button at the top-right corner of the screen.
- (void)offerwallDidClose {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource offerwallDidClose \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}

// This method will be called each time the user has completed an offer.
// All relative information is stored in 'creditInfo' and it is
// specified in more detail in 'SupersonicOWDelegate.h'.
// If you return NO the credit for the last offer will be added to
// Everytime you return 'NO' we aggragate the credit and return it all
// at one time when you return 'YES'.
- (BOOL)didReceiveOfferwallCredits:(NSDictionary *)creditInfo {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource didReceiveOfferwallCredits: \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,creditInfo];
    return YES;
}

// This method get invoked when the ‘-getOWCredits’ fails to retrieve
// the user's credit balance info.
- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource didFailToReceiveOfferwallCreditsWithError \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,error];
}

@end
