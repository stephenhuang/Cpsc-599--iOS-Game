//
//  otherTrivaGenerator.m
//  trivaGen
//
//  Created by Robert Siry on 2013-11-16.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "otherTrivaGenerator.h"
NSMutableArray* questionNumberUsed;

@implementation otherTrivaGenerator

-(NSMutableArray*)createQuestion
{
    NSMutableArray *questionWithAnswers =  [[NSMutableArray alloc] init];
    
    srand(time(NULL));
    int whatQuestion = (rand() %24)+1;
    //whatQuestion=23;
    
    switch(whatQuestion)
    {
        case 1 :
            [questionWithAnswers addObject:@"What is the Capital of Canada?"];    //Question
            [questionWithAnswers addObject:@"Ottawa"];  //Answer
            [questionWithAnswers addObject:@"Toronto"];   //option 1
            [questionWithAnswers addObject:@"Calgary"];   //option 2
            [questionWithAnswers addObject:@"Saint John"]; ;  //option 3
            [questionWithAnswers addObject:@"Ottawa"]; ;  //Answer
            break;
        case 2 :
            [questionWithAnswers addObject:@"What is the most populated City in the world?"];    //Question
            [questionWithAnswers addObject:@"Shanghai"];  //Answer
            [questionWithAnswers addObject:@"Moscow"];   //option 1
            [questionWithAnswers addObject:@"Beijing"];   //option 2
            [questionWithAnswers addObject:@"Mumbai"]; ;  //option 3
            [questionWithAnswers addObject:@"Shanghai"]; ;  //Answer
            break;
        case 3 :
            [questionWithAnswers addObject:@"A collective of Crows is called what?"];    //Question
            [questionWithAnswers addObject:@"Murder"];  //Answer
            [questionWithAnswers addObject:@"Herd"];   //option 1
            [questionWithAnswers addObject:@"Drove"];   //option 2
            [questionWithAnswers addObject:@"Mob"]; ;  //option 3
            [questionWithAnswers addObject:@"Murder"]; ;  //Answer
            break;
        case 4 :
            [questionWithAnswers addObject:@"A collective of Dogs is called what?"];    //Question
            [questionWithAnswers addObject:@"Pack"];  //Answer
            [questionWithAnswers addObject:@"Team"];   //option 1
            [questionWithAnswers addObject:@"Swarm"];   //option 2
            [questionWithAnswers addObject:@"Mob"]; ;  //option 3
            [questionWithAnswers addObject:@"Pack"]; ;  //Answer
            break;
        case 5 :
            [questionWithAnswers addObject:@"A collective of Frogs is called what?"];    //Question
            [questionWithAnswers addObject:@"Army"];  //Answer
            [questionWithAnswers addObject:@"Skulk"];   //option 1
            [questionWithAnswers addObject:@"Flock"];   //option 2
            [questionWithAnswers addObject:@"Charm"]; ;  //option 3
            [questionWithAnswers addObject:@"Army"]; ;  //Answer
            break;
        case 6 :
            [questionWithAnswers addObject:@"What Famous Rapper was gunned down in Las Vegas in 1996"];    //Question
            [questionWithAnswers addObject:@"Tupac"];  //Answer
            [questionWithAnswers addObject:@"Biggie"];   //option 1
            [questionWithAnswers addObject:@"Tupac"];   //option 2
            [questionWithAnswers addObject:@"Eazy-e"]; ;  //option 3
            [questionWithAnswers addObject:@"Dr.Dre"]; ;
            break;
        case 7 :
            [questionWithAnswers addObject:@"Which of the following isn't an Ivy League School"];    //Question
            [questionWithAnswers addObject:@"UCLA"];  //Answer
            [questionWithAnswers addObject:@"Yale"];   //option 1
            [questionWithAnswers addObject:@"Dartmouth"];   //option 2
            [questionWithAnswers addObject:@"Brown"]; ;  //option 3
            [questionWithAnswers addObject:@"UCLA"]; ;  //Answer
            break;
        case 8 :
            [questionWithAnswers addObject:@"What famous Assassination lead to WW1?"];    //Question
            [questionWithAnswers addObject:@"Franz Ferdinand."];  //Answer
            [questionWithAnswers addObject:@"Lee Harvey Oswald."];   //option 1
            [questionWithAnswers addObject:@"John F. Kennedy."];   //option 2
            [questionWithAnswers addObject:@"Abraham Lincoln."]; ;  //option 3
            [questionWithAnswers addObject:@"Franz Ferdinand."]; ;  //Answer
            break;
        case 9 :
            [questionWithAnswers addObject:@"What comic hero is present in every episode of Seinfeld?"];    //Question
            [questionWithAnswers addObject:@"Superman"];  //Answer
            [questionWithAnswers addObject:@"Spiderman"];   //option 1
            [questionWithAnswers addObject:@"Aquaman"];   //option 2
            [questionWithAnswers addObject:@"Batman"]; ;  //option 3
            [questionWithAnswers addObject:@"Superman"];  //Answer
            break;
        case 10 :
            [questionWithAnswers addObject:@"Who cut Van Gogh's ear off?"];    //Question
            [questionWithAnswers addObject:@"Himself."];  //Answer
            [questionWithAnswers addObject:@"Himself."];   //option 1
            [questionWithAnswers addObject:@"His girlfriend."];   //option 2
            [questionWithAnswers addObject:@"His Father."]; ;  //option 3
            [questionWithAnswers addObject:@"His bestfriend."];  //Answer
            break;
        case 11 :
            [questionWithAnswers addObject:@"Who painted the Mona Lisa?"];    //Question
            [questionWithAnswers addObject:@"Da Vinci."];  //Answer
            [questionWithAnswers addObject:@"Da Vinci."];   //option 1
            [questionWithAnswers addObject:@"Van Gogh."];   //option 2
            [questionWithAnswers addObject:@"Boss Ross."]; ;  //option 3
            [questionWithAnswers addObject:@"Rembrandt."];
            break;
        case 12 :
            [questionWithAnswers addObject:@"What Spaceflight landed the first humans on the Moon?"];    //Question
            [questionWithAnswers addObject:@"Apollo 11"];  //Answer
            [questionWithAnswers addObject:@"Apollo 6"];   //option 1
            [questionWithAnswers addObject:@"Apollo 11"];   //option 2
            [questionWithAnswers addObject:@"Apollo 13"]; ;  //option 3
            [questionWithAnswers addObject:@"Apollo 12"];
            break;
        case 13 :
            [questionWithAnswers addObject:@"Which is the smallest ocean?"];    //Question
            [questionWithAnswers addObject:@"Artic"];  //Answer
            [questionWithAnswers addObject:@"Pacific"];   //option 1
            [questionWithAnswers addObject:@"Alantic"];   //option 2
            [questionWithAnswers addObject:@"Artic"]; ;  //option 3
            [questionWithAnswers addObject:@"Indian"];
            break;
        case 14 :
            [questionWithAnswers addObject:@"How many months have 31 days?"];    //Question
            [questionWithAnswers addObject:@"7"];  //Answer
            [questionWithAnswers addObject:@"4"];   //option 1
            [questionWithAnswers addObject:@"9"];   //option 2
            [questionWithAnswers addObject:@"4"]; ;  //option 3
            [questionWithAnswers addObject:@"7"];
            break;
        case 15 :
            [questionWithAnswers addObject:@"What temperature does water boil at?"];    //Question
            [questionWithAnswers addObject:@"100 C"];  //Answer
            [questionWithAnswers addObject:@"80 C"];   //option 1
            [questionWithAnswers addObject:@"100 C"];   //option 2
            [questionWithAnswers addObject:@"120 C"]; ;  //option 3
            [questionWithAnswers addObject:@"110 C"];
            break;
        case 16 :
            [questionWithAnswers addObject:@"How much does a litre of water weigh?"];    //Question
            [questionWithAnswers addObject:@"1kg"];  //Answer
            [questionWithAnswers addObject:@"2kg"];   //option 1
            [questionWithAnswers addObject:@".8kg"];   //option 2
            [questionWithAnswers addObject:@"1.4kg"]; ;  //option 3
            [questionWithAnswers addObject:@"1kg"];
            break;
        case 17 :
            [questionWithAnswers addObject:@"What is Canada's official summer sport?"];    //Question
            [questionWithAnswers addObject:@"Lacrosse"];  //Answer
            [questionWithAnswers addObject:@"BasketBall"];   //option 1
            [questionWithAnswers addObject:@"Hockey"];   //option 2
            [questionWithAnswers addObject:@"Tennis"]; ;  //option 3
            [questionWithAnswers addObject:@"Lacrosse"];
            break;
        case 18 :
            [questionWithAnswers addObject:@"What Religion celebrates Christmas?"];    //Question
            [questionWithAnswers addObject:@"Christianity"];  //Answer
            [questionWithAnswers addObject:@"Judaism"];   //option 1
            [questionWithAnswers addObject:@"Buddhism"];   //option 2
            [questionWithAnswers addObject:@"Islam"]; ;  //option 3
            [questionWithAnswers addObject:@"Christianity"];
            break;
        case 19 :
            [questionWithAnswers addObject:@"The Wategate scandal led to resignation of what US president?"];    //Question
            [questionWithAnswers addObject:@"Richard Nixon"];  //Answer
            [questionWithAnswers addObject:@"Ronald Reagan"];   //option 1
            [questionWithAnswers addObject:@"Bill Clinton"];   //option 2
            [questionWithAnswers addObject:@"Harry Truman"]; ;  //option 3
            [questionWithAnswers addObject:@"Richard Nixon"];
            break;
        case 20 :
            [questionWithAnswers addObject:@"What National Sports Leage is most popular in the US?"];    //Question
            [questionWithAnswers addObject:@"NFL"];  //Answer
            [questionWithAnswers addObject:@"NFL"];   //option 1
            [questionWithAnswers addObject:@"NBA"];   //option 2
            [questionWithAnswers addObject:@"MLB"]; ;  //option 3
            [questionWithAnswers addObject:@"NHL"];
            break;
        case 21 :
            [questionWithAnswers addObject:@"What National Sports Leage is most popular in the Canada?"];    //Question
            [questionWithAnswers addObject:@"NHL"];  //Answer
            [questionWithAnswers addObject:@"MLS"];   //option 1
            [questionWithAnswers addObject:@"NLL"];   //option 2
            [questionWithAnswers addObject:@"AHL"]; ;  //option 3
            [questionWithAnswers addObject:@"NHL"];
            break;
        case 22 :
            [questionWithAnswers addObject:@"A Sommelier is an expert in what?"];    //Question
            [questionWithAnswers addObject:@"Wine"];  //Answer
            [questionWithAnswers addObject:@"Beer"];   //option 1
            [questionWithAnswers addObject:@"Wine"];   //option 2
            [questionWithAnswers addObject:@"Scotch"]; ;  //option 3
            [questionWithAnswers addObject:@"Vodka"];
            break;
        case 23 :
            [questionWithAnswers addObject:@"The country to host the 2014 World Cup is?"];    //Question
            [questionWithAnswers addObject:@"Brazil"];  //Answer
            [questionWithAnswers addObject:@"Japan"];   //option 1
            [questionWithAnswers addObject:@"Spain"];   //option 2
            [questionWithAnswers addObject:@"Germany"]; ;  //option 3
            [questionWithAnswers addObject:@"Brazil"];
            break;
        case 24 :
            [questionWithAnswers addObject:@"The city to host the 2020 Summer Olympics is?"];    //Question
            [questionWithAnswers addObject:@"Tokyo"];  //Answer
            [questionWithAnswers addObject:@"Tokyo"];   //option 1
            [questionWithAnswers addObject:@"Madrid "];   //option 2
            [questionWithAnswers addObject:@"Istanbul "]; ;  //option 3
            [questionWithAnswers addObject:@"Rome"];
            break;
        default :
            printf("Invalid grade\n" );
    }
    
    return [self randomizeAnswers:questionWithAnswers];
}

-(NSMutableArray*)randomizeAnswers:(NSMutableArray*) question{
    
    for (int i=2; i<6; i++) {
        [question exchangeObjectAtIndex:i withObjectAtIndex:(rand()%3)+2];  //Replace i with any
    }
    return question;
}

@end
