#!/usr/bin/python 
# by hcbbt 2014-11-28 15:11:49
# 

import scrapy
class DmozSpider(scrapy.Spider):
    name = "dmoz"
    allowed_domains = ["dmoz.org"]
    start_urls = [
            "http://www.dmoz.org/Computers/Programming/Languages/Python/Books/",
            "http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/"
            ]

    def parse(self, response):
        for sel in response.xpath('//ul[@class="directory-url"]/li'):
            title = sel.xpath('a/text()').extract()
            link = sel.xpath('a/@href').extract()
            desc = sel.xpath('text()').re('-\s[^\n]*\\r')
            print "title: ", title
            print "link : ", link
            print "desc : ", desc

