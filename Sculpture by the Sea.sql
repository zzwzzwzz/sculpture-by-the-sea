-- This database was inspired by one of Sydney's most popular events
-- Sculpture by the Sea, held in 1997, which is a free exhibition 
-- with over 100 sculptures by artists from around the world. 
-- Most of the data in the project are not real, they are self-generated.
-- 
-- Official Website: https://sculpturebythesea.com
-- 
-- There're 6 main tables in the database which are Sculpture, Artist, Award, Material, Volunteer, Shift.
-- And there're three association tables between three many to many relationships,
-- which are SculptureMaterial, SculptureArtist, ShiftVolunteer.
-- 
-- The relationship between Sculpture and Material, Shift and Volunteer, Sculpture and Artist are many to many.
-- One sculpture can use many materials, and one material can be used by many sculptures.
-- One shift with specific ShiftID can be matched with many volunteers, and one volunteer can have many shifts.
-- One sculpture can be designed by many artists, and one artist can design many sculptures.


DROP TABLE IF EXISTS Sculpture CASCADE;
DROP TABLE IF EXISTS Material CASCADE;
DROP TABLE IF EXISTS Award CASCADE;
DROP TABLE IF EXISTS Shift CASCADE;
DROP TABLE IF EXISTS Volunteer CASCADE;
DROP TABLE IF EXISTS Artist CASCADE;
DROP TABLE IF EXISTS ShiftVolunteer CASCADE;
DROP TABLE IF EXISTS SculptureMaterial CASCADE;
DROP TABLE IF EXISTS SculptureArtist CASCADE;

DROP VIEW IF EXISTS SculptureDetailsView CASCADE;
DROP VIEW IF EXISTS ArtistAwardsView CASCADE;
DROP VIEW IF EXISTS MaterialSculpturesView CASCADE;
DROP VIEW IF EXISTS SculptureArtistsView CASCADE;


CREATE TABLE Sculpture (
    SculptureID INTEGER NOT NULL,
    SculptureName VARCHAR(255) NOT NULL,
    Height DECIMAL,
    Width DECIMAL,
    Depth DECIMAL,

    CONSTRAINT sculpturePK PRIMARY KEY (SculptureID),
    CONSTRAINT sculpture_height CHECK (Height >= 0),
    CONSTRAINT sculpture_width CHECK (Width >= 0),
    CONSTRAINT sculpture_depth CHECK (Depth >= 0),
    CONSTRAINT sculpture_dimensions CHECK (Height + Width + Depth <= 1500.0)
);

INSERT INTO Sculpture (SculptureID, SculptureName, Height, Width, Depth)
VALUES 
    (1, 'HEADS IT IS', 380, 150, 150),
    (2, 'WIND ROSE', 250, 160, 160),
    (3, 'TRIP HAZARD', 50, 330, 470),
    (4, 'THE DOUBTING COLUMN', 400, 25, 25),
    (5, 'JUST A DROP IN THE OCEAN', 300, 165, 165),
    (6, 'TIDAL BODY', 220, 67, 80),
    (7, 'THE WATER MUSIC', 70, 115, 90),
    (8, 'FLIGHT', 180, 127, 77),
    (9, 'HOTBED TWILIGHT', 20, 26, 18),
    (10, 'DEEP SEA BLOOM', 15, 60, 60),
    (11, 'BUNKER DOWN', 0, 0, 0),
    (12, 'BONDI SIRENS', 250, 150, 150),
    (13, 'A PIECE OF GREECE', 300, 300, 0.3),
    (14, 'THE SANCTUARY OF DISTANCE', 70, 90, 5),
    (15, 'MORNING', 60, 60, 60),
    (16, 'CONTINUUM', 180, 60, 60),
    (17, 'WIND STONE', 200, 80, 50),
    (18, 'AFTERNOON', 60, 60, 60),
    (19, 'EVENING', 60, 60, 60),
    (20, 'AWAKENING OF PHYSICAL RECOGNITION', 50, 75, 200),
    (21, 'PIVOT', 270, 34, 34),
    (22, 'WAKE', 159, 293, 116),
    (23, 'YESTERDAY', 60, 60, 60),
    (24, 'TOMORROW', 60, 60, 60),
    (25, 'BENOIT', 310, 120, 120),
    (28, 'EARLY LIGHT', 365, 718, 250),
    (36, 'FRAGMENTS OF CONTINUITY', 50, 200, 50),
    (38, 'DOUBLEGEES', 86, 123, 78),
    (41, 'LOVE AUS', 170, 210, 110),
    (77, 'COLOSSUS HOLDS UP THE WORLD', 280, 75, 85),
    (82, 'THE EARTH IS FLAT', 130, 100, 46),
    (83, 'TRAP FOR DREAMS', 300, 240, 350),
    (89, 'SOCIAL DISTANCE 2020', 260, 240, 158),
    (92, 'GACHE', 140, 190, 80),
    (97, 'HALF THE TIME', 550, 240, 140),
    (98, 'THE SOUND OF CLOUDS', 8, 650, 60),
    (99, 'HEMISPHERIC', 101, 750, 75);




