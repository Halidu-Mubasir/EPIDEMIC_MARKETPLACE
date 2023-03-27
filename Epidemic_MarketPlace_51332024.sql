DROP DATABASE IF EXISTS epidemic_marketplace_51332024;

CREATE DATABASE epidemic_marketplace_51332024;

USE epidemic_marketplace_51332024;

CREATE TABLE DISEASE (
	diseaseId int auto_increment,
	DiseaseName varchar(50) not null unique,
	pathogen varchar(20) not null unique,
	pathogenGroup varchar (20) not null,
	LatentPeriod varchar (10) null,
	InfectiousPeriod varchar (10) null,
	host varchar (20) default "Human",
	PRIMARY KEY (diseaseId)
);

CREATE TABLE OUTBREAK (
	outbreakId int auto_increment,
	diseaseId int,
	OutbreakName varchar (30) unique not null,
	OutbreakDescription varchar (255) not null,
	YearOfFirstEmergence date not null,
	PRIMARY KEY (outbreakId),
	FOREIGN KEY (diseaseId) references DISEASE (diseaseId) on delete cascade,
	FOREIGN KEY (diseaseId) references DISEASE (diseaseId) on update cascade
);

CREATE TABLE COUNTRY (
	countryId int auto_increment,
	CountryName varchar (30) not null unique,
	CountryCode varchar (5) not null unique,
	Region varchar (30) not null,
	Continent varchar (15) not null,
	PRIMARY KEY (countryId)
);

CREATE TABLE DEMOGRAPHIC (
	demographicId int auto_increment,
	Affected_group varchar (255) not null,
	SocioEconomicActivity varchar (30) null,
	EnvironmentalCondition varchar (30) not null,
	Population int not null,
	PRIMARY kEY (demographicId)
);

CREATE TABLE SYMPTOM (
	symptomId int auto_increment,
	SymptomName varchar (20) not null unique,
	SymptomSynonym varchar (15) not null unique,
	SymptomDefinition varchar (255) not null,
	PRIMARY kEY (symptomId)
);

CREATE TABLE TRANSMISSION (
	transmissionId int auto_increment,
	EnvironmentalFactor varchar (50) not null,
	TransmissionMechanism varchar (255) not null,
	PRIMARY KEY (transmissionId)
);

CREATE TABLE TREATMENT (
	treatmentId int auto_increment,
	TreatmentName varchar (50) not null unique,
	TreatmentCategory varchar (50) not null,
	Treatmentdescription varchar (255) null,
	PRIMARY KEY (treatmentId)
);

CREATE TABLE CONTROL_MEASURE (
	controlId int auto_increment,
	ControlType varchar (50) not null,
	ControlDescription varchar (100) null,
	PRIMARY KEY (controlId)
);

CREATE TABLE VECTOR (
	vectorId int auto_increment,
	transmissionId int,
	VectorName varchar (50) not null unique,
	Vector_Specie varchar (50) not null,
	PRIMARY KEY (vectorId),
	FOREIGN KEY (transmissionId) references TRANSMISSION (transmissionId) on delete cascade,
	FOREIGN KEY (transmissionId) references TRANSMISSION (transmissionId) on update cascade
);

CREATE TABLE OUTBREAK_COUNTRY_DEMOGRAPHIC (
	outbreakId int,
	countryId int,
	demographicId int,
	OutbreakYear date not null,
	EndYear date null,
	NumOfInfected int null,
	NumOfDeaths int null,
	SpreadFrequency double not null,
	CHECK (numOfInfected >= numOfDeaths),
	FOREIGN KEY (outbreakId) references OUTBREAK (outbreakId),
	FOREIGN KEY (countryId) references COUNTRY (countryId),
	FOREIGN KEY (demographicId) references DEMOGRAPHIC (demographicId)
);

CREATE TABLE DISEASE_SYMPTOM (
	diseaseId int,
	symptomId int,
	FOREIGN KEY (diseaseId) references DISEASE (diseaseId),
	FOREIGN KEY (symptomId) references SYMPTOM (symptomId)
);

CREATE TABLE DISEASE_TRANSMISSION_CONTROL (
	diseaseId int,
	transmissionId int,
	controlId int,
	FOREIGN KEY (diseaseId) references DISEASE (diseaseId),
	FOREIGN KEY (transmissionId) references TRANSMISSION (transmissionId),
	FOREIGN KEY (controlId) references CONTROL_MEASURE (controlId)
);

CREATE TABLE DISEASE_TREATMENT (
	diseaseId int,
	treatmentId int,
	FOREIGN KEY (diseaseId) references DISEASE (diseaseId),
	FOREIGN KEY (treatmentId) references TREATMENT (treatmentId)
);

