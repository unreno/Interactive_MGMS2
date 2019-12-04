#	Interactive MGMS2

This is a Shiny app to demo the ability of the MGMS2 R package.
The code is shared. The data is not.


##	Prepare Environment


```BASH
R -e 'install.packages(c("shiny","MALDIquant","MALDIquantForeign"));devtools::install_github("unreno/MGMS2")'
```

```BASH
R -e 'install.packages(c("shiny","MALDIquant","MALDIquantForeign","MGMS2"))'
```


##	Run Locally

```BASH
R -e 'library(shiny);runApp(launch.browser = TRUE)'
```


##	Pre-Post

To prepare post on ShinyApps.io ...

```R
install.packages('rsconnect')
rsconnect::setAccountInfo(name='computationalomics',
		token='<KINDA SECRET>',
		secret='<SECRET>')
```

This only needs to be done once.


##	Post

To post on ShinyApps.io ...

```BASH
R -e 'library(rsconnect);rsconnect::deployApp(".",account="computationalomics",appName="mgms2")'
```

