//
//  AOAWineModel.m
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWineModel.h"

@implementation AOAWineModel

@synthesize photo = _photo;
#pragma mark - Properties

-(UIImage *) photo
{
    //INtentamos cargar fichero desde Caches    
    //Si no hay fichero cargamos desde url
    //Guardamos fichero en cache

    _photo = [self loadImageFromCacheWithURL:self.photoURL];
    
    return _photo;
}

#pragma mark - Class methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoUrL: (NSURL *) aPhotoURL
{
    
    return [[self alloc ] initWithName: aName
                       wineCompanyName: aWineCompanyName
                                  type: aType
                                origin: anOrigin
                                grapes: arrayOfGrapes
                        wineCompanyWeb: aURL
                                 notes: aNotes
                                rating: aRating
                              photoURL: aPhotoURL];
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
          photoURL: (NSURL *) aPhotoURL
{
    if ( self = [super init]){
        _name =  aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating= aRating;
        _photoURL= aPhotoURL;
    }
    return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
{
    
    return [self initWithName: aName
              wineCompanyName: aWineCompanyName
                         type: aType
                       origin: anOrigin
                       grapes: nil
               wineCompanyWeb: nil
                        notes: nil
                       rating: NO_RATING
                     photoURL: nil];
}

#pragma mark - JSON

-(id) initWithDictionary:(NSDictionary *)aDictionary
{
    return [self initWithName:[aDictionary objectForKey:@"name"]
              wineCompanyName:[aDictionary objectForKey:@"wineCompanyName"]
                         type:[aDictionary objectForKey:@"type"]
                       origin:[aDictionary objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDictionary objectForKey:@"grapes"]]
               wineCompanyWeb:[aDictionary objectForKey:@"wineCompanyWeb"]
                        notes:[aDictionary objectForKey:@"notes"]
                       rating:[[aDictionary objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDictionary objectForKey:@"picture"]]];
}

-(NSDictionary *) proxyForJSON
{
    return @{@"name" : self.name,
             @"wineCompanyName" : self.wineCompanyName,
             @"type" : self.type,
             @"origin" : self.origin,
             @"grapes" : self.grapes,
             @"wineCompanyWeb" : self.wineCompanyWeb,
             @"notes" : self.notes,
             @"rating" : @(self.rating),
             @"photoURL" : [self.photoURL path]};
}

#pragma mark - Utils

-(NSArray *) extractGrapesFromJSONArray: (NSArray *)JSONArray
{
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for(NSDictionary *dict in JSONArray){
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
}

-(NSArray *) packGrapesIntoJSONArray
{
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for(NSString *grape in self.grapes){
        [jsonArray addObject:@{@"grape":grape}];
    }
    return jsonArray;
}


-(UIImage *) loadImageFromCacheWithURL: (NSURL *) aURL
{
    NSArray *pathComponents = [aURL pathComponents];
    NSString *fileName = [pathComponents lastObject];

    //ruta a fichero text.txt en carpeta cache de sandbox
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSURL *url = [[fm URLsForDirectory:NSCachesDirectory
                             inDomains:NSUserDomainMask] lastObject];
    
    url = [url URLByAppendingPathComponent:fileName];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = nil;
    if (data != nil){
        img = [[UIImage alloc] initWithData:data];
        return img;
    } else {
        NSData *imgData = [NSData dataWithContentsOfURL:self.photoURL];
        if ([imgData writeToURL:url atomically:true]){
            img = [[UIImage alloc]initWithData:imgData];
            return img;
        } else {
            return nil;
        }
        
    }
}
@end
