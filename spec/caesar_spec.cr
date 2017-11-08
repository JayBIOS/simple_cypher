require "./spec_helper"

describe SimpleCypher::Caesar do
    describe "#cypher" do
        it "should return the next char" do
            caesar = SimpleCypher::Caesar.new
            caesar.cypher("a", "1").should eq "b"
        end

        it "should return the first char" do
            caesar = SimpleCypher::Caesar.new
            caesar.cypher("'", "1").should eq "a"
        end
    end

    describe "#decypher" do
        it "should return the previous char" do
            caesar = SimpleCypher::Caesar.new
            caesar.decypher("b", "1").should eq "a"
        end

        it "should return the last char" do
            caesar = SimpleCypher::Caesar.new
            caesar.decypher("a", "1").should eq "'"
        end
    end
end
