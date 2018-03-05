package Perinci::CmdLine::cryp;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use parent 'Perinci::CmdLine::Lite';

sub hook_config_file_section {
    my ($r, $section_name, $section_content) = @_;

    if ($section_name =~ m!\Aexchange\s*/\s*(\S+)(?:\s*/\s*(.+)\z!) {
        my $xchg = $1;
        my $nick = $2 // 'default';
        $r->{appdata}{cryp}{exchanges}{$xchg}{$nick} //= {};
        for (keys %$section_content) {
            $r->{appdata}{cryp}{exchanges}{$xchg}{$nick}{$_} =
                $section_content->{$_};
        }
        return [204];
    }
}

1;
# ABSTRACT: Perinci::CmdLine::Lite to read entities from config

=head1 SEE ALSO

L<App::cryp> and other C<App::cryp::*> modules.

L<Perinci::CmdLine::Lite>

=cut
