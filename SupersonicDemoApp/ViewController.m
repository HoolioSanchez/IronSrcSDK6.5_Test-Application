//
//  ViewController.m
//  SupersoniceDemoApp
//
//  Created by Yotam Ohayon on 08/12/2015.
//  Copyright © 2015 supersonic. All rights reserved.
//

#import "ViewController.h"
#import "RVDelegate.h"
#import "OWdelegate.h"
#import "ISDelegate.h"
#import <IronSource/IronSource.h>
#import <QuartzCore/QuartzCore.h>
#import <IronSource/ISIntegrationHelper.h>

#define USERID @"demoapp"
#define APPKEY @"437ae1ad"

@interface ViewController ()

@property (nonatomic, strong) id<ISRewardedVideoDelegate>  rvDelegate;
@property (nonatomic, strong) id<ISOfferwallDelegate>  owDelegate;
@property (nonatomic, strong) id<ISInterstitialDelegate>  isDelegate;
@property (nonatomic, weak) IBOutlet UILabel            *versionLabel;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (weak, nonatomic) IBOutlet UIButton *clicktoinit;
@property (strong, nonatomic) ISIntegrationHelper* validateIntegration;

@end

@implementation ViewController

#pragma mark -
#pragma mark Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // SDK version label change
    self.versionLabel.text = [NSString stringWithFormat:@"sdk version %@",
                              [IronSource sdkVersion]];
    
    //Buttons UI
    for (UIButton *button in @[self.showISButton, self.showOWButton, self.showRVButton]) {
        button.layer.cornerRadius = 10.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 3.5f;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    
    _clicktoinit.layer.cornerRadius = 10.0f;
    _clicktoinit.layer.masksToBounds = YES;
    _clicktoinit.layer.borderWidth = 3.5f;
    _clicktoinit.layer.borderColor = [[UIColor grayColor] CGColor];
    
    _loadingIS.layer.cornerRadius = 10.0f;
    _loadingIS.layer.masksToBounds = YES;
    _loadingIS.layer.borderWidth = 3.5f;
    _loadingIS.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //Default for Appkey
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *defAppKey = [_userDefaults stringForKey:@"APPKEY_DEFAULT"];
    
    if(defAppKey != nil){
        [_appKeyText setText:defAppKey];
    }
    
    //Setting Client side callback
    
    [ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = @(YES);
    
    //Supersonic tracking SDK
    [ISEventsReporting reportAppStarted];
    
}


// Scroll down the file to find out what happens when you click a button...

- (IBAction)initButton:(UIButton *)clicktoinit {
    
    
    // Before initializing any of our products (Rewarded video, Offerwall or Interstitial) you must set
    // their delegates. Take a look at these classes and you will see that they each implement a product
    // protocol. This is our way of letting you know what's going on, and if you don't set the delegates
    // we will not be able to communicate with you.
    // We're passing 'self' to our delegates because we want
    // to be able to enable/disable buttons to match ad availability.
    self.rvDelegate = [[RVDelegate alloc] initWithViewController:self];
    self.owDelegate = [[OWdelegate alloc] initWithViewController:self];
    self.isDelegate = [[ISDelegate alloc] initWithViewController:self];
    
    [IronSource setRewardedVideoDelegate:self.rvDelegate];
    [IronSource setOfferwallDelegate: self.owDelegate];
    [IronSource setInterstitialDelegate:self.isDelegate];
    
//Setting UserID
    NSString *userId = [IronSource advertiserId];
    
    if([userId length] == 0){
        //If we couldn't get the advertiser id, we will use a default one.
        userId = USERID;
    }
    
    NSString *appendString = @"UserID:\n";
    self.consoleOutPut.text = [NSString stringWithFormat:@"%@%@%@ \n",self.consoleOutPut.text, appendString,userId];
    
//Setting Appkey
    NSString *appKeyText = [_appKeyText text];
    [_userDefaults setObject:appKeyText forKey:@"APPKEY_DEFAULT"];
    [_userDefaults synchronize];
    
//Init all Adunits (two different methods)
    
    [IronSource initWithAppKey:appKeyText];
    //[IronSource initWithAppKey:appKeyText adUnits:@[IS_REWARDED_VIDEO, IS_INTERSTITIAL, IS_OFFERWALL]];
    
    //Integration Helper
    [ISIntegrationHelper validateIntegration];
    
    
}


//close keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -
#pragma mark Interface Handling

- (IBAction)showRVButtonTapped:(id)sender {
    
    // After calling 'setRVDelegate' and 'initRVWithAppKey:withUserId'
    // you are ready to present an ad. You can supply a placement
    // by calling 'showRVWithPlacementName', or you can simply
    // call 'showRV'. In this case the SDK will use the default
    // placement one created for you.

    [IronSource showRewardedVideoWithViewController:self];
    
}

- (IBAction)showOWButtonTapped:(id)sender {
    
    // This will present the Offerwall. Unlike Rewarded
    // Videos there are no placements.
    [IronSource showOfferwallWithViewController:self];
}

- (IBAction)showISButtonTapped:(id)sender {
    
    // This will present the Interstitial. Unlike Rewarded
    // Videos there are no placements.
    
    [IronSource showInterstitialWithViewController:self];
    
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)loadingIS:(id)sender {
    [IronSource loadInterstitial];
    
    NSString *appendString = @"IronSource loadInterstitial \n";
    self.consoleOutPut.text = [NSString stringWithFormat:@"%@%@",self.consoleOutPut.text, appendString];
}


@end