CREATE TABLE Artist (
    ArtistID VARCHAR(4) NOT NULL,
    ArtistName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    BirthYear INTEGER,
    Country VARCHAR(50),

    CONSTRAINT artistPK PRIMARY KEY (ArtistID),
    CONSTRAINT artist_birth_year CHECK (BirthYear >= 1900 AND BirthYear <= 2005),
    CONSTRAINT artist_gender CHECK (Gender IN ('Male', 'Female'))
);

INSERT INTO Artist (ArtistID, ArtistName, Gender, BirthYear, Country)
VALUES 
    ('A01', 'Paul Caporn', 'Male', 1963, 'Australia'),
    ('A02', 'Zolotar', 'Male', 1977, 'Ukraine'),
    ('A03', 'Paul Hay', 'Male', 1982, 'Australia'),
    ('A04', 'Isabela Lleo Castells', 'Female', 1991, 'Spain'),
    ('A05', 'Marina Debris', 'Female', 1970, 'USA'),
    ('A06', 'April Pine', 'Female', 1995, 'Australia'),
    ('A07', 'Takeshi Tanabe', 'Male', 1960, 'Japan'),
    ('A08', 'Gavin Younge', 'Male', 1975, 'South Africa'),
    ('A09', 'Sivaan Lansdowne Walker', 'Female', 1988, 'Australia'),
    ('A10', 'Danni Bryant', 'Female', 1993, 'Australia'),
    ('A11', 'Sally Kidall', 'Female', 1978, 'England'),
    ('A12', 'Charlie Trivers', 'Male', 1968, 'Australia'),
    ('A13', 'Leda Alexopoulou', 'Female', 1980, 'Greece'),
    ('A14', 'Richard Tipping', 'Male', 1959, 'Australia'),
    ('A15', 'Zelda Chen', 'Female', 1995, 'China'),
    ('A16', 'Naja Utzon Popov', 'Female', 1971, 'Denmark'),
    ('A17', 'Koichi Ishino', 'Male', 1965, 'Japan'),
    ('A18', 'Zizi Zhao', 'Female', 1999, 'China'),
    ('A19', 'Akshana Wang', 'Female', 1996, 'China'),
    ('A20', 'Watara Hamasaka', 'Male', 1986, 'Japan'),
    ('A21', 'Donna Marcus', 'Female', 1979, 'Australia'),
    ('A22', 'Orest Keywan', 'Male', 1966, 'Australia'),
    ('A23', 'Zeno Huang', 'Male', 1996, 'China'),
    ('A24', 'Zoe Li', 'Female', 1997, 'China'),
    ('A25', 'Bruno Catalano', 'Male', 1960, 'France'),
    ('A26', 'Morgan Jones', 'Male', 1973, 'New Zealand'),
    ('A27', 'Christine Madies', 'Female', 1982, 'France'),
    ('A28', 'Stuart Ian Frost', 'Male', 1971, 'Norway'),
    ('A29', 'Akiho Tata', 'Female', 1985, 'Japan'),
    ('A30', 'Egor Zigura', 'Male', 1970, 'Ukraine'),
    ('A31', 'Ling Gang Mao', 'Male', 1981, 'China'),
    ('A32', 'Leonardo Cumbo', 'Male', 1987, 'Italy'),
    ('A33', 'Barbara Licha', 'Female', 1972, 'Poland'),
    ('A34', 'Jina Lee', 'Female', 1986, 'South Korea'),
    ('A35', 'Robert Barnstone', 'Male', 1975, 'USA'),
    ('A36', 'Heinz Schmid', 'Male', 1958, 'Switzerland'),
    ('A37', 'Shaumyika Sharma', 'Female', 1984, 'India');




CREATE TABLE Material (
    MaterialID VARCHAR(4) NOT NULL,
    MaterialName VARCHAR(255),

    CONSTRAINT MaterialPK PRIMARY KEY (MaterialID)
);

