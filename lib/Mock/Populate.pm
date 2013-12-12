package Mock::Populate;

# ABSTRACT: Handy mock data creation

our $VERSION = '0.01';

use strict;
use warnings;

use Data::SimplePassword;
use Date::Range;
use lib '/Users/gene/sandbox/github/ology/Mock-Person/lib';
use Mock::Person;
use Statistics::Distributions;
use List::Util qw(shuffle);

=head1 NAME

Mock::Populate - Handy mock data creation

=head1 SYNOPSIS

  > perl Date-Ranger 1900-01-01 2020-12-31 1000 > dates.dat
  > perl Time-Ranger '01:02:03' '23:59:59' 1000 > times.dat
  > perl Number-Ranger 1000 5000 2 1000 > nums.dat
  > perl Personify b 2 1000 > people.dat
  > perl Stats-Distrib n 3 1000 > stats.dat
  > perl Collate dates.dat times.dat nums.dat people.dat stats.dat > mock.dat

=head1 DESCRIPTION

This is a set of modules and scripts handy for mock data creation.

See the documentation (and source) of each script for arguments and usage.

=head1 FUNCTIONS

=head2 date_ranger()

=cut

sub date_ranger {

    # Bucket for our result list.
    my @results;

    return @results;
}

=head2 number_ranger()

  @results = number_ranger($start, $end, $prec, $random, $n)

Return a list of B<$n> random numbers within a range.  The start, end,
precision, whether we want random or sequential numbers and desired number of
data-points arguments are all optional.  The defaults are:

  start: 0
  end: 9
  precision: 2
  random: 0
  n: 10

=cut

sub number_ranger {

    # Bucket for our result list.
    my @results;

    # Get start and end numbers.
    my $i = defined $_[0] ? shift : 0;
    my $j = defined $_[0] ? shift : 9;
    # Get the decimal precision.
    my $p = defined $_[0] ? shift : 2;
    # Do we want random numbers?
    my $r = defined $_[0] ? shift : 0;
    # Get the number of data points desired.
    my $n = defined $_[0] ? shift : 9;

    # Do we want random numbers?
    if ($r) {
        # Roll!
        for(0 .. $n) {
            # Get our random candidate.
            my $x = rand($j);
            # Make sure it is above the start value.
            while ($x < $i) {
                $x = rand($j);
            }
            push @results, $x;
        }
    }
    else {
        # Use a simple sequence of integers.
        @results = ($i .. $j);
    }

    return @results;
}

=head2 personify()

  @results = personify($gender, $names, $country, $n)

Return a list of B<$n> random names.  The gender, number of names and desired
number of data-points arguments are all optional.  The defaults are:

  gender: both
  names: 2
  country: us
  n: 10

=cut

sub personify {

    # Bucket for our result list.
    my @results;

    # Get gender. f: female, m: male, b: both
    my $g = defined $_[0] ? shift : 'b';
    # Get desired number of names.
    my $d = defined $_[0] ? shift : 2;
    # Get the country to use.
    my $c = defined $_[0] ? shift : 'us';
    # Get desired number of data-points.
    my $n = defined $_[0] ? shift : 9;

    # Roll!
    for my $i (0 .. $n) {
        # Get our random person.
        my $p = '';
        if (($g eq 'b' && $i % 2) || $g eq 'f') {
            $p = Mock::Person::name(sex => 'female', country => $c);
        }
        else {
            $p = Mock::Person::name(sex => 'male', country => $c);
        }
        # Only use the requested number of names.
        my @names = split / /, $p;
        my $name = '';
        if ($d == 1) {
            push @results, $names[-1];
        }
        elsif ($d == 2) {
            push @results, "@names[0,-1]";
        }
        else {
            push @results, $p;
        }
    }

    return @results;
}

=head2 stats_distrib()

  @results = stats_distrib($type, $prec, $dof, $n)

Return a list of B<$n> distribution values.  The type, precision,
degrees-of-freedom and desired number of data-points arguments are optional.
The defaults are:

  type: u (normal)
  precision: 2
  degrees-of-freedom: 2
  n: 10

=head3 TYPES

This function uses single letter identifiers:

  u: Normal distribution (default)
  c: Chi-squared distribution
  s: Student's T distribution
  f: F distribution

=head3 DEGREES OF FREEDOM

Given the type, this function accepts the following:

  c: A single integer
  s: A single integer
  f: A fraction string of the form 'N/D' (default 2/1)

=cut

sub stats_distrib {

    # Get type of distribution.
    my $p = defined $_[0] ? shift : 'u';
    # Get digits of precision.
    my $t = defined $_[0] ? shift : 2;
    # Get desired degrees of freedom for the ChiSq, StudentT & F.
    my $d = defined $_[0] ? shift : 2;
    # Get desired number of data-points.
    my $n = defined $_[0] ? shift : 9;

    # Separate numerator/denominator for F degs-of-freedm.
    my $e = 1;
    ($d, $e) = split(/\//, $d) if $t eq 'f';

    # Bucket for our result list.
    my @results;

    # Roll!
    for(0 .. $n) {
        # Select distribution.
        if ($t eq 'c') {
            # Chi-squared
            push @results, Statistics::Distributions::chisqrdistr($d, rand);
        }
        elsif ($t eq 's') {
            # Student's T
            push @results, Statistics::Distributions::tdistr($d, rand);
        }
        elsif ($t eq 'f') {
            # F distribution
            push @results, Statistics::Distributions::fdistr($d, $e, rand);
        }
        else {
            # Normal
            push @results, Statistics::Distributions::udistr(rand);
        }
    }

    return @results;
}

=head2 collate()

=cut

sub collate { # 
}

1;
__END__

=head1 SEE ALSO

L<Data::SimplePassword>

L<Date::Range>

L<Date::Simple>

L<List::Util>

L<Mock::Person>

L<Statistics::Distribution>

=cut
