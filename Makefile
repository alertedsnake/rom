SHELL=/bin/bash

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: clean install upload docs test

default:
	find . -type f | xargs chmod -x

clean:
	-rm -f *.pyc rom/*.pyc MANIFEST
	-rm -rf dist build

install:
	python setup.py install

upload:
	python setup.py sdist upload

test:
	PYTHONPATH=`pwd` python test/test_rom.py

docs:
	python -c "import rom; open('README.rst', 'wb').write(rom.__doc__); open('VERSION', 'wb').write(rom.VERSION);"
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	cd _build/html/ && zip -r9 ../../rom_docs.zip * && cd ../../
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."
