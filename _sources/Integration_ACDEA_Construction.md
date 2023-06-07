### Construction Workflow

#### Overview of Construction Workflow
---
The construction of the Australian Cultural Data Engine Architecture (ACDEA) follows a general methodology that integrates a unified data model from all the existing data models of the data sources. This is a bottom-up approach that ensures that all the relevant data is included and organised into a coherent and integrated database.

Importantly, to achieve this methodology, the construction of ACDEA follows the principles below:

- **Refer to the Most Comprehensive Existing Data Models**: ACDEA aims to include all relevant attributes from various cultural data sources into the unified entities (levels). Therefore, the most comprehensive entity structure was referred to and analysed to ensure that ACDEA includes the most relevant and useful attributes of specific entity from all sources. For instance, to construct its own `person` level, ACDEA refers to the `person` data model from DAAO, which is a person-oriented data collection.
<br><br>

- **Keep Differences & Unify Common**: The construction of ACDEA required reconciling differences between the data models of different sources, which is a significant challenge. To maintain the completeness of the original data sources and integrate the similarities of data attributes, ACDEA follows the principle of keeping differences between the data models that are significant and add value to the data, while unifying common elements to ensure consistency and usability. This approach helps to capture the unique characteristics of each data source and ensure that ACDEA includes all relevant information.
<br><br>

- **Fuzzy Mapping**: This involves mapping data attributes from different sources to a common attribute in the unified data model, even if they are not an exact match. For instance, the DAAO has an attribute called `other_occupations` and the AusStage has an attribute called `(contributing) functions`, these attributes can be mapped to a common attribute in ACDEA called `career`. This allows ACDEA to capture as much information as possible while still maintaining consistency and usability.

Although the construction process varies across different data sources, there is a general construction workflow that has been established for integrating the data sources into ACDEA.

![ACD-Engine Architecture Construction Workflow](./images/ivy_images/ACD-Engine+Architecture_Construction_Workflow.png)

#### Data Extraction
---
The first step in constructing ACDEA involves extracting or scraping data from various data sources. This process may involve using web scraping tools to collect data from websites or using database dumps to access data.

#### Data Exploration
---
Once the data is collected, the next step is to explore it in order to understand its structure, contents and biases. This may involve **creating a data dictionary** that describes the attributes and values for each data source, as well as a **data mapping plan** that outlines how the data from different sources can be combined into ACDEA.

#### Data Transformation
---
This stage focuses on preparing the data for integration into the ACDEA. It involves expanding the data by adding missing attributes or levels, as well as cleansing the data by identifying and correcting errors or inconsistencies.

##### Data Expansion
This step involves expanding the data to include additional attributes or levels that are necessary for the integration process. This may involve supplementing missing attributes, projecting similar attributes to the target attributes in ACDEA or expanding the data model to include additional levels or entities. For example, the `structure` entity in DAQA is projected to `place` level as well as `work` level in ACDEA.

##### Data Cleansing
In this step, the data is cleaned and standardised to ensure that it is consistent and accurate. This may involve removing redundant texts, and standardising time and place formats and values.

#### Data Loading
---
Once the data is transformed and cleansed, it is loaded into a MongoDB database where it can be accessed and queried for analysis.

#### Downstream tasks
---
This final stage relates to ongoing downstream tasks such as data analysis and visualisation that can now be conducted given the unification process. Through the investigation of various case studies, the full potential value of the integrated data can be realised.

Please note that the details of case studies and analytical works carried out by the ACDE can be found in the [Data Analysis](https://acd-engine.github.io/jupyterbook/data_analysis_intro.html) chapter.

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>