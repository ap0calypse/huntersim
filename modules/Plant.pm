#!/usr/bin/perl
use strict;
{
    package Plant;
    require Exporter;
    our @ISA = ("Exporter");

    sub new {
        my ($self, $name) = (shift, shift);
        if (@_) {   
            bless { 
                Name        => $name, 
                FleeSkill   => shift, 
                Age         => 0, 
                LocX        => shift,
                LocY        => shift,
                Fertil      => 100,
                LastMeal    => 0,
                Speed       => 1,
                TSLM        => 10,

            }, $self;
        }
        else {
            bless { 
                Name        => $name, 
                FleeSkill   => $self->random_flee_skill, 
                Age         => $self->random_age, 
                LocX        => $self->init_locx,
                LocY        => $self->init_locy,
                Fertil      => 100,
                LastMeal    => 0,
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
#
    sub random_flee_skill { 
        int (rand 30) + 1;
    }


# function for returning a random age. this is only needed at initialisation.
#
    sub random_age { 
        int (rand $Territory::MAX_AGE_HERBIVORES) + 1;
    }


# function for returning the "hornyness" of a carnivore. because it was quite
# unrealistic that all carnivores start with the same "hornyness" ;)
# this is only needed for initialisation.
#
    sub random_hornyness { 
        int (rand 10) + 1;
    }


# function for returning the x coordinate of "birth" at initialisation. it
# depends on the size of the territory of course.
#
    sub init_locx { 
        int (rand $Territory::LENGTH) + 1;
    }


# function for returning the y coordinate of "birth" at initialisation. it
# depends on the size of the territory of course.
#
    sub init_locy { 
        int (rand $Territory::HEIGHT) + 1;
    }

# function for returning the current x coordinate

    sub where_x { $_[0]->{'LocX'}; }


# function for returning the current y coordinate

    sub where_y { $_[0]->{'LocY'}; }

# function for returning the hunger of the herbivore

    sub how_hungry { $_[0]->{'LastMeal'}; }
 
    
# function for returning the age of the herbivore

    sub how_old { $_[0]->{'Age'}; }


# function for returning the skill level of the herbivore

    sub how_skilled { $_[0]->{'FleeSkill'}; }


# function for aging a herbvore. because older herbivores should become slower or 
# less talented for fleeing, the skill level decreases when at a specified amount 
# cycles. i think MAX_MATE_HERBIVORES is quite appropriate.

    sub age { 
        $_[0]->{'Age'}++; 
        $_[0]->{'FleeSkill'}-- if $_[0]->{'Age'} >= $Territory::MAX_MATE_HERBIVORES; 
    }

# function for raising the skill
#
    sub raise_skill { $_[0]->{'FleeSkill'} += 5; }


# function for lowering the skill
#
    sub lower_skill { $_[0]->{'FleeSkill'} -= 5; }

# function for eating (not needed)

    sub eat { $_[0]->{'LastMeal'} -= 50; }

# function for starving
#
    sub starve { $_[0]->{'LastMeal'} += 1; }

# function for casting
#
    sub cast { $_[0]->{'TSLM'} += $Territory::I_HAVE_A_HEADACHE;}

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
