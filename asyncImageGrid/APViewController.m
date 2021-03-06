//
//  APViewController.m
//  asyncImageGrid
//
//  Created by Anton Pauli on 19.09.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import "APViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "APFlickrPhotoCell.h"

@interface APViewController ()
@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic) int cellSize;
- (IBAction)cellSizeChanged:(id)sender;
@end

@implementation APViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.cellSize = 0;
	self.searches = [@[] mutableCopy];
    self.searchResults = [@{} mutableCopy];
    self.flickr = [[Flickr alloc] init];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
    [self.flickr searchFlickrForTerm:@"BMW" completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            // 2
            if(![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %d photos matching %@", [results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results; }
            // 3
            dispatch_async(dispatch_get_main_queue(), ^{
                // Placeholder: reload collectionview data
                [self.collectionView reloadData];
            });
        } else { // 1
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.searches count];
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APFlickrPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    cell.photo = self.searchResults[searchTerm][indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSString *searchTerm = self.searches[indexPath.section];
    //FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
    
    
    if(self.cellSize == 0){
        return CGSizeMake(118, 118);
    } else if(self.cellSize == 1){
        return CGSizeMake(236, 236);
    }
    

    CGSize retval = CGSizeMake(350, 350);
    //retval.height += 35;
    //retval.width += 35;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark – Interdace rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
//    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        CGRect newFrame = CGRectMake(0, 0, 1024, 768);
//        [self.collectionView setFrame:newFrame];
//    } else {
//        CGRect newFrame = CGRectMake(0, 0, 768, 1024);
//        [self.collectionView setFrame:newFrame];
//    }
}

- (IBAction)cellSizeChanged:(id)sender {
    UISegmentedControl *tempSegment = sender;
    self.cellSize = tempSegment.selectedSegmentIndex;
    [self.collectionView performBatchUpdates:nil completion:nil];
    
    NSLog(@"set new sell size to: %i", self.cellSize);
}
@end
