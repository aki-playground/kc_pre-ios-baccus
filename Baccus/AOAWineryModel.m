//
//  AOAWineryModel.m
//  Baccus
//
//  Created by Akixe on 8/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWineryModel.h"
#import "AOAWineModel.h"

@interface AOAWineryModel ()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation AOAWineryModel

#pragma mark - Properties

-(NSUInteger) redWineCount {
    return self.redWines.count;
}

-(NSUInteger) whiteWineCount {
    return self.whiteWines.count;
}

-(NSUInteger) otherWineCount {
    return self.otherWines.count;
}

-(id) init
{
    if (self = [super init]){
        
        //Cargar fichero de Cache
        NSData *data = [self loadDataFromFile];
        if (data == nil) {
            data = [self loadDataFromInet];
        }
        
        
        if (data != nil) {
            NSError * error;
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];
            
            if (JSONObjects != nil){

                for(NSDictionary *dict in JSONObjects){
                    AOAWineModel *wine = [[AOAWineModel alloc]initWithDictionary:dict];
                    if([wine.type isEqualToString:RED_WINE_KEY]){
                        if(!self.redWines){
                            self.redWines = [NSMutableArray arrayWithObject:wine];
                        } else {
                            [self.redWines addObject: wine];
                            
                        }
                    } else if ([wine.type isEqualToString:WHITE_WINE_KEY]){
                        if(!self.whiteWines){
                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                        } else {
                            [self.whiteWines addObject: wine];
                        }
                    } else {
                        if(!self.otherWines){
                            self.otherWines = [NSMutableArray arrayWithObject:wine];
                        } else {
                            [self.otherWines addObject: wine];
                        }
                        
                    }
                }
            } else {
                NSLog(@"Error al cargar JSON: %@", error.localizedDescription);
            }
        }
    }
    return self;
}

-(AOAWineModel *) redWineAtIndex: (int) index{
    return [self.redWines objectAtIndex: index];
}

-(AOAWineModel *) whiteWineAtIndex: (int) index{
    return [self.whiteWines objectAtIndex: index];
}

-(AOAWineModel *) otherWineAtIndex: (int) index{
    return [self.otherWines objectAtIndex: index];
}


#pragma mark - Util


-(NSData *) loadDataFromFile
{
    //ruta a fichero text.txt en carpeta cache de sandbox
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSURL *url = [[fm URLsForDirectory:NSCachesDirectory
                             inDomains:NSUserDomainMask] lastObject];
    
    url = [url URLByAppendingPathComponent:@"wines.json"];
    
    NSData *data =[NSData dataWithContentsOfURL: url];

    return data;
}



-(NSData *) loadDataFromInet
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://golang.bz/baccus/wines.json"]];
    
    NSURLResponse * response = [[NSURLResponse alloc] init];
    
    NSError * error;
    
    NSData * data = [NSURLConnection sendSynchronousRequest : request
                                          returningResponse : &response
                                                       error: &error];
    
    if (data != nil){
        
        //ruta a fichero text.txt en carpeta cache de sandbox
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSURL *url = [[fm URLsForDirectory:NSCachesDirectory
                                 inDomains:NSUserDomainMask] lastObject];
        
        url = [url URLByAppendingPathComponent:@"wines.json"];
        
        BOOL rc = NO;
        
        rc = [data writeToURL:url
                   atomically:YES];
    }
    return data;
}

@end
