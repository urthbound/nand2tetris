class CompilationEngine

  def initilize(input)
    #creates a new compilation engine with the given input and output. The next routine to be called must be compile_class()
  end


  def compile_class
    # compiles a complete class
  end


  def compile_class_var_dec
    # compiles a static declaration
  end


  def compile_subroutine
    # compiles a complete method, function, or constructor
  end


  def compile_parameter_list
    # compiles a (possibly empty) parameter list, not including the enclosing ()
  end


  def compile_var_dec
    # compiles a var declaration
  end


  def compile_statements
    # compiles a sequence of statements, not including the enclosing {}
  end


  def compile_do
    # compiles a do statement, and motivates highly redundant comments
  end


  def compile_let
    # compiles a let statement
  end


  def compile_while
    # compiles a while statement
  end


  def compile_return
    # compiles a return statement
  end


  def compile_if
    # compiles an if statement, possibly with a trailing else clause
  end


  def compile_expression
    # compiles_expression
  end


  def compile_term
    # compiles a term.  This routine is faced with a slight difficulty when trying to decide between some of the alternative parsing rules.  Specifically, if the current token is an identifier, the routine must distinguish between a variable, an array entry, and a subroutine call.  A single look-ahead token, which may be one of [, (, or . suffices to distinguish between the three possibilities.  Any other token is not part of this term and should not be advanced over.

  end

  def compile_expression_list
    # compiles a (possibly empty) comma-separated list of expressions
  end
end



    def xml_tokenize

      while has_more_tokens?

#         if @current_token == 'class'
#           @xml += "<class>\n"
#           @nest << "class"
#         elsif @current_token == 'function'
#           @xml += "<subroutineDec>\n"
#           @nest << "subroutineDec"
#           @state = :subroutine
#         elsif @current_token == ")"
#           @xml += "</parameterList>\n"
#         end

#         if @current_token == "{" && @state == :subroutine
#           @xml += "<subroutineBody>\n"
#         end

        type = token_type.downcase
        case type
        when 'keyword'
          type = 'keyword'
          out = key_word
        when 'symbol'
          type = 'symbol'
          out = symbol
        when 'identifier'
          type = 'identifier'
          out = identifier
        when 'int_const'
          type = 'integerConstant'
          out = int_val
        when 'string_const'
          type = 'stringConstant'
          out = string_val
        end


        @xml += "<#{type}> #{out} </#{type}>\n"

#         if @current_token == "("
#           @xml += "<parameterList>\n"
#         elsif @current_token == '}'
#           @xml += "</#{@nest.pop}>\n"
#         end

        advance

      end


    end