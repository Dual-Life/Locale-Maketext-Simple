use strict;
use warnings;
use Test::More;
use File::Basename qw(dirname);

use Locale::Maketext::Simple (
    Path => dirname(__FILE__) . '/po_without_i_default',
    Style => "gettext",
);

eval {
    require Locale::Maketext::Lexicon;
    Locale::Maketext::Lexicon->VERSION(0.20);
    1;
} or do {
    plan skip_all => 'No soft dependencies, i_default will not work';
};

plan tests => 5;

loc_lang("en");
is(loc("Not a lexicon key"), "Not a lexicon key", "Not a lexicon key");
is(loc("I have got %1 alerts", 65), "I have got 65 alerts", "Got auto key" );
is(loc("I have acknowledged %1 alerts", 83), "Yo dude, I've been working on these 83 alerts", "Got translation");

loc_lang("fr");
is(loc("system.messages.arbitrary.unique.lexicon.key"), "system.messages.arbitrary.unique.lexicon.key", "No translation" );
is(loc("I have got %1 alerts", "red"), "Mon Francais red, c'est terrible", "French translated" );

