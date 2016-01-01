use v6;
use Test;
use lib 'lib';
use NativeCall;

plan 14;

use Native::LDAP;

my Native::LDAP::Handle $ld = ldap_init('localhost', 389);
die 'LDAP init failed' unless $ld.defined;
pass 'LDAP_init()';

my $option-id = 0x0011; # LDAP_OPT_PROTOCOL_VERSION, defaults to 2
my @pint := CArray[int].new;
@pint[0] = 0; # ensures a size of 1 for the array
my $ret = ldap_get_option($ld, $option-id, @pint);
ok $ret == 0, 'ldap_get_option() returns OK';
ok @pint[0] == 2, 'ldap_get_option() got expected default value';

@pint[0] = 3;
$ret = ldap_set_option($ld, $option-id, @pint);
ok $ret == 0, 'ldap_set_option() returns OK';

# read back
@pint[0] = 4; # just to be sure we overwrite this value
$ret = ldap_get_option($ld, $option-id, @pint);
ok @pint[0] == 3, 'ldap_set_option() got expected modified value';

$ret = ldap_simple_bind_s($ld, "cn=admin,dc=test,dc=picnet,dc=pl", "molquaph");
ok $ret == 0, 'ldap_simple_bind_s() returns OK';

# search!
my $pmsg = CArray[Native::LDAP::Message].new;
$pmsg[0] = Native::LDAP::Message; # Ensures a slot exists
my int32 $scope = int32.new(0x02);
$ret = ldap_search_ext_s(
					$ld,
					"dc=test,dc=picnet,dc=pl",
					$scope,
					"(objectClass=*)",
					CArray[Str],
					0,
					Pointer,
					Pointer,
					Pointer[timeval],
					0,
					$pmsg);

ok $ret == 0, 'ldap_search_ext_s() returns OK';

my $nent = ldap_count_entries($ld, $pmsg[0]);
ok $ret == 0, 'ldap_count_entries() returns OK';
ok $nent == 5, 'ldap_count_entries() returns correct number of elts';

# entry = ldap_first_entry(ld, msg);
my $entry;
my $index = 0;
loop ($entry = ldap_first_entry($ld, $pmsg[0]);
			defined $entry;
			$entry = ldap_next_entry($ld, $entry) ) {
				my $dn = ldap_get_dn($ld, $entry);
				ok $dn.ends-with("dc=test,dc=picnet,dc=pl"), 'entry #' ~ $index++ ;
			}
