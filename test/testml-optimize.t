use strict;
use lib (-e 't' ? 't' : 'test'), 'inc';
use File::Spec;
use TestML;
use TestML::Compiler::Lite;
use TestMLBridge;

TestML->new(
    testml => File::Spec->catfile(qw{testml optimize.tml}),
    bridge => 'TestMLBridge',
    compiler => 'TestML::Compiler::Lite',
)->run;
