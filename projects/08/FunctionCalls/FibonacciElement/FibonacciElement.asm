// sys init
@256
 D=A
@SP
M=D
// function Sys.init 0

                  @return.1

                  D=A

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @LCL

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @ARG

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THIS

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THAT

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @SP

                  D=M

                  @0

                  D=D-A

                  @5
                  D=D-A
                  @ARG

                  M=D


                  @SP

                  D=M

                  @LCL

                  M=D

                  @Sys.init

                  0;JMP

                  (return.1)
(Main.fibonacci)

                @0

                D=A


                @skip.2

                D; JLE



                (loop.1)

                @SP

                A=M

                M=0

                @SP

                M=M+1

                D=D-1
                @loop.1

                D;JGT

                (skip.2)
//push ARG 0
 @ARG
 D=M 
 @SP 
 A=M
 M=D 
 @SP 
 M=M+1
//push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// if-goto IF_TRUE
@SP
M=M-1
A=M
D=M
@IF_TRUE
D;JNE
// goto IF_FALSE
@IF_FALSE
0;JMP
// label IF_TRUE
(IF_TRUE)
//push ARG 0
 @ARG
 D=M 
 @SP 
 A=M
 M=D 
 @SP 
 M=M+1
@LCL

                D=M

                @R13

                M=D


                @R13

                M=M-1

                M=M-1

                M=M-1

                M=M-1

                M=M-1

                A=M

                D=M

                @R14

                M=D


                @SP

                A=M-1

                D=M

                @ARG

                A=M

                M=D


                @ARG

                D=M+1

                @SP

                M=D


                @R13

                M=M+1

                M=M+1

                M=M+1

                M=M+1

                A=M

                D=M

                @THAT

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @THIS

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @ARG

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @LCL

                M=D


                @R14

                A=M
                0;JMP

                // label IF_FALSE
(IF_FALSE)
//push ARG 0
 @ARG
 D=M 
 @SP 
 A=M
 M=D 
 @SP 
 M=M+1
//push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
//sub
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
// function Main.fibonacci 1

                  @return.2

                  D=A

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @LCL

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @ARG

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THIS

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THAT

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @SP

                  D=M

                  @1

                  D=D-A

                  @5
                  D=D-A
                  @ARG

                  M=D


                  @SP

                  D=M

                  @LCL

                  M=D

                  @Main.fibonacci

                  0;JMP

                  (return.2)
//push ARG 0
 @ARG
 D=M 
 @SP 
 A=M
 M=D 
 @SP 
 M=M+1
//push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//sub
@SP
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
// function Main.fibonacci 1

                  @return.3

                  D=A

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @LCL

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @ARG

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THIS

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THAT

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @SP

                  D=M

                  @1

                  D=D-A

                  @5
                  D=D-A
                  @ARG

                  M=D


                  @SP

                  D=M

                  @LCL

                  M=D

                  @Main.fibonacci

                  0;JMP

                  (return.3)
@LCL

                D=M

                @R13

                M=D


                @R13

                M=M-1

                M=M-1

                M=M-1

                M=M-1

                M=M-1

                A=M

                D=M

                @R14

                M=D


                @SP

                A=M-1

                D=M

                @ARG

                A=M

                M=D


                @ARG

                D=M+1

                @SP

                M=D


                @R13

                M=M+1

                M=M+1

                M=M+1

                M=M+1

                A=M

                D=M

                @THAT

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @THIS

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @ARG

                M=D


                @R13

                M=M-1

                A=M

                D=M

                @LCL

                M=D


                @R14

                A=M
                0;JMP

                (Sys.init)

                @0

                D=A


                @skip.8

                D; JLE



                (loop.7)

                @SP

                A=M

                M=0

                @SP

                M=M+1

                D=D-1
                @loop.7

                D;JGT

                (skip.8)
//push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
// function Main.fibonacci 1

                  @return.4

                  D=A

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @LCL

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @ARG

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THIS

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @THAT

                  D=M

                  @SP

                  A=M

                  M=D

                  @SP

                  M=M+1


                  @SP

                  D=M

                  @1

                  D=D-A

                  @5
                  D=D-A
                  @ARG

                  M=D


                  @SP

                  D=M

                  @LCL

                  M=D

                  @Main.fibonacci

                  0;JMP

                  (return.4)
// label WHILE
(WHILE)
// goto WHILE
@WHILE
0;JMP
