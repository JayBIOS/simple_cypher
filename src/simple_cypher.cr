require "./simple_cypher/*"
require "kemal"
require "json"

caesar = SimpleCypher::Caesar.new

static_headers do |response, filepath, filestat|
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "*"
    response.headers.add("Content-Size", filestat.size.to_s)
end

before_all do |env|
    env.response.content_type = "application/json"
end

get "/" do |env|
    { "message" => "Simple Cypher, #IFRN.", "version" => SimpleCypher::VERSION }.to_json
end

post "/cypher" do |env|
    { "result" => caesar.cypher(env.params.json["phrase"].as(String), env.params.json["password"].as(String)) }.to_json
end

post "/decypher" do |env|
    { "result" => caesar.decypher(env.params.json["phrase"].as(String), env.params.json["password"].as(String)) }.to_json
end

Kemal.run ENV.has_key?("PORT") ? ENV["PORT"].to_i : 3000
