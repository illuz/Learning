#!/usr/bin/python 
# by hcbbt 2014-11-23 20:11:08
# 

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

# define: global options object
define("port", default = 8000, help = "Run on the given port", type = int)

# inheritance from RequestHandler
class IndexHandler(tornado.web.RequestHandler):
    # HTTP get requests
    def get(self):
        # built-in methods: get_argument, write
        greeting = self.get_argument('greeting', 'Hello')
        self.write(greeting + ', friendly user!')

if __name__ == "__main__":
    # may change port
    tornado.options.parse_command_line()

    # Create Application object, handlers can have regex+RequestHandler pairs
    app = tornado.web.Application(handlers = [(r"/", IndexHandler)])

    # create an httpserver listen to the port
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)

    # create an IOLoop to accept the http requests
    tornado.ioloop.IOLoop.instance().start()

# http://localhost:8000/
# http://localhost:8000/?greeting=Salutations 

