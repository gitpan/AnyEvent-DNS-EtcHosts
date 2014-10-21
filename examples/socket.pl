#!/usr/bin/perl

# Example: socket.pl google.com xmpp-client tcp 4

use v5.14;

use lib 'lib', '../lib';

my $domain  = $ARGV[0] || 'example.com';
my $service = $ARGV[1] || 80;
my $proto   = $ARGV[2] || 'tcp';
my $family  = $ARGV[3] || 0;

use AnyEvent::DNS::EtcHosts;
use AnyEvent::Socket;
use Socket;

my $cv = AE::cv;

AnyEvent::Socket::resolve_sockaddr $domain, $service, $proto, $family, undef, sub {
    say foreach map { format_address((AnyEvent::Socket::unpack_sockaddr($_->[3]))[1]) } @_;
    $cv->send;
};

$cv->recv;
