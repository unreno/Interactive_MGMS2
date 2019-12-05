#	Interactive MGMS2

##	Description

MGMS2 (Membrane Glycolipid Mass Spectrum Simulator) Shiny app simulates in-silico mass spectra for polymicrobial samples. 
This interactive MGMS2 Shiny app allows users to simulate and visualize in-silico glycolipid mass spectra. 
It can be used to explore the effect of changes in parameters on simulated polymicoribal mass spectra. 
The app can be run locally or shared on-line at shinyapps.io (https://www.shinyapps.io/). 
MGMS2 R package is also available at R CRAN. 

An example MGMS2 app that simulates six microbes is at https://computationalomics.shinyapps.io/mgms2/. 
The six microbes are Acinetobacter baumannii, Enterobacter cloacae, Enterococcus faecium, 
Klebsiella pneumoniae, Pseudomonas aeruginosa, Staphylococcus aureus.

##	Developers
George A. Wendt and So Young Ryu

##	Reference
Ryu, S.R., Wendt, G.A., Ernst, R.K., and Goodlett, D.R., (2019+) MGMS2: Membrane Glycolipid Mass Spectrum Simulator for polymicrobial samples.(Under Review)

##	Getting Started
Requirement: R 3.5.3 or higher (https://www.r-project.org/)


###	Preparing Environment

```R
install.packages(c("shiny","MALDIquant","MALDIquantForeign","MGMS2"))
```

Clone this repository or download app.R and example data. To specify DIRECTORY in app.R (line 6), 
```R
mono.info=gather_summary_file(directory='<DIRECTORY>')
```

###	Running Interactive MGMS2 app locally

In R, 

```R
library(shiny)
runApp(launch.browser = TRUE)
```

or directly from the command line,

```BASH
R -e "library(shiny);runApp(launch.browser = TRUE)"
```




###	Posting Interactive MGMS2 app at ShinyApps.io

To prepare post on ShinyApps.io, 

```R
install.packages('rsconnect')
rsconnect::setAccountInfo(name='<ACCOUNT>',
	token='<TOKEN>',
	secret='<SECRET>')
```

Please specify ACCOUNT, TOKEN, and SECRET.
This only needs to be done once and will create a directory structure under "rsconnect/".

To post on ShinyApps.io,

```BASH
library(rsconnect)
rsconnect::deployApp(".",account="<ACCOUNT>",appName="mgms2")
```

Please specify ACCOUNT. 


###	Further Application

Users may want to include new microbiomes to build an interactive MGMS2 Shiny app.
This can be done by running a MGMS2 R package as the followings. 

1. Obtain mzXML files and a sample description (list.txt).
MGMS2 R package contains example mzXML files and a sample description file (e.g. listA.txt, listB.txt, and listC.txt).
See a MGMS2 R package manual for details. 

2. Create a file that contains summary statistics of a specified species by running,

```R
spectra.processed <- process_monospectra(
	file='<SAMPLE DESCRIPTION FILE>',
	mass.range=c(1000,2200))

summarize_monospectra

spectra.mono.summary.A <- summarize_monospectra(
	processed.obj=spectra.processed,
	species='<SPECIES>',
	directory='<DIRECTORY>')
```
Please specify SAMPLE DESCRIPTION FILE, SPECIES, and DIRECTORY. 

3. Use the resulting csv file(s) as data for the interactive MGMS2 app. 

4. Modify species_list in app.R if necessary,
```R
species_list <-   list(
	'<A>' = '<SPECIESA>',
	'<B>' = '<SPECIESB>',
	'<C>' = '<SPECIESC>',
	'<D>' = '<SPECIESD>',
	'<E>' = '<SPECIESE>',
	'<F>' = '<SPECIESF>'
)
```

Please modify A, B, ..., F, and SPECIESA, SPECIESB, ..., and SPECIESF.
A, B, ..., F are short names of species in a sample description file (e.g. list.txt).
SPECIESA, SPECIESB, ..., and SPECIESF are long names of species that will be displayed in the MGMS2 app. 


