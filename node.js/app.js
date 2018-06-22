var WebSocketServer = require('ws').Server
var wss = new WebSocketServer({
 	host : '10.10.8.20',
 	port : 8080
});
wss.on('connection', function(ws) {
 	ws.on('message', function(message) {
 		console.log('received: %s', message);
 		ws.send('Received your json text!');
 	});
 });
