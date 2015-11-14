//
//  AutoLayoutTableViewCell.h
//  AutoLayoutDemo
//
//  Created by coderyi on 15/6/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowcasesTableViewCell : UITableViewCell
@property UILabel *titleLabel;
@property UIImageView *logoImageView;
@property UILabel *descriptionLabel;

/**
 *  calulate tableView row height
 *
 *  @param title   showcases cell title
 *  @param descrip showcases cell description
 *
 *  @return tableView row height
 */
-(CGFloat)calulateHeightWithtTitle:(NSString*)title desrip:(NSString*)descrip;

@end
