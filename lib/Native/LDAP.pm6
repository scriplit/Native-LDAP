use v6;
use NativeCall;

module Native::LDAP:ver<0.0.1> {

	sub libldap {
		return $*VM.platform-library-name('ldap'.IO).Str;
	}

	class Native::LDAP::Handle is repr('CPointer') { }
	class Native::LDAP::Message is repr('CPointer') { }

	class timeval is repr('CStruct') is export {
	  has long $tv_sec;
	  has long $tv_usec;
	}

	#`[
	LDAP *ldap_init(host, port)
	char *host;
	int port;
	]
	# sub ldap_init(Str, int32) returns Native::LDAP::Handle is native('ldap_r-2.4', v2) {*};
	sub ldap_init(Str, int32) returns Native::LDAP::Handle is export is native(&libldap) {*};

	# int ldap_get_option(LDAP *ld, int option, void *outvalue);
	sub ldap_get_option(Native::LDAP::Handle, int32, CArray[int32])
		returns int32 is export is native(&libldap) {*};

	# int ldap_set_option(LDAP *ld, int option, const void *invalue);
	sub ldap_set_option(Native::LDAP::Handle, int32, CArray[int32])
		returns int32 is export is native(&libldap) {*};

	# int ldap_simple_bind(LDAP *ld, const char *who, const char *passwd);
	sub ldap_simple_bind_s(Native::LDAP::Handle, Str, Str)
		returns int32 is export is native(&libldap) {*};
	#`[
	int ldap_search_ext_s(
				 LDAP *ld,
				 char *base,
				 int scope,
				 char *filter,
				 char *attrs[],
				 int attrsonly,
				 LDAPControl **serverctrls,
				 LDAPControl **clientctrls,
				 struct timeval *timeout,
				 int sizelimit,
				 Native::LDAP::Message **res );
	]
	sub ldap_search_ext_s(
		Native::LDAP::Handle,
		Str,
		int32,
		Str,
		CArray[Str],
		int32,
		Pointer,
		Pointer,
		Pointer[timeval],
		int32,
		CArray[Native::LDAP::Message] )
			returns int32 is export is native(&libldap) {*};

	# int ldap_count_entries( LDAP *ld, Native::LDAP::Message *result )
	sub ldap_count_entries(Native::LDAP::Handle, Pointer[Native::LDAP::Message])
		returns int32 is export is native(&libldap) {*};

	# Native::LDAP::Message *ldap_first_entry( LDAP *ld, Native::LDAP::Message *result )
	sub ldap_first_entry(Native::LDAP::Handle, Pointer[Native::LDAP::Message])
		returns Pointer[Native::LDAP::Message] is export is native(&libldap) {*};

	# Native::LDAP::Message *ldap_next_entry( LDAP *ld, Native::LDAP::Message *entry )
	sub ldap_next_entry(Native::LDAP::Handle, Pointer[Native::LDAP::Message])
		returns Pointer[Native::LDAP::Message] is export is native(&libldap) {*};

	# char *ldap_get_dn( LDAP *ld, Native::LDAP::Message *entry )
	sub ldap_get_dn(Native::LDAP::Handle, Pointer[Native::LDAP::Message])
		returns Str is export is native(&libldap) {*};
}
