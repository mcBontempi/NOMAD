//
//  ItemDetailTableViewCell.m
//  NOMAD
//
//  Created by Daren taylor on 17/04/2014.
//  Copyright (c) 2014 NOMAD. All rights reserved.
//

#import "ItemDetailTableViewCell.h"

@implementation ItemDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
