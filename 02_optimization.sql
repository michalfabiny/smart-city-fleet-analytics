CREATE OR REPLACE TABLE `Smart_City_fleet_management.fakt_jazdy_optimized`
PARTITION BY Datum_Jazdy
CLUSTER BY Vozidlo_ID, Uzivatel_ID AS
SELECT * 
FROM `Smart_City_fleet_management.fakt_jazdy`;
