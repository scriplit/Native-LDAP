use v6;
use Test;
use lib 'lib';

plan 4;

use Native::LDAP::Simple;

my Native::LDAP::Simple $ld .= new(:host<ldap.picnet.pl>);
ok (defined $ld), 'LDAP object created';

my $ret = $ld.bind(:dn<cn=admin,dc=test,dc=picnet,dc=pl>, :passwd<secret>);
ok $ret == 0, "Bind OK";

my $lm = $ld.search(:base<dc=test,dc=picnet,dc=pl>);
ok (defined $lm), "Got LDAPMessages!";

my $nent = $ld.count-entries($lm);
ok $nent == 5, 'ldap_count_entries() returns correct number of elts';

for $ld.get-entries($lm) -> $entry {
    say $ld.get-dn($entry);
}
