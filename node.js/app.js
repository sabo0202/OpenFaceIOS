var WebSocketServer = require('ws').Server
var wss = new WebSocketServer({
 	host : '10.239.122.42',
 	port : 8080
});
var connections = [];

wss.on('connection', function(ws) {
 	connections.push(ws);
 	console.log('connection');

 	ws.on('message', function(message) {
 		console.log(message);
 		//broadcast(JSON.stringify(message));
 		broadcast(message);
 		//ws.send('Received your json text!');
 	});

 	ws.on('close', function() {
        	connections = connections.filter(function (conn, i) {
 			return (conn === ws) ? false : true;
        	});
 		console.log('close');
    	});
 });

//ブロードキャストを行う
function broadcast(message) {
    connections.forEach(function (con, i) {
        con.send(message);
    });
};
