//
//  APFlickrPhotoCell.m
//  asyncImageGrid
//
//  Created by Anton Pauli on 19.09.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import "APFlickrPhotoCell.h"
#import "FlickrPhoto.h"

@implementation APFlickrPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) setPhoto:(FlickrPhoto *)photo {
    
    if(_photo != photo) {
        _photo = photo;
    }
    self.imageView.image = _photo.thumbnail;
}

@end
