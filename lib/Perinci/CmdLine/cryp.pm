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

    if ($section_name =~ m!\Aexchange\s*/\s*([^/]+)(?:\s*/\s*(.+))?\z!) {
        my $xchg = $1;
        my $nick = $2 // 'default';
        $r->{_cryp}{exchanges}{$xchg}{$nick} //= {};
        for (keys %$section_content) {
            $r->{_cryp}{exchanges}{$xchg}{$nick}{$_} =
                $section_content->{$_};
        }
        return [204];
    }

    if ($section_name =~ m!\Awallet\s*/\s*([^/]+)(?:\s*/\s*(.+))?\z!) {
        my $coin = $1;
        my $nick = $2 // 'default';
        $r->{_cryp}{wallets}{$coin}{$nick} //= {};
        for (keys %$section_content) {
            $r->{_cryp}{wallets}{$coin}{$nick}{$_} =
                $section_content->{$_};
        }
        return [204];
    }

    if ($section_name =~ m!\Amasternode\s*/\s*([^/]++)(?:\s*/\s*(.+))?\z!) {
        my $coin = $1;
        my $nick = $2 // 'default';
        $r->{_cryp}{masternodes}{$coin}{$nick} //= {};
        for (keys %$section_content) {
            $r->{_cryp}{masternodes}{$coin}{$nick}{$_} =
                $section_content->{$_};
        }
        return [204];
    }

    if ($section_name =~ m!\Aarbit-strategy\s*/\s*([^/]++)\z!) {
        my $strategy = $1;
        $r->{_cryp}{arbit_strategy}{$strategy} //= {};
        for (keys %$section_content) {
            $r->{_cryp}{arbit_strategy}{$strategy}{$_} =
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
