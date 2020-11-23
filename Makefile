FC := gfortran
FFLAGS := -O3 -g -std=f2008 -Wall -Wextra
PROGS := test

.PHONY:	all clean

all: 	$(PROGS)

clean:
	$(RM) $(PROGS) *.o *.mod

# How to get executables from .f90 source files
%: %.f90
	$(FC) -o $@ $^ $(FFLAGS)

# How to get object files from .f90 source files
%.o: %.f90
	$(FC) -c -o $@ $^ $(FFLAGS)

# Dependencies
$(PROGS): m_spline_interp.o
