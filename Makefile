#
# qclsip: The Quantum Cascade Laser Stock Image Project.
#
# Copyright (c) 2019, Computational Photonics Group, Technical University of
# Munich.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

SRC_DIR = src
OUT_DIR = fig
OUT_ZIP = fig.zip
DPI = 900

# input files
SVG_SOURCES = $(wildcard $(SRC_DIR)/*/*.svg)
TEX_SOURCES = $(wildcard $(SRC_DIR)/*/*.tex)

# output files
SVG2PDF = $(SVG_SOURCES:$(SRC_DIR)/%.svg=$(OUT_DIR)/%.pdf)
TEX2PDF = $(TEX_SOURCES:$(SRC_DIR)/%.tex=$(OUT_DIR)/%.pdf)
COMPPDF = $(SVG2PDF) $(TEX2PDF)
COMPEPS = $(COMPPDF:%.pdf=%.eps)
COMPPNG = $(COMPPDF:%.pdf=%.png)

# phony targets
all: pdf eps png

eps: $(COMPEPS)
	@echo "Build eps complete."

pdf: $(COMPPDF)
	@echo "Build pdf complete."

png: $(COMPPNG)
	@echo "Build png complete."

install: $(TIK2PDF) $(SVG2PNG)
	zip -FSr $(OUT_ZIP) $(COMPEPS) $(COMPPDF) $(COMPPNG)

clean:
	@rm -rf ./$(OUT_DIR) ./$(OUT_ZIP)

distclean: clean
	@rm -f *~ *#

.PHONY: all eps pdf png install clean distclean

# PDF generation from SVG files
$(SVG2PDF): $(OUT_DIR)/%.pdf: $(SRC_DIR)/%.svg
	@mkdir -p $(dir $@)
	@inkscape --export-area-drawing --export-pdf=$@ $<

# PDF generation from TikZ files
$(TEX2PDF): $(OUT_DIR)/%.pdf: $(SRC_DIR)/%.tex
	@latexmk -outdir=$(dir $@) -pdf -interaction=nonstopmode $<

# PNG generation from PDF files
$(COMPPNG): %.png: %.pdf
	pdftoppm -r $(DPI) -png $< > $@

# EPS generation from PDF files
$(COMPEPS): %.eps: %.pdf
	pdftops -eps $<