INSERT INTO Material (MaterialID, MaterialName)
VALUES
    ('M01', 'Aluminum'),
    ('M02', 'Basalt'),
    ('M03', 'Brass'),
    ('M04', 'Bronze'),
    ('M05', 'Concrete'),
    ('M06', 'Dust'),
    ('M07', 'Glass'),
    ('M08', 'Granite'),
    ('M09', 'Ink'),
    ('M10', 'Marble'),
    ('M11', 'Paint'),
    ('M12', 'Plywood'),
    ('M13', 'Polyethylene'),
    ('M14', 'Porcelain'),
    ('M15', 'Sand'),
    ('M16', 'Steel'),
    ('M17', 'Timber'),
    ('M18', 'Wire'),
    ('M19', 'Wood');




CREATE TABLE Award (
    AwardID serial PRIMARY KEY,
    AwardName VARCHAR(100) NOT NULL,
    Year INTEGER NOT NULL,
    ArtistID VARCHAR(4) NOT NULL,

    CONSTRAINT award_year CHECK (Year >= 1950 AND Year <= EXTRACT(YEAR FROM NOW())),
    CONSTRAINT award_unique_artist_year UNIQUE (ArtistID, Year),
    CONSTRAINT award_artist_FK FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE CASCADE
);

INSERT INTO Award (AwardName, Year, ArtistID)
VALUES 
    ('Sculpture Master', 2010, 'A01'),
    ('Artistic Innovation Award', 2012, 'A02'),
    ('Best Design in Sculpture', 2018, 'A04'),
    ('Contemporary Art Prize', 2013, 'A05'),
    ('Sculptor of the Year', 2008, 'A07'),
    ('Creative Design Award', 2015, 'A08'),
    ('Innovative Sculpture Award', 2014, 'A10'),
    ('Art Excellence', 2006, 'A01'),
    ('Best Sculpture Artist', 2005, 'A13'),
    ('Modern Art Design Prize', 2019, 'A14'),
    ('Sculpture Master', 2017, 'A17'),
    ('Art Design Innovation Award', 2011, 'A18'),
    ('Outstanding Sculptor', 2012, 'A19'),
    ('Abstract Art Prize', 2009, 'A20'),
    ('Design Excellence', 2016, 'A21'),
    ('Sculpture of the Year', 2007, 'A22'),
    ('Innovative Art Design', 2015, 'A23');




CREATE TABLE Volunteer (
    VolunteerID VARCHAR(4) NOT NULL,
    VolunteerName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    BirthYear INTEGER,
    PhoneNo VARCHAR(15),
    Occupation VARCHAR(255),
    Role VARCHAR(50),
    TeamLeaderID VARCHAR(5) NOT NULL,

    CONSTRAINT volunteerPK PRIMARY KEY (VolunteerID),
    CONSTRAINT volunteer_birth_year CHECK (BirthYear >= 1900 AND BirthYear <= 2005),
    CONSTRAINT volunteer_gender CHECK (Gender IN ('Male', 'Female')),
    CONSTRAINT volunteer_phone_format CHECK (PhoneNo ~ '^\d{10}$'),
    CONSTRAINT volunteer_role CHECK (Role IN ('Volunteer', 'Team Leader'))
);

INSERT INTO Volunteer (VolunteerID, VolunteerName, Gender, BirthYear, PhoneNo, Occupation, Role, TeamLeaderID)
VALUES
    ('V01', 'Tom', 'Male', 1985, '1234567890', 'Engineer', 'Team Leader', 'V01'),
    ('V02', 'Mary', 'Female', 1990, '9876543210', 'Teacher', 'Volunteer', 'V01'),
    ('V03', 'Henry', 'Male', 1999, '9890873210', 'Student', 'Volunteer', 'V01'),
    ('V04', 'John', 'Male', 1980, '1231231234', 'Doctor', 'Volunteer', 'V01'),
    ('V05', 'Lisa', 'Female', 1975, '5558889999', 'Nurse', 'Volunteer', 'V01'),
    ('V06', 'Alex', 'Male', 1986, '1231113333', 'Engineer', 'Volunteer', 'V08'),
    ('V07', 'Grace', 'Female', 1990, '9992228888', 'Teacher', 'Volunteer', 'V08'),
    ('V08', 'Frank', 'Male', 1982, '3335557777', 'Writer', 'Team Leader', 'V08'),
    ('V09', 'Olivia', 'Female', 1995, '5559991111', 'Student', 'Volunteer', 'V08'),
    ('V10', 'George', 'Male', 1991, '6667778888', 'Artist', 'Volunteer', 'V08'),
    ('V11', 'Sophia', 'Female', 1988, '1234567890', 'Nurse', 'Team Leader', 'V11'),
    ('V12', 'Leo', 'Male', 1989, '5551112222', 'Photographer', 'Volunteer', 'V11'),
    ('V13', 'Avery', 'Female', 1984, '2224446666', 'Designer', 'Volunteer', 'V11'),
    ('V14', 'Mason', 'Male', 1997, '7778889999', 'Student', 'Volunteer', 'V11'),
    ('V15', 'Chloe', 'Female', 1987, '3337770000', 'Designer', 'Team Leader', 'V15'),
    ('V16', 'Samuel', 'Male', 1980, '1112223333', 'Dentist', 'Volunteer', 'V11'),
    ('V17', 'Victoria', 'Female', 1993, '1233211234', 'Student', 'Volunteer', 'V15'),
    ('V18', 'Elijah', 'Male', 1981, '5555555555', 'Mechanic', 'Volunteer', 'V15'),
    ('V19', 'Sofia', 'Female', 1983, '7777777777', 'Lawyer', 'Volunteer', 'V15'),
    ('V20', 'Henry', 'Male', 1987, '9999999999', 'Doctor', 'Team Leader', 'V20'),
    ('V21', 'Emma', 'Female', 1989, '1231231234', 'Marketing', 'Volunteer', 'V15'),
    ('V22', 'Lucas', 'Male', 1985, '1110001111', 'Artist', 'Volunteer', 'V20'),
    ('V23', 'Scarlett', 'Female', 1992, '1239874560', 'Student', 'Volunteer', 'V20'),
    ('V24', 'William', 'Male', 1988, '7771112222', 'Student', 'Volunteer', 'V20'),
    ('V25', 'Madison', 'Female', 1986, '5558889999', 'Musician', 'Volunteer', 'V20');




