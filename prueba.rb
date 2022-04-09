require "uri"
require "net/http"
require "json"

def request(url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    
    response = https.request(request)
    JSON.parse(response.read_body)
end

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=XdnbymJbsxa3Bis1kWmsz14zk4Ch0jPiDa7akYdS")
# selected_data = data["bpi"].select do |key, value|
#     value < 40000
# end
# response = data["photos"][0].select[|x| x["img_src"]]

array = data["photos"]

photos = array.map do |photo|
    photo["img_src"]
    # puts photo
end

# photos = photos[0..9]

header = ""
html = ""
photos[0..9].each do |photo|
    # <head>
    # </head>
    # <body>
    #     <ul>
    # header = "<html>\n<head>"
        
            html += "\t\t<li><img src='#{photo}'></li>\n"
    #     </ul>
    # </body>
    # </html>
end
# puts "<html><head></head><body>Hello world</body></html>"
fileHtml = File.new('index.html', "w+")
fileHtml.puts "<HTML>"
fileHtml.puts "<HEAD>"
fileHtml.puts "</HEAD>"
fileHtml.puts "<BODY>"
fileHtml.puts "\t<ul>"
fileHtml.puts html
fileHtml.puts "\t</ul>"
fileHtml.puts "</BODY>"
fileHtml.puts "</HTML>"