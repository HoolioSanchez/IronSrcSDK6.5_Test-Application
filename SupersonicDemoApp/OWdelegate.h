//
//  OWdelegate.h
//  SupersoniceDemoApp
//
//  Created by Yotam Ohayon on 08/12/2015.
//  Copyright © 2015 supersonic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IronSource/IronSource.h>
#import "ViewController.h"

@interface OWdelegate : UIViewController <ISOfferwallDelegate>

- (instancetype)initWithViewController:(ViewController *)viewController;

@end
