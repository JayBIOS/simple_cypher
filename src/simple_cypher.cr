require "./simple_cypher/*"
require "kemal"
require "json"

caesar = SimpleCypher::Caesar.new

class CORSHandler < Kemal::Handler
    def call(context)
        context.response.headers["Access-Control-Allow-Origin"] = "*"
        context.response.headers["Access-Control-Allow-Methods"] = "*"
        context.response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        if context.request.method.downcase == "options"
            context.response.status_code = 200
            context.response.content_type = "text/html; charset=utf-8"
            context.response.print("")
        else
            call_next context
        end
    end
end
add_handler CORSHandler.new

def is_password_valid?(password)
    return /^[0-9 ]+$/ =~ password
end

def result(text)
    { "result" => text }.to_json
end

def password_invalid
    { "error" => "Password must contain only integers and spaces" }.to_json
end

before_all do |env|
    env.response.content_type = "application/json"
end

get "/" do |env|
    { "message" => "Simple Cypher, #IFRN.", "version" => SimpleCypher::VERSION }.to_json
end

post "/cypher" do |env|
    unless is_password_valid? env.params.json["password"]
        env.response.status_code = 400
        next password_invalid
    end
    result caesar.cypher(env.params.json["text"].as(String), env.params.json["password"].as(String))
end

post "/decypher" do |env|
    unless is_password_valid? env.params.json["password"]
        env.response.status_code = 400
        next password_invalid
    end
    result caesar.decypher(env.params.json["text"].as(String), env.params.json["password"].as(String))
end

Kemal.run ENV.has_key?("PORT") ? ENV["PORT"].to_i : 3000
