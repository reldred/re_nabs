# Evil monstorous HNFO compiling makefile of DOOM!
# Written by Richard 'Aegir' Eldred. Major kudos to Josef 'Patchman' Drexler for the suggestion.

# MINI README:

# What we're doing here breaks away from NFO coding norms a bit by using C style includes in our NFO files. Our working NFO files we now give the extension ".hnfo". I have no idea what the significance of the H is, blame Josef for that. So now, we can break up a large NFO into multiple parts.

# From there, we use GCC to preprocess our HNFO. Unfortunatly it strips // comments but leaves # comments intact, so our processed NFO needs some nforenum loving (Which really should be done anyway to fix up sprite numbers and pseudosprite sizes, trying to do those by hand is madness).

# Lastly, with our NFORENUM processed NFO, we can then run GRFCODEC over it as usual.

# Instant lovin' for your large projects.

# Change the macro's around to suit your local configuration. I'm a lazy twot who uses grfcodec and nforenum via WINE. This allows my same TTD setup and dev environment to be portable back and forth between Windows and my own Linux machines.

# This should all work on a Windows machine with GCC and MAKE, although you will have to possibly change your CC macro to suit your setup.

# Lastly, you will just need to change around the relevent portion of the macros that alias your particular project, and then you should be about right.

# Have fun.

# Our Steps:
# 1: gcc -E preprocess
# 2: nforenum process
# 3: grfcodec compile

# Macros:
# Paths for our tools
GRFCODEC = ../../Executables/grfcodec.exe -e
NFORENUM = ../../Executables/nforenum.exe -b +
GRFDIR = ../../../../../DMZ/Software/Games/OpenTTD\ Nightly/newgrf/

# GCC Settings:
CC = gcc
PREPROCESS = -E -C -P - <

# Aliases for the set:
NAME = re_nabs

# Now, the fun stuff:

# Target for all:
all : compile

# Compile GRF's
#don't need graphics anymore since grfcodec can eat pngs
#compile : process graphics
compile : process
#	@echo "Compiling Windows GRF:"
#	$(GRFCODEC) $(NAME)w.nfo .
#	@echo
	@echo "Compiling OpenTTD/DOS GRF:"
	$(GRFCODEC) -em 1 $(NAME).nfo .
	@echo
	
# NFORENUM process the Windows copy of the NFO
process : preprocess
	@echo "NFORENUM Processing:"
	-$(NFORENUM) $(NAME).nfo
#	-cp $(NAME).nfo $(NAME)w.nfo
	@echo
	
# GCC Preprocess the HNFO	
preprocess :
	@echo "GCC Preprocessing HNFO:"
	$(CC) $(PREPROCESS) $(NAME).hnfo > $(NAME).nfo
	@echo

# so grfcodec can handle pngs now... 
#oh what wonders the new decade has wrought
#graphics :
#	@echo "Converting .png files to .pcx:"
#	$(MAKE) -C art/
#	@echo

# Clean the source tree
clean:
	@echo "Cleaning source tree:"
	@echo "Remove backups:"
	-rm *.bak *~
#	@echo
#	@echo "Remove .pcx:"
#	-rm art/*.pcx
	@echo
	@echo "Remove .nfo:"
	-rm *.nfo
	@echo
	@echo "Remove compiled .grf:"
	-rm *.grf

# Installation process
install:
	@echo Installing .grf files to $(GRFDIR).
#	@echo "Windows GRF:"
#	-cp $(NAME)w.grf $(GRFDIR)/$(NAME)w.grf
#	@echo
	@echo "DOS/OpenTTD GRF:"
	-cp $(NAME).grf $(GRFDIR)/$(NAME).grf
