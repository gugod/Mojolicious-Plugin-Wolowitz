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

=head1 SYNOPSIS

    # Enable this plugin in the startup method.
    sub startup {
        my $self = shift;
        $self->plugin('wolowitz');
        ...
    }


=head1 DESCRIPTION

L<Locale::Wolowitz> is a i18n tool that use JSON as its lexicon
storage.  This Mojolicious plugin is an alternative choice to do i18n
in Mojolicious.  You'll need to make a directory named C<i18n> under
you app home, and then put translation files into there. See
L<Locale::Wolowitz> for the content format of JSON files.

=method loc($message, @args)

Return the localized C<$message>. The language in question is retrieved
from app stash with key C<"language">. The default language key is C<"en">.

This plugin does not consult the value of C<"Accept"> HTTP request
header to automatically set the value of language.

For example:

    # In controller
    $self->stash(language => "zh-TW");

    # In view
    <%= loc("Nihao") %>

=cut
