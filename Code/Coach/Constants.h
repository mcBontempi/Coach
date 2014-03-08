#ifndef Coach_Constants_h
#define Coach_Constants_h

typedef enum{
  EActivityTypeSwim,
  EActivityTypeBike,
  EActivityTypeRun,
  EActivityTypeStrengthAndConditioning,
  EActivityType8_stack_multi_station_small,
  EActivityTypeleg_extension_small
  , EActivityTypeabdominal_crunch_bench_small
  , EActivityTypeleg_press_small
  , EActivityTypeabdominal_small
  , EActivityTypemedicine_ball_small
  , EActivityTypeadjustable_bench_small
  , EActivityTypemulti_adjustable_bench_small
  , EActivityTypeadjustable_decline_bench_small
  , EActivityTypemultimode_rope_climber_small
  , EActivityTypearm_curl_small
  , EActivityTypeolympic_bar_small
  , EActivityTypeascent_trainer_small
  , EActivityTypepectoral_fly_small
  , EActivityTypeback_extension_small
  , EActivityTypepower_station_small
  , EActivityTypecalf_press_small
  , EActivityTypeprone_leg_curl_small
  , EActivityTypechest_press_small
  , EActivityTyperear_delt_fly_small
  , EActivityTypeconverging_chest_press_small
  , EActivityTyperecumbent_cycle_small
  , EActivityTypeconverging_shoulder_press_small
  , EActivityTyperotary_hip_small
  , EActivityTypedip_chin_assist_small
  , EActivityTyperotary_torso_small
  , EActivityTypediverging_lat_pulldown_small
  , EActivityTyperower_small
  , EActivityTypediverging_seated_row_small
  , EActivityTypeseated_dip_small
  , EActivityTypedumbbells_small
  , EActivityTypeseated_leg_curl_small
  , EActivityTypeelliptical_trainer_small
  , EActivityTypeseated_row_small
  , EActivityTypefunctional_trainer_small
  , EActivityTypeshoulder_press_small
  , EActivityTypehip_abductor_small
  , EActivityTypesmith_machine_small
  , EActivityTypehip_adductor_small
  , EActivityTypespinner_bike_small
  , EActivityTypehybrid_cycle_small
  , EActivityTypestepper_small
  , EActivityTypeindoor_cycle_small,
  EActivityTypetreadmill_small
  , EActivityTypekettlebells_small
  , EActivityTypetriceps_extension_small
  , EActivityTypelat_pull_small
  , EActivityTypeupright_cycle_small
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

#define KMENUITEM_NEWTIMETABLE @"New/Export"

#endif
