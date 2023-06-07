## Introduction

> The Australian Cultural Data Engine is a multidisciplinary project based at the University of Melbourne that harnesses leading [cultural databases](https://www.acd-engine.org/partners) to analyse cultural production, artistic networks, and the socio-economic implications of arts and cultural data. 

The goal of the Australian Cultural Data Engine (ACDE) is to increase the accessibility and scope of cultural data in Australia. Additionally, it seeks to examine and address any biases, exclusions, or cultural assumptions that may exist within the data, with the aim of utilising high-quality data to provide rich, multilevel analysis and to tell more compelling stories.

In order to achieve the goals stated eariler, it is necessary to have a complete, accurate, and consistent view of the data. The data from various cultural databases need to be combined and harmonised for critical cultural analysis and quantitative analysis. Therefore, the data processing procedures in the ACDE become critical components of this project. 

This section will provide an overview of the crucial steps taken in the ACDE data processing, which include developing a unified data model, establishing the Australian Cultural Data Engine Architecture (ACDEA), as well as designing and implementing the ETL (Extraction, Transformation, Loading) process. Additionally, the future work of data processing will be discussed, as well as other interesting projects found during the implementation of this process.

For the sake of brevity and clarity, here are a list of abbreviations will be used in the following sections.

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

| Abbreviation | Full Name                                                                                                                                                            | Description                                                                                                                                                                                                                                                                                                |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ACDE         | [The Australian Cultural Data Engine](https://www.acd-engine.org/)                                                                                                   | The Australian Cultural Data Engine is a multidisciplinary project based at the University of Melbourne that harnesses leading [cultural databases](https://www.acd-engine.org/partners) to analyse cultural production, artistic networks, and the socio-economic implications of arts and cultural data. |
| ACDEA        | [The Australian Cultural Data Engine Architecture](https://acd-engine.github.io/jupyterbook/Integration_Architecture.html)                                                                                                                     | The Australian Cultural Data Engine Architecture is the unified data model of the Australian Cultural Data Engine.                                                                                                                                                                                       |
| AusStage     | [The Australian Live Performance Database](https://www.ausstage.edu.au/pages/browse/)                                                                                | The Australian Live Performance Database provides an accessible online resource for researching live performance in Australia.                                                                                                                                                                             |
| CircusOz     | [The Circus Oz Living Archive Collection](https://circusozlivingarchive.com/)                                                                                        | Built in collaboration with the world’s oldest contemporary circus company, the Circus Oz Living Archive combines performer interviews and performance videos with audience engagement to create an interactive, immersive environment for experiencing the magic of circus over and over again.           |
| DAAO         | [Design & Art Australia Online](https://www.daao.org.au/)                                                                                                            | Design & Art Australia Online is an open source freely accessible scholarly e-Research tool that presents biographical data about Australian artists, designers, craftspeople and curators.                                                                                                                |
| DAQA         | [Digital Archive of Queensland Architecture](https://qldarch.net/)                                                                                                   | This digital archive of Queensland architecture comprises thousands of audiovisual and textual files that allow you to explore relationships between people, projects and firms.                                                                                                                           |
| SFC          | [Summerhayes Family Collection](https://catalogue.curtin.edu.au/discovery/collectionDiscovery?vid=61CUR_INST:CUR_SPECIAL_COLLECTIONS&collectionId=81190473680001951) | The Summerhayes Family Collection represents the work of three generations of the Summerhayes family, Edwin, Reginald and Geoffrey, whose combined practice of architecture in Western Australia extended through the 20th century.

### Table of Contents
---

1. [Australian Cultural Data Engine Architecture](https://acd-engine.github.io/jupyterbook/Integration_Architecture.html)
   
   1.1 [Overview of the Australian Cultural Data Engine Architecture](https://acd-engine.github.io/jupyterbook/Integration_ACDEA_Overview.html)
   
   1.2 [Construct Workflow](https://acd-engine.github.io/jupyterbook/Integration_ACDEA_Construction.html)
   
   1.3 [Data Report (Exploration)](https://acd-engine.github.io/jupyterbook/Integration_ACDEA_DataReport.html)
   
   1.4 [Special Considerations for Data Analysis](https://acd-engine.github.io/jupyterbook/Integration_ACDEA_SpecialConsiderations.html)

2. [Data Sources](https://acd-engine.github.io/jupyterbook/Integration_DataSources.html)

    2.1 [Australian Live Performance Database](https://acd-engine.github.io/jupyterbook/Integration_DataSources_AusStage.html)
   
    2.2 [The Circus Oz Living Archive collection](https://acd-engine.github.io/jupyterbook/Integration_DataSources_CircusOz.html)
   
    2.3 [Design & Art Australia Online](https://acd-engine.github.io/jupyterbook/Integration_DataSources_DAAO.html)
   
    2.4 [Digital Archive of Queennsland Architecture](https://acd-engine.github.io/jupyterbook/Integration_DataSources_DAQA.html)
   
    2.5 [Summerhayes Family Collection](https://acd-engine.github.io/jupyterbook/Integration_DataSources_SummerHayes.html)

3. [Integrated Data](https://acd-engine.github.io/jupyterbook/Integration_Download.html)

4. [Future Works](https://acd-engine.github.io/jupyterbook/Integration_FutureWorks.html)

5. [More Interesting Works and Culture Data Sources](https://acd-engine.github.io/jupyterbook/Integration_Miscellaneous.html)

<style>
  a {
    color: #1ea5a6 !important;
  }
</style>