#!/usr/bin/python 
# by hcbbt 2014-11-23 20:57:10
# 

import textwrap

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

define("port", default = 8000, help = "run on the given port", type = int)

class ReverseHandler(tornado.web.RequestHandler):
    # input is the first ()
    def post(self, input):
        self.write(input[::-1])

class WrapHandler(tornado.web.RequestHandler):
    def pos(self):
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

                # this sentense is unavailable (???)
                (r"/wrap", WrapHandler)
                ]
            )
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()



# http://localhost:8000/reverse/slipup
# http://localhost:8000/wrap -d text=Lorem+ipsum+dolor+sit+amet,+consectetuer+adipiscing+elit.
# I don't know why the second address return 404
