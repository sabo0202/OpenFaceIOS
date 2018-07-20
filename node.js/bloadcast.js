var WebSocketServer = require('ws').Server
var wss = new WebSocketServer({
 	host : '10.10.0.28',
 	port : 8080
});
var connections = [];

wss.broadcast = function (data) {
 	for (var i in this.clients) {
 		this.clients [i].send (data);
 	}
};

wss.on('connection', function(ws) {
 	connections.push(ws);
 	console.log('connection');

 	ws.on ('message', function (message) {
        	var now = new Date();
        	console.log (now.toLocaleString() + ' Received: %s', message);
        	wss.broadcast (message);
 	});

 	ws.on('close', function() {
        	connections = connections.filter(function (conn, i) {
 			return (conn === ws) ? false : true;
        	});
 		console.log('close');
    	});
 });