CREATE TABLE DIRECT_TRANSMISSION (
	transmissionId int,
	transmissionType varchar (30) not null,
	FOREIGN KEY (transmissionId) references TRANSMISSION (transmissionId)
);

-- TABLES POPULATION

-- INSERTION INTO THE PERSON TABLE FOR THE DIFFERENT PERSON GROUP

-- INSERTION INTO DISEASE
INSERT INTO DISEASE (DiseaseName, pathogen, pathogenGroup, latentPeriod, infectiousPeriod)
VALUES  ("Ebola Virus Disease", "Ebolavirus", "Virus", "0-10", "11-22"),
		("Cholera", "Vibrio cholarae", "Bacterium", "0-4", "5-15"),
		("Malaria", "Plasmodium", "Parasite", "0-8", "9-19"),
		("Yellow Fever", "Flavivirus", "Virus", "0-5", "5-21"),
		("Meningitis", "Meningococcus", "Bacterium", "0-15", "16-31");

-- INSERTION INTO OUTBREAK
INSERT INTO OUTBREAK (diseaseId, outbreakName, Outbreakdescription, YearOfFirstEmergence)
VALUES  (1, "Ebola Disease Outbreak", "The outbreak is a dead disease, first recorded in 1930", "1973-09-20"),
		(2, "Cholera Outbreak", "The outbreak is a dead disease, first recorded in 1930", "2004-02-14"),
		(3, "Malaria Disease Outbreak", "The outbreak is a dead disease, first recorded in 1930", "1988-03-10"),
		(4, "Yellow Fever Outbreak", "The outbreak is a dead disease, first recorded in 1930", "1800-07-12"),
		(5, "Meningitis Outbreak", "The outbreak is a dead disease, first recorded in 1930", "2012-11-30");

-- INSERTION INTO COUNTRY
INSERT INTO COUNTRY (countryName, countryCode, region, continent)
VALUES  ("Sudan", "+249", "North Eastern Africa", "Africa"),
		("Nigeria", "+234", "Sub-Sahara Africa", "Africa"),
		("Qatar", "+974", "Middle East", "Asia"),
		("Canada", "+1", "NorthAmerica", "North America"),
		("India", "+91", "Southeast Asia", "Asia");

-- INSERTION INTO DEMOGRAPHIC_DETAILS
INSERT INTO DEMOGRAPHIC (affected_group, socioEconomicActivity, environmentalCondition, population)
VALUES  ("Elderly people, Pregnant, and Breastfeeding women", "Agriculture", "Low humidity", 3000000),
		("Children, Women", "Trade", "Polluted Water", 12000),
		("Children", "student", "High Temperatures", 2003450),
		("Elderly people, Youth", "factory work", "High Humidity", 9990000),
		("Elderly People", "agrigulture", "Hihg Rainfall", 123400);

