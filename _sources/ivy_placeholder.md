# Australian Cultural Data Engine - Data Processing

This repository contains all the necessary scripts, Jupyter notebooks, and documentations needed to explore and process the data sources for the Australian Cultural Data Engine. This repository serves as a comprehensive resource for anyone interested in the data processing of this project, providing a clear overview of the various steps involved in the Australian Cultural Data Engine construction, as well as the methodologies and tools used to carry out these tasks. 

> The Australian Cultural Data Engine is a multidisciplinary project based at the University of Melbourne that harnesses leading [cultural databases](https://www.acd-engine.org/partners) to analyse cultural production, artistic networks, and the socio-economic implications of arts and cultural data. 

The goal of the Australian Cultural Data Engine (aka ACDE) is to increase the accessibility and scope of cultural data in Australia. Additionally, it seeks to examine and address any biases, exclusions, or cultural assumptions that may exist within the data, with the aim of utilizing high-quality data to provide rich, multilevel analysis and to tell more compelling stories.

In order to achieve the goals stated eariler, it is necessary to have a complete, accurate, and consistnet view of data. The data from various cultural databases need to be combined and hoarmonized for the critical cultural analysis and quantitative analysis. Therefore, the data processing procedures in the ACD-Engine become critical components of this project. This section will provide an overview of the crucial steps taken in the ACDE data processing, which include developing a unified data model, establishing the Australian Cultural Data Engine Architecture, as well as designing and implementing the ETL (Extraction, Transformation, Loading) process. Additionally, the future work of data processing will be discussed, as well as other interesting projects found during the implementation of this progress.

For the sake of brevity and clarity, here are a list of abbreviations will be used in the following sections.

| Abbreviation | Full Name                                                                                                                                                            | Description                                                                                                                                                                                                                                                                                                |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ACDE         | [The Australian Cultural Data Engine](https://www.acd-engine.org/)                                                                                                   | The Australian Cultural Data Engine is a multidisciplinary project based at the University of Melbourne that harnesses leading [cultural databases](https://www.acd-engine.org/partners) to analyse cultural production, artistic networks, and the socio-economic implications of arts and cultural data. |
| ACDEA        | The Australian Cultural Data Engine Architecture                                                                                                                     | ThThe Australian Cultural Data Engine Architecture is the unified data model of the Australian Cultural Data Engine.                                                                                                                                                                                       |
| AusStage     | [The Australian Live Performance Database](https://www.ausstage.edu.au/pages/browse/)                                                                                | The Australian Live Performance Database provides an accessible online resource for researching live performance in Australia.                                                                                                                                                                             |
| AWR          | [The Australian Women's Register](https://www.womenaustralia.info/)                                                                                                  | The Australian Women's Register is Australia's premier online archival resource discovering, promoting and preserving the diverse stories of Australian women, past and present.                                                                                                                           |
| CircuzOZ     | [The Circus OZ Living Archive Collection](https://circusozlivingarchive.com/)                                                                                        | Built in collaboration with the world’s oldest contemporary circus company, the Circus Oz Living Archive combines performer interviews and performance videos with audience engagement to create an interactive, immersive environment for experiencing the magic of circus over and over again.           |
| DAAO         | [Design & Art Australia Online](https://www.daao.org.au/)                                                                                                            | Design & Art Australia Online is an open source freely accessible scholarly e-Research tool that presents biographical data about Australian artists, designers, craftspeople and curators.                                                                                                                |
| DAQA         | [Digital Archive of Queensland Architecture](https://qldarch.net/)                                                                                                   | This digital archive of Queensland architecture comprises thousands of audiovisual and textual files that allow you to explore relationships between people, projects and firms.                                                                                                                           |
| SFC          | [Summerhayes Family Collection](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951) | The Summerhayes Family Collection represents the work of three generations of the Summerhayes family, Edwin, Reginald and Geoffrey, whose combined practice of architecture in Western Australia extended through the 20th century.                                                                        |

## Australian Cultural Data Engine Architecture

### Introduction

To construct a comprehensive and consistent view of data from various cultural databases, the development of a unified data model is crucial. The unified data model is named as the Australian Cultural Data Engine Architecture, or ACDEA for short. The ACDEA serves as the foundation effectively for integrating and harmonizing data from multiple data sources. By constructing the ACDEA, insights can be gained into the vaiuos data models that underpin the different cultural databases, thereby helping to clarify the number of entites in each data sources. as well as doing comparison analysis on the definition of entity unit concept in each data source.

It should be noted that the ACDEA is currently only a prototype for integrating existing data sources. As discussions around improving data integration performance and clarifying professional domain definitions continue, and as more data sources are accumulated, the ACDEA may be modified accordingly.

The following sections will begin with a brief overview of the ACDEA, followed by a description of the general procedure of the ACDEA construction workflow.

### <a name="overview-acdea">Overview of the Australian Cultural Data Engine Architecture</a>

To construct a unified data model for the Australian Cultural Data Engine, a set of 8 entities were identified from the overlapping entities of all the data models of the current data sources. These entities are collectively referred to as "levels" within the Australian Cultural Data Engine Architecture. The 8 levels include **person**, **organization**, event, **work**, **recognition**, **place**, **resource**, and **relationship**. These entities were selected based on their relevance to cultural data, and their ability to provide a comprehensive view of the data from the various cultural databases.

The conceptual level diagram below presents the Australian Cultural Data Engine Architecture:

![Australian Cultural Data Engine Architecture](./images/ACD-E_Architecture_General.png)

Each level within the ACDEA serves a unique and important purpose in the overall model. Additionally, each level contains three essential types of data:

* The metadata of the record, including the original (database) ID, URL, associated level name, timestamps, and other important details. This metadata is crucial in maintaining the integrity and traceability of the data.

* The specific content details of the record.

* The one-dimentional related records of the particular record refer to its direct connections to other records within the same level. This feature provides easier access to the one-dimensional relationship network of a particular record, while all relationship records can be found in the relationship level.

The content detail summary of each level are described as follows:

- **Person Level**: representing individuals who are relevant to the cultural data. 
  
  - Names: all types of names of the person, including display name, primary name and alternative names.
  
  - Summary: the biography summary of the person
  
  - Gender
  
  - Birth: the date and place of birth
  
  - Death: the date and place of death
  
  - Long Term Roles: the roles that the individual has held for an extended period of time.
  
  - Career: the features about career.
  
  - Residences: the time and place of the person has resided.
  
  - Languages
  
  - National Library Archive ID: The ID assigned by the National Library of Australia for the same individual.

- **Organization Level**: representing organizations that are relevant to the cultural data.
  
  - Names: all types of names of the organization, including display name, primary name and alternative names.
  
  - Description: the brief description of the organization.
  
  - Types: the types of the organizations.
  
  - Long Term Roles: : the roles that the organization has held for an extended period of time.
  
  - Operation: the features about operation of the organization.
  
  - Locations: the places where the organization has been located.

- **Event Level**: representing cultural events. 
  
  - Title
  
  - Description: the brief description of the event.
  
  - Types: the types of the events.
  
  - Time & Place: the specific date and location where the event took place.

- **Work Level**: representing cultural works such as books, architecture, performance , art, and etc. 
  
  - Titles: all types of titles of the work, including primary title and alternative titles.
  
  - Summary: the summary of the work.
  
  - Time & Place: the specific date and location where the work was created.

- **Recognition Level**: representing awards or recognition received by individuals or organizations. 
  
  - Title
  
  - Summary: the summary of the recognition.
  
  - Types: the types of the recognition.
  
  - Time & Place: the specific date and location where the recognition was granted.

- **Place Level**: representing the locations that are geographic locations or facilities where the cultural events take place. 
  
  - Names: all types of names of the location, including primary names and alternative names.
  
  - Address: the standardized physical address of the location, including country, state, suburb, street and postcode.
  
  - Geo-Coordinates: the geographic coordinates (latitude and longitude) of the locations.
  
  - Start & End Date (Optional): the start and demolished date of a location, which is the optional information in tracking the changes of a location whose type is "venue" over time.

- **Resource Level**: represents resources that are relevant to the cultural data, such as books, images, paintings and audio files. The content details of this level refer to the metadata schema used in the National Library of Australia.
  
  - Titles: all types of titles of the resource, including primary title and alternative titles.
  
  - Description
  
  - Type
  
  - Authoring: the author or creator information of the resource.
  
  - Source: the source of the resource.
  
  - Date: the associated dates of the resource, such as created date, published date, etc.
  
  - Acquisition: the method or process used to acquire the resource.
  
  - Right: the rights associated with the resource, such as copyright or licensing information.
  
  - Format: the format information of the resource.
  
  - Identifier: the identifiers associated with the resource.

- **Relationship Level**: representing the relationships between the various entities within the cultural data. It plays a crucial role in establishing connections and dependencies between the other levels.
  
  - Subject: the entity that initiates the relationship.
  
  - Object: the entity that is being related to by the subject.
  
  - Predicate: describing the type of relationship that exists between the subject and the object.
  
  - Time: the time period during which the relationship between the subject and the object existed.

The following illustration shows an overview of the attributes in ACDEA.

![Australian Cultural Data Engine Architecture](./images/ACD-E_Architecture_Details.png)

To obtain more detailed information about the specific attributes within each level, please refer to [the ACDEA data dictionary]().

### <a name="constr-workflow">Construction Workflow</a>

#### Overview of Construction Workflow

The construction of the Australian Cultural Data Engine Architecture (ACDEA) follows a general methodology that integrates a unified data model from all the existing data models of the data sources. This is a bottom-up approach that ensures that all the relevant data is included and organized into a coherent and integrated database.

Importantly, to achieve this methodology, the construction of ACDEA follows the principles below:

- **Refer to the Most Comprehensive Existing Data Models**: ACDEA aims to include all relevant attributes from various cultural data sources into the unified enities (levels) . Therefore, the most comprehensive entity sturcture were referred to and analyzed to ensure that ACDEA includes the most relevant and useful attributes of specific entity from all sources. For instance, to construct its own "person" level, ACDEA refers to the "person" data model from DAAO, which is a person-oriented data collection.

- **Keep Differences & Unify Common**: The construction of ACDEA required reconciling differences between the data models of different sources, which is a significant challenge. To maintain the completeness of the original data sources and integrate the similarities of data attributes, ACDEA follows the principle of keeping differences between the data models that are significant and add value to the data, while unifying common elements to ensure consistency and usability. This approach helps to capture the unique characteristics of each data source and ensure that ACDEA includes all relevant information.

- **Fuzzy Mapping**: This involves mapping data attributes from different sources to a common attribute in the unified data model, even if they are not an exact match. For instance, ithe DAAO has an attribute called "other_occupations" and the AusStage has an attribute called "(contributing) functions", these attributes can be mapped to a common attribute in ACDEA called "career." This allows ACDEA to capture as much information as possible while still maintaining consistency and usability.

Although the construction process varies across different data sources, there is a general construction workflow that has been established for integrating the data sources into ACDEA.

![ACD-Engine Architecture Construction Workflow](./images/ACD-Engine+Architecture_Construction_Workflow.png)

#### Data Extraction

The first step in constructing ACDEA involves extracting or scraping data from various data sources. This process may involve using web scraping tools to collect data from websites or using database dumps to access data.

#### Data Exploration

Once the data is collected, the next step is to explore it in order to understand its structure, contents and biases. This may involve **creating a data dictionary** that describes the attributes and values for each data source, as well as **a data mapping plan** that outlines how the data from different sources can be combined into ACDEA.

#### Data Transformation

This stage focuses on preparing the data for integration into the ACDEA. It involves expanding the data by adding missing attributes or levels, as well as cleansing the data by identifying and correcting errors or inconsistencies.

##### Data Expansion

This step involves expanding the data to include additional attributes or levels that are necessary for the integration process. This may involve supplementing missing attributes, projecting similar attributes to the target attributes in ACDEA or expanding the data model to include additional levels or entities. For example, the "sturcture" entity in DAQA is projected to "place" level as well as "work" level in ACDEA.

##### Data Cleansing

In this step, the data is cleaned and standardized to ensure that it is consistent and accurate. This may involve removing redundanct texts, and standardizing time and place formats and values.

#### Data Loading

Once the data is transformed and cleansed, it is loaded into a MongoDB database where it can be accessed and queried for analysis.

#### Experiments & Show Cases

This part is mainly for stages for downstream data analysis for showing cases and future works. Please note that it will not be included in this chapter. The following are the brief introduction of post-data-processing works: 

* Experiments for the Better Integration: This involves experimenting with different integration methods to improve the accuracy and completeness of the data model. So far, ACDE focuses on integrating records referring to same entities into one single records, as well as compress the numbers of unique terms in the categorical attributes. 

* Data Extraction (Round2) & Data Analysis (Show Cases): By extracting full static datasets or extracting fine samples for data analysis, ACDE is creating different show cases on how to utilize the integrated data in ACDE.

### <a name='data-report'>Data Report</a>

Finally, the integrated data are loaded into 7 collections of `acd-engine` MongoDB database. The following charts, which was generated by the jupyter notebook [ACDE_Exploration.ipynb](./data_exploration/ACDE/ACDE_Exploration.ipynb), show the numbers of records by data source and relation class in each data source respectively.

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\ACDE_collection_summary.png)

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\ACDE_relation_class_summary.png)

### <a name='spec-consid-da'>Special Considerations for Data Analysis</a>

As ACDEA is a prototype for integrating existing data sources and it is still in a stage that need further cleansing, there are some special considerations to be aware of when conducting data analysis.

1. **Ambiguous Concepts**: When working with ACDEA, it is important to keep in mind that some of the concepts may have different interpretations across cultural data in different domains. 
   
   For example, the entity "project" in DAQA may have a different definition from "work" in DAAO, despite being integrated into the same level "Work". Similary, AusStage's "event" may be defined differently from the general "event" concept which is more like "production" in performing art.
   
   Hence, it is important to understand the specific concept being used in each data source. And further data manipulation could be required to construct the exact entities you want to analyze.

2. **Duplicated Records**: Another important consideration when working with ACDEA is dealing with duplicated records. Due to the nature of integrating data from multiple sources, it is possible for some records to appear in multiple places. As de-duplication progress is still under experimentation at this stage, it is crucial to identify and handle duplicated records appropriately to avoid skewing analysis results.

3. **Empty Values**: When working with current datasets, it is important to note that some records may contain missing or empty values for certain attributes. These empty expressions could be represented as `null`, "", "None", "null", or other variations. This could be due to incomplete or inconsistent data in the original data sources, or due to errors during the integration process. 
   
   To avoid skewing the analysis results, it is important to identify and handle these missing values appropriately. Depending on the analysis being conducted, empty values may need to be **imputed** or **removed**. Additionally, it is important to carefully consider **the impact of missing data on the validity of the results** and to acknowledge any limitations or uncertainties caused by missing values.

## <a name='data-src-acde'>Data Sources of Australia Cultural Data Engine</a>

### <a name='data-src-summary'>Summary</a>

So far, there are 6 cultural data sources authorized and provided by [the ACDE partners](https://www.acd-engine.org/partners), distibuted in 4 different domains.

- Performing Art
  
  Data about any art form that involves live performances, such as theater, dance, music, opera, and circus. Performing arts can be further divided into subcategories based on the specific art form, such as classical music, contemporary dance, or musical theater. 
  
  Data Sources: [The Australian Live Performance Database (AusSatge)](https://www.ausstage.edu.au/pages/browse/), [Circus Oz Living Archive (CircuzOZ)](https://circusozlivingarchive.com/)

- Visual Art
  
  This domain includes any art form that is primarily visual, such as painting, sculpture, photography, printmaking, and installation art. Visual arts can also be further divided into subcategories based on the medium, style, or period of the artwork. 
  
  Data Sources: [Design and Arts Australia Online (DAAO)](https://www.daao.org.au/)

- Architecture
  
  This domain is specific to the art and science of designing buildings and other physical structures. It includes information about architectural styles, building materials, construction methods, and the history of architecture. 
  
  Data Sources: [Digital Archive of Queensland Architecture (DAQA)](https://qldarch.net/), [Summerhayes Family Collection (SFC)](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951)

- Politics
  
  This category encompasses any cultural data related to political events, movements, or figures. 
  
  Data Sources: [Australian Women's Register (AWR)](https://www.womenaustralia.info/)

The table below summarizes the data fetching information of each data source.

| Data Source | Orientation | Format/Fetching Method            | Fetching Date |
| ----------- | ----------- | --------------------------------- | ------------- |
| AWR         | Person      | Web Scraping                      | TBC           |
| AusStage    | Event       | Database Dump (MySQL)             | 2022-03       |
| CircuzOz    | Event       | static file (xlsx)                | 2022-12       |
| DAAO        | Person      | Database Dump (MongoDB)           | 2021-08       |
| DAQA        | Person      | Web Scraping (storing in MongoDB) | 2023-04       |
| SFC         | Resource    | static file (xml)                 | 2022-11       |

The following sections will provide a general introduction, specific data processing workflow, integration data report for each data source.

Please note that, in the integration data report section, the number of loaded records in the ACDE database may not match the number of records in the original database due to the following reasons:

1. Only the records that have completed relationship records, where both the subject and object exist in the original database, will be loaded into the ACDE database. Records that have relevant relationship records but are missing the corresponding subject or object records will be excluded from the ACDE database for consistency reasons.

2. Some additional relationships that were newly constructed during the transformation procedure may not be inserted into the original database and therefore will not be included in the ACDE database.

### <a name='ausstage'>The Australian Live Performance Database</a>

#### Introduction

> AusStage provides an accessible online resource for researching live performance in Australia. Development is led by a [consortium](https://www.ausstage.edu.au/pages/learn/about/partners-and-staff.html) of universities, government agencies, industry organisations and collecting institutions with funding from the Australian Research Council and other sources.
> 
> ......
> 
> AusStage is committed to collecting and sharing information about Australian live performance as an ongoing, open-access and collaborative endeavour. ......
> 
> By sharing knowledge through AusStage researchers and consumers can learn more about Australian performance than ever before.

The following sections will describe the data processing procedure that integrates AusStage data into ACDE and the data sumary of AusStage.

#### Data Processing

##### Data Extraction & Exploration

The AusStage data was provided in the format of MySQL database dump. It can be downloaded from an API as a compressed file. As the MySQL database was using the storage engine MyISAM, there were no foreign keys could be found in the original database dump. However, the schema of AusStage can be roughly inferred based on the actual display of official website, physical database, expert suggestions as well as [previsous documentation](https://www.ausstage.edu.au/opencms/export/system/modules/au.edu.flinders.ausstage.learn/pages/learn/contribute/manuals/AusStage_Data_Entry_Manual_2021.pdf). The AusStage Schema is shown as following:

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\AusStage_Schema.png)

For more detailed of downloading and restoring AusStage database, please check [AusStage_DBUpdate.ipynb](./data_pipelines/AusStage/AusStage_DBExtraction/AusStage_DBUpdate.ipynb).

It is noted that for the [public data sharing](https://www.ausstage.edu.au/pages/learn/data-sharing), there is a SPARQL end point that could provide most of the data when ACDE tried to fetch the AusStage data. However, as ACDE require the birth information of contributors for comparison and further research, database dump extraction was chosen to be the final data delivery method to fetch data. 

"Regarding public data sharing, there is a SPARQL endpoint available on the AusStage website that could provide most of the data required by ACDE. However, as birth information of contributors is needed for comparison and further research, a database dump extraction was chosen as the final data delivery method to fetch data.  

During the exploration of the AusStage database, a significant concern was identified that needs to be taken into account when establishing the transforming and loading pipeline. It was found that there might be some ambiguity and incorrectness in the definition of an event in AusStage. The unit definition of an event in AusStage, "a distinct happening defined by title, date, and venue," might be different from the contributing unit definition in the common sense of performing data analysis.  This usually don't make inconsistency in data integration, however, it might cause confusion and inconvenience in downstream data analysis.

For instance, an actress may have contributed to 30 performances in the whole season of Les Miserables, which means in the AusStage perspective, she has contributed to 30 events. However, in most theatre concepts, this actress only contributed to one event, or more precisely, one production. Additionally, some "concert" events are found to have the same name as the contributors.

For more examples of AusStage event ambiguation, please look into the jupyter notebook [AusStage_EventExploration.ipynb](./data_exploration/AusStage/AusStage_EventExploration.ipynb). A work-around solution will be described below to adjust this circumstance.

##### Data Transformation & Loading

To address the issue of event ambiguity in the AusStage database, we created a new attribute called "unf_id" (unified ID) to assign the same ID to records that refer to the same individual or entity but are distributed across different records due to various reasons. This includes records for contributors, organizations, venues, and events. Specifically, event records with the same titles that occurred in the same year were grouped together as the same "real event," or "production" in common theater terminology, unless they had same names as the organizations involved.

For more detailed of creating unified table for data loading, please check "**Create Table(s) (for unification)**" section in [AusStage_DBUpdate.ipynb](./data_pipelines/AusStage/AusStage_DBExtraction/AusStage_DBUpdate.ipynb) and the corresponding SQL scripts.

Furthermore, to facilitate table joining during data loading, we created several views and renamed attribute names to match those used in ACDEA.

For more detailed of creating views for data loading, please check "**Create Views**" section in [AusStage_DBUpdate.ipynb](./data_pipelines/AusStage/AusStage_DBExtraction/AusStage_DBUpdate.ipynb) and the corresponding SQL scripts.

With these additional attributes and views, it is now possible to map the corresponding entities and attributes of AusStage to the levels and attributes in ACDEA. The related records of the corresponding original records are also aggregated from the relationship level and updated into the related attribute of the original records.

On entity level, the AusStage entity projection is listed as follows:

| AusStage Entity (Collection)  | ACDEA Level  |
| ----------------------------- | ------------ |
| contributor                   | person       |
| work                          | work         |
| event                         | event        |
| ----                          | recognition  |
| venue                         | place        |
| organisation                  | organization |
| item, datasource              | resource     |
| all xxxxx**link** tables, etc | relationship |

On attribute level, please find the attribute mapping details in the notes of [AusStage data dictionary](./data_management/AusStage_Data_Dictionary.xlsx).

For more details of data loading of AusStage, please check jupyter notebook [AusStage_Loading.ipynb](./data_pipelines/AusStage/AusStage_Extraction/AusStage_Loading.ipynb).

#### Integration Data Report

The following chart, which was generated by the jupyter notebook [AusStage_IntegrationSummary.ipynb](./data_exploration/AusStage/AusStage_IntegrationSummary.ipynb), illustrates the number of AusStage records before and after integration.

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\AusStage_integration_summary.png)

#### References

* [AusStage Data Entry Manual Version 6.0](https://www.ausstage.edu.au/opencms/export/system/modules/au.edu.flinders.ausstage.learn/pages/learn/contribute/manuals/AusStage_Data_Entry_Manual_2021.pdf)

### <a name='circuzoz'>The Circus Oz Living Archive collection</a>

#### Introduction

> Built in collaboration with the world’s oldest contemporary circus company, the Circus Oz Living Archive combines performer interviews and performance videos with audience engagement to create an interactive, immersive environment for experiencing the magic of circus over and over again.

#### Data Processing

##### Data Extraction & Exploration

The CircusOZ data are manually collected from three data sources, and it is provided in the xlsx format. As all the data are merged in one spreedsheet, it need to be denormalized 3 separated entities, namely `person`, `event`, and `venue` and transformed into SQLite database for the convenience of understanding the data. 

For the details of constructing the CircusOZ database, please check the jupyter notebook [circusoz_DBConstruction.ipynb](./data_pipelines/CircusOz/circusoz_DBConstruction.ipynb).

The following diagram shows the schema of CircusOZ data:

![](./images/CircusOZ_Schema.png)

##### Data Transformation & Loading

Due to the manual collection process of CircusOZ data, it is inevitable that some records may contain typos and duplicate attributes. Therefore, the main goal of the transformation process is to perform deduplication while retaining the unique attributes from the three source data collection.

On entity level, the CircusOZ entity projection is listed as follows:

| CircusOZ Entity (Collection)               | ACDEA Level  |
| ------------------------------------------ | ------------ |
| person                                     | person       |
| ----                                       | work         |
| event                                      | event        |
| ----                                       | recognition  |
| venue                                      | place        |
| ----                                       | organization |
| ----                                       | resource     |
| foreign keys among person, venue and event | relationship |

On attribute level, please find the attribute mapping details in the notes of [CircusOZ_data dictionary](./data_management/CircusOZ_Data_Dictionary.xlsx). 

For the details of trasforming and loading the CircusOZ data into ACDE database, please check the jupyter notebook [circusoz_Loading.ipynb](./data_pipelines/CircusOz/circusoz_Loading.ipynb).

#### Integration Data Report

The following chart, which was generated by the jupyter notebook [circusoz_IntegrationSummary.ipynb](./data_exploration/circusoz/circusoz_IntegrationSummary.ipynb), illustrates the number of CircusOZ records before and after integration.

![](./images/CircusOZ_integration_summary.png)

#### References

- [CircusOZ Living Archive](https://alpine-test.hpc.unimelb.edu.au/)

### <a name='awr'>The Australian Women's Register</a>

TBC

### <a name='daao'>Design & Art Australia Online</a>

#### Introduction

> Design and Art Australia Online (DAAO) is a collaborative e-Research tool built upon the foundations of the Dictionary of Australian Artists Online. DAAO is an open source freely accessible scholarly e-Research tool that links biographical data about Australian artists, designers, craftspeople and curators with information about artworks, event histories and collection details.

The following sections will describe the data processing procedure that integrates DAAO data into ACDE and the data sumary of DAAO.

#### Data Processing

##### Data Extraction & Exploration

The DAAO data was provided in the format of MongoDB database dump. The dump was restored, and 20 collections were found in the DAAO database, which including:

1. Main collections for the main objects and their relationships: xactivity, xparty, xwork, xpredicate, relation

2. The corresponding version-controlling collections for main collections: xactivity_counters, xactivity_revisions, xparty_counters, xparty_revisions, xwork_counters, xwork_revisions

3. Dependency collections for detailed information and the convenience of display : asset, controlledvocab, culturalheritage, externalresource, predicate, place, indigenousdreaming, stubperson, stubpersongroup

For more details of restoring DAAO database, please check [DAAO_DBRestore.ipynb](./data_pipelines/daao/DAAO_DBRestore.ipynb).

Since DAAO is an archive of data that is updated cumulatively, there is no up-to-date confirmed data model or data dictionary to refer to. However, a conceptual data model can be roughly inferred based on the actual display of official website, physical database, expert suggestions as well as [previsous documentation](https://blogs.unsw.edu.au/daao/blog/2015/03/schema-and-data-model-refinements/). The conceptual data model is shown as following:

![](./images/DAAO_Conceptual_Data_Model.png)

The schema of DAAO can also be confirmed as following:

![](./images/DAAO_Schema.png)

During the exploration of the DAAO database, some concerns have been identified that should be taken into account when establishing the transforming and loading pipeline.

Firstly, it should be noted that not all records in the main entity collections are shown on the official website. Through comparing the data between the website and the raw database, it became apparent that some boolean fields like `is_locked`, `is_primary`, `is_shadow`, `is_featured` and `is_deleted` need to be filtered out in order to select only reliable records.

Secondly, the consistency of relationship records needs to be considered. The data in the `relation` collection doesn't include all relationships displayed on the official website. It appears that this collection may not have been updated after the last structural renovation of the website. Therefore, the collection of relationships needs to be reconstructed based on up-to-date relations.

Lastly, the place information is somewhat confusing. Although there are only four effective fields in the place collection, namely name, address, country, and centroid, the values in name, address, and country are often mixed up. As such, it is important to implement a place information normalization process that utilizes all available effective information to generate a standardized place record. This is particularly important for downstream analysis that requires spatial visualization.

##### Data Transformation

![](./images/DAAO_ETL_Workflow.png)

Regarding the complexity of the DAAO data structure and the concerns found during DAAO data exploration, a three-step approach is proposed for DAAO data transformation. 

The first step is normalizing the place records. The purpose of this step is to standardize the geo-elements of place records that are not consistently formatted, and to normalize the expression of name and address of specific places.  

To achieve this, two methods are implemented to infer the standardized elements of place information such as `country`, `state`, `city`, `suburb`, and optionally `postcode`. 

The first method is **reverse geocoding**, which involves using the latitude and longitude coordinates, as well as existing name and address in the DAAO database to find potential standardized address elements and place names. The reverse geocoding process generates two types of standardized location element candidate sets, which are merged to create a new place element candidate set. During this process, standardized location element candidate sets are selected from the reverse geocoding results.  

The second method is **rule-based recognition**. This method involves cleaning all place elements, such as address, name, and country, by correcting typos and expanding place name abbreviations. Then, potential places in the cleaned place elements are identified to create the second set of potential standardized place element candidates.  

Once the two sets of candidates are ready, the extracted-candidates and geo-candidates are merged to create a final set of standardized place element candidates for the place records. The final place elements are confirmed by comparing each level of place element candidate from top (country) to down (suburb), excluding the inconsistent candidates and keeping the most frequent candidates. Any redundant place element still present is removed by comparing whether the element is matching with all the other place elements.  

Finally, the cleaned location components can be updated to the `place` collection. This normalization process standardizes the geo-elements and place name expressions of the place records, making it easier to work with the data and reducing potential errors caused by inconsistent or incomplete data.

For more details of updating place information of DAAO, please check jupyter notebook [DAAO_PlaceUpdate.ipynb](./data_pipelines/DAAO/DAAO_PlaceUpdate.ipynb).

The second step is aggregating all the relationship records into a new collection `relationship`. There are `related_xxx` attributes existing in the records of main object collections (`xparty`, `xactivity`, and `xwork`), which shows the relationships among the main objects. However, in ACDE, relationships with `resource` and `place`  that are not explicitly assigned as `related_xxx` attributes in DAAO records are also crucial. Therefore, the attributes showing relationships with `resource` and `place` hidden should be firstly found and inserted into new collection `relationship`. For instance, `see_alsos`, `references`, `images`, `portrait_images` are the attributes that connect `resource` with other entities, while the place of  `birth` and `death` are the attributes showing relationships between `person` and `place`. And after the implicit relationship extraction, the explicity relationships under `related_xxx` attributes of each main object can inserted into the collection `relationship`.

For more details of reconstructing relationship collection of DAAO, please check jupyter notebook [DAAO_RelationUpdate.ipynb](./data_pipelines/DAAO/DAAO_RelationUpdate.ipynb).
The third step is standardizing the format of date attributes. In all collections with date attributes, namely `xparty`, `xactivity`, `xwork`, `externalresource`, all the relevant date attributes are updated as the format of json documents having `year`, `month`, `day`. The original data of the collections are backed up into the collections named `{collection_name}_ori`. 

For more details of cleansing date fields in DAAO, please check jupyter notebook [DAAO CleanDates.ipynb](./data_pipelines/DAAO/DAAO_CleanDates.ipynb).

##### Data Loading

After making extensive preparations during the transformation process, it is now possible to map the corresponding entities/attributes of DAAO to the levels/attributes in ACDEA. Finally, related records were aggregated from the relationship level and updated into the related attribute of the original records.

On entity level, the DAAO entity projection is listed as follows:

| DAAO Entity (Collection) | ACDEA Level  |
| ------------------------ | ------------ |
| xparty.person            | person       |
| xwork.work               | work         |
| xactivity.Event          | event        |
| xactivity.Recognition    | recognition  |
| place                    | place        |
| xparty.PersonGroup       | organization |
| external resource, asset | resource     |
| relationship             | relationship |

On attribute level, please find the attribute mapping details in the notes of [DAAO data dictionary](./data_management/DAAO_Data_Dictionary.xlsx).

For more details of data loading of DAAO, please check jupyter notebook [DAAO_Loading.ipynb](./data_pipelines/DAAO/DAAO_Loading.ipynb).

#### Integration Data Report

The following chart, which was generated by the jupyter notebook [DAAO_IntegrationSummary.ipynb](./data_exploration/DAAO/DAAO_IntegrationSummary.ipynb), illustrates the number of DAAO records before and after integration.

![](./images/DAAO_integration_summary.png)

#### References

* [Schema and Data Model Refinements](https://blogs.unsw.edu.au/daao/blog/2015/03/schema-and-data-model-refinements/)

![Schema and Data Model Refinements](https://blogs.unsw.edu.au/daao/files/2015/03/DAAO-Data-Model-Proposed-Revisions-February-20151.jpg "Schema and Data Model Refinements")

### <a name='daqa'>Digital Archive of Queensland Architecture</a>

#### Introduction

> "[This digital archive of Queensland architecture](https://qldarch.net/) offers a wealth of information on the region's design history. The archive was originally constructed as part of the Hot Modernism project and focused on the period 1945-1975. We are now expanding to include earlier and later periods. The database comprises thousands of audiovisual and textual files that allow you to explore relationships between people, projects and firms."

The following sections will describe the data processing procedure that integrates DAQA data into ACDE and the data sumary of DAQA.

#### Data Processing

##### Data Extraction & Exploration

The DAQA data needs to be scraped from its original website, which poses a challenge for developing a data model that can be easily integrated into ACDEA while being as similar as possible to the original DAAO data schema. Efforts will be made to carefully design a data model that can capture all relevant information from the scraped data and effectively integrate it into ACDEA without losing its original structure and meaning. 

Upon exploring the `Browsing` tab on the original DAQA website, it was discovered that there are at least five key entities existing in DAQA: "ARCHITECT", "FIRM", "PROJECT", "ARTICLE", and "INTERVIEW".

After parsing the DAQA website, several implicit APIs were found to be useful in web scraping.

1. `https://qldarch.net/ws/search?q={query_terms}&pc={page_count}&p={page_no}`: When `query_terms` is `*`, the general records under all the document ids existing in DAQA can be retrieved.

2. `https://qldarch.net/ws/{query_category}/{doc_id}`: This API can be used to retrieve the detailed record under the specific document id within the specific query category. The value of `query_category` can be `media` or `archobj`.

3. `https://qldarch.net/ws/media/download/{doc_id}`: This API can be used to retrieve the resource under the specific document id within the `media` category. 

4. `https://qldarch.net/ws/{query_type}`: This API can be used to retrieve all detailed records under the specific query type, where the `query_type` values are the names listed in the Browsing tab on the original website.

By analyzing the all the general records using `https://qldarch.net/ws/search?q=*`, the DAQA records are classified into 2 categories: "media" and "archobj". In the `media` category, there are 10 types of records including `Photograph`, `LineDrawing`, `Image`, `Article`, `Audio`, `Transcript`, `Portrait`, `Youtube`, `Video`, `Spredsheet`, while there are 13 types of records including `structure`, `person`, `firm`,`article`,`interview`, `publication`, `topic`,` education`, `award`, `event`, `place`, `organisation`, `government` in `archobj` category. The hierachy of DAQA records are illustrated as following:

The following charts, which was generated by the jupyter notebook [DAQA_HierachySummary.ipynb](./data_exploration/DAQA/DAQA_HierachySummary.ipynb), illustrates the hierachy of the hierachy of DAQA records.

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\DAQA_Hierachy_Summary.png)

To facilitate loading DAQA data into ACDE, a scraping pipeline has been established. The process involves the following steps:

![DAQA Web Scraping Workflow](images/DAQA_Web_Scraping.png)

1. Setting up a MongoDB database called `daqa_scraped`.

2. All Records Scraping: Scraping all general records by calling the API `https://qldarch.net/ws/search?q=*`, and storing them in the `all_objects` collection.

3. Key Objects Scraping: Scraping all detailed records, including their relationship records, for the five key objects explicitly listed on the original website. These records are stored in their respective collections in the database. Specially, the geographical coordinates of `project` records are reverse-geocoded to obtain standardized geographic information for the project.

4. Records Supplement: Supplementing records of all other objects not listed on the original website and extracting implicit records from the scraped data.
   
   1. Inserting all other archival objects that are not listed on the original website, but exist in the `all_objects` collection, into their respective collections in the database.
   
   2. Inserting all the media records into the `media` collection.
   
   3. Converting some fields of the records into corresponding relationship records and inserting them into the `relationship` collection.
   
   4. Adding unpublished records that couldn't be found in the `all_objects` collection but exist in relationship records.
   
   5. Adding a tracking attribute called `ori_dbid` into the subject and object of relationship records in the `relationship` collection.

5. Date Format Cleansing: Cleansing date formats and converting all date attributes into a standard JSON format consisting of fields for year, month, and day.

6. New Fields Update: Updating new fields supplemented by experts at the University of Queensland.

Finally, the conceptual data model of scrapped DAQA data is shown as follows:

![DAQA Conceptual Data Model](./images/DAQA_Conceptual_Data_Model.png)

The schema of DAQA is shown as follows:

![DAQA Schema](./images/DAQA_Schema.png)

This pipeline ensures that all relevant records are scraped and loaded into the database in an organized and structured manner, ready for integration into ACDE. For more details of web scraping of DAQA, please check jupyter notebook [DAQA_Scraping.ipynb](./data_pipelines/DAQA/DAQA_Scraping.ipynb).

##### Data Transformation & Loading

As many preparations have been made in the scraping process, the transformation and loading of DAQA data are more straightforward by mapping corresponding entities/attributes to the levels/attributes in ACDEA. The related records of the corresponding original records are aggregated from the relationship level and updated into the related attribute of the original records.

On entity level, the DAQA entity projection is listed as follows:

| DAQA Entity (Collection)               | ACDEA Level  |
| -------------------------------------- | ------------ |
| person                                 | person       |
| structure                              | work         |
| event                                  | event        |
| award                                  | recognition  |
| place, structure                       | place        |
| government, organisation, firm         | organization |
| publication, article, interview, media | resource     |
| relationship                           | relationship |

On attribute level, please find the details in the notes of [DAQA data dictionary](./data_management/DAQA_Data_Dictionary.xlsx).

For more details of data transforming and loading of DAQA, please check jupyter notebook [DAQA_Loading.ipynb](./data_pipelines/DAQA/DAQA_Loading.ipynb).

#### Integration Data Report

The following chart, which was generated by the jupyter notebook [DAQA_IntegrationSummary.ipynb](./data_exploration/DAQA/DAQA_IntegrationSummary.ipynb), illustrates the number of DAQA records before and after integration.

![](C:\ProjectCollections\Programs\Australia_Cultural_Data_Engine\images\DAQA_integration_summary.png)

#### References

1. [The Digital Archive of Queensland Architecture | Deborah van der Plaat - Academia.edu](https://www.academia.edu/38956628/The_Digital_Archive_of_Queensland_Architecture)

2. [A Web 3.0 approach to building an online digital archive of architectural practice in post-war Queensland](http://ica2012.ica.org/files/pdf/Full%20papers%20upload/ica12Final00326.pdf)

3. [GitHub - uq-eresearch/qldarch-frontend](https://github.com/uq-eresearch/qldarch-frontend)

4. [GitHub - uq-eresearch/qldarch.backend: Digital Archive of Queensland Architecture](https://github.com/uq-eresearch/qldarch.backend)

## <a name='sfc'>Summerhayes Family Collection</a>

#### Introduction

> This collection represents the work of three generations of the Summerhayes family who practiced architecture in Western Australia.

The following sections will describe the data processing procedure that integrates SFA data into ACDE and the data sumary of SFA.

#### Data Processing

The SFC data is provided in XML format using MARC standards, which are standards for the representation and communication of bibliographic and related information in machine-readable form. The SFC data has a clear structure as it is extracted from a professional library archive. However, there are still many efforts that need to be taken to parse the XML file according to the archive's structure description.

The following diagram shows the sturcture of Summerhayes Family Collection.

![TBC](./images/SFA_Structure.png)

For more details of parsing SFC data and loading it into ACDEA, please check jupyter notebook [SFC_Loading.ipynb](./data_pipelines/SFC/SFC_Loading.ipynb). The details of SFC attributes projection from MARC to ACDEA can also be found in the notes of [SFC data dictionary](./data_management/SFC_Data_Dictionary.xlsx).

It is important to note that ACDEA does not assign any sub-level for the resource level, and due to the challenges in re-linking the original SFC records into a hierarchical structure, all the SFC records are loaded solely into the resource level of ACDEA. No new relationship records were constructed during this stage. The original hierarchy information is preserved and stored in the `_class_ori` field.

Finally, 241 SFC resource records were loaded into the resource level of ACDEA.

#### References

- [Summerhayes Family Collection](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951)
- [MARC Standards](https://www.loc.gov/marc/[MARC STANDARDS (Network Development and MARC Standards Office, Library of Congress)](https://www.loc.gov/marc/))

## <a name=integrated-data>Integrated Data</a>

As the result of the data integration, four formats of data have been generated for downstream data analysis purposes.

For more details of static files export for ACDE, please check the jupyter notebook [ACDE_Export.ipynb](./data_delivery/ACDE/ACDE_Export.ipynb).

| Format        | Description                                                                                                                                                                                                                                                                  | Download Url |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| Database Dump | A MongoDB database `acd_engine` that consists of 7 collections, including `event`, `organization`, `person`, `place`, `recognition`, `relationship`, `resource`, `work`.<br/>This type of data is intended primarily for development purposes.                               |              |
| CSV           | Each CSV file corresponds to a specific level in ACDEA and contains data organized according to the attributes of that level. The columns of the CSV file represent the first-level attributes of the corresponding level.                                                   |              |
| XLSX          | Each XLSX file corresponds to a **10% sample** of the specific level in ACDEA.<br/>Similar to the CSV files, the columns of each XLSX file represent the first-level attributes of the corresponding level.<br/>This type of data is intended for exploratory purposes.      |              |
| JSONL         | JSONL is a format that stores data records as individual JSON objects separated by a newline character. <br/>Each JSONL file corresponds to a specific level in ACDEA, and the data is structured as a list of dictionaries, where each dictionary represents a data record. |              |

## <a name='future-works'>Future Works</a>

1. **Improving Accessibility, Efficiency, and Scalability:** One of the key focus areas for future works is to improve the accessibility, efficiency, and scalability of ACDEA.
   
   **Accessibility:** To improve the accessibility of ACDEA, we plan to develop APIs and a more user-friendly interface that can provide researchers with streamingly updated data. This will enable researchers to access the data they need more easily and quickly.
   
   **Efficiency:** In the next stage, we plan to improve the overall performance of the ETL (extract, transform, load) process for ACDEA. This will involve migrating the data processing progress to a more powerful server, implementing multithreading, and using MPI (message passing interface) to increase the efficiency of data transfer.
   
   **Scalability:** In order to enhance the scalability of ACDEA, careful consideration will be given to the dynamic nature of the data sources and the study of ontology. Special attention will be devoted to improving the fault tolerance of the system, ensuring its resilience against failures and errors.
   
   It is worth noting that the resource level plays a crucial role in ACDEA, as it inherits the complex structure of the library archive. Therefore, careful consideration will be given to determining whether the resource level should retain the same level of information and structure as found in the original library archive. This decision will require thoughtful design in order to create a more scalable ACDEA that can seamlessly adapt to changes in the format and structure of the data sources.

2. **Experimental Integration (Record Unification)** 
   
   While the cultural data has benn integrated in the structural level, there is still room for finer integration in the unit record level to better utilize the ACDE data, which is called "Record Unification". It is common to find many duplicated records in different extents exsist in the integrated data. For instance, records under the same organization name might have different information that can be integrated into a single record. Another typical circumstance is records with different person names but referring to the same person, which are common within the same data source and across data sources. And it should not be ignored that some data sources might cite the data originated from the other data sources. For instance, CircuzOz cite the circuz performance data from AusStage.
   
   Given the complexity of the situation, one of the significant focus of the future works would be conducting experiments to confirm the methodology of defining, detecting, and integrating the duplicated records.

3. **Identify more implicity data**
   
   Implicit data refers to the data that is not explicitly mentioned or labeled but can be inferred from the existing data. For example, the gender, date of birth and relationships with other people of a person may not be explicitly mentioned in the attributes, but can be inferred from the biography of the person and other contextual information. Therefore, in the future works, efforts will be made to identify more implicit data and integrate them into the ACDE data.

4. **Integrate with more data sources**
   
   ACDE currently integrates cultural data from six data sources. However, there are still many other sources of cultural data that have not yet been integrated into ACDE. For example, some interesting data sources that we have discovered are listed in [More Interesting Data Sources](https://chat.openai.com/c/1573acdc-bfdd-4c4d-a7ec-8039de8df1c3?__cf_chl_rt_tk=7Xs0hpEM7Wf9kjzDSR_319eEU9rAAUNHeYnYWUlNdVk-1681633648-0-gaNycGzNGqU#inter-data-sr). In future work, efforts will be made to integrate with more data sources and develop a more scalable data integration life cycle that can adjust to data from different data models. This will not only enrich the cultural data in ACDE but also provide researchers with a more comprehensive and diverse cultural insight for their analysis.

## <a name='repo-dir-stru'>Repository Directory Structure</a>

## <a name='inter-works'>More Interesting Works</a>

In addition to the ACDE project, we found many other interesting digital humanities projects related to cultural data integration and analysis. These projects could inspire further work in this field and help humanities researchers utilize integrated data in new and innovative ways. Here are a few examples:

1. [Map Theatres in Australia](https://circuit.unimelb.edu.au/)
   
   This project is a digital platform that maps the history of Australian theatre from the early colonial period to the present day. It features a searchable database of historical information and multimedia resources, including photographs, playbills, and recordings of performances.

2. [HuNI: Humanities Networked Infrastructure](https://huni.net.au/)
   
   HuNI is a national research infrastructure project that provides a platform for integrating and sharing cultural data from a wide range of sources, including museums, archives, and libraries. It allows researchers to discover new connections between different types of cultural data and to explore complex research questions across multiple disciplines.

3. [Experiments | DX Lab - State Library of NSW](https://dxlab.sl.nsw.gov.au/experiments/)
   
   The DX Lab at the State Library of NSW is a hub for digital experimentation and innovation in the cultural sector. Their website features a collection of projects and prototypes that use emerging technologies to explore new ways of engaging with cultural collections.

4. [Análisis | Vincent van Gogh](http://infografias.elmercurio.com/20180623-VA-vincentvangogh/)
   
   This interactive data visualization by El Mercurio newspaper explores the life and work of Vincent van Gogh through a series of infographics and interactive tools. It provides a new way of understanding the artist's creative process and the social and cultural context in which he lived and worked.

## <a name='inter-data-sr'>More Interesting Culture Data Sources</a>

In addition to current data sources, we found many other interesting Australian/International cultural data collections that could be integrated into ACDEA. These data collections could boost the existing integrated data as well as  inspire further work in this field. Here are a few examples:

1. [Archibald, Wynne and Sulman Prizes | Art Gallery of NSW](https://www.artgallery.nsw.gov.au/art/prizes/)
   
   This is a collection of art prize data from the Art Gallery of NSW. It contains information about the artists, artworks and judges of the prizes. This data collection could add more value to "recognition" level in ACDEA.

2. [Australian and New Zealand Art Sales Digest](https://www.aasd.com.au/)
   
   This is a database of sales of Australian and New Zealand art. It includes information about the artwork, artist, sale date, price and sale location. This data collection could strenthen the structure for "work" level in ACDEA.

3. [Australian Prints + Printmaking](https://www.printsandprintmaking.gov.au/)
   
   This is an online database of Australian prints and printmaking, maintained by the National Gallery of Australia. It contains information about artists, prints, printmaking techniques, and print collections in Australian museums and galleries. This data collection could add more value to "work", "resource" and "place" level in ACDEA which enrich the data related to visual art domain in ACDE.

4. [IMDB](https://www.imdb.com/)
   
   This is a well-known database of information about movies, television shows, and other productions. It includes information about the cast and crew, production companies, release dates, and ratings. This data collection could enrich the data related to modern film art domain in ACDE.

5. [Miles Lewis' Research DataBases](https://www.mileslewis.net/research-database/index.html)
   
   Miles Lewis' Research Databases: This is a collection of research databases compiled by Professor Miles Lewis, a prominent Australian architectural historian. The databases cover topics such as Australian architectural heritage, post-war modernism, and Australian war memorials. This data collection could boost the data in Architecture domain in ACDE.
