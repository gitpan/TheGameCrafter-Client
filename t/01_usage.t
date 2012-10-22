use Test::More;
use Test::Deep;

use lib 'lib';
use 5.010;
use Ouch;

use_ok 'TheGameCrafter::Client';

# process responses
my $result = TheGameCrafter::Client::_process_response(HTTP::Response->new(200, 'OK', ['Content-Type' => 'application/json'], '{"result":{"foo":"bar"}}'));
is $result->{foo}, 'bar', 'process_response()';


# get
is tgc_get('_test')->{method}, 'GET', 'get';

# error
eval { tgc_get('/api/something/that/does/not/exist') };
is $@->code, '404', 'error handling works';

# put
is tgc_put('_test', {foo => 'bar'})->{method}, 'PUT', 'put';

# delete 
is tgc_delete('_test', {foo => 'bar'})->{method}, 'DELETE', 'delete';

# post & upload
cmp_deeply 
    tgc_post('_test', { file => ['t/upload.txt']}),  
    {
          "params" => {
             "file" => "upload.txt"
          },    
          "uploads" => [
             {
                "filename" => "upload.txt",
                "type" => "text/plain",
                "size" => "13"
             }
          ],
          "method" => "POST",
          "path" => "/api/_test"
    },
    'post / upload';

# really bad error
eval { TheGameCrafter::Client::_process_response(HTTP::Response->new(500, 'ERROR', ['Content-Type' => 'text/plain'], 'fubared')) };
isa_ok $@, 'Ouch';
is $@->code, 500, 'parsing error code works';
is $@->message, 'Server returned unparsable content.', 'parsing error message works';
is $@->data->{content}, 'fubared', 'parsing error data works';


done_testing();
