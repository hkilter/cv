# MAKEFILE TO BUILD CV AND PORTFOLIO

# Variables
## List of available languages
LANGUAGES = german english
## Input file name
INPUT = cv_tobiw.tex
## Readmefile
README = README.md
## Style fiels (packages)
PACKAGES = citobiw.sty cvtobiw.sty
## Image directory
IMAGESDIR = img/
## Sources directory
SOURCESDIR = sources/
## Output directory
OUTPUTDIR = cv_tobiw/
## Output file base
OUTPUTBASE = cv_tobiw_
## PDF files
PDF = $(LANGUAGES:%=${OUTPUTBASE}%.pdf)
## ZIP file name
ZIP = cv_tobiw.zip


# make ZIP
${ZIP}: $(PDF) ${README.md}
	# prepare directories
	mkdir -p ${OUTPUTDIR}
	mkdir -p ${OUTPUTDIR}${SOURCESDIR}
	# add PDFs
	for i in $(PDF); do cp $$i ${OUTPUTDIR}$$i; done
	# add readme
	cp ${README} ${OUTPUTDIR}${README}
	# add sources
	cp ${INPUT} ${OUTPUTDIR}${SOURCESDIR}${INPUT}
	cp -a ${IMAGESDIR} ${OUTPUTDIR}${SOURCESDIR}${IMAGESDIR}
	for i in $(PACKAGES); do cp $$i ${OUTPUTDIR}${SOURCESDIR}$$i; done
	# zip it
	zip -r ${ZIP} ${OUTPUTDIR}
	# clean up
	rm -r ${OUTPUTDIR}
	rm ${OUTPUTBASE}*.*
	
# make PDFs
${OUTPUTBASE}%.pdf: ${INPUT} $(PACKAGES) ${IMAGES}
	xelatex --jobname=${OUTPUTBASE}$* "\newcommand{\selectedlanguage}{$*}\input{${INPUT}}"
	xelatex --jobname=${OUTPUTBASE}$* "\newcommand{\selectedlanguage}{$*}\input{${INPUT}}"