CREATE TABLE Shift (
    ShiftID VARCHAR(6) NOT NULL,
    ShiftDate DATE NOT NULL,
    ShiftStartTime TIME NOT NULL,
    ShiftEndTime TIME NOT NULL,
    Hours DECIMAL NOT NULL,
    VolunteerQTY INTEGER NOT NULL,
    SculptureID INTEGER NOT NULL,

    CONSTRAINT ShiftPK PRIMARY KEY (ShiftID),
    CONSTRAINT shift_sculpture_fk FOREIGN KEY (SculptureID) REFERENCES Sculpture (SculptureID) ON DELETE CASCADE,

    CONSTRAINT shift_hours CHECK (Hours >= 0 AND Hours <= 19),
    CONSTRAINT shift_start_time CHECK (ShiftStartTime >= '05:00' AND ShiftStartTime <= '22:00'),
    CONSTRAINT shift_time CHECK (ShiftStartTime <= ShiftEndTime),
    CONSTRAINT shift_end_time CHECK (ShiftEndTime >= '05:00' AND ShiftEndTime <= '22:00'),
    CONSTRAINT shift_volunteerqty CHECK (VolunteerQTY >= 0 AND VolunteerQTY <= 10)
);

INSERT INTO Shift (ShiftID, ShiftDate, ShiftStartTime, ShiftEndTime, Hours, VolunteerQTY, SculptureID)
VALUES 
    ('S01', '2023-10-15', '09:00', '13:00', 4.0, 5, 1),
    ('S02', '2023-10-15', '11:00', '15:00', 4.0, 4, 1),
    ('S03', '2023-10-16', '09:00', '17:00', 8.0, 8, 1),
    ('S04', '2023-10-16', '13:30', '17:00', 3.5, 6, 2),
    ('S05', '2023-10-16', '15:00', '19:00', 4.0, 4, 2),
    ('S06', '2023-10-17', '08:00', '14:00', 6.0, 6, 2),
    ('S07', '2023-10-17', '12:00', '16:00', 4.0, 5, 3),
    ('S08', '2023-10-18', '09:30', '13:30', 4.0, 5, 3),
    ('S09', '2023-10-18', '14:00', '18:00', 4.0, 4, 4),
    ('S10', '2023-10-19', '11:30', '15:30', 4.0, 4, 4),
    ('S11', '2023-10-19', '14:00', '20:00', 6.0, 7, 5),
    ('S12', '2023-10-20', '10:00', '14:00', 4.0, 5, 5),
    ('S13', '2023-10-20', '13:30', '19:30', 6.0, 6, 6),
    ('S14', '2023-10-21', '08:30', '12:30', 4.0, 4, 6),
    ('S15', '2023-10-21', '11:00', '15:00', 4.0, 4, 7),
    ('S16', '2023-10-22', '14:30', '18:30', 4.0, 5, 7),
    ('S17', '2023-10-22', '15:30', '19:30', 4.0, 5, 8),
    ('S18', '2023-10-23', '09:00', '13:00', 4.0, 4, 8),
    ('S19', '2023-10-23', '10:30', '14:30', 4.0, 4, 9),
    ('S20', '2023-10-24', '11:00', '17:00', 6.0, 6, 9),
    ('S21', '2023-10-24', '13:30', '17:30', 4.0, 5, 10),
    ('S22', '2023-10-25', '08:00', '12:00', 4.0, 5, 10),
    ('S23', '2023-10-25', '09:30', '13:30', 4.0, 4, 11),
    ('S24', '2023-10-26', '12:30', '16:30', 4.0, 4, 11),
    ('S25', '2023-10-26', '14:00', '18:00', 4.0, 5, 12),
    ('S26', '2023-10-27', '10:00', '14:00', 4.0, 5, 12),
    ('S27', '2023-10-27', '11:30', '15:30', 4.0, 4, 13),
    ('S28', '2023-10-28', '15:00', '19:00', 4.0, 5, 13),
    ('S29', '2023-10-28', '14:30', '18:30', 4.0, 4, 14),
    ('S30', '2023-10-29', '08:00', '14:00', 6.0, 6, 14),
    ('S31', '2023-10-29', '09:00', '13:00', 4.0, 5, 15),
    ('S32', '2023-10-30', '14:00', '18:00', 4.0, 5, 15),
    ('S33', '2023-10-30', '13:30', '19:30', 6.0, 7, 16),
    ('S34', '2023-10-31', '11:00', '15:00', 4.0, 5, 16),
    ('S35', '2023-10-31', '12:30', '16:30', 4.0, 4, 17),
    ('S36', '2023-11-01', '08:30', '12:30', 4.0, 4, 17),
    ('S37', '2023-11-01', '10:00', '14:00', 4.0, 5, 18),
    ('S38', '2023-11-02', '13:30', '17:30', 4.0, 5, 18),
    ('S39', '2023-11-02', '11:30', '15:30', 4.0, 4, 19),
    ('S40', '2023-11-03', '15:30', '19:30', 4.0, 4, 19),
    ('S41', '2023-11-03', '14:00', '18:00', 4.0, 5, 20),
    ('S42', '2023-11-04', '12:00', '16:00', 4.0, 5, 20),
    ('S43', '2023-11-04', '09:30', '13:30', 4.0, 4, 21),
    ('S44', '2023-11-05', '11:00', '17:00', 6.0, 6, 21),
    ('S45', '2023-11-05', '10:30', '14:30', 4.0, 5, 22),
    ('S46', '2023-11-06', '14:30', '18:30', 4.0, 5, 22),
    ('S47', '2023-11-06', '15:00', '19:00', 4.0, 4, 23),
    ('S48', '2023-11-06', '13:00', '17:00', 4.0, 4, 23),
    ('S49', '2023-11-06', '08:00', '12:00', 4.0, 5, 24),
    ('S50', '2023-11-06', '09:00', '13:00', 4.0, 5, 24),
    ('S51', '2023-11-07', '09:30', '13:30', 4.5, 5, 25),
    ('S52', '2023-11-07', '14:00', '18:00', 4.5, 5, 25),
    ('S53', '2023-11-08', '08:30', '12:30', 4.5, 4, 28),
    ('S54', '2023-11-08', '10:00', '14:00', 4.5, 5, 28),
    ('S55', '2023-11-09', '15:30', '19:30', 4.5, 4, 36),
    ('S56', '2023-11-09', '14:00', '18:00', 4.5, 5, 36),
    ('S57', '2023-11-10', '13:30', '17:30', 4.5, 4, 83),
    ('S58', '2023-11-10', '12:00', '16:00', 4.5, 5, 89),
    ('S59', '2023-11-11', '08:00', '12:00', 4.5, 4, 41),
    ('S60', '2023-11-11', '09:30', '13:30', 4.5, 5, 41),
    ('S61', '2023-11-12', '13:00', '17:00', 4.5, 4, 77),
    ('S62', '2023-11-12', '11:30', '15:30', 4.5, 5, 77),
    ('S63', '2023-11-13', '14:30', '18:30', 4.5, 4, 82),
    ('S64', '2023-11-13', '15:00', '19:00', 4.5, 5, 82),
    ('S65', '2023-11-14', '10:00', '14:00', 4.5, 4, 83),
    ('S66', '2023-11-14', '12:30', '16:30', 4.5, 5, 83),
    ('S67', '2023-11-15', '11:00', '15:00', 4.5, 4, 89),
    ('S68', '2023-11-15', '09:00', '13:00', 4.5, 5, 89),
    ('S69', '2023-11-16', '14:30', '18:30', 5.0, 4, 92),
    ('S70', '2023-11-16', '13:00', '17:00', 5.0, 5, 92),
    ('S71', '2023-11-17', '08:30', '12:30', 5.0, 4, 97),
    ('S72', '2023-11-17', '09:30', '13:30', 5.0, 5, 97),
    ('S73', '2023-11-18', '11:30', '15:30', 5.0, 4, 98),
    ('S74', '2023-11-18', '12:00', '16:00', 5.0, 5, 98);




