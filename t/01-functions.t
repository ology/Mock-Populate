use Test::More;

use_ok 'Mock::Populate';

# TODO Test contents for looks_like_a_number instead.
my @x = Mock::Populate::date_ranger();
is @x, 10, 'date_ranger';
@x = Mock::Populate::number_ranger();
is @x, 10, 'number_ranger';
@x = Mock::Populate::personify();
is @x, 10, 'personify';
@x = Mock::Populate::stats_distrib();
is @x, 10, 'stats_distrib';

done_testing();
