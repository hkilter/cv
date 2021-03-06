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
## Makefile
MAKEFILE = makefile
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
## compile command
COMPILE = xelatex --jobname=${OUTPUTBASE}$* "\newcommand{\SelectedColorSchemeNumber}{$(shell bash -c 'echo $$(( $$RANDOM % 4 + 1 ))')}\newcommand{\SelectedLanguage}{$*}\input{${INPUT}}"


# make ZIP
${ZIP}: $(PDF) ${README.md} ${MAKEFILE}
	# prepare directories
	mkdir -p ${OUTPUTDIR}
	mkdir -p ${OUTPUTDIR}${SOURCESDIR}
	# add PDFs
	for i in $(PDF); do cp $$i ${OUTPUTDIR}$$i; done
	# add sources
	cp ${INPUT} ${OUTPUTDIR}${SOURCESDIR}${INPUT}
	cp -a ${IMAGESDIR} ${OUTPUTDIR}${SOURCESDIR}${IMAGESDIR}
	for i in $(PACKAGES); do cp $$i ${OUTPUTDIR}${SOURCESDIR}$$i; done
	cp ${README} ${OUTPUTDIR}${SOURCESDIR}${README}
	cp ${MAKEFILE} ${OUTPUTDIR}${SOURCESDIR}${MAKEFILE}
	# zip it
	zip -r ${ZIP} ${OUTPUTDIR}
	# clean up
	rm -r ${OUTPUTDIR}
	rm ${OUTPUTBASE}*.*
	
# make PDFs
${OUTPUTBASE}%.pdf: ${INPUT} $(PACKAGES) ${IMAGES}
	${COMPILE}
	${COMPILE}