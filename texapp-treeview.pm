# NOTE: Best I can tell you need to open Treeview at least once and make sure
# it's authorized. Otherwise it just returns a 404, even though the URL is
# valid.
#
# You'll need to add `exts=/path/to/texapp-treeview.pm` to your .texapprc or
# call Texapp with `texapp -exts=/path/to/texapp-treeview.pm`.
#
# From a running Texapp instance, call with /tree [menucode]
#
$addaction = sub {
	my $command = shift;

	if ($command =~ s#^/tree ## && length($command)) {
		my $post = &get_post($command);
		if (!$post->{'id'}) {
			&std(" -- sorry, no such post (yet?): $command\n");
			return 1;
		}
		my $canonical_id = $post->{'id'};
		# I use the following command, because I call an external script with
		# urlopen in .texapprc:
		#
		# system "xdg-open", "http://treeview.us/home/Form?postID=$canonical_id";
		#
		# You'll probably want this:
		&openurl("http://treeview.us/home/Form?postID=$canonical_id");
		return 1;
	}

	return 0;
};
