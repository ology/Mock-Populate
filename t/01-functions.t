use Test::More;

use_ok 'Mock::Populate';

my @x = Mock::Populate::stats_distrib();
is @x, 10, 'stats_distrib';
# TODO Test contents for looks_like_a_number

done_testing();
