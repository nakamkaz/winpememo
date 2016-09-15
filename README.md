# winpememo
WinPE memo

## usage of peedit.cmd

edit peedit.cmd 

:setenv
echo setenv
set PE_ARCH=__x86__
set PE_BASE=__C:\hack\pettt__

### set arch and target directory

peedit.cmd  setenv

### Create PE 

peedit.cmd  copype

### Mount WIM image

peedit.cmd  mountimg

### Adding some packages and setting language 

peedit.cmd  addpkg

### check Pakages installed

peedit.cmd  getpkg

### make ISO file
peedit.cmd  makeiso

