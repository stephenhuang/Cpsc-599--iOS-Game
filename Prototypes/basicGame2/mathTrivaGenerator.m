//
//  mathTrivaGenerator.m
//  trivaGen
//
//  Created by Robert Siry on 2013-11-08.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "mathTrivaGenerator.h"

@interface mathTrivaGenerator()

@end

@implementation mathTrivaGenerator

int answer,num1,num2,num3;

-(NSMutableArray*)createQuestion
{
    NSMutableArray *questionWithAnswers =  [[NSMutableArray alloc] init];
    
    srand(time(NULL));
    int operatorScale = (rand() %100)+1;
    
    if(operatorScale<=25)
    {
        //Addition
        num1 =((rand() %20)+1);
        num2 =(rand() %20)+1;
        num3 =(rand() %20)+1;
        answer = num1+num2+num3;
        
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i + %i + %i", num1,num2,num3]];    //Question
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (1+answer)]];  //option 1
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (answer - 1)]];  //option 2
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i",  (2+answer)]];  //option 3
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer
        
    }
    else if (operatorScale>25 && operatorScale<=50)
    {
        printf("Subtraction\n");
        //Subtraction
        num1 =((rand() %40)+1);
        num2 =(rand() %40)+1;
        answer = num1-num2;
        
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i - %i ", num1,num2]];    //Question
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (1+answer)]];  //option 1
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (answer - 1)]];  //option 2
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i",  (2+answer)]];  //option 3
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer

    }
    else if (operatorScale>50 && operatorScale<=80)
    {
        printf("Mult");
        //Multiplication
        num1 =((rand() %10)+1);
        num2 =(rand() %10)+1;
        answer = num1*num2;
        
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i x %i ", num1,num2]];    //Question
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (1+answer)]];  //option 1
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", (answer - 1)]];  //option 2
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i",  (2+answer)]];  //option 3
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%i", answer]];  //Answer
    }
    else
    {
        float fnum1,fnum2;
        float fanswer;
        printf("Divison");
        //Divison
        fnum1 =((rand() %60)+1);
        fnum2 =(rand() %10)+1;
        fanswer = fnum1/fnum2;
        
        [questionWithAnswers addObject:[NSString stringWithFormat:@"%.1f divided by %.1f ", fnum1,fnum2]];    //Question
        [questionWithAnswers addObject:[NSString stringWithFormat:@"~%.1f", fanswer]];  //Answer
        [questionWithAnswers addObject:[NSString stringWithFormat:@"~%.1f", (1.0+fanswer)]];  //option 1
        [questionWithAnswers addObject:[NSString stringWithFormat:@"~%.1f", (fanswer - 1)]];  //option 2
        [questionWithAnswers addObject:[NSString stringWithFormat:@"~%.1f",  (2+fanswer)]];  //option 3
        [questionWithAnswers addObject:[NSString stringWithFormat:@"~%.1f", fanswer]];  //Answer
    }
    
    return [self randomizeAnswers:questionWithAnswers];
}

-(NSMutableArray*)randomizeAnswers:(NSMutableArray*) question{

//    for (int i=2; i<6; i++) {
//        [question exchangeObjectAtIndex:i withObjectAtIndex:(rand()%3)+2];  //Replace i with any
//    }
    return question;
}

//Need to make sure random answers are not the same

@end
