class JackTokenizer
  attr_accessor :current_token, :tokens, :lines, :xml

  @@symbols = '{}[]().,;+-*/&|<>=~'.split(//)
  @@keywords = "class
                constructor
                function
                method
                field
                static
                var
                int
                char
                boolean
                void
                true
                false
                null
                this
                let
                do
                if
                else
                while
                return".split

  def initialize(filename)
    # opens the input file and gets ready to tokenize it

    @nest = []
    @xml = ''
    @lines = clean_lines(File.open(filename, 'r').read)
    @tokens = tokenize(@lines)
    advance

  end

  def has_more_tokens?
    @tokens.length > 0
  end

  def advance
    if has_more_tokens?
      @current_token = @tokens.shift
    end
  end

  def token_type

    if @@symbols.include?(@current_token)
      "SYMBOL"
    elsif @@keywords.include?(@current_token)
      "KEYWORD"
    elsif @current_token[0] == '"'
      "STRING_CONST"
    elsif @current_token.is_a?(Integer)
      "INT_CONST"
    else
      "IDENTIFIER"
    end

  end



    def key_word
      # returns the keyword which is the current token should be called only when token type is keyword
      @current_token
    end

    def symbol
      # returns the character which is the current token, should be called only when the current token is symbol
      @current_token
    end

    def identifier
      # returns the identifier which is the current token should be called only when token type is identifier
      @current_token
    end

    def int_val
      # returns the integer value of the current token. should be called only if the token type is int_const.
      @current_token.to_i
    end

    def string_val
      # returns the string value of the current token, without the double quotes. should be called only when token type is string_const.
      @current_token.delete('"').strip

    end


    def clean_lines(input)
      tokens = input.sub(/\/\*.*\*\//, '').split("\n")
      tokens.collect! do |e|
        e.sub(/\/\/.*$/, '').sub("\r", '').sub(/^\s*/, '')
      end

      tokens.reject! { |c| c.empty? }
    end


    def tokenize(lines)
      lines.map! { |line| line.split(//) }

      lines.each do |linearray|
        linearray.map! do |char|
          if @@symbols.include?(char) || char == '"'
            char = (' ' + char + ' ')
          else
            char
          end
        end
      end


      lines.map! { |line| line.join }
      lines.map! { |line| line.split }
      lines.flatten!

      lines.collect!.with_index do |token, index|
        if token[0] == '"'
          out = ''
          until out[-2] == '"'
            out += lines.delete_at(index + 1)
            out += ' '
          end
          out = '"' + out
          out
        else
          token
        end
      end

      return lines

    end
end
