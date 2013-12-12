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

=cut

sub number_ranger {

    # Bucket for our result list.
    my @results;

    return @results;
}

=head2 personify()

=cut

sub personify {

    # Bucket for our result list.
    my @results;

    return @results;
}

=head2 stats_distrib()

  @results = stats_distrib($type, $prec, $dof, $n)

Return a list of B<$n> distribution values.  The type, precision,
degrees-of-freedom and desired number of data-points arguments are optional.

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
  f: A fraction string of the form 'N/D'

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
