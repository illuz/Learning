#!/usr/bin/python 
# by hcbbt 2014-11-24 10:28:56
# tornado template
# poem maker pro

import os.path

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

# define: global options object
define("port", default=8000, help="Run on the given port", type=int)


# '/'
# RequestHandler built-in method render tell tornado to read in a
# template file
class IndexHandler(tornado.web.RequestHandler):
    # HTTP get requests
    def get(self):
        self.render('index.html')
    
    # def write_error(self, status_code, **kwargs):


# '/poem'
# render will replace the {{}} in html files
class PoemPageHandler(tornado.web.RequestHandler):
    def post(self):
        noun1 = self.get_argument('noun1')
        noun2 = self.get_argument('noun2')
        verb = self.get_argument('verb')
        noun3 = self.get_argument('noun3')
        self.render('poem.html', roads=noun1, wood=noun2, made=verb,
                difference=noun3)

    # def write_error(self, status_code, **kwargs):


if __name__ == "__main__":
    # may change port
    tornado.options.parse_command_line()

    # Create Application object
    app = tornado.web.Application(
            handlers = [
                (r'/', IndexHandler),
                (r'/poem', PoemPageHandler)
                ],
            template_path = os.path.join(
                os.path.dirname(__file__), "templates"
                )
            )

    # loop
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

# http://localhost:8000/
