//
//  MiProfileViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileViewController.h"

@interface MIProfileViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *fullnameLabel;

@end

@implementation MIProfileViewController

#pragma mark - Actions

- (IBAction)logoutAction
{
    [_actionsHandler logoutAction];
}

@end
