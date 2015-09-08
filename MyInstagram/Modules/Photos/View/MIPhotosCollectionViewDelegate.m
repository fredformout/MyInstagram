//
//  MIPopularPhotosCollectionViewDelegate.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosCollectionViewDelegate.h"

@interface MIPhotosCollectionViewDelegate ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation MIPhotosCollectionViewDelegate

#pragma mark - Initialization

- (instancetype)initWithData:(NSArray *)data
{
    self = [super init];
    
    if (self)
    {
        self.data = data;
    }
    
    return self;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_actionsHandler selectPost:_data[indexPath.row]];
}

@end
