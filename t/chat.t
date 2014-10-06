use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../chat.pl";


my $cant = 260;

my $tsender = Test::Mojo->new;
#prepare publisher
$tsender->websocket_ok('/echo')->status_is('101', 'publisher websocket connected');


my $t = Test::Mojo->new;

#
# Single channel example, just to understand the idea
#

$t->websocket_ok('/echo')
  ->status_is('101', 'websocket connection')
  ->send_ok("abcd0000")				# send something to himself (alone in chat room)
  ->message_ok
  ->message_like(qr/abcd0000/);

# publishes message "abcd0001" to all connected chats
$tsender->send_ok("abcd0001")->message_ok;
# and checks it
$t->message_ok->message_like(qr/abcd0001/)->finish_ok;

#
# Now opens $cant different subscription channels
#

my @ta;

for my $i (0..$cant-1) {
	$ta[$i] = Test::Mojo->new;
	$ta[$i]	->websocket_ok("/echo")
}

#
# ...sends data to the chat room with $cant channels
#

	$tsender->send_ok("from_sender_message")->message_ok;


#
# ...and checks data on each connected chatter
#

for my $j (0..$cant-1) {
	my $i = ($j*37) % $cant;
	$ta[$i]->message_ok->message_like(qr/from_sender_message/)->finish_ok;
}

$tsender->finish_ok;

done_testing();