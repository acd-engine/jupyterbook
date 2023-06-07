### Design & Art Australia Online

#### Introduction
---
> Design and Art Australia Online (DAAO) is a collaborative e-Research tool built upon the foundations of the Dictionary of Australian Artists Online. DAAO is an open source freely accessible scholarly e-Research tool that links biographical data about Australian artists, designers, craftspeople and curators with information about artworks, event histories and collection details.

The following sections will describe the data processing procedure that integrates DAAO data into the ACDE and the data sumary of DAAO.

#### Data Processing
---
##### Data Extraction & Exploration

The DAAO data was provided in the format of a MongoDB database dump. The dump was restored, and 20 collections were found in the DAAO database, which include:

1. Main collections for the primary objects and their relationships: xactivity, xparty, xwork, xpredicate, relation

2. The corresponding version-controlling collections for main collections: xactivity_counters, xactivity_revisions, xparty_counters, xparty_revisions, xwork_counters, xwork_revisions

3. Dependency collections for detailed information and the convenience of display: asset, controlledvocab, culturalheritage, externalresource, predicate, place, indigenousdreaming, stubperson, stubpersongroup

For more details in restoring the DAAO database, please refer to [DAAO_DBRestore.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_DBRestore.ipynb).

Since DAAO is an archive of data that is updated cumulatively, there is no up-to-date confirmed data model or data dictionary to refer to. However, a conceptual data model can be roughly inferred based on the actual display of the official website, the physical database, expert suggestions and [previous documentation](https://blogs.unsw.edu.au/daao/blog/2015/03/schema-and-data-model-refinements/). The conceptual data model is as follows:

![](./images/ivy_images/DAAO_Conceptual_Data_Model.png)
<br>

The schema of DAAO can also be confirmed as follows:

![](./images/ivy_images/DAAO_Schema.png)
<br>

During the exploration of the DAAO database, some concerns have been identified that should be taken into account when establishing the transforming and loading pipeline.

Firstly, it should be noted that not all records in the main entity collections are shown on the official website. Through comparing the data between the website and the raw database, it became apparent that some boolean fields like `is_locked`, `is_primary`, `is_shadow`, `is_featured` and `is_deleted` needed to be filtered out in order to maintain reliable records.

Secondly, the consistency of relationship records needs to be considered. The data in the `relation` collection does not include all relationships displayed on the official website. It appears that this collection may not have been updated after the last structural renovation of the website. Therefore, the collection of relationships needs to be reconstructed based on up-to-date relations.

Lastly, the `place` information is somewhat confusing. Although there are only four effective fields in the `place` collection, namely name, address, country, and centroid, the values in name, address, and country are often mixed up. As such, it is important to implement a `place` information normalisation process that utilises all available information to generate a standardised place record. This is particularly important for downstream analysis that requires spatial visualisation.

##### Data Transformation

![](./images/ivy_images/DAAO_ETL_Workflow.png)
<br>

Regarding the complexity of the DAAO data structure and the concerns found during DAAO data exploration, a three-step approach is proposed for DAAO data transformation. 

The first step is normalising the place records. The purpose of this step is to standardise the geo-elements of place records that are not consistently formatted, and to normalise the expression of name and address of specific places.  

To achieve this, two methods are implemented to infer the standardised elements of place information such as `country`, `state`, `city`, `suburb`, and optionally `postcode`. 

The first method is **reverse geocoding**, which involves using the latitude and longitude coordinates, as well as existing name and address in the DAAO database to find potential standardised address elements and place names. The reverse geocoding process generates two types of standardized location element candidate sets, which are merged to create a new place element candidate set. During this process, standardised location element candidate sets are selected from the reverse geocoding results.  

The second method is **rule-based recognition**. This method involves cleaning all place elements, such as address, name, and country, by correcting typographical errors and expanding place name abbreviations. From here, potential places in the cleaned place elements are identified to create the second set of potential standardised place element candidates.  

Once the two sets of candidates are ready, the extracted-candidates and geo-candidates are merged to create a final set of standardised place element candidates for the place records. The final place elements are confirmed by comparing each level of place element candidate from top (country) to bottom (suburb), excluding the inconsistent candidates and keeping the most frequent candidates. Any redundant place elements still present are removed by comparing whether the element is matching with all the other place elements.  

Finally, the cleaned location components can be updated to the `place` collection. This normalisation process standardises the geo-elements and place name expressions of the place records, making it easier to work with the data and reducing potential errors caused by inconsistent or incomplete data.

For more details in updating place information of DAAO, please refer to this jupyter notebook [DAAO_PlaceUpdate.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_PlaceUpdate.ipynb).

The second step is aggregating all the relationship records into a new collection `relationship`. There are `related_xxx` attributes existing in the records of main object collections (`xparty`, `xactivity`, and `xwork`), which shows the relationships among the primary objects. However, in ACDE, relationships with `resource` and `place`  that are not explicitly assigned as `related_xxx` attributes in DAAO records are also crucial. Therefore, the attributes showing relationships with `resource` and `place` should be firstly identified and inserted into the new collection `relationship`. For instance, `see_alsos`, `references`, `images`, and `portrait_images` are the attributes that connect `resource` with other entities, while the place of  `birth` and `death` are the attributes showing relationships between `person` and `place`. Following this implicit relationship extraction, the explicity relationships under `related_xxx` attributes of each main object can be inserted into the collection `relationship`.

For more details in reconstructing relationship collection of DAAO, please refer to this jupyter notebook [DAAO_RelationUpdate.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_RelationUpdate.ipynb).

The third step is standardising the format of date attributes. In all collections with date attributes, namely `xparty`, `xactivity`, `xwork`, and `externalresource`, all the relevant date attributes are updated in the format of json documents having `year`, `month`, and `day`. The original data of the collections are backed up into the collections named `{collection_name}_ori`. 

For more details in cleansing date fields in DAAO, please refer to this jupyter notebook [DAAO CleanDates.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_CleanDates.ipynb).

##### Data Loading

After making extensive preparations during the transformation process, it is now possible to map the corresponding entities/attributes of DAAO to the levels/attributes in ACDEA. Finally, related records were aggregated from the relationship level and updated into the related attribute of the original records.

On entity level, the DAAO entity projection is listed as follows:

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

| DAAO Entity (Collection) | ACDEA Level  |
| ------------------------ | ------------ |
| xparty.person            | person       |
| xwork.work               | work         |
| xactivity.Event          | event        |
| xactivity.Recognition    | recognition  |
| place                    | place        |
| xparty.PersonGroup       | organisation |
| external resource, asset | resource     |
| relationship             | relationship |
<br>

On attribute level, please find the attribute mapping details in the notes of **DAAO data dictionary**. The data dictionary can be downloaded below. 

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Add icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.btn {
  background-color: #f39c52;
  border: none;
  color: white;
  padding: 12px 30px;
  cursor: pointer;
  font-size: 15px;
  border-radius: 5px; /* Make the button rounder */
}
</style>

</head>
<body>

<div style="text-align: center;">
	<button id="download-btn" class="btn"><i class="fa fa-download"></i> Download <br>DAAO data dictionary</button>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/filesaver.js"></script>
<script>
  // Define the URL of the CSV file
  const csvUrl = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data dictionaries/DAAO_Data_Dictionary.xlsx";
  
  // Add a click event listener to the button
  document.getElementById("download-btn").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr = new XMLHttpRequest();
    xhr.open("GET", csvUrl);
    xhr.responseType = "blob";
    xhr.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr.response, "DAAO_Data_Dictionary.xlsx");
    };
    xhr.send();
  });
</script>
<br>

For more details in data loading of DAAO, please refer to this jupyter notebook [DAAO_Loading.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_Loading.ipynb).

#### Integration Data Report
---
The following chart, which was generated by the jupyter notebook [DAAO_IntegrationSummary.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/DAAO_IntegrationSummary.ipynb), illustrates the number of DAAO records before and after integration.

![](./images/ivy_images/DAAO_integration_summary.png)

#### Analytical examples
---
For examples of how to use the integrated DAAO data for analytical purposes, please refer to the following jupyter notebooks in the **Data Analysis** chapter of this book.
- [**The DAAO 500**](https://acd-engine.github.io/jupyterbook/Analysis_DAAO500.html)
- [**Natural language processing with DAAO**](https://acd-engine.github.io/jupyterbook/Analysis_DAAOVenues.html)

#### References
---
* [Schema and Data Model Refinements](https://blogs.unsw.edu.au/daao/blog/2015/03/schema-and-data-model-refinements/)
<br>

![Schema and Data Model Refinements](https://blogs.unsw.edu.au/daao/files/2015/03/DAAO-Data-Model-Proposed-Revisions-February-20151.jpg "Schema and Data Model Refinements")

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>