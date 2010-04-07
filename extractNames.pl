#!/usr/bin/perl

#Author: Sai Charan
#Finds the first occurance 'value' in Name="value" in a <table>...</table> constructs.

use warnings;
use strict;

#Thanks to Alan Moore: http://stackoverflow.com/questions/2468101/why-does-my-perl-regular-expression-only-find-the-last-occurrence/2470721#2470721
my $nameRegExp = '(<TABLE>\n+(?:(?!<\/TABLE>|NAME=).*\n+)*)NAME="([^"]+)"';

sub extractNames($$){
	my ($ifh, $ofh) = @_;
	my $fullFile;
	read ($ifh, $fullFile, 1024);#Hardcoded to read just 1024 bytes.
	while( $fullFile =~ m/$nameRegExp/gi){
		print $+."\n";
	}
}

sub main(){
	if( ($#ARGV + 1 )!= 1){
		die("Usage: extractNames infile\n");
	}
	my $infileName = $ARGV[0];
	my $outfileName = $ARGV[1];
	open my $inFile, "<$infileName" or die("Could not open log file $infileName");
	my $outFile;
	#open my $outFile, ">$outfileName" or die("Could not open log file $outfileName");
	extractNames( $inFile, $outFile );
	close( $inFile );
	#close( $outFile );
}

#call 
main();