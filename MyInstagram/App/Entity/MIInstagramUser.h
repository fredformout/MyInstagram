//
//  MIInstagramUser.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MIInstagramUser : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *userPhotoURL;

@end
