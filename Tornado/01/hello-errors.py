#!/usr/bin/python 
# by hcbbt 2014-11-24 10:19:44
# tornado basic

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

# define: global options object
define("port", default = 8000, help = "Run on the given port", type = int)


# (r"/"), or add [(\d+)(\w+)]
class ExampleHandler(tornado.web.RequestHandler):
    # HTTP get requests
    def get(self):
        self.write("This is a test")
    
    # def post(self):
    # def put(self):
    # def head(self):
    def write_error(self, status_code, **kwargs):
        self.write("Yo, you get a %d error." % status_code)


if __name__ == "__main__":
    # may change port
    tornado.options.parse_command_line()

    # Create Application object
    app = tornado.web.Application(
            handlers = [
                (r"/", ExampleHandler)
                ]
            )

    # loop
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

# http://localhost:8000/
