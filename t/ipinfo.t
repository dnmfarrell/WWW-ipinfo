use strict;
use warnings;
use Test::More;
use Test::RequiresInternet 0.03 ( 'ipinfo.io' => 80 );

BEGIN { use_ok 'WWW::ipinfo' }

ok my $info = get_ipinfo(), 'get_ipinfo works';
like $info->{ip}, qr/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/,
    'ip address in expected format';

ok exists $info->{city}, 'has city';
ok exists $info->{region}, 'has region';
ok exists $info->{postal}, 'has postal';
ok exists $info->{country}, 'has country';

done_testing();
