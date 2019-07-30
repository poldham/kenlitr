# Kenlit

This repository compiles open access data on scientific publications from Kenya. The aim of Kenlit is to compile scientific publications about Kenya available in open access form to assist policy makers, researchers and the wider community with accessing research about Kenya. To view the data in interactive form please visit the [Tableau public web page](https://public.tableau.com/profile/poldham#!/vizhome/kenya_mag/KenyaOverview?publish=yes). Kenlit has been developed in the context of a wider collaboration with the [National Commission for Science, Technology and Innovation (NACOSTI)](https://www.nacosti.go.ke/) in Kenya and the German Technical Cooperation (GIZ) focusing on biodiversity related research.

Kenlit is in an early stage of development and the data should not be regarded as complete. For further information please see the known issues below.

Kenlit is available for R as the `kenlitr` package. Due to its size it is not on CRAN but can be installed from github.

```r
devtools::install_github("poldham/kenlitr")
```
To download the data in this repository as a single 170MB zip file containing all the csv files click [here](https://storage.googleapis.com/impossiblestorage/kenlit.zip).

## Data Sources

Kenlit data is presently drawn from two sources. These form distinct datasets that are linked by a common identifier (paperid). The sources are:

1. Microsoft Academic Graph (January 2019 Release) which is provided under an [Open Data Commons Attribution Licence (ODC-By) v. 1.0](https://opendatacommons.org/licenses/by/1.0/). Visit [Microsoft Academic Graph](https://www.microsoft.com/en-us/research/project/microsoft-academic-graph/) to learn more and view the [documentation](https://docs.microsoft.com/en-us/academic-services/graph/).

2. [The Lens](https://www.lens.org/). The Lens is an open access database for scientific and patent literature. The Lens has recently expanded coverage of the scientific literature to include Crossref, PubMed, Microsoft Academic Graph, and CORE (for open access full text articles).

Data from MAG is used to identify research outputs from organisations in Kenya based on affiliationids for Kenya that match to ids in the Global Research Identifier Database ([GRID](https://www.grid.ac/downloads)). 

Data from the Lens (which aggregates from a range of sources) is used to identify other scientific publications about Kenya. 

At present `Kenlit` consists of: 

- 28,462 publications directly linked to organisations in Kenya.
- 160,654 publications that make reference to Kenya in the title, abstract, author keywords or full texts but are not directly linked to Kenyan research organisations. 

### Data processing

Data processing is carried out using a Databricks Apache Spark cluster using the `sparklyr` package to work with Microsoft Academic Graph. 

Data cleaning is carried out in R using `tidyverse` packages. Additional data cleaning is performed using VantagePoint from Search Technology Inc. Data is mainly visualized in Tableau. 

Kenlit is a work in progress and suggestions or corrections are welcome.

### Known Issues

Kenlit is a work in progress. Please note the following issues. 

a) Incomplete author affiliation data. 130,581 of the papers in the dataset lack an affiliation identifier and require cleaning. This arises either because affilition data is missing in the Microsoft Academc Graph data, or because a name has not been matched to an affiliation id. 

b) There were reports on early versions of MAG based on small samples of data (one institution) that not all authors names were reflected in a record. The extent to which this reflects a wider issue or remains an issue in recent updates is unclear. This would require a larger scale validation effort to assess.

c) Counts may vary depending on the data source. This is likely to reflect the use of different editions. 

### Contributing

Contributions to Kenlit are welcome. Kenlit is released with a [Contributor Code of Conduct](https://github.com/poldham/kenlitr/blob/master/CODE_OF_CONDUCT.md) and when contributing you agree to be bound by its terms. 