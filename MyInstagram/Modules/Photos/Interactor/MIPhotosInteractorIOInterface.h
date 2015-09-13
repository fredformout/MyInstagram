//
//  MIPhotosInteractorInputInterface.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MIPhotosInteractorInputInterface <NSObject>

- (void)getNewPosts;
- (void)getMorePosts;
- (void)getPhotoByURLString:(NSString *)URLString
                 identifier:(NSString *)identifier;

@end

@protocol MIPhotosInteractorOutputInterface <NSObject>

- (void)addPosts:(NSArray *)posts
        lastPart:(BOOL)lastPart;
- (void)failAddPosts;
- (void)addNewPosts:(NSArray *)posts;
- (void)failAddNewPosts;
- (void)replaceAllPostsByPosts:(NSArray *)posts
                      lastPart:(BOOL)lastPart;
- (void)failReplaceAllPosts;

@end