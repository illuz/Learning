#!/usr/bin/python 
# by hcbbt 2014-11-23 20:57:10
# tornado 4.0.2

import textwrap

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

define("port", default = 8000, help = "run on the given port", type = int)

# (r"/reverse/(\w+)", ReverseHandler),
class ReverseHandler(tornado.web.RequestHandler):
    # input is the first ()
    def get(self, input):
        self.write(input[::-1])

# (r"/wrap", WrapHandler)
class WrapHandler(tornado.web.RequestHandler):
    def post(self):
        # self.write("hehe")
        text = self.get_argument('text')
        width = self.get_argument('width', 40)
        self.write(textwrap.fill(text, int(width)))

if __name__ == "__main__":
    tornado.options.parse_command_line()
    app = tornado.web.Application(
            handlers = [
                # () contains argument
                (r"/reverse/(\w+)", ReverseHandler),

                (r"/wrap", WrapHandler)
                ]
            )
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()



# curl http://localhost:8000/reverse/slipup

# curl -d text=Lorem+ipsum+dolor+sit+amet,+consectetuer+adipiscing+elit. http://localhost:8000/wrap
