//
//  MIPopularPhotosDataSource.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosCollectionViewDataSource.h"
#import "MIPhotosCollectionViewCell.h"

static NSString *kPopularPhotosCollectionViewCellReuseIdentifier = @"PhotosCollectionViewCell";

@interface MIPhotosCollectionViewDataSource ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation MIPhotosCollectionViewDataSource

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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 18;//[_data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MIPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPopularPhotosCollectionViewCellReuseIdentifier
                                                                                        forIndexPath:indexPath];
    
//    NSObject *post = _data[indexPath.row];
//    
//    [cell configureCellWithPost:post];
    
    UIColor *color = nil;

    if (indexPath.row % 5 == 0)
    {
        color = [UIColor greenColor];
    }
    else if (indexPath.row % 4 == 0)
    {
        color = [UIColor blackColor];
    }
    else if (indexPath.row % 3 == 0)
    {
        color = [UIColor blueColor];
    }
    else if (indexPath.row % 2 == 0)
    {
        color = [UIColor redColor];
    }
    else
    {
        color = [UIColor yellowColor];
    }
    
    cell.backgroundColor = color;
    
    return cell;
}

@end
