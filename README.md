Rb-XMacro by Mike Smullin <mike@smullindesign.com>
============

** RB-XMacro lets you automate your keyboard and mouse movements in XWindows using Ruby. **

Installation
------------

on Ubuntu 10.04 LTS (Lucid Lynx) 64-bit:

    sudo aptitude install xmacro

this will get you the last known release of xmacro
but it only supports a minimum delay of 1 second
which is extremely slow. too slow for me. so below
i have modified the source of xmacroplay binary
so that you can sleep for milliseconds:

    sudo aptitude install libxtst-dev
    cd src/xmacro-pre0.3-20000911/
    make xmacroplay
    sudo mv xmacroplay /usr/bin/xmacroplay

Usage
------------

 - View scripts under ./example/
 - Write your own script using similar syntax.
 - Execute by passing path to your script as first argument to rbxmacro bash script, leaving off the file extension of .rb.
 - Watch is xmacro performs your automated keyboard/mouse movements.
 - Ctrl+C to stop execution, or wait for script to finish.
 - Enjoy!


Example
------------

    ./rbxmacro example/awesome-workspace-setup

I use it to automate setting up my development workspace, but its similar
to Ruby Expect in power and utility. You could technically use it to ssh
into remote servers and execute queries. The only problem is it is one-way;
right now the macro program is not triggered by events and can only wait
with a sufficient delay that it usually works. 

Future goals
------------

At some point, I would like to see this extended to function more like AutoHotkey does for Windows.
http://www.autohotkey.com/

Credits
------------

RB-XMacro is written by Mike Smullin and is released under the GPLv2 license.
based on Xmacro by Gabor Keresztfalvi <keresztg@mail.com> see http://xmacro.sourceforge.net/
based on xremote by Jan Ekholm <chakie@infa.abo.fi> see http://freshmeat.net/projects/xremote/
