//
//  Constants.h
//  Coach
//
//  Created by Daren Taylor on 19/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#ifndef Coach_Constants_h
#define Coach_Constants_h

typedef enum{
    EActivityTypeSwim,
    EActivityTypeBike,
    EActivityTypeRun,
    EActivityTypeStrengthAndConditioning,
    EActivityTypeBrick,
} TActivityType;


typedef enum{
    ETypeSprint,
    ETypeHalf,
    ETypeFull,
}TType;

typedef enum{
    EEffortEasy,
    EEffortIntermediate,
    EEffortCompetitive,
}TEffort;

#define maxHoursInAPlan 20

#define KMENUITEM_NEWTIMETABLE @"New Timetable" 

#endif
