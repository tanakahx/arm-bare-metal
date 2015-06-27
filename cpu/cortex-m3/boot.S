        .equ    stack_top, 0x20000800
        .text
	.code 16
	.syntax unified

        .word stack_top
        .word start
        .type start, function
start:  
        bl       main
        b       .
