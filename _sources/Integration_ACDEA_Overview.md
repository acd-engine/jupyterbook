### Overview of the Australian Cultural Data Engine Architecture

To construct a unified data model for the Australian Cultural Data Engine, a set of eight entities were identified from the overlapping entities of all the data models of the current data sources. The eight entities include `person`, `organisation`, `event`, `work`, `recognition`, `place`, `resource`, and `relationship`. These entities were selected based on their relevance to cultural data, and their ability to provide a comprehensive view of the data from the various cultural databases.

The conceptual diagram below presents the Australian Cultural Data Engine Architecture:

![Australian Cultural Data Engine Architecture](./images/ivy_images/ACD-E_Architecture_General.png)

Each entity within the ACDEA serves a unique and important purpose in the overall model. Additionally, each entity contains three essential types of data:

* The metadata of the record, including the original (database) ID, URL, associated entity name, timestamps, and other important details. This metadata is crucial in maintaining the integrity and traceability of the data.

* The description of the record.

* The one-dimensional related records of the particular record refer to its direct connections to other records across all enttities i.e., person-to-person, person-to-event, etc. This feature provides easier access to the network relationships of a particular record.

The descriptive summary of the contents of each entity is described as follows:

- **Person**: representing individuals who are relevant to the cultural data. 
  
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
<br><br>

- **Organisation**: representing organisations that are relevant to the cultural data.
  
  - Names: all types of names of the organisation, including display name, primary name and alternative names.
  
  - Description: the brief description of the organisation.
  
  - Types: the types of the organisation.
  
  - Long Term Roles: the roles that the organisation has held for an extended period of time.
  
  - Operation: the features about operation of the organisation.
  
  - Locations: the places where the organisation has been located.
<br><br>

- **Event**: representing cultural events. 
  
  - Title
  
  - Description: the brief description of the event.
  
  - Types: the types of the events.
  
  - Time & Place: the specific date and location where the event took place.
<br><br>

- **Work**: representing cultural works such as books, architecture, performance, art, etc. 
  
  - Titles: all types of titles of the work, including primary title and alternative titles.
  
  - Summary: the summary of the work.
  
  - Time & Place: the specific date and location where the work was created.
<br><br>

- **Recognition**: representing awards or recognition received by individuals or organisations. 
  
  - Title
  
  - Summary: the summary of the recognition.
  
  - Types: the types of the recognition.
  
  - Time & Place: the specific date and location where the recognition was granted.
<br><br>

- **Place**: representing the locations that are geographic locations or facilities where the cultural events take place. 
  
  - Names: all types of names of the location, including primary names and alternative names.
  
  - Address: the standardized physical address of the location, including country, state, suburb, street and postcode.
  
  - Geo-Coordinates: the geographic coordinates (latitude and longitude) of the locations.
  
  - Start & End Date (Optional): the start and demolished date of a location, which is the optional information in tracking the changes of a location whose type is "venue" over time.
<br><br>

- **Resource**: represents resources that are relevant to the cultural data, such as books, images, paintings and audio files. The descriptive details of this entity refer to the metadata schema used in the National Library of Australia.
  
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
<br><br>

- **Relationship**: representing the relationships between the various entities within the cultural data. It plays a crucial role in establishing connections and dependencies between the other entities.
  
  - Subject: the entity that initiates the relationship.
  
  - Object: the entity that is being related to by the subject.
  
  - Predicate: describing the type of relationship that exists between the subject and the object.
  
  - Time: the time period during which the relationship between the subject and the object existed.

The following illustration shows an overview of the attributes in ACDEA.

![Australian Cultural Data Engine Architecture](./images/ivy_images/ACD-E_Architecture_Details.png)

To obtain more detailed information about the specific attributes within each entity, please refer to the **ACDEA data dictionary**. The data dictionary can be downloaded below. 

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
	<button id="download-btn" class="btn"><i class="fa fa-download"></i> Download <br>ACDEA data dictionary</button>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/filesaver.js"></script>
<script>
  // Define the URL of the CSV file
  const csvUrl = "https://raw.githubusercontent.com/acd-engine/jupyterbook/master/data dictionaries/ACDE_Data_Dictionary.xlsx";
  
  // Add a click event listener to the button
  document.getElementById("download-btn").addEventListener("click", () => {
    // Load the CSV file from the URL using an XMLHttpRequest
    const xhr = new XMLHttpRequest();
    xhr.open("GET", csvUrl);
    xhr.responseType = "blob";
    xhr.onload = () => {
      // Save the Blob as a file with the given name
      saveAs(xhr.response, "ACDE_Data_Dictionary.xlsx");
    };
    xhr.send();
  });
</script>

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>