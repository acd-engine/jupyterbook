### Special Considerations for Data Analysis

As ACDEA is a prototype for integrating existing data sources and it is still in a stage that need further cleansing, there are some special considerations to be aware of when conducting data analysis.

1. **Ambiguous Concepts**: When working with ACDEA, it is important to keep in mind that some of the concepts may have different interpretations across cultural data in different domains. 
   <br><br>

   For example, the entity "project" in DAQA may have a different definition from "work" in DAAO, despite being integrated into the same level "Work". Similary, AusStage's "event" may be defined differently from the general "event" concept which is more like "production" in performing art.
   <br><br>

   Hence, it is important to understand the specific concept being used in each data source. And further data manipulation could be required to construct the exact entities you want to analyze.
<br><br>

2. **Duplicated Records**: Another important consideration when working with ACDEA is dealing with duplicated records. Due to the nature of integrating data from multiple sources, it is possible for some records to appear in multiple places. As de-duplication progress is still under experimentation at this stage, it is crucial to identify and handle duplicated records appropriately to avoid skewing analysis results.
<br><br>

3. **Empty Values**: When working with current datasets, it is important to note that some records may contain missing or empty values for certain attributes. These empty expressions could be represented as `null`, "", "None", "null", or other variations. This could be due to incomplete or inconsistent data in the original data sources, or due to errors during the integration process. 
<br><br>

   To avoid skewing the analysis results, it is important to identify and handle these missing values appropriately. Depending on the analysis being conducted, empty values may need to be **imputed** or **removed**. Additionally, it is important to carefully consider **the impact of missing data on the validity of the results** and to acknowledge any limitations or uncertainties caused by missing values.