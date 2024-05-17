IF DB_ID('HR_DB') IS NOT NULL
    DROP DATABASE HR_DB
GO

CREATE DATABASE HR_DB
GO 



USE HR_DB;



/*   Job       */

-- Drop the existing 'Job' table
DROP TABLE IF EXISTS Job;
-- Recreate the 'Job' table based on your DBML code
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    Position VARCHAR(255),
    Title VARCHAR(255),
    Type VARCHAR(50),
    Medium VARCHAR(50),
    NumberOfPositions INT
);




/*       Job Openings      */

-- Drop the existing 'JobOpenings' table
DROP TABLE IF EXISTS JobOpenings;
-- Recreate the 'JobOpenings' table based on your DBML code
CREATE TABLE JobOpenings (
    OpeningID INT PRIMARY KEY,
    JobID INT,
    NumberOfPositions INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);



/*      Candidates      */



-- Drop the existing 'Candidates' table
DROP TABLE IF EXISTS Candidates;
-- Recreate the 'Candidates' table based on your DBML code
CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    ShortProfile TEXT
);







/*      Documents       */

-- Drop the existing 'Documents' table
DROP TABLE IF EXISTS Documents;
-- Recreate the 'Documents' table based on your DBML code
CREATE TABLE Documents (
    DocumentID INT PRIMARY KEY,
    CandidateID INT,
    CV VARCHAR(255),
    ReferenceLetter VARCHAR(255),
    CoverLetter VARCHAR(255),
    OtherDocuments TEXT,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);




/*      Applications       */


-- Drop the existing 'Applications' table
DROP TABLE IF EXISTS Applications;
-- Recreate the 'Applications' table based on your DBML code
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT,
    OpeningID INT,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (OpeningID) REFERENCES JobOpenings(OpeningID)
);



/*      Interviews       */


-- Drop the existing 'Interviewers' table
DROP TABLE IF EXISTS Interviewers;
-- Recreate the 'Interviewers' table based on your DBML code
CREATE TABLE Interviewers (
    InterviewerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Department VARCHAR(100),
    Title VARCHAR(100)
);





/*      Interviews       */

-- Drop the existing 'Interviews' table
DROP TABLE IF EXISTS Interviews;
-- Recreate the 'Interviews' table based on your DBML code
CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT,
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    InterviewerID INT,
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers(InterviewerID)
);


/*      Test       */



-- Drop the existing 'Tests' table
DROP TABLE IF EXISTS Tests;
-- Recreate the 'Tests' table based on your DBML code
CREATE TABLE Tests (
    TestID INT PRIMARY KEY,
    ApplicationID INT,
    Type VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    Answers TEXT,
    Grade DECIMAL(5,2),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);




/*     Background Checks        */

-- Drop the existing 'BackgroundChecks' table
DROP TABLE IF EXISTS BackgroundChecks;
-- Recreate the 'BackgroundChecks' table based on your DBML code
CREATE TABLE BackgroundChecks (
    CheckID INT PRIMARY KEY,
    CandidateID INT,
    CriminalBackground VARCHAR(255),
    EmploymentHistory VARCHAR(255),
    Status VARCHAR(50),
    CheckDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);


/*     Drug Tests        */


-- Drop the existing 'DrugTests' table
DROP TABLE IF EXISTS DrugTests;
-- Recreate the 'DrugTests' table based on your DBML code
CREATE TABLE DrugTests (
    TestID INT PRIMARY KEY,
    CandidateID INT,
    TestType VARCHAR(50),
    TestDate DATE,
    Results VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);




/*      Evaluation       */

-- Drop the existing 'Evaluations' table
DROP TABLE IF EXISTS Evaluations;
-- Recreate the 'Evaluations' table based on your DBML code
CREATE TABLE Evaluations (
    EvaluationID INT PRIMARY KEY,
    ApplicationID INT,
    EvaluationNotes TEXT,
    Result VARCHAR(50),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);



/*    Reimbursements         */


-- Drop the existing 'Reimbursements' table
DROP TABLE IF EXISTS Reimbursements;
-- Recreate the 'Reimbursements' table based on your DBML code
CREATE TABLE Reimbursements (
    ReimbursementID INT PRIMARY KEY,
    ApplicationID INT,
    RequestDate DATE,
    Processed BIT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);





/*     Onboarding        */
-- Drop the existing 'Onboarding' table
DROP TABLE IF EXISTS Onboarding;
-- Recreate the 'Onboarding' table based on your DBML code
CREATE TABLE Onboarding (
    OnboardingID INT PRIMARY KEY,
    CandidateID INT,
    JobID INT,
    StartDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);




/*      StatusFlow       */

-- Drop the existing 'StatusFlow' table
DROP TABLE IF EXISTS StatusFlow;
-- Recreate the 'StatusFlow' table based on your DBML code
CREATE TABLE StatusFlow (
    id INT PRIMARY KEY,
    candidate_id INT,
    status VARCHAR(255),
    timestamp DATETIME,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(CandidateID)
);




/*      JobCategory       */


-- Drop the existing 'JobCategory' table
DROP TABLE IF EXISTS JobCategory;
-- Recreate the 'JobCategory' table based on your DBML code
CREATE TABLE JobCategory (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);


/*      JobCategoryJob      */

-- Drop the existing 'JobCategoryJob' table
DROP TABLE IF EXISTS JobCategoryJob;
-- Recreate the 'JobCategoryJob' table based on your DBML code
CREATE TABLE JobCategoryJob (
    job_category_id INT,
    job_id INT,
    FOREIGN KEY (job_category_id) REFERENCES JobCategory(id),
    FOREIGN KEY (job_id) REFERENCES Job(JobID)
);

/*    JobPlatform         */

-- Drop the existing 'JobPlatform' table
DROP TABLE IF EXISTS JobPlatform;
-- Recreate the 'JobPlatform' table based on your DBML code
CREATE TABLE JobPlatform (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);



/*       JobPlatformJob      */
-- Drop the existing 'JobPlatformJob' table
DROP TABLE IF EXISTS JobPlatformJob;
-- Recreate the 'JobPlatformJob' table based on your DBML code
CREATE TABLE JobPlatformJob (
    job_platform_id INT,
    job_id INT,
    FOREIGN KEY (job_platform_id) REFERENCES JobPlatform(id),
    FOREIGN KEY (job_id) REFERENCES Job(JobID)
);




/*    JobReview         */

-- Drop the existing 'JobReview' table
DROP TABLE IF EXISTS JobReview;
-- Recreate the 'JobReview' table based on your DBML code
CREATE TABLE JobReview (
    id INT PRIMARY KEY,
    candidate_id INT,
    interviewer_id INT,
    review_text VARCHAR(255),
    rating INT,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (interviewer_id) REFERENCES Interviewers(InterviewerID)
);









/*      Complaint       */

-- Drop the existing 'Complaint' table
DROP TABLE IF EXISTS Complaint;
-- Recreate the 'Complaint' table based on your DBML code
CREATE TABLE Complaint (
    id INT PRIMARY KEY,
    candidate_id INT,
    description VARCHAR(255),
    status VARCHAR(255),
    resolution VARCHAR(255),
    FOREIGN KEY (candidate_id) REFERENCES Candidates(CandidateID)
);


