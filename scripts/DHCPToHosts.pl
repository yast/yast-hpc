#!/usr/bin/perl

use strict;

#=========================================
# Variables
#-----------------------------------------
my $config = "/etc/dhcpd.conf";
my $hosts  = "/etc/hosts";

#=========================================
# Setup
#-----------------------------------------
if (! -e $config) {
	die "DTH::No such file or directory: $config: $!";
}

#=========================================
# Read DHCP config
#-----------------------------------------
if (! open (FD,$config)) {
	die "DTH::open failed on: $config: $!";
}
my $stream;
while (my $line = <FD>) {
	chomp $line;
	$stream.=$line; 
}
close FD;

#=========================================
# Parse host <name> { ... } entries
#-----------------------------------------
my @hosts;
while (1) {
	if ($stream =~ /host(.*)\{(.*?)\}/) {
		my $match = $2;
		$stream =~ s/\{$match\}//;
		push (@hosts,$match);
	} else {
		last;
	}
}

#=========================================
# update hosts
#-----------------------------------------
my %data;
foreach my $host (@hosts) {
	my $ip;
	my $name;
	if ($host =~ /host-name.*\"(.*)\"/) {
		$name=$1;
	}
	if ($host =~ /fixed-address ((\d{1,3}\.){3}\d{1,3})/) {
		$ip=$1;
	}
	$data{$ip}=$name;
}
foreach my $ip (keys %data) {
if (defined $data{$ip}) {
	if (! open (FD,$hosts)) {
		die "DTH::open failed on: $hosts: $!";
	}
	while (my $line = <FD>) {
		chomp $line;
		if ($line =~ /$ip/) {
			delete $data{$ip};
		}
	}
	close FD;
}
}
foreach my $ip (keys %data) {
if (defined $data{$ip}) {
	if (! open (FD,">>$hosts")) {
		die "DTH::open failed on: $hosts: $!";
	}
	print FD "$ip $data{$ip}\n";
	close FD;
}
}
