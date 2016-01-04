use v6;
use Native::LDAP;

# unit module Net::LDAP:ver<0.0.1>;
class Net::LDAP:ver<0.0.1> is export {

    has Str $.host is required;
    has Str $.port;
    has Native::LDAP::Handle $!ldh;
}
