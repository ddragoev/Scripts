var http=require('http');
var ports = [80, 443, 91, 3000, 8000, 8080, 8081, 8443, 9000];
var servers = [];
var s;
function reqHandler(req, res) {
    console.log({
        remoteAddress: req.socket.remoteAddress,
        remotePort: req.socket.remotePort,
        localAddress: req.socket.localAddress,
        localPort: req.socket.localPort,
    });
	res.writeHead(200, {'Content-Type': 'text/html'});
    res.end('Its working, local server is running on ' + ports);
}
ports.forEach(function(port) {
    s = http.createServer(reqHandler);
    s.listen(port);
	
    servers.push(s);
});
console.log('Server started at ports ' + ports)
