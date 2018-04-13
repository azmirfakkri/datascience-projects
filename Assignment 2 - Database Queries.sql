--Create relevant tables using CREATE TABLE statement
CREATE TABLE Doctor (
DoctorID int Primary Key NOT NULL,
FirstName varchar(255),
LastName varchar(255),
DOB date,
Gender varchar(255),
Address varchar(255),
Phone varchar(225),
Email varchar(255),
LevelID int,
DeptID varchar(255),
);

CREATE TABLE Patient (
PatientID int Primary Key NOT NULL,
FirstName varchar(255),
LastName varchar(255),
DOB date,
Gender varchar(255),
Address varchar(255),
Phone varchar(225),
Email varchar(255),
DoctorID int,
WardNo varchar(255),
IxID varchar(255),
);

CREATE TABLE Department (
DeptID varchar(255) Primary Key NOT NULL,
DepartmentName varchar(255),
Phone varchar(225),
Email varchar(255),
);

CREATE TABLE TrainingLevel (
LevelID int Primary Key NOT NULL,
Level varchar(255),
);

CREATE TABLE Ward (
WardNo varchar(255) Primary Key NOT NULL,
WardName varchar(255),
Phone varchar(225),
Capacity int,
);

CREATE TABLE Investigation (
IxID varchar(255) Primary Key NOT NULL,
InvestigationName varchar(255),
);

--Populate tables with INSERT INTO SQL
INSERT INTO Doctor
VALUES (1001, 'John', 'Murray', '05/10/1991', 'Male', '12 Merrion Road, Dublin 4', '0832712833', 'john.murray@gmail.com', 500, 'Med100'), 
(1002, 'Aoife', 'Donnelly', '17/02/1977', 'Female', '149 Cooley Street, Dublin 12', '0873428654', 'aoife123@hotmail.com', 600, 'Med100'), 
(1003, 'Mairead', 'Herlihy', '29/06/1990', 'Female', '5 Roebuck Road, Dublin 14', '0867266309', 'm.herlihy@gmail.com', 501, 'Med200'), 
(1004, 'John', 'Murray', '11/12/1975', 'Male', '66 Greenmount Avenue, Dublin 1', '0843773883', 'jm_2000@yahoo.com', 600, 'Surg100'), 
(1005, 'James', 'Howard', '24/07/1988', 'Male', '605 Crumlin Road, Dublin 12', '0823238460', 'jhoward@gmail.com', 502, 'Surg100'), 
(1006, 'Monica', 'Pearson', '21/03/1989', 'Female', '3671 Felis Avenue, Dublin 20', '0862410170', 'm_pearson@yahoo.com', 502, 'Med300'), 
(1007, 'Kaseem', 'Hoffman', '05/11/1980', 'Male', '1163 Erat Street, Dublin 13', '0868439479', 'k80_h@gmail.com', 503, 'Med200'), 
(1008, 'Ronan', 'O''Meara', '12/12/1976', 'Male', '8182 Dolor Road, Dublin 16', '0869611828', 'romrom@yahoo.com', 600, 'Surg200'), 
(1009, 'Niamh', 'Higgins', '17/01/1990', 'Female', '7432 Eget Street, Dublin 5', '0861919017', 'higginsniamh@hotmail.com', 501, 'Surg200'), 
(1010, 'Brigid', 'Smith', '03/04/1985', 'Female', '6900 Cras Road, Dublin 3', '0878554947', 'bsmith123@gmail.com', 503, 'Med300');


