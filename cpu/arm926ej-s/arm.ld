SECTIONS {
         . = 0x00010000;
         .text                  : { * (.text) }
         .data                  : { * (.data) }
         .rodata                : { * (.rodata*) }
         .bss                   : { * (.bss) }
         . = ALIGN(8);
         . = . + 0x1000;
         stack_top = .;
}