CREATE TABLE SculptureArtist (
    SculptureID INTEGER NOT NULL,
    ArtistID VARCHAR(4) NOT NULL,

    FOREIGN KEY (SculptureID) REFERENCES Sculpture (SculptureID) ON DELETE RESTRICT,
    FOREIGN KEY (ArtistID) REFERENCES Artist (ArtistID) ON DELETE RESTRICT,
    UNIQUE (SculptureID, ArtistID)
);

INSERT INTO SculptureArtist (SculptureID, ArtistID)
VALUES
    (1, 'A01'),
    (1, 'A15'),
    (2, 'A02'),
    (3, 'A03'),
    (3, 'A18'),
    (1, 'A04'),
    (2, 'A05'),
    (3, 'A06'),
    (4, 'A07'),
    (4, 'A08'),
    (5, 'A01'),
    (5, 'A09'),
    (6, 'A10'),
    (6, 'A11'),
    (7, 'A12'),
    (8, 'A13'),
    (9, 'A14'),
    (10, 'A15'),
    (10, 'A16'),
    (11, 'A01'),
    (12, 'A02'),
    (12, 'A17'),
    (13, 'A18'),
    (13, 'A03'),
    (14, 'A01'),
    (14, 'A04'),
    (15, 'A19'),
    (16, 'A05'),
    (17, 'A20'),
    (17, 'A06'),
    (18, 'A07'),
    (19, 'A08'),
    (19, 'A21'),
    (20, 'A09'),
    (21, 'A10'),
    (21, 'A22'),
    (22, 'A11'),
    (23, 'A01'),
    (24, 'A02'),
    (25, 'A03'),
    (25, 'A23'),
    (28, 'A24'),
    (28, 'A04'),
    (36, 'A25'),
    (36, 'A05'),
    (38, 'A01'),
    (38, 'A06'),
    (41, 'A26'),
    (41, 'A27'),
    (77, 'A07'),
    (82, 'A28'),
    (83, 'A29'),
    (83, 'A08'),
    (89, 'A01'),
    (92, 'A09'),
    (92, 'A30'),
    (97, 'A31'),
    (97, 'A10'),
    (98, 'A32'),
    (98, 'A33');



