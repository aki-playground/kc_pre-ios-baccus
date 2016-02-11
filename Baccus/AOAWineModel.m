//
//  AOAWineModel.m
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWineModel.h"

@implementation AOAWineModel

#pragma mark - Class methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
             photo: (UIImage *) aPhoto {
    
    return [[self alloc ] initWithName: aName
                       wineCompanyName: aWineCompanyName
                                  type: aType
                                origin: anOrigin
                                grapes: arrayOfGrapes
                        wineCompanyWeb: aURL
                                 notes: aNotes
                                rating: aRating
                                 photo: aPhoto];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin {
    
    return [[self alloc ] initWithName: aName
                       wineCompanyName: aWineCompanyName
                                  type: aType
                                origin: anOrigin];
}


#pragma mark - Init


-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
             photo: (UIImage *) aPhoto{
    
    
    if ( self = [super init]){
        _name =  aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating= aRating;
        _photo= aPhoto;
    }
    return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin{
    
    return [self initWithName: aName
              wineCompanyName: aWineCompanyName
                         type: aType
                       origin: anOrigin
                       grapes: nil
               wineCompanyWeb: nil
                        notes: nil
                       rating: NO_RATING
                        photo: nil];
}
@end
