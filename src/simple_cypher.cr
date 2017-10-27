require "./simple_cypher/*"
require "kemal"
require "json"

caesar = SimpleCypher::Caesar.new

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

Kemal.run
