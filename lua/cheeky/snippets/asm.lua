local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local parse = ls.parser.parse_snippet
local common = require "cheeky.common"

return {
  s(
    "start",
    c(1, {
      -- Apple silicon
      common.tmulti [[// APPLE SILICON ARM64 ASSEMBLY
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Unix system calls
// X16 - Mach System Call function number
//

.global _start			// Provide program starting address to linker
.align 2			// Make sure everything is aligned properly

// Setup the parameters to print hello world
// and then call the Kernel to do it.
_start: mov	X0, #1		// 1 = StdOut
	adr	X1, helloworld 	// string to print
	mov	X2, #13	    	// length of our string
	mov	X16, #4		// Unix write system call
	svc	#0x80		// Call kernel to output the string

// Setup the parameters to exit the program
// and then call the kernel to do it.
	mov     X0, #0		// Use 0 return code
	mov     X16, #1		// System call number 1 terminates this program
	svc     #0x80		// Call kernel to terminate the program

helloworld:      .ascii  "Hello World!\n"]],
      -- Arm Linux
      common.tmulti [[// LINUX ARM64 ASSEMBLY

			.data

/* Data segment: define our message string and calculate its length. */
helloworld:
    .ascii        "Hello, ARM64!\n"
helloworld_len = . - helloworld

.text

/* Our application's entry point. */
.globl _start
_start:
    /* syscall write(int fd, const void *buf, size_t count) */
    mov     x0, #1              /* fd := STDOUT_FILENO */
    ldr     x1, =helloworld     /* buf := msg */
    ldr     x2, =helloworld_len /* count := len */
    mov     w8, #64             /* write is syscall #64 */
    svc     #0                  /* invoke syscall */

    /* syscall exit(int status) */
    mov     x0, #0               /* status := 0 */
    mov     w8, #93              /* exit is syscall #1 */
    svc     #0                   /* invoke syscall */
			]],
    })
  ),
  -- parse("armlinux")
}