CREATE TABLE SculptureMaterial (
    SculptureID INTEGER NOT NULL,
    MaterialID VARCHAR(4) NOT NULL,

    FOREIGN KEY (SculptureID) REFERENCES Sculpture (SculptureID) ON DELETE RESTRICT,
    FOREIGN KEY (MaterialID) REFERENCES Material (MaterialID) ON DELETE RESTRICT,
    UNIQUE (MaterialID, SculptureID)
);

INSERT INTO SculptureMaterial (MaterialID, SculptureID)
VALUES
    ('M01', 1),
    ('M01', 9),
    ('M01', 14),
    ('M01', 21),
    ('M01', 98),
    ('M02', 7),
    ('M03', 82),
    ('M04', 4),
    ('M04', 8),
    ('M04', 25),
    ('M04', 77),
    ('M04', 92),
    ('M05', 15),
    ('M05', 16),
    ('M05', 18),
    ('M05', 19),
    ('M05', 99),
    ('M06', 9),
    ('M06', 19),
    ('M07', 10),
    ('M07', 15),
    ('M07', 28),
    ('M08', 7),
    ('M08', 41),
    ('M08', 92),
    ('M09', 13),
    ('M09', 14),
    ('M10', 12),
    ('M10', 20),
    ('M10', 36),
    ('M11', 11),
    ('M11', 23),
    ('M11', 24),
    ('M11', 41),
    ('M12', 11),
    ('M13', 1),
    ('M14', 10),
    ('M14', 11),
    ('M15', 9),
    ('M16', 2),
    ('M16', 4),
    ('M16', 6),
    ('M16', 17),
    ('M16', 21),
    ('M16', 22),
    ('M16', 28),
    ('M16', 41),
    ('M16', 83),
    ('M16', 89),
    ('M16', 97),
    ('M16', 98),
    ('M17', 1),
    ('M17', 11),
    ('M17', 23),
    ('M18', 3),
    ('M18', 5),
    ('M18', 6),
    ('M18', 12),
    ('M18', 89),
    ('M19', 3),
    ('M19', 5),
    ('M19', 38);



