require "./spec_helper"

describe SimpleCypher do
    it "returns the application version on /" do
        get "/"
        JSON.parse(response.body)["version"].should eq SimpleCypher::VERSION
    end

    it "cypher a text correctly on /cypher" do
        json_body = { "text": "JayBIOS", "password": "512 256 128" }
        post "/cypher", headers: HTTP::Headers{ "Content-Type" => "application/json" }, body: json_body.to_json
        JSON.parse(response.body)["result"].should eq "Re}JNa1"
    end

    it "decypher a text correctly on /decypher" do
        json_body = { "text": "Re}JNa1", "password": "512 256 128" }
        post "/decypher", headers: HTTP::Headers{ "Content-Type" => "application/json" }, body: json_body.to_json
        JSON.parse(response.body)["result"].should eq "JayBIOS"
    end
end
