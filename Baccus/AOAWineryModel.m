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

@property (strong, nonatomic) NSArray *redWines;
@property (strong, nonatomic) NSArray *whiteWines;
@property (strong, nonatomic) NSArray *otherWines;

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

-(id) init {
    if (self = [super init]){
        AOAWineModel * vegaSicilia = [AOAWineModel wineWithName: @"VegaSicilia 2007"
                                                wineCompanyName: @"VegaSicilia"
                                                           type: @"Tinto"
                                                         origin: @"Ribera"
                                                         grapes: @[@"Garnacha"]
                                                 wineCompanyWeb: [NSURL URLWithString:@"http://www.vega-sicilia.com"]
                                                          notes: @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin id metus aliquet, facilisis tellus id, blandit sem. Sed suscipit arcu id mi sodales lobortis nec at tellus. Vivamus mollis pretium semper. Sed in pretium tellus, vitae imperdiet purus. Sed libero nisi, tincidunt nec lorem ac, ornare feugiat metus. Curabitur ante urna, facilisis non lacus id, condimentum dapibus nulla. Suspendisse a metus vulputate urna varius ultricies eget sed turpis. Praesent tortor tellus, tincidunt a turpis vitae, consectetur dignissim metus. Nunc blandit, libero ut efficitur sagittis, velit massa efficitur tellus, et efficitur purus arcu at odio. Proin vitae condimentum urna. Nam sollicitudin ultrices est at ornare. Praesent ut mauris nec risus vehicula dictum vitae ac felis. Donec nec luctus tellus. Proin congue enim ex. Aenean vulputate ipsum at mauris sollicitudin, vitae condimentum purus accumsan.Aenean facilisis nibh ac lorem pellentesque luctus. Praesent id ultricies tellus, eu placerat arcu. Duis vulputate leo sem, vel imperdiet purus tincidunt eu. Nulla facilisis vestibulum tortor, ac volutpat erat vestibulum non. Integer id diam nec nisl sagittis sollicitudin at ac augue. Nulla sit amet volutpat orci, in convallis elit. Vivamus ac blandit tellus. Curabitur vel auctor arcu, vitae aliquam eros. Vestibulum at congue lacus. Mauris posuere vitae est id placerat. Quisque sed ligula massa. Suspendisse potenti."
                                                         rating: 5
                                                          photo:[UIImage imageNamed:@"solaguen.png"]];
        AOAWineModel * pagoCarraovejas = [AOAWineModel wineWithName: @"Pago de Carraovejas Crianza 2013"
                                                    wineCompanyName: @"Pago Carraovejas"
                                                               type: @"Tinto"
                                                             origin: @"Ribera"
                                                             grapes: @[@"Tinto Fino", @"Sauvignon", @"Merlot"]
                                                     wineCompanyWeb: [NSURL URLWithString:@"http://www.pagodecarraovejas.com/"]
                                                              notes: @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin id metus aliquet, facilisis tellus id, blandit sem. Sed suscipit arcu id mi sodales lobortis nec at tellus. Vivamus mollis pretium semper. Sed in pretium tellus, vitae imperdiet purus."
                                                             rating: 5
                                                              photo:[UIImage imageNamed:@"carraovejas.jpg"]];
        AOAWineModel * solaguen = [AOAWineModel wineWithName: @"Solaguen Reserva"
                                             wineCompanyName: @"Solaguen"
                                                        type: @"Tinto"
                                                      origin: @"Rioja"
                                                      grapes: @[@"Tempranillo"]
                                              wineCompanyWeb: [NSURL URLWithString:@"http://www.solaguen.com"]
                                                       notes: @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin id metus aliquet, facilisis tellus id, blandit sem."
                                                      rating: 5
                                                       photo:[UIImage imageNamed:@"vegasici.jpg"]];
        
        self.redWines = @[vegaSicilia];
        self.whiteWines = @[pagoCarraovejas];
        self.otherWines = @[solaguen];

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


@end
