//
//  ISDelegate.m
//  SupersoniceDemoApp
//
//  Created by Yotam Ohayon on 08/12/2015.
//  Copyright © 2015 supersonic. All rights reserved.
//

#import "ISDelegate.h"
#import <IronSource/IronSource.h>

@interface ISDelegate ()
@property (nonatomic, strong) ViewController *viewController;
@end

@implementation ISDelegate

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
#pragma mark SupersonicISDelegate Functions


- (void)interstitialDidLoad {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.showISButton setEnabled:YES];
        
        NSString *appendString = @"IronSource InterstitalDidLoad \n";
        self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
    });
    
}

-(void)interstitialDidShow {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource InterstitalDidShow \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
    
    
}
- (void)interstitialDidFailToLoadWithError:(NSError *)error {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.showISButton setEnabled:NO];
        
        NSString *appendString = @"IronSource InterstitalFailedToLoadWithError: \n";
        self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,error];
    });
}

-(void) interstitialDidFailToShowWithError:(NSError *)error{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource InterstitalDidFailToShowWithError: \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@",self.viewController.consoleOutPut.text, appendString,error];
    
    
}
- (void)interstitialDidOpen {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource InterstitalDidOpen \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}


- (void)didClickInterstitial {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource InterstitalDidClick \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
    
}

// This method get invoked after the Interstitial window had closed and control
// returns to your application.
- (void)interstitialDidClose {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSString *appendString = @"IronSource InterstitalDidClose \n";
    self.viewController.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.viewController.consoleOutPut.text, appendString];
}

@end
