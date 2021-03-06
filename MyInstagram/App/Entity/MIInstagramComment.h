//
//  MIInstagramComment.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MIInstagramComment : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *userPhotoURL;

@end
