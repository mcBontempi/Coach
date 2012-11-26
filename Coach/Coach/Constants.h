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
