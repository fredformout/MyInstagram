//
//  NSData+SaveData.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "NSData+SaveData.h"

@implementation NSData (SaveData)

- (void)saveDataInDocumentDirectoryPath:(NSString *)path
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, path];
    [self writeToFile:fullPath
           atomically:NO];
}

@end
