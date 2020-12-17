SWIG := ./swig
SWIG_LOCATION := /c/it64/fbedit
SWIG_FLAGS := -I$(SWIG_LOCATION) -freebasic -module

HEADERS := $(wildcard *.h)
MODULES := $(HEADERS:%.h=%)

all	:
	for i in $(MODULES); do \
		$(SWIG) $(SWIG_FLAGS) $$i $$i.h 2> errors.txt; \
	done