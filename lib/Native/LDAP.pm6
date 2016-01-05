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
    constant LDAP_OPT_DIAGNOSTIC_LDAPMessage is export = 0x0032;
    constant LDAP_OPT_ERROR_STRING is export = LDAP_OPT_DIAGNOSTIC_LDAPMessage;
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

    constant LDAP_SUCCESS is export = 0x00;
    constant LDAP_OPERATIONS_ERROR is export = 0x01;
    constant LDAP_PROTOCOL_ERROR is export = 0x02;
    constant LDAP_TIMELIMIT_EXCEEDED is export = 0x03;
    constant LDAP_SIZELIMIT_EXCEEDED is export = 0x04;
    constant LDAP_COMPARE_FALSE is export = 0x05;
    constant LDAP_COMPARE_TRUE is export = 0x06;
    constant LDAP_AUTH_METHOD_NOT_SUPPORTED is export = 0x07;
    constant LDAP_STRONG_AUTH_NOT_SUPPORTED is export = LDAP_AUTH_METHOD_NOT_SUPPORTED;
    constant LDAP_STRONG_AUTH_REQUIRED is export = 0x08;
    constant LDAP_STRONGER_AUTH_REQUIRED is export = LDAP_STRONG_AUTH_REQUIRED;
    constant LDAP_PARTIAL_RESULTS is export = 0x09;
    constant LDAP_REFERRAL is export = 0x0a;
    constant LDAP_ADMINLIMIT_EXCEEDED is export = 0x0b;
    constant LDAP_UNAVAILABLE_CRITICAL_EXTENSION = 0x0c;
    constant LDAP_CONFIDENTIALITY_REQUIRED is export = 0x0d;
    constant LDAP_SASL_BIND_IN_PROGRESS is export = 0x0e;
    constant LDAP_NO_SUCH_ATTRIBUTE is export = 0x10;
    constant LDAP_UNDEFINED_TYPE is export = 0x11;
    constant LDAP_INAPPROPRIATE_MATCHING is export = 0x12;
    constant LDAP_CONSTRAINT_VIOLATION is export = 0x13;
    constant LDAP_TYPE_OR_VALUE_EXISTS is export = 0x14;
    constant LDAP_INVALID_SYNTAX is export = 0x15;
    constant LDAP_NO_SUCH_OBJECT is export = 0x20;
    constant LDAP_ALIAS_PROBLEM is export = 0x21;
    constant LDAP_INVALID_DN_SYNTAX is export = 0x22;
    constant LDAP_IS_LEAF is export = 0x23;
    constant LDAP_ALIAS_DEREF_PROBLEM is export = 0x24;
    constant LDAP_X_PROXY_AUTHZ_FAILURE is export = 0x2F;
    constant LDAP_INAPPROPRIATE_AUTH is export = 0x30;
    constant LDAP_INVALID_CREDENTIALS is export = 0x31;
    constant LDAP_INSUFFICIENT_ACCESS is export = 0x32;
    constant LDAP_BUSY is export = 0x33;
    constant LDAP_UNAVAILABLE is export = 0x34;
    constant LDAP_UNWILLING_TO_PERFORM is export = 0x35;
    constant LDAP_LOOP_DETECT is export = 0x36;
    constant LDAP_NAMING_VIOLATION is export = 0x40;
    constant LDAP_OBJECT_CLASS_VIOLATION is export = 0x41;
    constant LDAP_NOT_ALLOWED_ON_NONLEAF is export = 0x42;
    constant LDAP_NOT_ALLOWED_ON_RDN is export = 0x43;
    constant LDAP_ALREADY_EXISTS is export = 0x44;
    constant LDAP_NO_OBJECT_CLASS_MODS is export = 0x45;
    constant LDAP_RESULTS_TOO_LARGE is export = 0x46;
    constant LDAP_AFFECTS_MULTIPLE_DSAS is export = 0x47;
    constant LDAP_VLV_ERROR is export = 0x4C;
    constant LDAP_OTHER is export = 0x50;
    constant LDAP_CUP_RESOURCES_EXHAUSTED is export = 0x71;
    constant LDAP_CUP_SECURITY_VIOLATION is export = 0x72;
    constant LDAP_CUP_INVALID_DATA is export = 0x73;
    constant LDAP_CUP_UNSUPPORTED_SCHEME is export = 0x74;
    constant LDAP_CUP_RELOAD_REQUIRED is export = 0x75;
    constant LDAP_CANCELLED is export = 0x76;
    constant LDAP_NO_SUCH_OPERATION is export = 0x77;
    constant LDAP_TOO_LATE is export = 0x78;
    constant LDAP_CANNOT_CANCEL is export = 0x79;
    constant LDAP_ASSERTION_FAILED is export = 0x7A;
    constant LDAP_PROXIED_AUTHORIZATION_DENIED is export = 0x7B;

	class LDAPHandle is repr('CPointer') { }
	class LDAPMessage is repr('CPointer') { }

	class timeval is repr('CStruct') is export {
	  has long $tv_sec;
	  has long $tv_usec;
	}

	#`[
	LDAP *ldap_init(host, port)
	char *host;
	int port;
	]
	# sub ldap_init(Str, int32) returns LDAPHandle is native('ldap_r-2.4', v2) {*};
	sub ldap_init(Str, int32) returns LDAPHandle is export is native(&libldap) {*};

	# int ldap_get_option(LDAP *ld, int option, void *outvalue);
	sub ldap_get_option(LDAPHandle, int32, CArray[int32])
		returns int32 is export is native(&libldap) {*};

	# int ldap_set_option(LDAP *ld, int option, const void *invalue);
	sub ldap_set_option(LDAPHandle, int32, CArray[int32])
		returns int32 is export is native(&libldap) {*};

	# int ldap_simple_bind(LDAP *ld, const char *who, const char *passwd);
	sub ldap_simple_bind_s(LDAPHandle, Str, Str)
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
				 LDAPMessage **res );
	]
	sub ldap_search_ext_s(
		LDAPHandle,
		Str,
		int32,
		Str,
		CArray[Str],
		int32,
		Pointer,
		Pointer,
		Pointer[timeval],
		int32,
		CArray[LDAPMessage] )
			returns int32 is export is native(&libldap) {*};

	# int ldap_count_entries( LDAP *ld, LDAPMessage *result )
	sub ldap_count_entries(LDAPHandle, LDAPMessage)
		returns int32 is export is native(&libldap) {*};

	# LDAPMessage *ldap_first_entry( LDAP *ld, LDAPMessage *result )
	sub ldap_first_entry(LDAPHandle, LDAPMessage)
		returns Pointer[LDAPMessage] is export is native(&libldap) {*};

	# LDAPMessage *ldap_next_entry( LDAP *ld, LDAPMessage *entry )
	sub ldap_next_entry(LDAPHandle, LDAPMessage)
		returns Pointer[LDAPMessage] is export is native(&libldap) {*};

	# char *ldap_get_dn( LDAP *ld, LDAPMessage *entry )
	sub ldap_get_dn(LDAPHandle, LDAPMessage)
		returns Str is export is native(&libldap) {*};
}
