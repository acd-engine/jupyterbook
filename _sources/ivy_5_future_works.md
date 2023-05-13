## Future Works

#### Improving Accessibility, Efficiency, and Scalability
---
One of the key focus areas for future works is to improve the accessibility, efficiency, and scalability of ACDEA.
   
**Accessibility:** To improve the accessibility of ACDEA, we plan to develop APIs and a more user-friendly interface that can provide researchers with streamingly updated data. This will enable researchers to access the data they need more easily and quickly.

**Efficiency:** In the next stage, we plan to improve the overall performance of the ETL (extract, transform, load) process for ACDEA. This will involve migrating the data processing progress to a more powerful server, implementing multithreading, and using MPI (message passing interface) to increase the efficiency of data transfer.

**Scalability:** In order to enhance the scalability of ACDEA, careful consideration will be given to the dynamic nature of the data sources and the study of ontology. Special attention will be devoted to improving the fault tolerance of the system, ensuring its resilience against failures and errors.

It is worth noting that the resource level plays a crucial role in ACDEA, as it inherits the complex structure of the library archive. Therefore, careful consideration will be given to determining whether the resource level should retain the same level of information and structure as found in the original library archive. This decision will require thoughtful design in order to create a more scalable ACDEA that can seamlessly adapt to changes in the format and structure of the data sources.

#### Experimental Integration (Record Unification)
---
While the cultural data has benn integrated in the structural level, there is still room for finer integration in the unit record level to better utilize the ACDE data, which is called "Record Unification". It is common to find many duplicated records in different extents exsist in the integrated data. For instance, records under the same organization name might have different information that can be integrated into a single record. Another typical circumstance is records with different person names but referring to the same person, which are common within the same data source and across data sources. And it should not be ignored that some data sources might cite the data originated from the other data sources. For instance, CircuzOz cite the circuz performance data from AusStage.

Given the complexity of the situation, one of the significant focus of the future works would be conducting experiments to confirm the methodology of defining, detecting, and integrating the duplicated records.

#### Identify more implicity data
--- 
Implicit data refers to the data that is not explicitly mentioned or labeled but can be inferred from the existing data. For example, the gender, date of birth and relationships with other people of a person may not be explicitly mentioned in the attributes, but can be inferred from the biography of the person and other contextual information. Therefore, in the future works, efforts will be made to identify more implicit data and integrate them into the ACDE data.

#### Integrate with more data sources
---
ACDE currently integrates cultural data from six data sources. However, there are still many other sources of cultural data that have not yet been integrated into ACDE. For example, some interesting data sources that we have discovered are listed in [More Interesting Works and Cultural Data Sources](https://acd-engine.github.io/jupyterbook/ivy_7_more_interesting_works.html). 

In future work, efforts will be made to integrate with more data sources and develop a more scalable data integration life cycle that can adjust to data from different data models. This will not only enrich the cultural data in ACDE but also provide researchers with a more comprehensive and diverse cultural insight for their analysis.

