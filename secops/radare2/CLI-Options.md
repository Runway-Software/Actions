# More info is available at: https://r2wiki.readthedocs.io/en/latest/home/misc/cheatsheet/
# https://book.rada.re/first_steps/commandline_flags.html

$ radare2 -h
Usage: r2 [-ACdfLMnNqStuvwzX] [-P patch] [-p prj] [-a arch] [-b bits] [-i file]
          [-s addr] [-B baddr] [-m maddr] [-c cmd] [-e k=v] file|pid|-|--|=
 --           run radare2 without opening any file
 -            same as 'r2 malloc://512'
 =            read file from stdin (use -i and -c to run cmds)
 -=           perform !=! command to run all commands remotely
 -0           print \x00 after init and every command
 -2           close stderr file descriptor (silent warning messages)
 -a [arch]    set asm.arch
 -A           run 'aaa' command to analyze all referenced code
 -b [bits]    set asm.bits
 -B [baddr]   set base address for PIE binaries
 -c 'cmd..'   execute radare command
 -C           file is host:port (alias for -c+=http://%s/cmd/)
 -d           debug the executable 'file' or running process 'pid'
 -D [backend] enable debug mode (e cfg.debug=true)
 -e k=v       evaluate config var
 -f           block size = file size
 -F [binplug] force to use that rbin plugin
 -h, -hh      show help message, -hh for long
 -H ([var])   display variable
 -i [file]    run script file
 -I [file]    run script file before the file is opened
 -k [OS/kern] set asm.os (linux, macos, w32, netbsd, ...)
 -l [lib]     load plugin file
 -L           list supported IO plugins
 -m [addr]    map file at given address (loadaddr)
 -M           do not demangle symbol names
 -n, -nn      do not load RBin info (-nn only load bin structures)
 -N           do not load user settings and scripts
 -q           quiet mode (no prompt) and quit after -i
 -Q           quiet mode (no prompt) and quit faster (quickLeak=true)
 -p [prj]     use project, list if no arg, load if no file
 -P [file]    apply rapatch file and quit
 -r [rarun2]  specify rarun2 profile to load (same as -e dbg.profile=X)
 -R [rr2rule] specify custom rarun2 directive
 -s [addr]    initial seek
 -S           start r2 in sandbox mode
 -t           load rabin2 info in thread
 -u           set bin.filter=false to get raw sym/sec/cls names
 -v, -V       show radare2 version (-V show lib versions)
 -w           open file in write mode
 -x           open without exec-flag (asm.emu will not work), See io.exec
 -X           same as -e bin.usextr=false (useful for dyldcache)
 -z, -zz      do not load strings or load them even in raw

aa: Analyze all (fcns + bbs) same that running r2 with -A
ahl <length> <range>: fake opcode length for a range of bytes
ad: Analyze data
ad@rsp (analyze the stack)
af: Analyze functions
afl: List all functions
    number of functions: afl~?
afi: Returns information about the functions we are currently at
afr: Rename function: structure and flag
afr off: Restore function name set by r2
afn: Rename function
    afn strlen 0x080483f0
af-: Removes metadata generated by the function analysis
af+: Define a function manually given the start address and length
    af+ 0xd6f 403 checker_loop
axt: Returns cross references to (xref to)
axf: Returns cross references from (xref from)
d, f: Function analysis
d, u: Remove metadata generated by function analysis
ao x: Analyze x opcodes from current offset
a8 bytes: Analyze the instruction represented by specified bytes
iI: File info
iz: Strings in data section
izz: Strings in the whole binary
iS: Sections
    iS~w returns writable sections
is: Symbols
    is~FUNC exports
il: Linked libraries
ii: Imports
ie: Entrypoint
i~pic : check if the binary has position-independent-code
i~nx : check if the binary has non-executable stack
i~canary : check if the binary has canaries
psz n @ offset: Print n zero terminated String
px n @ offset: Print hexdump (or just x) of n bytes
pxw n @ offset: Print hexdump of n words
    pxw size@offset  prints hexadecimal words at address
pd n @ offset: Print n opcodes disassembled
pD n @ offset: Print n bytes disassembled
pi n @ offset: Print n instructions disassembled (no address, XREFs, etc. just instructions)
pdf @ offset: Print disassembled function
    pdf~XREF (grep: XREFs)
    pdf~call (grep: calls)
pcp n @ offset: Print n bytes in python string output.
    pcp 0x20@0x8048550
    import struct
    buf = struct.pack ("32B",
    0x55,0x89,0xe5,0x83,0xzz,0xzz,0xzz,0xzz,0xf0,0x00,0x00,
    0x00,0x00,0xc7,0x45,0xf4,0x00,0x00,0x00,0x00,0xeb,0x20,
    0xc7,0x44,0x24,0x04,0x01,0x00,0x00,0x00,0xzz,0xzz)
p8 n @ offset: Print n bytes (8bits) (no hexdump)
pv: Print file contents as IDA bar and shows metadata for each byte (flags , ...)
pt: Interpret data as dates
pf: Print with format
pf.: list all formats
p=: Print entropy ascii graph
wx: Write hex values in current offset
    wx 123456
    wx ff @ 4
wa: Write assembly
    wa jnz 0x400d24
wc: Write cache commit
wv: Writes value doing endian conversion and padding to byte
wo[x]: Write result of operation
    wow 11223344 @102!10
        write looped value from 102 to 102+10
        0x00000066  1122 3344 1122 3344 1122 0000 0000 0000
    wox 0x90
        XOR the current block with 0x90. Equivalent to wox 0x90 $$!$b (write from current position, a whole block)
    wox 67 @4!10
        XOR from offset 4 to 10 with value 67
wf file: Writes the content of the file at the current address or specified offset (ASCII characters only)
wF file: Writes the content of the file at the current address or specified offset
wt file [sz]: Write to file (from current seek, blocksize or sz bytes)
    Eg: Dump ELF files with wt @@ hit0* (after searching for ELF headers: \x7fELF)
wopO 41424344 : get the index in the De Bruijn Pattern of the given word
f: List flags
f label @ offset: Define a flag `label` at offset
    f str.pass_len @ 0x804999c
f-label: Removes flag
fr: Rename flag
fd: Returns position from nearest flag (looking backwards). Eg => entry+21
fs: Show all flag spaces
fs flagspace: Change to the specified flag space
y n: Copies n bytes from current position
y: Shows yank buffer content with address and length where each entry was copied from
yp: Prints yank buffer
yy offset: Paste the contents of the yank buffer at the specified offset
yt n target @ source: Yank to. Copy n bytes from source to target address
q: Exits visual mode
hjkl: move around (or HJKL) (left-down-up-right)
o: go/seek to given offset
?: Help
.: Seek EIP
<enter>: Follow address of the current jump/call
:cmd: Enter radare commands. Eg: x @ esi
d[f?]: Define cursor as a string, data, code, a function, or simply to undefine it.
    dr: Rename a function
    df: Define a function
v: Get into the visual code analysis menu to edit/look closely at the current function.
p/P: Rotate print (visualization) modes
    hex, the hexadecimal view
    disasm, the disassembly listing
        Use numbers in [] to follow jump
        Use "u" to go back
    debug, the debugger
    words, the word-hexidecimal view
    buf, the C-formatted buffer
    annotated, the annotated hexdump.
c: Changes to cursor mode or exits the cursor mode
    select: Shift+[hjkl]
    i: Insert mode
    a: assembly inline
    A: Assembly in visual mode
    y: Copy
    Y: Paste
    f: Creates a flag where cursor points to
    <tab> in the hexdump view to toggle between hex and strings columns
V: View ascii-art basic block graph of current function
W: WebUI
x, X: XREFs to current function. ("u" to go back)
t: track flags (browse symbols, functions..)
gG: Begging or end of file
HUD
    _ Show HUD
    backspace: Exits HUD
    We can add new commands to HUD in: radare2/shlr/hud/main
;[-]cmt: Add/remove comment
m<char>: Define a bookmark
'<char>: Go to previously defined bookmark
/R opcodes: Search opcodes
    /R pop,pop,ret
/Rl opcodes: Search opcodes and print them in linear way
    /Rl jmp eax,call ebx
/a: Search assembly
    /a jmp eax
pda: Returns a library of gadgets that can be use. These gadgets are obtained by disassembling byte per byte instead of obeying to opcode length
e search.roplen = 4  (change the depth of the search, to speed-up the hunt)
/ bytes: Search bytes
    \x7fELF

Cd [size]: Define as data
C- [size]: Define as code
Cs [size]: Define as String
Cf [size]: Define as struct
    We can define structures to be shown in the disassembly
CC: List all comments or add a new comment in console mode
    C* Show all comments/metadata
    CC <comment> add new comment
    CC- remove comment

    pm: Print Magic files analysis
    [0x00000000]> pm
    0x00000000 1 ELF 32-bit LSB executable, Intel 80386, version 1
    :yara scan

    zg <language> <output file>: Generate signatures
    eg: zg go go.z
Run the generated script to load signatures
    eg: . go.z
z: To show signatures loaded:

r2-(pid2)> pd 35 @ 0x08049adb-10
|          0x08049adb   call fcn.0805b030
|             fcn.0805b030(unk, unk, unk, unk) ; sign.sign.b.sym.fmt.Println
|          0x08049ae0   add esp, 0xc
|          0x08049ae3   call fcn.08095580

r2 -m 0xf0000 /etc/fstab    ; Open source file
o /etc/issue                ; Open file2 at offset 0
o                           ; List both files
cc offset: Diff by columns between current offset address and "offset"
ag $$ > a.dot: Dump basic block graph to file
ag $$ | xdot -: Show current function basic block graph

af: Load function metadata
agc $$ > b.dot: Dump basic block graph to file
dot -Tpng -o /tmp/b.png b.dot
radiff2 -g main crackme.bin crackme.bin > /tmp/a
xdot /tmp/a
