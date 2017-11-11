require "big_int"

module SimpleCypher
    class Caesar

        @chars : Array(String)

        def initialize
            unless File.file?("dicionario.txt")
                puts "\e[31mArquivo \"dicionario.txt\" não encontrado!\e[0m"
                exit
            end

            dictionary = File.read_lines("dicionario.txt")
            @chars = (dictionary.map { |line| line.split("") unless line.starts_with? "#" }).flatten.compact
        end

        def cypher(text : String, password : String) : String
            add = -> (x : Int32, y : BigInt) { x + y }
            process(text, password, add)
        end

        def decypher(text : String, password : String) : String
            subtract = -> (x : Int32, y : BigInt) { x - y }
            process(text, password, subtract)
        end

        def process(text : String, password : String, index_calculation : (Int32, BigInt) -> BigInt) : String
            return text.split("\n").map { |line| process_line(line, password, index_calculation) }.join("\n")
        end

        def process_line(line : String, password : String, index_calculation : (Int32, BigInt) -> BigInt) : String
            steps = password.split.map { |n| n.to_big_i }
            rotation = 0
            result = ""

            line.split("").each do |char|
                position = @chars.index char

                next if position.nil?

                index = index_calculation.call(position, steps[rotation].to_big_i) % (@chars.size)

                encrypted_char = @chars[index]

                result += encrypted_char.nil? ? char : encrypted_char

                rotation += 1
                rotation = 0 if rotation >= steps.size
            end

            result
        end
    end
end
