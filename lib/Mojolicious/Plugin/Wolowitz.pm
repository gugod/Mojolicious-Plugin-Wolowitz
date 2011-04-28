package Mojolicious::Plugin::Wolowitz;
use Mojo::Base 'Mojolicious::Plugin';
use Locale::Wolowitz;

sub register {
    my ($self, $app, $config) = @_;

    my $w = Locale::Wolowitz->new( $app->home->rel_dir("i18n") );
    $app->helper(
        loc => sub {
            my ($app, @args) = @_;
            $w->loc(@args, $app->stash('language'));
        }
    );
}

1;
