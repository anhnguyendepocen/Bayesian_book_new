library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribution viewer"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
           selectInput("lowerDist", "Lower Distribution type:",
                       c("Normal" = "Normal",
                         "Uniform" = "Uniform",
                         "Log-Normal" = "LogNormal",
                         "Exponential" = "Exponential",
                         "Gamma" = "Gamma",
                         "t" = "t",
                         "Beta"="Beta",
                         "Cauchy"="Cauchy",
                         "Half-Cauchy"="HalfCauchy",
                         "Inverse-Gamma"="InverseGamma",
                         "Inverse-Chi-Squared"="InverseChiSquared",
                         "Logit-Normal"="LogitNormal")),
           selectInput("upperDist1", "Upper Distribution 1 type:",
                       c("Normal" = "Normal",
                         "Uniform" = "Uniform",
                         "Log-Normal" = "LogNormal",
                         "Exponential" = "Exponential",
                         "Gamma" = "Gamma",
                         "t" = "t",
                         "Beta"="Beta",
                         "Cauchy"="Cauchy",
                         "Half-Cauchy"="HalfCauchy",
                         "Inverse-Gamma"="InverseGamma",
                         "Inverse-Chi-Squared"="InverseChiSquared",
                         "Logit-Normal"="LogitNormal")),
           selectInput("upperDist2", "Upper Distribution 2 type:",
                       c("Normal" = "Normal",
                         "Uniform" = "Uniform",
                         "Log-Normal" = "LogNormal",
                         "Exponential" = "Exponential",
                         "Gamma" = "Gamma",
                         "t" = "t",
                         "Beta"="Beta",
                         "Cauchy"="Cauchy",
                         "Half-Cauchy"="HalfCauchy",
                         "Inverse-Gamma"="InverseGamma",
                         "Inverse-Chi-Squared"="InverseChiSquared",
                         "Logit-Normal"="LogitNormal")),
      sliderInput("sampleSize", "Sample size", min=10, max=20000, value=1000),
      sliderInput("numBins", "number of bins", min=10, max=1000, value=50),
      conditionalPanel("input.upperDist1=='Normal'",
                       sliderInput("muN1", "Mean of upper normal 1", min=-5, max=5, value=0),
                       sliderInput("sigmaN1", "Standard deviation of upper normal 1", min=0, max=10, value=1)),
      conditionalPanel("input.upperDist2=='Normal'",
                       sliderInput("muN2", "Mean of upper normal 2", min=-5, max=5, value=0),
                       sliderInput("sigmaN2", "Standard deviation of upper normal 2", min=0, max=10, value=1)),
      conditionalPanel("input.upperDist1=='Uniform'",
                       sliderInput("aU1", "Lower of uniform 1", min=-5, max=5, value=0),
                       sliderInput("bU1", "Upper of uniform 1", min=-5, max=5, value=0)),
      conditionalPanel("input.upperDist2=='Uniform'",
                       sliderInput("aU2", "Lower of uniform 2", min=-5, max=5, value=0),
                       sliderInput("bU2", "Upper of uniform 2", min=-5, max=5, value=0)),
      conditionalPanel("input.upperDist1=='LogNormal'",
                      sliderInput("meanlog1", "Mu of log-normal 1", min=-5, max=5, value=0),
                      sliderInput("sdlog1", "Sigma of log-normal 1", min=0, max=5, value=0)),
      conditionalPanel("input.upperDist2=='LogNormal'",
                       sliderInput("meanlog2", "Mu of log-normal 2", min=-5, max=5, value=0),
                       sliderInput("sdlog2", "Sigma of log-normal 2", min=0, max=5, value=0)),
      br()
    ),
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot of PDF", plotOutput("plot"))
      )
    )
  )
)
)
