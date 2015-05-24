.text
        ldr     sp, =stack_top  // Set stack pointer for C code environment
        bl      main            // Branch C code
        b       .               // Loop forever
