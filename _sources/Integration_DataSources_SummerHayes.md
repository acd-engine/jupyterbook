### Summerhayes Family Collection

#### Introduction
---
> This collection represents the work of three generations of the Summerhayes family who practiced architecture in Western Australia.

The following sections will describe the data processing procedure that integrates SFC data into the ACDE and the data sumary of SFC.

#### Data Processing
---
The SFC data is provided in an XML format using MARC standards, which are used for the representation and communication of bibliographic and related information in a machine-readable format. The SFC data has a clear structure as it is extracted from a professional library archive. However, there are still many efforts that need to be taken to parse the XML file according to the archive's structure description.

The following diagram shows the structure of Summerhayes Family Collection.
<br>
<br>

![TBC](./images/ivy_images/SFA_Structure.png)

For more details in parsing SFC data and loading it into the ACDEA, please refer to this jupyter notebook [SFC_Loading.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/SFC_Loading.ipynb). The details of SFC attributes projection from MARC to ACDEA can also be found in the notes of the **SFC data dictionary**. The data dictionary can be downloaded below. 

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
	<button id="download-btn" class="btn"><i class="fa fa-download"></i> Download <br>SFC data dictionary</button>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/filesaver.js"></script>
<script>
  // Define the URL of the CSV file
  const csvUrl = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data dictionaries/SFC_Data_Dictionary.xlsx";
  
  // Add a click event listener to the button
  document.getElementById("download-btn").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr = new XMLHttpRequest();
    xhr.open("GET", csvUrl);
    xhr.responseType = "blob";
    xhr.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr.response, "SFC_Data_Dictionary.xlsx");
    };
    xhr.send();
  });
</script>
<br>

It is important to note that the ACDEA does not assign any sub-level for the resource level, and due to the challenges in re-linking the original SFC records into a hierarchical structure, all the SFC records are loaded solely into the resource level of ACDEA. No new relationship records were constructed during this stage. The original hierarchy information is preserved and stored in the `_class_ori` field.

Ultimately, 241 SFC resource records were loaded into the resource level of ACDEA.

#### References
---
- [Summerhayes Family Collection](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951)
- [MARC Standards](https://www.loc.gov/marc/[MARC STANDARDS (Network Development and MARC Standards Office, Library of Congress)](https://www.loc.gov/marc/))

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>