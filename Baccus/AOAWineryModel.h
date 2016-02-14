//
//  AOAWineryModel.h
//  Baccus
//
//  Created by Akixe on 8/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOAWineModel.h"

#define RED_WINE_KEY @"Tinto"
#define WHITE_WINE_KEY @"Blanco"


@interface AOAWineryModel : NSObject


@property (readonly, nonatomic) NSUInteger redWineCount;
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger otherWineCount;


-(AOAWineModel *) redWineAtIndex: (int) index;
-(AOAWineModel *) whiteWineAtIndex: (int) index;
-(AOAWineModel *) otherWineAtIndex: (int) index;

@end
