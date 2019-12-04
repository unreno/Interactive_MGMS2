
library(shiny)

library(MGMS2)

mono.info = gather_summary_file(directory='Dummy_Mix')

sim.template <- create_insilico_mixture_template(mono.info) 

species_list <-   list(
  'Ab' = 'Acinetobacter baumannii',
  'Ec' = 'Enterobacter cloacae',
  'Ef' = 'Enterococus faecalis',
  'Kp' = 'Klebsiella pneumoniae',
  'Pa' = 'Pseudomonas aerugonusa',
  'Sa' = 'Staphylococcus aureus'
)

species = names(species_list)



#	Code outside "server" run once per R session (worker)
#	Code inside "server" run once per user (connection)
#	Code inside reactive function run once per reaction (lots)

######################################################################
#
#	NO ':' in inputId !
#
# Define UI for app that draws a histogram ----
ui <- fluidPage(

	# App title ----
	#titlePanel("Interactive Poly-bacterial In-silico Glycolipid Spectrum Simulator"),
	titlePanel("Interactive MGMS2 (Membrane Glycolipid Mass Spectrum Simulator for polymicrobial samples)"),

	# Sidebar layout with input and output definitions ----
	# Sidebar panel for inputs ----
	#	Sidebar Layout has a total width of 12, normally sidebar is 4 and main is 8.
	sidebarLayout(
		sidebarPanel( width=3,
			tabsetPanel(type = "tabs",
				tabPanel("Mixture Ratios", 

					#checkboxGroupInput(inputId = "species",
					#	label = "Species in a mixture:",
					#	inverted_species_list),

					#	For species.mixture.ratio, any non-negative numbers
					#	Mixture ratios ...
					#	species.mixture.ratio c(1, 1, 1, 1, 1, 1)

#						MGMS2::species,
#						function(i) {
#							sliderInput(inputId = i, label = MGMS2::species_list[[i]], min = 0, max = 1, value = 1, step = 0.01)
#						}
					lapply(
						species,
						function(i) {
							sliderInput(inputId = i, label = species_list[[i]], min = 0, max = 1, value = 1, step = 0.01)
						}
					)
			),
			tabPanel("Parameters", 

				#	mz.tol = 0.5
				#	For mz.tol, any non-negative numbers
				#	m/z tolerance ...
				#sliderInput( inputId = "mz.tol", 
				#	label = "m/z tolerance:", 
				#	value = 0.5, min = 0, max = 2, step = 0.01),

				#	mixture.missing.prob.peak = 0.05
				#	allow some peaks to be missing
				#	For Mixtures.missing.prob.peak, between 0 and 1 including 0 excluding 1
				#	Missing rates of peaks ...
				sliderInput(inputId = "mixture.missing.prob.peak",
					label = "Mixture missing probabilities of peaks:",
					step = 0.01,
					min = 0.00, max = 0.99,
					value = 0.05),

				# no. of noise peaks /no. of signature ion peaks; if you don't want to add noise then enter 0
				#	noise.peak.ratio = 0.20 NOW 0.05
				#	For noise.peak.ratio, any non-negative number
				#	Ratio between # of noise peaks and signal peaks ...
				sliderInput( inputId = "noise.peak.ratio", 
					label = "Ratio between # of noise peaks and signal peaks:", 
					value = 0.05, min = 0, max = 1, step = 0.01),

				#	snr.basepeak = 200 NOW 500
				#	if noise.peak.ratio is greater than 0, this has a meaning
				#	For snr.basepeak, greater than 1
				#	Base peak to noise ratio ...
				sliderInput(inputId = "snr.basepeak", 
					label = "Base peak to noise ratio:", 
					value = 500, min = 1, max = 1000, step = 1),

				#	noise.cv = 0.50 NOW 0.25
				#	coefficients of variation = standard deviation / mean of noise
				#	Noise peak intensity coefficient of variation ...
				sliderInput(inputId = "noise.cv", 
					label = "Coefficient of variation of noise peak intensity:", 
					value = 0.25, min = 0, max = 3, step = 0.01)

				)	#	tabPanel
			)	#	tabsetPanel
		),	#	sidebarPanel(

		# Main panel for displaying outputs ----
		mainPanel( width=9,
			plotOutput(outputId = "spectrum",height="800px")
		)	#	mainPanel(

	)	#	sidebarLayout( 
)	#	ui <- fluidPage(


######################################################################

server <- function(input, output) {

	output$spectrum <- renderPlot({

		mixture.ratio <- list()

		for( specie in species ){
			mixture.ratio[specie]=input[[specie]]
		}

		insilico.spectrum <- simulate_poly_spectra(sim.template, mixture.ratio, spectrum.name='',
			mixture.missing.prob.peak = input$mixture.missing.prob.peak,
			noise.peak.ratio = input$noise.peak.ratio,
			snr.basepeak = input$snr.basepeak,
			noise.cv = input$noise.cv,
			mz.range=c(1000,2200))

	})

}

shinyApp(ui = ui, server = server)

