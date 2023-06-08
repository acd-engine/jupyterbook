## Data Sources

### Summary
---
So far, there are 6 cultural data sources authorized and provided by [the ACDE partners](https://www.acd-engine.org/partners), distibuted in 4 different domains.

- **Performing Art**
  <br><br>

  Data about any art form that involves live performances, such as theater, dance, music, opera, and circus. Performing arts can be further divided into subcategories based on the specific art form, such as classical music, contemporary dance, or musical theater. 
  <br><br>

  Data Sources: [The Australian Live Performance Database (AusSatge)](https://www.ausstage.edu.au/pages/browse/), [Circus Oz Living Archive (CircuzOZ)](https://circusozlivingarchive.com/)
  <br><br>

- **Visual Art**
  <br><br>
 
  This domain includes any art form that is primarily visual, such as painting, sculpture, photography, printmaking, and installation art. Visual arts can also be further divided into subcategories based on the medium, style, or period of the artwork. 
  <br><br>
 
  Data Sources: [Design and Arts Australia Online (DAAO)](https://www.daao.org.au/)
  <br><br>

- **Architecture**
  <br><br>
  
  This domain is specific to the art and science of designing buildings and other physical structures. It includes information about architectural styles, building materials, construction methods, and the history of architecture. 
  <br><br>
  
  Data Sources: [Digital Archive of Queensland Architecture (DAQA)](https://qldarch.net/), [Summerhayes Family Collection (SFC)](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951)
  <br><br>

- **Politics**
  <br><br>
  
  This category encompasses any cultural data related to political events, movements, or figures. 
  <br><br>
  
  Data Sources: [Australian Women's Register (AWR)](https://www.womenaustralia.info/)
<br><br>

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