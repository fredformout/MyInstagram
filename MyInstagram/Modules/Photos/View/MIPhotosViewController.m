//
//  MIPopularPhotosViewController.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosViewController.h"
#import "MIPhotosCollectionViewDataSource.h"
#import "MIPhotosCollectionViewDelegate.h"
#import "Macro.h"

@interface MIPhotosViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) MIPhotosCollectionViewDataSource *dataSource;
@property (nonatomic, strong) MIPhotosCollectionViewDelegate *delegate;

@end

@implementation MIPhotosViewController

#pragma mark - Getters and Setters

- (void)setActionsHandler:(id<MIPhotosInterface>)actionsHandler
{
    _actionsHandler = actionsHandler;
    _delegate.actionsHandler = actionsHandler;
}

#pragma mark - NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _data = [NSMutableArray new];
    _dataSource = [[MIPhotosCollectionViewDataSource alloc] initWithData:_data];
    _delegate = [[MIPhotosCollectionViewDelegate alloc] initWithData:_data];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _collectionView.dataSource = _dataSource;
    _collectionView.delegate = _delegate;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat widthOfCollectionView = CGRectGetWidth(self.collectionView.frame);
    NSInteger columnsCount = IS_IPHONE_6P ? 3 : 2;
    
    CGFloat cellWidth = widthOfCollectionView / columnsCount;
    
    ((UICollectionViewFlowLayout*)_collectionView.collectionViewLayout).itemSize = CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - MIPopularPhotosInterface

- (void)appendData:(NSArray *)data
{
    [_data addObjectsFromArray:data];
}

- (void)reload
{
    [_collectionView reloadData];
}

#pragma mark - Others

- (void)setCollectionViewDataSource:(id<UICollectionViewDataSource>)dataSource
             collectionViewdelegate:(id<UICollectionViewDelegate>)delegate
{
    self.dataSource = dataSource;
    self.delegate = delegate;
}

@end