INSERT INTO Patient
VALUES (88101, 'Brenda', 'Lancaster', '19/04/1961',	'Female', '5166 Commodo Street, Dublin 16',	'0873733384', 'mthurn@live.com', 1010, '1M', 'FBC'), 
(88102,	'Denise', 'Summers', '22/06/2009', 'Female', '7296 Interdum Avenue, Dublin 4', '0818637900', 'fangorn@hotmail.com',	1001, '2M',	'CRP'), 
(88103,	'Hayley', 'Bonner', '11/12/1932', 'Female', '3906 Nullam Road, Dublin 15', '0874626798', 'euice@outlook.com', 1004,	'1S', 'CXR'), 
(88104,	'Clio',	'Flynn', '29/09/1950', 'Female', '1910 Iaculis Avenue, Dublin 20', '0849777966', 'rgarcia@optonline.net', 1003,	'3M', 'CRP'),
(88105,	'Glenna', 'Hood', '30/04/1985',	'Female', '4125 Donec Road, Dublin 10', '0884612277', 'mxiao@yahoo.com', 1005, '1S', 'FBC'), 
(88106,	'Nita',	'Hardin', '25/12/1996',	'Female', '851 Aliquet Street, Dublin 9', '0871750463', 'firstpr@att.net', 1004, '1S', 'LFT'), 
(88107,	'Ulysses', 'Washington', '14/04/1954', 'Female', '5185 Ullamcorper Street, Dublin 17', '0893996163', 'webdragon@comcast.net', 1006, '1M', 'U&E'), 
(88108, 'Deirdre', 'Padilla', '09/01/1971', 'Female', '7290 Felis Street, Dublin 3', '0876745795', 'jguyer@aol.com', 1005, '1S', 'MRI'), 
(88109,	'Idola', 'Dudley', '06/01/1989', 'Female', '7533 Quisque Avenue, Dublin 12', '0847289191', 'sakusha@yahoo.ca', 1006, '1M', 'LFT'),
(88110,	'Jessica', 'Patton', '16/11/1937', 'Female', '7713 Lobortis Street, Dublin 6','0828398052', 'crandall@sbcglobal.net', 1007, '3M', 'TFT'), 
(88111,	'Ivor', 'Aidan', '20/09/1980', 'Male', '9446 Risus Avenue, Dublin 18', '0814108645', 'drezet@hotmail.com', 1002, '2M', 'MRI'), 
(88112,	'Reese', 'Dominic', '25/05/1998', 'Male', '121 Nullam Street, Dublin 9', '0838851570', 'miyop@gmail.com', 1010, '1M', 'CT'), 
(88113,	'Amal',	'Nolan', '19/08/1976', 'Male', '1869 Vestibulum Street, Dublin 7', '0835603084', 'ournews@gmail.com', 1007, '3M', 'CXR'),
(88114,	'Timon', 'Allistair', '25/07/2015', 'Male', '595 Metus Avenue, Dublin 1', '0836757941', 'barnett@yahoo.ca', 1008, '2S', 'FBC'), 
(88115, 'Alan', 'Wylie', '17/04/1967', 'Male', '940 Suspendisse Street, Dublin 8', '0883360136', 'cgcra@sbcglobal.net', 1002, '2M', 'FBC'), 
(88116, 'Armand', 'Magee', '09/02/1971', 'Male', '8156 Nec Road, Dublin 11', '0862940396', 'ilial@comcast.net', 1002, '2M', 'TFT'), 
(88117, 'Yuli', 'Jordan', '06/08/1993', 'Male', '1867 Elementum Road, Dublin 14', '0824625722', 'stefano@live.com', 1008, '2S', 'CT'), 
(88118, 'Austin', 'Noah', '16/03/1958', 'Male', '1 Congue Avenue, Dublin 24', '0883303564', 'luebke@yahoo.com', 1002, '2M', 'U&E'), 
(88119, 'Gregory', 'Reed', '23/04/2012', 'Male', '4833 Nec Street, Dublin 7', '0893934114', 'sthomas@me.com', 1009, '2S', 'TFT'), 
(88120, 'Brennan', 'Griffin', '30/01/2009', 'Male', '222 Est Road, Dublin 1', '0822734238', 'jpflip@icloud.com', '1008', '2S', 'CRP');


INSERT INTO Department
VALUES ('Med100', 'Neurology', '194384839', 'neurology@vuh.ie'), 
('Med200', 'Nephrology', '185748494', 'nephrology@vuh.ie'), 
('Med300', 'Geriatrics', '180692504', 'geriatrics@vuh.ie'), 
('Surg100', 'Cardiothoracic', '153445673', 'cardiothoracic@vuh.ie'), 
('Surg200', 'Orthopaedics', '188295996', 'ortho@vuh.ie');


INSERT INTO TrainingLevel
VALUES (500, 'Intern'), 
(501, 'SHO'), 
(502, 'Registrar'), 
(503, 'Specialist Registrar'), 
(600, 'Consultant');


INSERT INTO Ward
VALUES ('1M', 'West', '102348391', 5), 
('1S', 'South', '185637473', 3), 
('2M', 'East', '194384239', 2), 
('2S', 'North East', '143435276', 5), 
('3M', 'North', '166337468', 1);



INSERT INTO Investigation
VALUES ('CRP', 'C-Reactive Protein'), 
('CT', 'Computed Tomography'), 
('CXR', 'Chest X-Ray'), 
('FBC', 'Full Blood Count'), 
('LFT', 'Liver Function Test'), 
('MRI', 'Magnetic Resonance Imaging'), 
('TFT', 'Thyroid Function Test'), 
('U&E', 'Urea & Electrolyte');


--5 Stored Procedures with parameters
-- (1) Doctor by Department
CREATE PROCEDURE spDrbyDept(@DeptName AS VARCHAR(255))
AS
BEGIN
	SELECT Department.[DepartmentName], Doctor.DoctorID, Doctor.[FirstName], Doctor.[LastName], Doctor.[LevelID]
	FROM (Department INNER JOIN Doctor ON Department.DeptID = Doctor.DeptID)
	WHERE (((Department.[DepartmentName])=@DeptName));
END

-- (2) Male Patient by Doctor
CREATE PROCEDURE spMalePtbyDr(@DrID AS INT)
AS
BEGIN
	SELECT Patient.PatientID, Patient.[FirstName], Patient.[LastName], Patient.Gender, Patient.DoctorID
	FROM Patient
	WHERE (((Patient.Gender)='Male') AND ((Patient.DoctorID)=@DrID)); 
END

-- (3) Patient born between certain Date
CREATE PROCEDURE spPtBornBtwn(@MinDate AS DATE, @MaxDate AS DATE)
AS
BEGIN
	SELECT Patient.PatientID, Patient.[FirstName], Patient.[LastName], Patient.DOB
	FROM Patient
	WHERE (((Patient.DOB) Between @MinDate And @MaxDate));
END

-- (4) Patient by Department
CREATE PROCEDURE spPtbyDept(@DeptName AS VARCHAR(255))
AS
BEGIN
	SELECT Department.[DepartmentName], Doctor.DoctorID, Doctor.[FirstName], Doctor.[LastName], Patient.PatientID, Patient.[FirstName], Patient.[LastName]
	FROM (Department INNER JOIN Doctor ON Department.DeptID = Doctor.DeptID) INNER JOIN Patient ON Doctor.DoctorID = Patient.DoctorID
	WHERE (((Department.[DepartmentName])=@DeptName));
END

-- (5) Training Level
CREATE PROCEDURE spTrainingLevel
AS
BEGIN
	SELECT DISTINCT Doctor.LevelID
	FROM Doctor;
END