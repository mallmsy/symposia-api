require 'activerecord-reset-pk-sequence'

# require 'rest-client'
# API_KEY = "cba4b9a885984bc49ddefc159d1fbb23"
# LEFT_SOURCES = "cnn,the-new-york-times,cbs-news,the-huffington-post,msnbc"
# CENTER_SOURCES = "bbc-news,the-wall-street-journal,associated-press,bloomberg,reuters,usa-today"
# RIGHT_SOURCES = "fox-news,breitbart-news,national-review,the-american-conservative"
# date = Date.today - 10.days
# DATE = date.to_s
#
# CATEGORIES = ["CLIMATE", "IMMIGRATION", "2020", "NATIONAL+DEBT", "ABORTION", "BORDER" ]

Post.destroy_all


Post.reset_pk_sequence

puts "seed complete 😻"
