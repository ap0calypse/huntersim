#!/usr/bin/perl
use strict;
{
    package Carnivore;
    require Exporter;
    our @ISA = ("Exporter");
    
    sub new {
        my ($self, $name) = (shift, shift);
        if (@_) {   
            bless { 
                Name        => $name,
                HuntSkill   => shift,
                Age         => 0,
                LocX        => shift,
                LocY        => shift,
                LastMeal    => 0,
                Speed       => 1,
                TSLM        => 20,
            }, $self;
        }
        else {
            bless { 
                Name        => $name,
                HuntSkill   => $self->random_hunt_skill, 
                Age         => $self->random_age,
                LocX        => $self->init_locx,
                LocY        => $self->init_locy,
                LastMeal    => $self->random_hunger,
                Speed       => 1,
                TSLM        => $self->random_hornyness,
            }, $self;
        }
    }

# func for returning a random hnting skill for the carnivore
# usually, carnivores have a good chance to kill a herbivore when
# meeting in the same coordinates, so the maximum value differs between
# carnivores and herbivores.
# this is only needed at initialisation.

    sub random_hunt_skill { 
        int (rand 100) + 1; 
    }


# function for returning a random age. this is only needed at initialisation.

    sub random_age { 
        int (rand $Territory::MAX_AGE_CARNIVORES) + 1;
    }


# function for returning a random hunger value. because it was unrealistic 
# in the beginning, that all carnivores and herbivores start full.
# now, some carnivores start nearly starving and other ones start full.
# this is only needed for initialisation.

    sub random_hunger { 
        int (rand $Territory::STARVE_CYCLES) + 1; 
    }


# function for returning the "hornyness" of a carnivore. because it was quite
# unrealistic that all carnivores start with the same "hornyness" ;)
# this is only needed for initialisation.
    
    sub random_hornyness { 
        int (rand 20) + 1; 
    }


# function for returning the x coordinate of "birth" at initialisation. it
# depends on the size of the territory of course.

    sub init_locx { 
        int (rand $Territory::LENGTH) + 1;
    }


# function for returning the y coordinate of "birth" at initialisation. it
# depends on the size of the territory of course.

    sub init_locy { 
        int (rand $Territory::HEIGHT) + 1; 
    }


# function for returning the current x coordinate

    sub where_x { $_[0]->{'LocX'}; }


# function for returning the current y coordinate

    sub where_y { $_[0]->{'LocY'}; }


# function for returning the hunger of the carnivore

    sub how_hungry { $_[0]->{'LastMeal'}; }


# function for returning the age of the carnivore

    sub how_old { $_[0]->{'Age'}; }


# function for returning the skill level of the carnivore

    sub how_skilled { $_[0]->{'HuntSkill'}; }


# function for aging a carnivore. because older carnivores should become slower or 
# less talented for hunting, the skill level decreases when at a specified amount 
# cycles. i think MAX_MATE_CARNIVORES is quite appropriate.

    sub age { 
        $_[0]->{'Age'}++; 
        $_[0]->{'HuntSkill'}-- if $_[0]->{'Age'} >= $Territory::MAX_MATE_CARNIVORES; 
    }


# function for raising the skill level of a carnivore. everytime a carnivore kills
# a herbivore it becomes more talented in doing so. i think this is realistic.
    
    sub raise_skill { $_[0]->{'HuntSkill'} += 5; }


# function for lowering the skill.

    sub lower_skill { $_[0]->{'HuntSkill'} -= 5; }


# function for eating a herbivore. the nutritional value is defined in Territory

    sub eat { $_[0]->{'LastMeal'} -= $Territory::NUTRITIONAL_HERBIVORE; }


# function for slow starving because of no eating 

    sub starve { $_[0]->{'LastMeal'}++; }


# function for initialisation of hunger after getting born

    sub born_starve { $_[0]->{'LastMeal'} += $Territory::BABY_HUNGER; }


# function for losing horniness after mating another carnivore

    sub cast { $_[0]->{'TSLM'} += $Territory::I_HAVE_A_HEADACHE; }


# function for slowly getting hornier every cycle ...

    sub get_horny { $_[0]->{'TSLM'}-- if $_[0]->{'TSLM'} > 0; }


# function for returning current hornyness ;)

    sub how_horny { $_[0]->{'TSLM'}; }


# function for movement

    sub move {
        my $loc = $_[1] || int (rand 4) + 1;
        if ($loc == 1 || $loc eq 'right') {
            if ($_[0]->{'LocX'} == $Territory::LENGTH) {
                $_[0]->move;
            }
            else {
                $_[0]->{'LocX'} += 1;
            }
        }
        elsif ($loc == 2 || $loc eq 'left') {
            if ($_[0]->{'LocX'} == 1) {
                $_[0]->move;
            }
            else {
                $_[0]->{'LocX'} -= 1;
            }
        }
        elsif ($loc == 3 || $loc eq 'up') {
            if ($_[0]->{'LocY'} == 1) {
                $_[0]->move;
            }
            else {
                $_[0]->{'LocY'} -= 1;
            }
        }
        elsif ($loc == 4 || $loc eq 'down') {
            if ($_[0]->{'LocY'} == $Territory::HEIGHT) {
                $_[0]->move;
            }
            else {
                $_[0]->{'LocY'} += 1;
            }
        }
    }
}
1;
