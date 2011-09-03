##
# name:      Pegex::AST
# abstract:  Pegex Abstract Syntax Tree Object Class
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

package Pegex::AST2;
use Pegex::Receiver -base;

sub __got__ {
    my ($self, $kind, $rule, $match) = @_;
# warn "got: $kind, $rule\n";
# WWW $match if $kind eq 'all';
    my $ref = ref($match) or die '$match is not a ref';
    if (ref($match) eq 'HASH') {
        return +{
            $rule => $match,
        };
    }
    elsif ($ref eq 'ARRAY') {
        my $size = @$match;
        if ($kind eq 'rgx') {
            return [] if $size == 0;
            $match = $match->[0] if $size == 1;
            return +{ $rule => $match };
        }
        if ($kind =~ /^(?:all|any)$/) {
#             WWW $match;
#             die if $main::x++ > 3;
            my $value = [
                map {
                    (ref($_) eq 'ARRAY') ? (
                        (not @$_) ? () :
                        (@$_ == 1) ? $_->[0] : $_
                    ) : $_
                } @$match
            ];
            $value = $value->[0] if @$value == 1;
            return +{ $rule => $value };
        }
        else {
            die "kind '$kind' not supported";
        }
    }
    else {
        XXX $match;
    }
}

sub __final__ {
    my $self = shift;
    my $match = shift;
    $self->data($match);
}

1;