-- INSERTION INTO SYMPTOM
INSERT INTO SYMPTOM (symptomname, symptomsynonym, symptomDefinition)
VALUES  ("Cough", "coughs", "A sudden, audible expulsion of air from the lungs 
		through a partially closed glottis, preceded by inhalation."),
		("Sleepiness", "somnolence", "Compelling urge to sleep."),
		("Fever", "Pyrexia", "An abnormal elevation of body temperature, usually as a result of a pathologic process."),
		("Edema", "Anasarca", "Abnormal fluid accumulation in TISSUES or body cavities."),
		("Fatigue", "Lassitude", "The state of weariness following a period of exertion, mental or physical, characterized 
        by a decreased capacity for work and reduced efficiency to respond to stimuli.");

-- INSERTION INTO TRANSMISSION
INSERT INTO TRANSMISSION (environmentalFactor, transmissionmechanism)
VALUES  ("above-normal rainfall", "Increased vegetation promoting increase in rodent reservoir"),
		("Flooding", "Promotes exposure to contaminated rat urine and water"),
		("Deforestation", "Creation of vector breeding sites"),
		("bushmeat hunting", "Exposure to infected bush animals"),
		("Water Treatment Plant", "Inadequate microbial barriers");

-- INSERTION INTO TREATMENT
INSERT INTO TREATMENT (treatmentName, treatmentcategory, treatmentdescription)
VALUES  ("Radiotherapy", "Radiation Therapy", "High-energy radiation therapy used to treat cancer"),
		("Arthroscopy.", "Surgery", "a procedure for diagnosing and treating joint problems"),
		("IV antibiotics", "Antibiotics", "Taking doses of drugs prescribed by a doctor."),
		("parenteral artesunate", "Medication", "Taking doses of drugs prescribed by a doctor."),
		("Intravenous hydration", "Hydration Therapy", "The injection of specially formulated liquids into a vein to prevent or treat dehydration");

-- INSERTION INTO CONTROL_MEASURE
INSERT INTO CONTROL_MEASURE (controlType, controlDescription)
VALUES  ("Personal Hygiene", "Improving personal hygienic practices such as hand washing"),
		("Quarantine", "Quarantine keeps someone who might have been exposed to the virus away from others. "),
		("Vaccination", "The administration of a vaccine to help the immune system develop immunity from a disease."),
		("Chemical Spraying of Vectors", "Using chemicals to kill vectors of diseases to control the spread of the disease"),
		("Usage of Personal Protective Equipment", "Using PPEs such as nose mask, overall clothes, and hand sanitizers."),
        ("Isolation", "Isolation separates sick people with a contagious disease from people who are not sick.");

-- INSERTION INTO VECTOR
INSERT INTO VECTOR (transmissionId, vectorName, vector_specie)
VALUES  (5, "Anopheles Mosquito", "Anopheles gambiae Giles"),
		(4, "Aedes aegypti", "Aedes albopictus"),
		(2, "Blackflies", "Simulium damnosum"),
		(3, "Tsetse flies", "Trypanosoma brucei"),
		(1, "Tick", "Amblyomma americanum");

-- INSERTION INTO OUTBREAK_COUNTRY
INSERT INTO OUTBREAK_COUNTRY_DEMOGRAPHIC (outbreakId, countryId, demographicId, outbreakYear, endYear, numOfInfected, numOfDeaths, spreadFrequency)
VALUES  (1,2,1, "2004-11-25", "2005-01-15", 5430, 123, 2.9),
		(1,3,4, "2014-08-21", "2014-12-30", 64301, 783, 3.5),
		(1,5,3, "2015-03-29", "2017-09-21", 6430, 999, 8.5),
		(2,2,1, "2020-04-03", null, 7800, 890, 3.0),
		(5,4,2, "2019-10-01", "2019-11-23", 10000, 2100, 6.2),
		(4,2,3, "1999-12-19", "2001-12-07", 67430, 200, 7.3),
		(2,4,3, "2000-07-0", "2004-05-09", 438, 123, 1.0),
		(3,5,5, "2004-01-13", "2004-08-01", 748, 34, 2.5),
		(3,4,2, "2022-11-28", null, 2930, 21, 1.4),
		(2,1,5, "2004-06-15", "2008-01-12", 100, 20, 5.1),
		(4,4,4, "1997-03-25", "1999-10-16", 203, 34, 2.5);


-- INSERTION INTO DISEASE_SYMPTOM
INSERT INTO DISEASE_SYMPTOM (diseaseId, symptomId)
VALUES  (1, 2),
		(2, 5),
		(3, 1),
		(4, 3),
		(5, 2),
		(2, 2),
		(4, 4),
		(2, 1),
		(3, 4),
		(1, 1);

-- INSERTION INTO DISEASE_TRANSMISSION_CONTROL
INSERT INTO DISEASE_TRANSMISSION_CONTROL (diseaseId, transmissionId, controlId)
VALUES  (1, 2, 5),
		(2, 2, 4),
		(3, 1, 3),
		(4, 5, 2),
		(5, 3, 1),
		(2, 1, 1),
		(4, 1, 1),
		(2, 5, 3),
		(3, 4, 5),
		(1, 4, 4);

-- INSERTION INTO DISEASE_TREATMENT
INSERT INTO DISEASE_TREATMENT (diseaseId, treatmentId)
VALUES  (1, 2),
		(2, 5),
		(3, 1),
		(4, 3),
		(5, 2),
		(2, 2),
		(4, 4),
		(2, 1),
		(3, 4),
		(1, 1);

-- INSERTION INTO DIRECT_TRANSMISSION
INSERT INTO DIRECT_TRANSMISSION (transmissionId, transmissionType)
VALUES  (1, "air borne"),
		(2, "water borne"),
		(3, "body contact"),
		(4, "air droplet"),
		(5, "soil borne"),
		(3, "airborne"),
		(5, "vehicle borne"),
		(2, "sexual activity"),
		(3, "soil borne"),
		(1, "airborne");

-- Creating indexes

/*Creating indexes for the outbreakYear column to increase the search speed based on the year
of outbreak without having to look through all the rows of the column */ 
create index outbreakYear_index on OUTBREAK_COUNTRY_DEMOGRAPHIC (outbreakYear);

/* When a symptom name is used in a query to find the types of diseases it is associated to, the indexes 
make the search faster since it doesn't have to look through the entire column */
create index symptomName_idex on Symptom (symptomName);

/* Creating indexes for the treatmentName column to increase the search speed based on the treatment name
 without having to look through all the rows of the column */
create index treatmentName_idex on Treatment (treatmentName);

/* Creating indexes for the outbreak end Year column to improve the search speed when given a 
specific end year without having to look through all the rows of the column */
create index endYear_idex on OUTBREAK_COUNTRY_DEMOGRAPHIC (endYear);

/* environmentalCondition_idex makes it easy and faster to return information based on specific environmental conditions.*/
create index environmentalCondition_idex on DEMOGRAPHIC (environmentalCondition);

-- QUERIES OF FUNCTIONALITIES

-- Query 1. countries and the outbreaks occurred
select
	country.countryName,
    outbreak.outbreakName,
    numOfInfected,
	numOfDeaths,
	spreadFrequency,
    YEAR(outbreakYear) AS OutbreakYear,
    YEAR(EndYear) AS EndYear
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join country on country.countryId=OUTBREAK_COUNTRY_DEMOGRAPHIC.countryId
    inner join outbreak on outbreak.outbreakId=OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId;


-- 2. country and the of outbreaks it has witnessed
select 
	country.countryName,
    country.continent,
    count(*) as "No. of Outbreaks"
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join country on country.countryId=OUTBREAK_COUNTRY_DEMOGRAPHIC.countryId
    group by country.countryName
	order by count(*) desc;
    
    
-- 3. environmental factor and likely outbreak
select 
	DEMOGRAPHIC.environmentalCondition,
    outbreak.outbreakName
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join DEMOGRAPHIC on DEMOGRAPHIC.demographicId=OUTBREAK_COUNTRY_DEMOGRAPHIC.demographicId
    inner join outbreak on outbreak.outbreakId=OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId
where environmentalCondition = "High Temperatures";


-- Query 3. outbreak and likely environmental conditions it thrives in and the group of people affected most
select 
	DEMOGRAPHIC.environmentalCondition,
	DEMOGRAPHIC.affected_group,
	outbreak.outbreakName
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join DEMOGRAPHIC on DEMOGRAPHIC.demographicId=OUTBREAK_COUNTRY_DEMOGRAPHIC.demographicId
	inner join outbreak on outbreak.outbreakId=OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId
where outbreak.outbreakName = "Cholera Outbreak";


-- Query 4. outbreaks since 2012
select
	country.countryName,
    outbreak.outbreakName,
    numOfInfected,
	numOfDeaths,
	spreadFrequency,
    YEAR(outbreakYear) AS OutbreakYear,
    YEAR(EndYear) AS EndYear
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join country on country.countryId=OUTBREAK_COUNTRY_DEMOGRAPHIC.countryId
    inner join outbreak on outbreak.outbreakId=OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId
where YEAR(outbreakYear) >= "2012";


-- Query Outbreaks caused by specific pathogen group
select distinct outbreak.outbreakname, disease.diseaseName, disease.pathogen 
from OUTBREAK_COUNTRY_DEMOGRAPHIC 
inner join outbreak on outbreak.outbreakId = OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId
inner join disease on outbreak.diseaseId = disease.diseaseId
where pathogenGroup in (
	select pathogenGroup from disease 
    where pathogenGroup = "Virus"
);

-- Query 5. number of times each outbreak has occurred
select 
	outbreakName,
    disease.diseaseName,
    count(*) as "No. of Occurrence"
from OUTBREAK_COUNTRY_DEMOGRAPHIC
	inner join outbreak on outbreak.outbreakId=OUTBREAK_COUNTRY_DEMOGRAPHIC.outbreakId
	inner join disease on disease.diseaseId=outbreak.outbreakId
    group by outbreak.outbreakName
	order by count(*) desc;


-- Query 6. disease and respective treatment for a particular symptom of the disease
select
	disease.diseaseName,
    symptom.symptomname,
    treatment.treatmentName,
    treatment.treatmentcategory
from disease
	inner join disease_symptom on disease.diseaseId=disease_symptom.diseaseId
    inner join symptom on disease_symptom.symptomId = symptom.symptomId
    inner join disease_treatment on disease.diseaseId=disease_treatment.diseaseId
    inner join treatment on disease_treatment.treatmentId = treatment.treatmentId
where symptomname in (
	select symptomname from symptom 
    where symptomname = "Cough"
);














