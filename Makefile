PROJECT = rcbasic

$(PROJECT).prg: $(PROJECT).asm bios.inc
	../dateextended.pl > date.inc
	cpp $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 temp
	cat temp.prg | sed -f adjust.sed > $(PROJECT).prg

elfos: $(PROJECT).asm bios.inc
	../dateextended.pl > date.inc
	../build.pl > build.inc
	cpp -DELFOS $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 -DELFOS temp 2>&1 | tee rcbasic.lst
	cat temp.prg | sed -f adjust.sed > $(PROJECT).prg

test: $(PROJECT).asm bios.inc
	../date.pl > date.inc
	rcasm -l -v -x -d1802 $(PROJECT)


clean:
	-rm $(PROJECT).prg

