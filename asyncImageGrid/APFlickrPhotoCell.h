//
//  APFlickrPhotoCell.h
//  asyncImageGrid
//
//  Created by Anton Pauli on 19.09.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;
@interface APFlickrPhotoCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FlickrPhoto *photo;
@end