CREATE TABLE ShiftVolunteer (
    ShiftID VARCHAR(6) NOT NULL,
    VolunteerID VARCHAR(4) NOT NULL,
    
    FOREIGN KEY (ShiftID) REFERENCES Shift (ShiftID) ON DELETE CASCADE,
    FOREIGN KEY (VolunteerID) REFERENCES Volunteer (VolunteerID) ON DELETE CASCADE,
    UNIQUE (ShiftID, VolunteerID)
);

INSERT INTO ShiftVolunteer (ShiftID, VolunteerID)
VALUES
    ('S01', 'V01'),
    ('S01', 'V02'),
    ('S01', 'V03'),
    ('S02', 'V01'),
    ('S02', 'V04'),
    ('S01', 'V07'),
    ('S03', 'V01'),
    ('S03', 'V05'),
    ('S03', 'V06'),
    ('S04', 'V02'),
    ('S04', 'V07'),
    ('S04', 'V08'),
    ('S05', 'V03'),
    ('S05', 'V09'),
    ('S05', 'V10'),
    ('S06', 'V04'),
    ('S06', 'V11'),
    ('S06', 'V12'),
    ('S07', 'V05'),
    ('S07', 'V13'),
    ('S07', 'V14'),
    ('S08', 'V06'),
    ('S08', 'V15'),
    ('S08', 'V16'),
    ('S09', 'V07'),
    ('S09', 'V17'),
    ('S09', 'V18'),
    ('S10', 'V08'),
    ('S10', 'V19'),
    ('S10', 'V20'),
    ('S11', 'V09'),
    ('S11', 'V21'),
    ('S11', 'V22'),
    ('S12', 'V10'),
    ('S12', 'V23'),
    ('S12', 'V24'),
    ('S13', 'V11'),
    ('S13', 'V25'),
    ('S14', 'V12'),
    ('S14', 'V13'),
    ('S14', 'V14'),
    ('S15', 'V15'),
    ('S15', 'V16'),
    ('S15', 'V17'),
    ('S16', 'V18'),
    ('S16', 'V19'),
    ('S16', 'V20'),
    ('S17', 'V21'),
    ('S17', 'V22'),
    ('S17', 'V23'),
    ('S18', 'V24'),
    ('S18', 'V25'),
    ('S18', 'V01'),
    ('S19', 'V02'),
    ('S19', 'V03'),
    ('S19', 'V04'),
    ('S20', 'V05'),
    ('S20', 'V06'),
    ('S20', 'V07'),
    ('S21', 'V08'),
    ('S21', 'V09'),
    ('S21', 'V10'),
    ('S22', 'V11'),
    ('S22', 'V12'),
    ('S22', 'V13'),
    ('S23', 'V14'),
    ('S23', 'V15'),
    ('S23', 'V16'),
    ('S24', 'V17'),
    ('S24', 'V18'),
    ('S24', 'V19'),
    ('S25', 'V20'),
    ('S25', 'V21'),
    ('S25', 'V22'),
    ('S26', 'V23'),
    ('S26', 'V24'),
    ('S26', 'V25'),
    ('S27', 'V01'),
    ('S27', 'V02'),
    ('S27', 'V03'),
    ('S28', 'V04'),
    ('S28', 'V05'),
    ('S28', 'V06'),
    ('S29', 'V07'),
    ('S29', 'V08'),
    ('S29', 'V09'),
    ('S30', 'V10'),
    ('S30', 'V11'),
    ('S30', 'V12'),
    ('S31', 'V13'),
    ('S31', 'V14'),
    ('S31', 'V15'),
    ('S32', 'V16'),
    ('S32', 'V17'),
    ('S32', 'V18'),
    ('S33', 'V19'),
    ('S33', 'V20'),
    ('S33', 'V21'),
    ('S34', 'V22'),
    ('S34', 'V23'),
    ('S34', 'V24'),
    ('S35', 'V25'),
    ('S36', 'V07'),
    ('S36', 'V15'),
    ('S36', 'V22'),
    ('S37', 'V03'),
    ('S37', 'V06'),
    ('S37', 'V13'),
    ('S38', 'V02'),
    ('S38', 'V12'),
    ('S38', 'V19'),
    ('S39', 'V14'),
    ('S39', 'V20'),
    ('S39', 'V25'),
    ('S40', 'V08'),
    ('S40', 'V11'),
    ('S40', 'V18'),
    ('S41', 'V05'),
    ('S41', 'V21'),
    ('S41', 'V09'),
    ('S42', 'V24'),
    ('S42', 'V04'),
    ('S42', 'V16'),
    ('S43', 'V17'),
    ('S43', 'V23'),
    ('S43', 'V10'),
    ('S44', 'V01'),
    ('S44', 'V06'),
    ('S44', 'V25'),
    ('S45', 'V15'),
    ('S45', 'V12'),
    ('S45', 'V07'),
    ('S46', 'V18'),
    ('S46', 'V08'),
    ('S46', 'V14'),
    ('S47', 'V02'),
    ('S47', 'V20'),
    ('S47', 'V03'),
    ('S48', 'V19'),
    ('S48', 'V05'),
    ('S48', 'V21'),
    ('S49', 'V09'),
    ('S49', 'V17'),
    ('S49', 'V13'),
    ('S50', 'V11'),
    ('S50', 'V16'),
    ('S50', 'V23'),
    ('S51', 'V25'),
    ('S51', 'V06'),
    ('S51', 'V19'),
    ('S52', 'V11'),
    ('S52', 'V14'),
    ('S52', 'V02'),
    ('S53', 'V12'),
    ('S53', 'V07'),
    ('S53', 'V08'),
    ('S54', 'V21'),
    ('S54', 'V17'),
    ('S54', 'V04'),
    ('S55', 'V03'),
    ('S55', 'V18'),
    ('S55', 'V16'),
    ('S56', 'V15'),
    ('S56', 'V24'),
    ('S56', 'V13'),
    ('S57', 'V23'),
    ('S57', 'V10'),
    ('S57', 'V09'),
    ('S58', 'V01'),
    ('S58', 'V22'),
    ('S58', 'V05'),
    ('S59', 'V25'),
    ('S59', 'V06'),
    ('S59', 'V19'),
    ('S60', 'V11'),
    ('S60', 'V14'),
    ('S60', 'V02'),
    ('S61', 'V12'),
    ('S61', 'V07'),
    ('S61', 'V08'),
    ('S62', 'V21'),
    ('S62', 'V17'),
    ('S62', 'V04'),
    ('S63', 'V03'),
    ('S63', 'V18'),
    ('S63', 'V16'),
    ('S64', 'V15'),
    ('S64', 'V24'),
    ('S64', 'V13'),
    ('S65', 'V23'),
    ('S65', 'V10'),
    ('S65', 'V09'),
    ('S66', 'V01'),
    ('S66', 'V22'),
    ('S66', 'V05'),
    ('S67', 'V25'),
    ('S67', 'V06'),
    ('S67', 'V19'),
    ('S68', 'V11'),
    ('S68', 'V14'),
    ('S68', 'V02'),
    ('S69', 'V12'),
    ('S69', 'V07'),
    ('S69', 'V08'),
    ('S70', 'V21'),
    ('S70', 'V17'),
    ('S70', 'V04'),
    ('S71', 'V03'),
    ('S71', 'V18'),
    ('S71', 'V16'),
    ('S72', 'V15'),
    ('S72', 'V24'),
    ('S72', 'V13'),
    ('S73', 'V23'),
    ('S73', 'V10'),
    ('S73', 'V09'),
    ('S74', 'V01'),
    ('S74', 'V22'),
    ('S74', 'V05');



