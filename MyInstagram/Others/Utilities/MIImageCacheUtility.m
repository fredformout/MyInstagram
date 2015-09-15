//
//  MIImageCacheUtility.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 14.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIImageCacheUtility.h"
#import "MIFileUtility.h"
#import "MIImagesDictionary.h"
#import "MIUniqueOperationsArray.h"

@interface MIImageCacheUtility ()

@property (nonatomic, strong) MIImagesDictionary *images;
@property (nonatomic, strong) MIUniqueOperationsArray *uniqueOperations;
@property (nonatomic, strong) NSOperationQueue *downloadImagesQueue;

@end

@implementation MIImageCacheUtility

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static MIImageCacheUtility *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [MIImageCacheUtility new];
    });
    
    return _sharedInstance;
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _images = [MIImagesDictionary new];
        _uniqueOperations = [MIUniqueOperationsArray new];
        _downloadImagesQueue = [NSOperationQueue new];
        _downloadImagesQueue.maxConcurrentOperationCount = 3;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCache)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Others

- (UIImage *)imageForURLString:(NSString *)urlString
{
    return [_images objectForKey:urlString];
}

- (void)addDownloadContentOperationWithURLString:(NSString *)urlString
                                        priority:(DownloadContentOperationPriority)priority
{
    @synchronized(_uniqueOperations)
    {
        if (urlString
            && ![urlString isEqualToString:@""]
            && ![_uniqueOperations containsObject:urlString])
        {
            [_uniqueOperations addObject:urlString];
        
            NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^
            {
                UIImage *image = [UIImage imageWithContentsOfFile:[MIFileUtility pathFromDocumentsForFilename:[MIFileUtility processedFilename:urlString]]];
                
                if (image)
                {
                    [_images setObject:image
                                forKey:urlString];
                }
                else
                {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    
                    if (data)
                    {
                        NSString *filename = [MIFileUtility processedFilename:urlString];
                        
                        [data writeToFile:[MIFileUtility pathFromDocumentsForFilename:filename]
                               atomically:YES];
                    
                        UIImage *image = [UIImage imageWithData:data];
                        
                        if (image)
                        {
                            [_images setObject:image
                                        forKey:urlString];
                        }
                    }
                }
                
                @synchronized(_uniqueOperations)
                {
                    [_uniqueOperations removeObject:urlString];
                }
            }];
            
            operation.queuePriority = (priority == DownloadContentOperationPriorityHigh) ? NSOperationQueuePriorityHigh : NSOperationQueuePriorityLow;
            
            [_downloadImagesQueue addOperation:operation];
        }
    }
}

- (void)cancelDownloadContentOperations
{
    [_downloadImagesQueue cancelAllOperations];
}

- (void)clearCache
{
    [_images removeAllObjects];
}

@end
