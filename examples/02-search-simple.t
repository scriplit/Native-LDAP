use v6;
use Test;
use lib 'lib';

plan 3;

use Native::LDAP::Simple;

my Native::LDAP::Simple $ld .= new(:host<ldap.picnet.pl>);
ok (defined $ld), 'LDAP object created';

my $ret = $ld.bind(:dn<cn=admin,dc=test,dc=picnet,dc=pl>, :passwd<secret>);
ok $ret == 0, "Bind OK";

my $lm = $ld.search(:base<dc=test,dc=picnet,dc=pl>);
ok (defined $lm), "Got messages!";
