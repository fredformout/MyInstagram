//
//  MIInstagramConstants.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

static NSString * const kInstagramClientID = @"23f4e1411e2e4d12a1268fa154d3600d";
static NSString * const kInstagramRedirectURI = @"myappfortest://";
static NSString * const kInstagramResponseType = @"token";
static NSString * const kInstagramScope = @"basic likes comments";
static NSString * const kInstagramAuthorizationURL = @"https://api.instagram.com/oauth/authorize/";
static NSString * const kInstagramBaseURL = @"https://api.instagram.com/v1/";
static NSString * const kInstagramKeychainStore = @"com.instagram";
static NSString * const kClientIDKey = @"client_id";
static NSString * const kRedirectURIKey = @"redirect_uri";
static NSString * const kResponseTypeKey = @"response_type";
static NSString * const kScopeKey = @"scope";
static NSString * const kAccessTokenKey = @"access_token";

static NSString * const kDataKey = @"data";
static NSString * const kCountKey = @"count";
static NSString * const kMaxIdKey = @"max_id";
static NSString * const kNextMaxIdKey = @"next_max_id";
static NSString * const kMaxLikeIdKey = @"max_like_id";
static NSString * const kNextMaxLikeIdKey = @"next_max_like_id";
static NSString * const kTextKey = @"text";
static NSString * const kPaginationKey = @"pagination";

static NSString * const kLowResolutionPhotoPattern = @"low_resolution_photo";
static NSString * const kStandardResolutionPhotoPattern = @"standard_resolution_photo";
static NSString * const kUserPhotoPattern = @"user_photo";
