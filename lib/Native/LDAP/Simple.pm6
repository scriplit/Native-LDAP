use v6;
use NativeCall;
use Native::LDAP;

class Native::LDAP::Simple:ver<0.0.1> is export {

    has Str $.host is required;
    has Int $.port = LDAP_PORT;
    has Int $.lasterror is rw;
    has Native::LDAP::LDAPHandle $!ldh;

    has Bool $!init-done = False;
    has Bool $!ldap3-done = False;
    has Bool $!bind-done = False;

    method init() {

        die "No LDAP host set" unless defined $.host;
        $!ldh = ldap_init($.host, $.port);
        die 'LDAP init failed' unless $!ldh.defined;
        $!init-done = True;
        return 0;
    }

    method set-opt-ldap3() {

        my $option-id = LDAP_OPT_PROTOCOL_VERSION;
        my @pint := CArray[int32].new;
        @pint[0] = LDAP_VERSION3;
        my $ret = ldap_set_option($!ldh, $option-id, @pint);
        die 'LDAPv3 option failed' unless $ret == 0;
        $!ldap3-done = True;
        return 0;
    }

    method bind(Str :$dn, Str :$passwd) {

        $.init() unless $!init-done;
        $.set-opt-ldap3 unless $!ldap3-done;

        my $ret = ldap_simple_bind_s($!ldh, $dn, $passwd);
        # die 'Bind failed' unless $ret == 0;
        $!bind-done = True if $ret == LDAP_SUCCESS;
        return $ret;
    }

    method search(Str :$base, Str :$filter, Int :$scope) {

        die "Not bound" unless $!bind-done;
        my $pmsg = CArray[Native::LDAP::LDAPMessage].new;
        $pmsg[0] = Native::LDAP::LDAPMessage; # Ensures a slot exists
        my $subtree = int32.new(LDAP_SCOPE_SUBTREE) unless defined $scope;
        my $ret = ldap_search_ext_s(
                $!ldh,
                $base,
                $scope // $subtree,
                $filter // "(objectClass=*)",
                CArray[Str],
                0,
                Pointer,
                Pointer,
                Pointer[timeval],
                0,
                $pmsg);

        $.lasterror = $ret;

        return $pmsg[0];
    }

    method count-entries(Native::LDAP::LDAPMessage $ldm) returns Int {

        die "Not bound" unless $!bind-done;
        die "Not a valid LDAPMessage" unless defined $ldm;
        my $nent = ldap_count_entries($!ldh, $ldm);
        return $nent;
    }

    method get-entries(Native::LDAP::LDAPMessage $ldm)  {

        my @entries;
        loop (my $entry = ldap_first_entry($!ldh, $ldm);
                    defined $entry;
                    $entry = ldap_next_entry($!ldh, $entry) ) {
                        @entries.push($entry.deref);
                    }
        return @entries;
    }

    method get-dn(Native::LDAP::LDAPMessage $entry) {
        return ldap_get_dn($!ldh, $entry);
    }
}
