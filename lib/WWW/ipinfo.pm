use strict;
use warnings;
package WWW::ipinfo;

use HTTP::Tiny;
use 5.008;
use JSON;

# ABSTRACT: Returns your ip address and geolocation data using L<http://ipinfo.io>

=head1 SYNOPSIS

    use WWW::ipinfo;

    my $ipinfo = get_ipinfo();
    my $city = $ipinfo->{city};

=head1 EXPORTS

Exports the C<get_ipinfo> function.

=cut

BEGIN {
    require Exporter;
    use base 'Exporter';
    our @EXPORT = 'get_ipinfo';
    our @EXPORT_OK = ();
}

=head1 FUNCTIONS

=head2 get_ipinfo

Returns a hashref containing your ip and geolocation data:

    {
      ip        => "198.115.6.53",
      hostname" => "cpe-198-115-6-53.nyc.res.rr.com",
      city      => "New York",
      region    => "New York",
      country   => "US",
      loc       => "43.7805,-79.9512",
      org       => "Time Warner Cable Internet LLC",
      postal    => "11154"
    }

Example

    use WWW::ipinfo;

    my $ipinfo = get_ipinfo();
    my $ip = $ipinfo->{ip};

=cut

sub get_ipinfo {
    my $response = HTTP::Tiny->new->get('http://ipinfo.io/json');
    die join(' ', 'Error fetching ip: ',
                  ($response->{status} or ''),
                  ($response->{reason} or '')) unless $response->{success};
   decode_json($response->{content}); 
}

=head1 SEE ALSO

L<WWW::curlmyip> - a similar module that returns your ip address

=cut

1;
