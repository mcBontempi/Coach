
@implementation UIImage (ImageForActivityType)

+(UIImage *)imageForActivityType:(TActivityType)activityType{
   return [UIImage imageNamed:@[@"swim.png", @"bike.png", @"run.png", @"strengthandconditioning.png"
                                , @"8-stack_multi_station_small.jpg", @"leg_extension_small.jpg"
                                , @"abdominal_crunch_bench_small.jpg", @"leg_press_small.jpg"
                                , @"abdominal_small.jpg", @"medicine_ball_small.jpg"
                                , @"adjustable_bench_small.jpg", @"multi_adjustable_bench_small.jpg"
                                , @"adjustable_decline_bench_small.jpg", @"multimode_rope_climber_small.jpg"
                                , @"arm_curl_small.jpg", @"olympic_bar_small.jpg"
                                , @"ascent_trainer_small.jpg", @"pectoral_fly_small.jpg"
                                , @"back_extension_small.jpg", @"power_station_small.jpg"
                                , @"calf_press_small.jpg", @"prone_leg_curl_small.jpg"
                                , @"chest_press_small.jpg", @"rear_delt_fly_small.jpg"
                                , @"converging_chest_press_small.jpg", @"recumbent_cycle_small.jpg"
                                , @"converging_shoulder_press_small.jpg", @"rotary_hip_small.jpg"
                                , @"dip_chin_assist_small.jpg", @"rotary_torso_small.jpg"
                                , @"diverging_lat_pulldown_small.jpg", @"rower_small.jpg"
                                , @"diverging_seated_row_small.jpg", @"seated_dip_small.jpg"
                                , @"dumbbells_small.jpg", @"seated_leg_curl_small.jpg"
                                , @"elliptical_trainer_small.jpg", @"seated_row_small.jpg"
                                , @"functional_trainer_small.jpg", @"shoulder_press_small.jpg"
                                , @"hip_abductor_small.jpg", @"smith_machine_small.jpg"
                                , @"hip_adductor_small.jpg", @"spinner_bike_small.jpg"
                                , @"hybrid_cycle_small.jpg", @"stepper_small.jpg"
                                , @"indoor_cycle_small.jpg", @"treadmill_small.jpg"
                                , @"kettlebells_small.jpg", @"triceps_extension_small.jpg"
                                 , @"lat_pull_small.jpg", @"upright_cycle_small.jpg"][activityType]];
}
@end
