### The Australian Live Performance Database

#### Introduction
---
> AusStage provides an accessible online resource for researching live performance in Australia. Development is led by a [consortium](https://www.ausstage.edu.au/pages/learn/about/partners-and-staff.html) of universities, government agencies, industry organisations and collecting institutions with funding from the Australian Research Council and other sources.

AusStage is committed to collecting and sharing information about Australian live performance as an ongoing, open-access and collaborative endeavour. By sharing knowledge through AusStage, researchers and consumers can learn more than ever before about Australian performance.

The following sections will describe the data processing procedure that integrates AusStage data into the ACDE and the data sumary of AusStage.

#### Data Processing
---
##### Data Extraction & Exploration

The AusStage data was provided in the format of MySQL database dump. It can be downloaded from an API as a compressed file. As the MySQL database was using the storage engine MyISAM, no foreign keys could be found in the original database dump. However, the schema of AusStage can be roughly inferred based on the actual display of the official website, the physical database, expert suggestions and [previous documentation](https://www.ausstage.edu.au/opencms/export/system/modules/au.edu.flinders.ausstage.learn/pages/learn/contribute/manuals/AusStage_Data_Entry_Manual_2021.pdf). 

The AusStage Schema is as follows:
<br><br>

![AusStage Schema](./images/ivy_images/AusStage_Schema.png)
<br><br>

For more details in downloading and restoring the AusStage database, please see [AusStage_DBUpdate.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_DBUpdate.ipynb).

Regarding [public data sharing](https://www.ausstage.edu.au/pages/learn/data-sharing), there is a SPARQL endpoint available on the AusStage website that could provide most of the data required by ACDE. However, as birth information of contributors is needed for comparison and further research, a database dump extraction was chosen as the final data delivery method to fetch data.  

During the exploration of the AusStage database, a significant concern was identified that needs to be taken into account when establishing the transforming and loading pipeline. It was found that there might be some ambiguity and incorrectness in the definition of an `event` in AusStage. The unit definition of an `event` in AusStage, "a distinct happening defined by title, date, and venue," might be different from the contributing unit definition in the common sense of performing data analysis.  While this will not inject inconsistencies in the data integration process, it might however cause some confusion and inconvenience in downstream data analysis.

For instance, an actress may have contributed to 30 performances in the whole season of Les Miserables, which means from an AusStage perspective, she has contributed to 30 events. However, in most theatre concepts, this actress only contributed to one event, or more precisely, one production. Additionally, some concert events are found to have the same name as the contributors.

For more examples of AusStage event ambiguation, please refer to this jupyter notebook [AusStage_EventExploration.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_EventExploration.ipynb). A workaround solution will be described below in accounting for this circumstance.

##### Data Transformation & Loading

To address the issue of event ambiguity in the AusStage database, we created a new attribute called "unf_id" (unified ID) to assign the same ID to records that refer to the same individual or entity but are distributed across different records due to various reasons. This includes records for contributors, organisations, venues, and events. Specifically, event records with the same titles that occurred in the same year were grouped together as the same "real event," or "production" in common theatre terminology, unless they had same names as the organisations involved.

For more detailed of creating unified table for data loading, please check "**Create Table(s) (for unification)**" section in [AusStage_DBUpdate.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_DBUpdate.ipynb) and the corresponding SQL scripts.

Furthermore, to facilitate table joining during data loading, we created several views and renamed attribute names to match those used in ACDEA.

For more details in creating views for data loading, please refer to the "**Create Views**" section in [AusStage_DBUpdate.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_DBUpdate.ipynb) and the corresponding SQL scripts.

With these additional attributes and views, it is now possible to map the corresponding entities and attributes of AusStage to the entities and attributes in the ACDEA. The related records of the corresponding original records are also aggregated from the relationship entity and updated into the related attribute of the original records.

On an entity level, the AusStage entity projection is listed as follows:

<style>
  /* CSS for zebra-striped table */
  table {
    border-collapse: collapse;
    width: 100%;
  }

  th, td {
    padding: 8px;
  }

  /* Zebra striping */
  tr:nth-child(even) {
    background-color: #f2f2f2;
  }
</style>

| AusStage Entity (Collection)  | ACDEA Entity |
| ----------------------------- | ------------ |
| contributor                   | person       |
| work                          | work         |
| event                         | event        |
| -                             | recognition  |
| venue                         | place        |
| organisation                  | organisation |
| item, datasource              | resource     |
| foreign keys across each entity | relationship |
<br>

On attribute level, please find the attribute mapping details in the notes of the AusStage data dictionary. The data dictionary can be downloaded below. 

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Add icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <style>
.btn {
  background-color: #f39c52;
  border: none;
  color: white;
  padding: 12px 30px;
  cursor: pointer;
  font-size: 15px;
  border-radius: 5px; /* Make the button rounder */
}
</style> -->

</head>
<body>

<div style="text-align: center;">
	<button id="download-btn" class="btn" style="background-color: #f39c52; color: white; border: none; color: white; padding: 12px 30px; cursor: pointer; font-size: 15px; border-radius: 5px;"> <i class="fa fa-download"></i> Download <br>AusStage data dictionary</button>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/filesaver.js"></script>
<script>
  // Define the URL of the CSV file
  const csvUrl = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data dictionaries/AusStage_Data_Dictionary.xlsx";
  
  // Add a click event listener to the button
  document.getElementById("download-btn").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr = new XMLHttpRequest();
    xhr.open("GET", csvUrl);
    xhr.responseType = "blob";
    xhr.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr.response, "AusStage_Data_Dictionary.xlsx");
    };
    xhr.send();
  });
</script>
<br>

For more details in data loading of AusStage, please refer to this jupyter notebook [AusStage_Loading.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_Loading.ipynb).

#### Integration Data Report
---
The following chart, which was generated by the jupyter notebook [AusStage_IntegrationSummary.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/AusStage_IntegrationSummary.ipynb), illustrates the number of AusStage records before and after integration.
<br><br>

![AusStage Integration](./images/ivy_images/AusStage_integration_summary.png)

#### Analytical examples
---
For examples of how to use the integrated AusStage data for analytical purposes, please refer to the following jupyter notebooks in the **Data Analysis** chapter of this book.
- [**ACDE Map**](https://acd-engine.github.io/jupyterbook/Analysis_ACDE_Map.html)
- [**AusStage: Preliminary analysis**](https://acd-engine.github.io/jupyterbook/Analysis_AusStage.html)
- [**DAAO 500**](https://acd-engine.github.io/jupyterbook/Analysis_DAAO500.html#ausstage-roles)
- [**Exploring intersections of external data**](https://acd-engine.github.io/jupyterbook/Analysis_ExternalDatasets.html)

#### References
---
* [AusStage Data Entry Manual Version 6.0](https://www.ausstage.edu.au/opencms/export/system/modules/au.edu.flinders.ausstage.learn/pages/learn/contribute/manuals/AusStage_Data_Entry_Manual_2021.pdf)

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>