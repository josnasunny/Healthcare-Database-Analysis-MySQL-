create database project;
use project;

# Q1
SELECT 
    TIMESTAMPDIFF(YEAR, pa.dob, CURDATE()) AS age,
    COUNT(DISTINCT pa.patientID) AS numTreatments
FROM Patient pa
JOIN Treatment t 
    ON t.patientID = pa.patientID
GROUP BY age
ORDER BY numTreatments DESC;

# Q2
SELECT 
    a.city,
    COUNT(DISTINCT p.personID) AS numRegisteredPeople,
    COUNT(DISTINCT ph.pharmacyID) AS numPharmacies,
    COUNT(DISTINCT ic.companyID) AS numInsuranceCompanies
FROM Address a
LEFT JOIN Person p 
    ON p.addressID = a.addressID
LEFT JOIN Pharmacy ph 
    ON ph.addressID = a.addressID
LEFT JOIN InsuranceCompany ic 
    ON ic.addressID = a.addressID
GROUP BY a.city
ORDER BY numRegisteredPeople DESC;

# Q3
SELECT 
    c.prescriptionID,
    SUM(c.Quantity) AS totalQuantity,
    CASE
        WHEN SUM(c.Quantity) < 20 THEN 'LowQuantity'
        WHEN SUM(c.Quantity) BETWEEN 20 AND 49 THEN 'MediumQuantity'
        ELSE 'HighQuantity'
    END AS Tag
FROM Contain c
JOIN Prescription p
    ON p.prescriptionID = c.prescriptionID
JOIN Pharmacy ph
    ON ph.pharmacyID = p.pharmacyID
WHERE ph.pharmacyName LIKE '%Ally%'
GROUP BY c.prescriptionID;

# Q4
SELECT 
    c.prescriptionID,
    SUM(c.Quantity) AS totalQuantity,
    (
        SELECT AVG(totalQty)
        FROM (
            SELECT SUM(Quantity) AS totalQty
            FROM Contain
            GROUP BY prescriptionID
        ) t
    ) AS avgQuantity
FROM Contain c
GROUP BY c.prescriptionID
HAVING SUM(c.Quantity) >
(
    SELECT AVG(totalQty)
    FROM (
        SELECT SUM(Quantity) AS totalQty
        FROM Contain
        GROUP BY prescriptionID
    ) t
);

# Q5
describe disease;
SELECT 
    d.`diseaseName`, 
    COUNT(t.claimID) AS numClaims
FROM Disease d
JOIN Treatment t 
    ON d.`ï»¿diseaseID` = t.diseaseID
WHERE d.`diseaseName` LIKE '%p%'
GROUP BY d.`diseaseName`;

   



   




  






    

