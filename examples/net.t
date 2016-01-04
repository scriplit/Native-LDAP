use v6;
use Test;
use lib 'lib';

plan 14;

use Net::LDAP;

my Net::LDAP $ld .= new(:host<test.picnet.pl>);
ok (defined $ld), 'LDAP object created';
dd $ld;
