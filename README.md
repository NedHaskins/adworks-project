# adworks-project
A project completed in December 2020.  A dimensional model of the Microsoft AdventureWorks OLTP database with accompanying visual references and code.

Thanks for checking out this project!

This repository is organized as follows:

    • The Purchasing, Sales, and SalesPerformance folders contain all of the code needed to construct the views and dinemsion and fact tables in the model.

    • A visual of the model in PDF format is provided.

For this project I worked with Microsoft's AdventureWorks database to apply the dimensional modeling framework to a fictional large-scale business enterprise.

The project consisted of the following large-scale steps:

    • Create a complete table representation (ER diagram) of the entire OLTP database with all relationships, recognizing the primary and secondary key connections that create those relationships and make dimensional modeling possible
    • Create a "flow chart" for the progression, or life cycle, of the data in the database that is a high-level model for the activities of the business
    • Create a dimensional model of the business following concepts outlined in Kimball's "A Dimensional Modeling Manifesto" that also reflects the practical needs of analysts who query the data; create dimension and fact tables based on the most important logical and physical (key) relationships within the data
    • Create a visualization of the model using Lucidchart

The project offered the following learning opportunities:

    • The chance to scrutinize the database model and look for chances to improve the code and the relationships between the tables
    • Implementing the requirement of connecting the "physical" database structure with the logical progression of business activities
    • Practicing SQL queries with many types of conditional statements
    • Creating views and fact tables with SQL, specifying data types
    • Inserting data from one table to another while preserving the data type
