use v6;
use NativeCall;

module Native::LDAP:ver<0.0.1> {

	sub libldap {
		return $*VM.platform-library-name('ldap'.IO).Str;
	}

    constant LDAP_VERSION1 is export = 1;
    constant LDAP_VERSION2 is export = 2;
    constant LDAP_VERSION3 is export = 3;

    constant LDAP_API_VERSION = 3001;

    constant LDAP_VERSION_MIN is export = LDAP_VERSION2;
    constant LDAP_VERSION is export = LDAP_VERSION2;
    constant LDAP_VERSION_MAX is export = LDAP_VERSION3;

    constant LDAP_PORT is export = 389;
    constant LDAPS_PORT is export = 636;

    constant LDAP_ROOT_DSE is export = "";
    constant LDAP_NO_ATTRS is export = "1.1";
    constant LDAP_ALL_USER_ATTRIBUTES is export = "*";
    constant LDAP_ALL_OPERATIONAL_ATTRIBUTES is export = "+";

    constant LDAP_MAXINT is export = (2147483647);

    constant LDAP_OPT_API_INFO is export = 0x0000;
    constant LDAP_OPT_DESC is export = 0x0001;
    constant LDAP_OPT_DEREF is export = 0x0002;
    constant LDAP_OPT_SIZELIMIT is export = 0x0003;
    constant LDAP_OPT_TIMELIMIT is export = 0x0004;
    constant LDAP_OPT_REFERRALS is export = 0x0008;
    constant LDAP_OPT_RESTART is export = 0x0009;
    constant LDAP_OPT_PROTOCOL_VERSION is export = 0x0011;
    constant LDAP_OPT_SERVER_CONTROLS is export = 0x0012;
    constant LDAP_OPT_CLIENT_CONTROLS is export = 0x0013;
    constant LDAP_OPT_API_FEATURE_INFO is export = 0x0015;
    constant LDAP_OPT_HOST_NAME is export = 0x0030;
    constant LDAP_OPT_RESULT_CODE is export = 0x0031;
    constant LDAP_OPT_ERROR_NUMBER is export = LDAP_OPT_RESULT_CODE;
    constant LDAP_OPT_DIAGNOSTIC_MESSAGE is export = 0x0032;
    constant LDAP_OPT_ERROR_STRING is export = LDAP_OPT_DIAGNOSTIC_MESSAGE;
    constant LDAP_OPT_MATCHED_DN is export = 0x0033;
    constant LDAP_OPT_SSPI_FLAGS is export = 0x0092;
    constant LDAP_OPT_SIGN is export = 0x0095;
    constant LDAP_OPT_ENCRYPT is export = 0x0096;
    constant LDAP_OPT_SASL_METHOD is export = 0x0097;
    constant LDAP_OPT_SECURITY_CONTEXT is export = 0x0099;
    constant LDAP_OPT_API_EXTENSION_BASE  is export = 0x4000;
    constant LDAP_OPT_DEBUG_LEVEL is export = 0x5001;
    constant LDAP_OPT_TIMEOUT is export = 0x5002;
    constant LDAP_OPT_REFHOPLIMIT is export = 0x5003;
    constant LDAP_OPT_NETWORK_TIMEOUT is export = 0x5005;
    constant LDAP_OPT_URI is export = 0x5006;
    constant LDAP_OPT_REFERRAL_URLS is export = 0x5007;
    constant LDAP_OPT_SOCKBUF is export = 0x5008;
    constant LDAP_OPT_DEFBASE is export = 0x5009;
    constant LDAP_OPT_CONNECT_ASYNC is export = 0x5010;
    constant LDAP_OPT_CONNECT_CB is export = 0x5011;
    constant LDAP_OPT_SESSION_REFCNT is export = 0x5012;

    constant LDAP_SCOPE_BASE is export = 0x0000;
    constant LDAP_SCOPE_BASEOBJECT is export = LDAP_SCOPE_BASE;
    constant LDAP_SCOPE_ONELEVEL is export = 0x0001;
    constant LDAP_SCOPE_ONE is export = LDAP_SCOPE_ONELEVEL;
    constant LDAP_SCOPE_SUBTREE is export = 0x0002;
    constant LDAP_SCOPE_SUB is export = LDAP_SCOPE_SUBTREE;
    constant LDAP_SCOPE_SUBORDINATE is export = 0x0003;
    constant LDAP_SCOPE_CHILDREN is export = LDAP_SCOPE_SUBORDINATE;
    constant LDAP_SCOPE_DEFAULT is export = -1;

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
