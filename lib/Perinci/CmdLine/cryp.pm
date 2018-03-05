package Perinci::CmdLine::cryp;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use parent 'Perinci::CmdLine::Lite';

sub hook_config_file_section {
    my ($self, $r, $section_name, $section_content) = @_;

    if ($section_name =~ m!\A(exchange|wallet)\s*/\s*(\S+)(?:\s*/\s*(.+))?\z!) {
        my $entity = $1;
        my $xchg = $2;
        my $nick = $3 // 'default';
        $r->{_cryp}{exchanges}{$xchg}{$nick} //= {};
        for (keys %$section_content) {
            $r->{_cryp}{exchanges}{$xchg}{$nick}{$_} =
                $section_content->{$_};
        }
        return [204];
    }

    [200];
}

1;
# ABSTRACT: Perinci::CmdLine::Lite subclass to read entities from config

=head1 SEE ALSO

L<App::cryp> and other C<App::cryp::*> modules.

L<Perinci::CmdLine::Lite>

=cut
