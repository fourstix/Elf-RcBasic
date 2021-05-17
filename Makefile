PROJECT = rcbasic

$(PROJECT).prg: $(PROJECT).asm bios.inc
	cpp $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 temp 2>&1 | tee rcbasic.lst
	cat temp.prg | sed -f adjust.sed > $(PROJECT).prg

elfos: $(PROJECT).asm bios.inc
	../dateextended.pl > date.inc
	../build.pl > build.inc
	cpp -DELFOS $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 -DELFOS temp 2>&1 | tee rcbasic.lst
	cat temp.prg | sed -f adjust.sed > $(PROJECT).prg

pico: $(PROJECT).asm bios.inc
	cpp -DMCHIP $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 -DPICOROM temp 2>&1 | tee rcbasic.lst
	mv temp.prg $(PROJECT).prg

mchip: $(PROJECT).asm bios.inc
	cpp -DMCHIP $(PROJECT).asm -o - | sed -e 's/^#.*//' > temp.asm
	rcasm -l -v -x -d1802 -DMCHIP temp 2>&1 | tee rcbasic.lst
	mv temp.prg $(PROJECT).prg

test: $(PROJECT).asm bios.inc
	../date.pl > date.inc
	rcasm -l -v -x -d1802 $(PROJECT)


clean:
	-rm $(PROJECT).prg