CREATE OR REPLACE VIEW SculptureDetailsView AS
SELECT
    S.SculptureID,
    S.SculptureName,
    S.Height,
    S.Width,
    S.Depth,
    string_agg(M.MaterialName, ', ') AS Materials
FROM Sculpture S
LEFT JOIN SculptureMaterial SM ON S.SculptureID = SM.SculptureID
LEFT JOIN Material M ON SM.MaterialID = M.MaterialID
GROUP BY S.SculptureID, S.SculptureName, S.Height, S.Width, S.Depth
ORDER BY S.SculptureID;

CREATE OR REPLACE VIEW ArtistAwardsView AS
SELECT
    Artist.ArtistID,
    Artist.ArtistName,
    Artist.Gender,
    COUNT(Award.ArtistID) AS AwardsWon
FROM Artist
LEFT JOIN Award ON Artist.ArtistID = Award.ArtistID
GROUP BY Artist.ArtistID, Artist.ArtistName, Artist.Gender
ORDER BY Artist.ArtistID;

CREATE OR REPLACE VIEW SculptureArtistsView AS
SELECT
    S.SculptureID,
    S.SculptureName,
    string_agg(Ar.ArtistName, ', ') AS Artists
FROM Sculpture S
JOIN SculptureArtist SA ON S.SculptureID = SA.SculptureID
JOIN Artist Ar ON SA.ArtistID = Ar.ArtistID
GROUP BY S.SculptureID, S.SculptureName
ORDER BY S.SculptureID;

