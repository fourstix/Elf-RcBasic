PROJECT = rcbasic

$(PROJECT).prg:
        echo Must specify target: elfos erom pico mchip

elfos: $(PROJECT).asm
	echo Building for Elf/OS
	../dateextended.pl > date.inc
	../build.pl > build.inc
	asm02 -l -L -DELFOS $(PROJECT).asm
	mv $(PROJECT).prg x.prg
	cat x.prg | sed -f adjust.sed > $(PROJECT).prg
	rm x.prg

erom: $(PROJECT).asm
	echo Building for Elf/OS ROM
	../dateextended.pl > date.inc
	../build.pl > build.inc
	asm02 -l -L -DELFOS -DEROM  $(PROJECT).asm
	mv $(PROJECT).prg x.prg
	cat x.prg | sed -f adjust.sed > $(PROJECT).prg
	rm x.prg

pico: $(PROJECT).asm
	echo Building for Pico/Elf ROM
	asm02 -l -L -DPICOROM  $(PROJECT).asm

mchip: $(PROJECT).asm
	echo Building for MemberChip ROM
	asm02 -l -L -DMCHIP  $(PROJECT).asm

clean:
	-rm $(PROJECT).prg
	-rm $(PROJECT).lst
