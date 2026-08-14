#
# This Makefile can be used to build the sshrc-insight class and
# package it for distribution on CTAN.
#
# It also contains some recipes to help compare application
# instructions across years, which can be useful when updating
# sshrc-insight for a new application year.
#
# Copyright 2024-2026 Tristan Miller
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3c
# of this license or (at your option) any later version.
# The latest version of this license is in
#   https://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX
# version 2008 or later.
#

PDFLATEX=pdflatex
CTANIFY=ctanify
TEXDIR=tex/latex/sshrc-insight
DOCDIR=doc/latex/sshrc-insight

GENERATED_EXTENSIONS=aux bbl bcf blg idx log out pdf run.xml synctex.gz gls ilg toc

TEMPLATE_PROPOSAL=insight_proposal.tex insight_proposal.bib budget_justification.tex career_interruptions.tex detailed_description.tex exclusion_of_potential_reviewers.tex expected_outcomes.tex knowledge_mobilization_plan.tex list_of_references.tex multi-interdisciplinary_evaluation.tex previous_critiques.tex research_contributions.tex research-creation_support_material.tex research_team.tex summary.tex
SSHRC_INS_FILES=sshrc-insight.cls $(TEMPLATE_PROPOSAL)
SSHRC_PREVIOUS_VERSIONS=2024-10-12 2026-07-17

CURL=curl
PANDOC=pandoc
prev_year_en=https://sshrc-crsh.canada.ca/en/funding/opportunities/insight-grants/2025/competition/instructions/applicant.aspx
prev_year_fr=https://sshrc-crsh.canada.ca/fr/financement/occasions/subventions-savoir/2025/concours/instructions/candidat.aspx
curr_year_en=https://sshrc-crsh.canada.ca/en/funding/opportunities/insight-grants/2026/competition/instructions/applicant.aspx
curr_year_fr=https://sshrc-crsh.canada.ca/fr/financement/occasions/subventions-savoir/2026/concours/instructions/personne-candidate.aspx

# Build the class, template insight_proposal, and documentation
all: insight_proposal.pdf sshrc-insight.pdf

# Extract the source files from sshrc-insight.dtx
$(SSHRC_INS_FILES): sshrc-insight.ins sshrc-insight.dtx
	$(PDFLATEX) sshrc-insight.ins

# Build the template insight_proposal
insight_proposal.pdf: $(SSHRC_INS_FILES)
	$(PDFLATEX) insight_proposal.tex
	$(PDFLATEX) insight_proposal.tex

# Build the documentation
sshrc-insight.pdf: sshrc-insight.dtx
	$(PDFLATEX) sshrc-insight.dtx
	$(PDFLATEX) sshrc-insight.dtx
	$(PDFLATEX) sshrc-insight.dtx

# Package sshrc for distribution on CTAN
sshrc-insight.tar.gz dist ctanify: insight_proposal.pdf sshrc-insight.pdf README.md $(foreach version,$(SSHRC_PREVIOUS_VERSIONS),sshrc-insight-$(version).cls)
	$(CTANIFY) sshrc-insight.ins $^ insight_proposal.tex=$(DOCDIR) $(foreach file,$(TEMPLATE_PROPOSAL),$(file)=$(DOCDIR))

# Generate the lists of instruction files
KEYS=prev_year_en prev_year_fr curr_year_en curr_year_fr
HTML_FILES=$(addsuffix .html,$(KEYS))
TXT_FILES=$(addsuffix .txt,$(KEYS))

# Fetch the HTML instructions
$(HTML_FILES): %.html:
	$(CURL) -sS -L -o $@ $($*)

# Convert the instructions to plain text
instructions: $(TXT_FILES)
%.txt: %.html
	$(PANDOC) --to=plain -o $@ $<

# Remove all generated files
clean:
	$(RM) sshrc-insight.cls sshrc-insight.glo sshrc-insight.hd sshrc-insight.tar.gz $(SSHRC_INS_FILES) $(foreach ext,$(GENERATED_EXTENSIONS),sshrc-insight.$(ext)) $(foreach ext,$(GENERATED_EXTENSIONS),$(foreach file,$(TEMPLATE_PROPOSAL),$(basename $(file)).$(ext))) $(TXT_FILES) $(HTML_FILES)

.PHONY: clean dist ctanify instructions

.PRECIOUS: $(HTML_FILES)
