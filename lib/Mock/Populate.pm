package Mock::Populate;

# ABSTRACT: Handy mock data creation

our $VERSION = '0.01';

use strict;
use warnings;

use Data::SimplePassword;
use Date::Range;
use Mock::Person;
use Statistics::Distribution;
use List::Util qw(shuffle);

=head1 NAME

Mock::Populate - Handy mock data creation

=head1 SYNOPSIS

> perl Personify b 2 1000 > people.txt
> perl Date-Ranger 1900-01-01 2020-12-31 1000 > dates.txt
> perl Number-Ranger 1000 5000 2 1000 > nums.txt
> perl Stats-Distrib n 3 1000 > stats.txt
> perl Columns people.txt dates.txt nums.txt stats.txt > mock-data.txt

=head1 DESCRIPTION

This is a set of modules and scripts handy for mock data creation.

See the documentation (and source) of each script for arguments and usage.

=cut

1;
__END__

