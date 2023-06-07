## Integrated Data

As the result of the data integration, four formats of data have been generated for downstream data analysis purposes.

For more details of static files exported for ACDE, please refer to this jupyter notebook [ACDE_Export.ipynb](https://github.com/acd-engine/jupyterbook/blob/main/integration%20notebooks/ACDE_Export.ipynb).
<br>

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

| Format          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Database Dump   | A MongoDB database `acd_engine` that consists of 7 collections, including `event`, `organisation`, `person`, `place`, `recognition`, `relationship`, `resource`, `work`. This type of data is intended primarily for development purposes.                                                                                                                                                                                                                      |
| CSV             | Each `csv` file corresponds to a specific level in ACDEA and contains data organised according to the attributes of that level. The columns of the `csv` file represent the first-level attributes of the corresponding level. <br><br> Throughout the **Data Analysis** section of the book, we provide guidance on how on to download `csv` files directly from GoogleDrive using python. Alternatively, you can manually download these unified datasets from the [ACDE Google Drive repository](https://drive.google.com/drive/folders/1_nL5O0wMmkmVC79DbQojvQB14-kpDgWQ?usp=drive_link).                                                                                                                                                                                                                                           |
| JSONL           | `jsonl` is a format that stores data records as individual json objects separated by a newline character. Each `jsonl` file corresponds to a specific level in ACDEA, and the data is structured as a list of dictionaries, where each dictionary represents a data record. <br><br> Analogous to the `csv` files, you will also be able to effectively download the unified data as `jsonl` files via the **Data Analysis** section of the book, or manually download `jsonl` files from the [ACDE Google Drive repository](https://drive.google.com/drive/folders/1Ug38g_j1MUu7RiY6egLaSCqMXzIr_Fux?usp=drive_link).                                                                                                                                                                                                                                                                            |
| XLSX            | Each XLSX file corresponds to a **10% sample** of the specific level in ACDEA. Similar to the CSV files, the columns of each XLSX file represent the first-level attributes of the corresponding level. This type of data is intended for exploratory purposes. <br><br> You can download the sample files using the download buttons below.                                                                                                                                                |

<br>

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
  padding: 12px 15px;
  cursor: pointer;
  font-size: 15px;
  border-radius: 5px; /* Make the button rounder */
}
</style>


</head>
<body>

<div style="text-align: center;">
	<button id="download-btn-event" class="btn"><i class="fa fa-download"></i> Download <br>Event Sample (xlsx)</button>
	<button id="download-btn-org" class="btn"><i class="fa fa-download"></i> Download <br>Organisation Sample (xlsx)</button>
	<button id="download-btn-person" class="btn"><i class="fa fa-download"></i> Download <br>Person Sample (xlsx)</button>
	<button id="download-btn-place" class="btn"><i class="fa fa-download"></i> Download <br>Place Sample (xlsx)</button>
</div>
<br>
<div style="text-align: center;">
	<button id="download-btn-recog" class="btn"><i class="fa fa-download"></i> Download <br>Recognition Sample (xlsx)</button>
	<button id="download-btn-resource" class="btn"><i class="fa fa-download"></i> Download <br>Resource Sample (xlsx)</button>
	<button id="download-btn-work" class="btn"><i class="fa fa-download"></i> Download <br>Work Sample (xlsx)</button>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/filesaver.js"></script>
<script>
  // Define the URL of the CSV file
  const csvUrl_event = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_eventSample_202305080816.xlsx";

  const csvUrl_org = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_organizationSample_202305080816.xlsx";

  const csvUrl_person = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_personSample_202305080816.xlsx";

  const csvUrl_place = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_placeSample_202305080816.xlsx";

  const csvUrl_recog = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_recognitionSample_202305080816.xlsx";

  const csvUrl_resource = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_resourceSample_202305080816.xlsx";

  const csvUrl_work = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data/xlsx/acde_workSample_202305080816.xlsx";
  
  // Add a click event listener to the button
  document.getElementById("download-btn-event").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_event = new XMLHttpRequest();
    xhr_event.open("GET", csvUrl_event);
    xhr_event.responseType = "blob";
    xhr_event.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_event.response, "acde_eventSample_202305080816.xlsx");
    };
    xhr_event.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-org").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_org = new XMLHttpRequest();
    xhr_org.open("GET", csvUrl_org);
    xhr_org.responseType = "blob";
    xhr_org.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_org.response, "acde_organizationSample_202305080816.xlsx");
    };
    xhr_org.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-person").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_person = new XMLHttpRequest();
    xhr_person.open("GET", csvUrl_person);
    xhr_person.responseType = "blob";
    xhr_person.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_person.response, "acde_personSample_202305080816.xlsx");
    };
    xhr_person.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-place").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_place = new XMLHttpRequest();
    xhr_place.open("GET", csvUrl_place);
    xhr_place.responseType = "blob";
    xhr_place.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_place.response, "acde_placeSample_202305080816.xlsx");
    };
    xhr_place.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-recog").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_recog = new XMLHttpRequest();
    xhr_recog.open("GET", csvUrl_recog);
    xhr_recog.responseType = "blob";
    xhr_recog.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_recog.response, "acde_recognitionSample_202305080816.xlsx");
    };
    xhr_recog.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-resource").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_resource = new XMLHttpRequest();
    xhr_resource.open("GET", csvUrl_resource);
    xhr_resource.responseType = "blob";
    xhr_resource.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_resource.response, "acde_resourceSample_202305080816.xlsx");
    };
    xhr_resource.send();
  });

  // Add a click event listener to the button
  document.getElementById("download-btn-work").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr_work = new XMLHttpRequest();
    xhr_work.open("GET", csvUrl_work);
    xhr_work.responseType = "blob";
    xhr_work.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr_work.response, "acde_workSample_202305080816.xlsx");
    };
    xhr_work.send();
  });

</script>
<br>

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>