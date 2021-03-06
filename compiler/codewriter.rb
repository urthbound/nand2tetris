class CodeWriter

  # these two lines evaluate external code and assign the output hash to this class var
  # eval(File.read('./libraries.rb'))
  # @@lib = make_asm_dict
  #maybe not a best practice way to do it but seems to make sense

  def initialize(output_file)
    # Opens the output file and gets ready to write into it
    output_file = output_file.delete('.vm') if output_file.include?('.vm')
    @output = File.open(output_file + '.asm', 'w+')
    @loop_count = 0
    @ret = 0
    @frame = 0
    @static_master_index  = 16
    @staticindex = 0
  end

  def static_master_index
    @static_master_index += 1
  end

  def staticindex
    @staticindex += 1
  end

  def frame
    @frame += 1
    @frame
  end

  def ret
    @ret += 1
    @ret
  end

  def looper
    @loop_count += 1
    @loop_count
  end

  def set_file_name(file_name)
    # Informs the code writer that the translation of a new VM file is started
    #
    @filename = file_name
    @static_master_index += @staticindex
    @staticindex = 0
  end

  def write_arithmetic(command)
    # Writes the assembly code that is the translation code of the given arithmetic command
    anchor = looper

    case command
    when 'add'
      @output << "//add\n@SP\nA=M-1\nD=M\n@SP\nM=M-1\nM=M-1\nA=M\nM=M+D\n@SP\nM=M+1\n"
    when 'sub'
      @output << "//sub\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nM=M-D\n@SP\nM=M+1\n"
    when 'eq'
      @output << "//eq\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\nM=1\nD=D-1\n(anchor.#{anchor})\n@SP\nA=M\nM=M-1\nD=D+1\n@anchor.#{anchor}\nD;JEQ\n@SP\nM=M+1\n"
    when 'lt'
      @output << "//lt\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\nM=1\nD=!D\n(anchor.#{anchor})\n@SP\nA=M\nM=M-1\n@anchor.#{anchor}\nD=!D\nD;JGT\n@SP\nM=M+1\n"
    when 'gt'
      @output << "//gt\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=D-M\nM=1\nD=!D\n(anchor.#{anchor})\n@SP\nA=M\nM=M-1\n@anchor.#{anchor}\nD=!D\nD;JLT\n@SP\nM=M+1\n"
    when 'and'
      @output << "//and\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nM=M&D\n@SP\nM=M+1\n"
    when 'or'
      @output << "//or\n@SP\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nM=M|D\n@SP\nM=M+1\n"
    when 'not'
      @output << "//not\n@SP\nM=M-1\nA=M\nM=!M\n@SP\nM=M+1\n"
    when 'neg'
      @output << "//neg\n@SP\nM=M-1\nA=M\nM=-M\n@SP\nM=M+1\n"
    end
  end

  def write_push_pop(command, segment, index)
    case segment
    when 'local'
      seg = 'LCL'
    when 'argument'
      seg = 'ARG'
    when 'this'
      seg = 'THIS'
    when 'that'
      seg = 'THAT'
    when 'pointer'
      seg = (3 + index.to_i).to_s
    when 'temp'
      seg = (5 + index.to_i).to_s
    when 'constant'
      seg = index
    when 'static'
      seg = "#{@filename}.#{staticindex.to_s}"
    end



    if command == 'C_PUSH'
      if segment == 'constant'
        @output << "//push constant #{index}\n@#{index}\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1\n"
      elsif segment == 'temp' || segment == 'pointer'
        @output << "//push #{seg} #{index}\n @#{seg}\n D=M \n @SP \n A=M\n M=D \n @SP \n M=M+1\n"
      elsif segment == 'static'
       @output << "//push #{seg} #{index}\n @#{(@static_master_index + index.to_i).to_s}\n D=M \n @SP \n A=M\n M=D \n @SP \n M=M+1\n"
      else
        @output << "//push #{seg} #{index}\n@#{index}\nD=A\n@#{seg}\nA=M+D\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n"
      end

    elsif command == 'C_POP'
      if segment == 'temp' || segment == 'pointer'
        @output << "//pop #{seg} #{index}\n @SP\n M=M-1 \n A=M \n D=M \n @#{seg}\n M=D\n "
      elsif segment == 'static'
        @output << "//pop #{seg} #{index}\n @SP\n M=M-1 \n A=M \n D=M \n@#{(@static_master_index + index.to_i).to_s}\n M=D \n"
      else
        @output << "//pop #{seg} #{index}\n @#{index}\nD=A\n@#{seg}\nM=M+D\n@SP\nM=M-1\nA=M\nD=M\n@#{seg}\nA=M\nM=D\n@#{index}\nD=A\n@#{seg}\nM=M-D\n"
      end
    end
  end

  def close
    @output.close
  end

  ###
  ###
  #This is where chapter 8 starts

  def write_init
    # writes assembly code that effects the VM initialization,
    # also called bootstrap code.
    # This code must be placed at the beginning of the output file.

    @output << "@256 \n D=A \n @SP \n M=D \n"
    write_call('Sys.init', '0')

  end

  def write_label(label)
    # writes assembly code that effects the label command
    @output << "// label #{label}\n(#{label})\n"
  end

  def write_goto(label)
    # writes assembly code that effects the goto command
    @output << "// goto #{label}\n@#{label}\n0;JMP\n"
  end

  def write_if(label)
    #writes assembly code that effects the if-goto command
    @output << "// if-goto #{label}\n@SP\nM=M-1\nA=M\nD=M\n@#{label}\nD;JNE\n"
  end

  def write_call(function_name, num_args)
    # writes assembly code that effects the call command
    #
      point = ret
      @output << "// function #{function_name} #{num_args}\n
                  @return.#{point}\n
                  D=A\n
                  @SP\n
                  A=M\n
                  M=D\n
                  @SP\n
                  M=M+1\n

                  @LCL\n
                  D=M\n
                  @SP\n
                  A=M\n
                  M=D\n
                  @SP\n
                  M=M+1\n

                  @ARG\n
                  D=M\n
                  @SP\n
                  A=M\n
                  M=D\n
                  @SP\n
                  M=M+1\n

                  @THIS\n
                  D=M\n
                  @SP\n
                  A=M\n
                  M=D\n
                  @SP\n
                  M=M+1\n

                  @THAT\n
                  D=M\n
                  @SP\n
                  A=M\n
                  M=D\n
                  @SP\n
                  M=M+1\n


                  @SP\n
                  D=M\n
                  @#{num_args}\n
                  D=D-A
                  @5
                  D=D-A
                  @ARG\n
                  M=D\n

                  @SP\n
                  D=M\n
                  @LCL\n
                  M=D\n
                  @#{function_name}\n
                  0;JMP\n
                  (return.#{point})\n"
  end

  def write_return
    # writes assembly code that effects the return command

    @output << "@LCL\n
                D=M\n
                @R13\n
                M=D\n

                @R13\n
                M=M-1\n
                M=M-1\n
                M=M-1\n
                M=M-1\n
                M=M-1\n
                A=M\n
                D=M\n
                @R14\n
                M=D\n

                @SP\n
                M=M-1\n
                A=M\n
                D=M\n
                @ARG\n
                A=M\n
                M=D\n

                @ARG\n
                D=M\n
                @SP\n
                M=D+1\n

                @R13\n
                M=M+1\n
                M=M+1\n
                M=M+1\n
                M=M+1\n
                A=M\n
                D=M\n
                @THAT\n
                M=D\n

                @R13\n
                M=M-1\n
                A=M\n
                D=M\n
                @THIS\n
                M=D\n

                @R13\n
                M=M-1\n
                A=M\n
                D=M\n
                @ARG\n
                M=D\n

                @R13\n
                M=M-1\n
                A=M\n
                D=M\n
                @LCL\n
                M=D\n

                @R14\n
                A=M
                0;JMP\n "
  end


  def write_function(function_name, num_locals)
    # writes assembly code that effects the function command
    looppoint= looper
    skip = looper

    @output << "(#{function_name})\n
                @#{num_locals}\n
                D=A\n
                @skip.#{skip}\n
                D;JEQ\n
                (loop.#{looppoint})\n
                @SP\n
                A=M\n
                M=0\n
                @SP\n
                M=M+1\n
                D=D-1\n
                @loop.#{looppoint}\n
                D;JGT\n
                (skip.#{skip})\n"
  end

end
