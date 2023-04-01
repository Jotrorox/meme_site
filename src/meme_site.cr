require "http/server"
require "http/client"
require "json"

module MemeSite
  VERSION = "0.1.0"


  server = HTTP::Server.new do |context|
    response = HTTP::Client.get("https://meme-api.com/gimme")
    json = JSON.parse(response.body)
    image_url = json["url"]
    post_url = json["postLink"]
    post_title = json["title"]
    html = "<!DOCTYPE html>
    <html lang=\"en\">
    <head>
        <meta charset=\"UTF-8\">
        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        <title>MEME SITE</title>
        <style>
            #img {
                display: block;
                margin-left: auto;
                margin-right: auto;
                max-width: 40%;
                max-height: 40%;
                height: auto;
                width: auto;
            }
            #title {
                text-align: center;
                font-size: 2rem;
            }
        </style>
    </head>
    <body>
        <p id=\"title\">#{post_title}</p>
        <a href=\"#{post_url}\">
            <img id=\"img\" src=\"#{image_url}\">
        </a>
    </body>
    </html>"
    context.response.content_type = "text/html"
    context.response.print(html)
  end

  puts "Listening on http://127.0.0.1:8080"
  server.listen(8080)
end
