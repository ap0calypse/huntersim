#!/usr/bin/perl
{
    package Territory;
    require Exporter;
    @ISA = ("Exporter");
    @EXPORT = qw($LENGTH $HEIGHT $NUM_CARNIVORES $NUM_HERBIVORES $MAX_AGE_CARNIVORES 
                 $MAX_AGE_HERBIVORES $MAX_MATE_CARNIVORES $MAX_MATE_HERBIVORES 
                 $STARVE_CYCLES $RAGE_CYCLES $HUNGRY_CYCLES $SIGHT_CARNIVORES 
                 $SIGHT_HERBIVORES $LOOSE_CARNIVORES $LOOSE_HERBIVORES 
                 $DENSITY_HERBIVORES $DENSITY_CARNIVORES $NUTRITIONAL_HERBIVORE
                 $CHICKEN_RADIUS $BABY_HUNGER $I_HAVE_A_HEADACHE);


# how big is the territory?
    $LENGTH = 100;
    $HEIGHT = 15;

# number of carnivores in the beginning
    $NUM_CARNIVORES = 70;

# number of herbivores in the beginning
    $NUM_HERBIVORES = 200;

# maximum age of carnivores in cycles
    $MAX_AGE_CARNIVORES = 400;

# maximum age of herbivores in cycles
    $MAX_AGE_HERBIVORES = 500;

# maximum age of carnivores to mate
    $MAX_MATE_CARNIVORES = 360;

# maximum age of herbivores to mate
    $MAX_MATE_HERBIVORES = 460;

# cycles before carnivores starve
    $STARVE_CYCLES = 70;

# cycles before carnivores become agressive
    $RAGE_CYCLES = 50;

# cycles before carnivores start getting hungry
    $HUNGRY_CYCLES = 25;

# how far can carnivores see?
    $SIGHT_CARNIVORES = 40;

# how far can herbivores see?
    $SIGHT_HERBIVORES = 25;

# how loose should the carnivore pack be? (1 = they stick together as hell)
    $LOOSE_CARNIVORES = 4;

# how loose should the herbivore pack be? (1 = they stick together as hell)
    $LOOSE_HERBIVORES = 5;

# how dense could the pack get (how many individuals on the same position)
    $DENSITY_HERBIVORES = 6;

# how dense could the pack get (how many individuals on the same position)
    $DENSITY_CARNIVORES = 4;

# how nutritional is a herbivore?
    $NUTRITIONAL_HERBIVORE = 50;

# when should herbivores flee ?
    $CHICKEN_RADIUS = 4;

# how hungry is a new born carnivore?
    $BABY_HUNGER = 40;

# how long do parents don't want to fuck again after they created a new carnivore?
    $I_HAVE_A_HEADACHE = 30;

}
1;
