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

typedef enum{
    EZone1 = 1,
    EZone2 = 2,
    EZone3 = 4,
    EZone4 = 8,
    EZone5 = 16,
} TZone;

#define maxHoursInAPlan 20

#define KMENUITEM_NEWTIMETABLE @"New/Export" 

#endif
