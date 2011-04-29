package Mojolicious::Plugin::Wolowitz;
# ABSTRACT: Mojo I18n with Locale::Wolowitz

use Mojo::Base 'Mojolicious::Plugin';
use Locale::Wolowitz;

sub register {
    my ($self, $app, $config) = @_;

    my $w = Locale::Wolowitz->new( $app->home->rel_dir("i18n") );
    $app->helper(
        loc => sub {
            my ($app, $message, @args) = @_;
            $w->loc($message, $app->stash('language') || 'en' , @args);
        }
    );
}

1;

=method loc($message, @args)

Return the localized C<$message>. The target language is retrieved from app stash.

For example:

    # In controller
    $self->stash("zh-TW");

    # In view
    <%= loc("Nihao") %>

=cut
