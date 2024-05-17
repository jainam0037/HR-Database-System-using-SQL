
USE HR_DB;



/*					Views				 */

/*				1)	Job Openings with Available Positions:
Question: Identify job openings that still have available positions and determine the number of positions available for each opening.

*/

SELECT j.Title, j.NumberOfPositions - COALESCE(COUNT(o.OpeningID), 0) AS AvailablePositions
FROM Job AS j
LEFT JOIN JobOpenings AS o ON j.JobID = o.JobID
GROUP BY j.Title, j.NumberOfPositions;







/*				2)	Candidates by Job Category:			

Question: Determine the distribution of candidates across different job categories and 
		  identify which job category is the most popular among candidates.
*/

SELECT jc.name AS JobCategory, COUNT(*) AS CandidateCount
FROM Candidates AS c
JOIN JobCategoryJob AS jcj ON c.CandidateID = jcj.job_category_id
JOIN JobCategory AS jc ON jcj.job_category_id = jc.id
GROUP BY jc.name;












/*			3) 		Interviews by Interviewer:
Question: Track the performance of interviewers by counting the number of interviews each one has conducted, 
		  and identify the top interviewers based on their interview count.
*/


SELECT i.Name AS Interviewer, COUNT(*) AS InterviewCount
FROM Interviews AS iv
JOIN Interviewers AS i ON iv.InterviewerID = i.InterviewerID
GROUP BY i.Name
ORDER BY COUNT(*) DESC;





/*			4)		Evaluation Results by Interview Type:
Question: Assess the evaluation results (pass, fail, pending) for different interview types (onsite, online) 
		  and identify which interview type has the highest pass rate.

*/

SELECT e.Result, 
       COUNT(CASE WHEN e.Result = 'Pass' THEN 1 END) AS PassCount,
       COUNT(CASE WHEN e.Result = 'Fail' THEN 1 END) AS FailCount,
       COUNT(CASE WHEN e.Result = 'Pending' THEN 1 END) AS PendingCount
FROM Evaluations AS e
JOIN Applications AS a ON e.ApplicationID = a.ApplicationID
GROUP BY e.Result;













/*			5)	Background Check Status by Candidate:
	Question: Monitor the background check status (clear, pending) for each candidate and 
		      determine how many candidates have pending background checks.
*/


SELECT c.Name AS CandidateName, bc.Status AS BackgroundCheckStatus
FROM Candidates AS c
JOIN BackgroundChecks AS bc ON c.CandidateID = bc.CandidateID;








/*			Stored	Procedures					 */

/*				1) Update Candidate Information
		Create a stored procedure to update the information of a candidate in the Candidates table.

*/

CREATE PROCEDURE UpdateCandidateInformation
    @CandidateID INT,
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @ShortProfile NVARCHAR(100)
AS
BEGIN
    UPDATE Candidates
    SET Name = @Name,
        Email = @Email,
        Phone = @Phone,
        ShortProfile = @ShortProfile
    WHERE CandidateID = @CandidateID;
END;

EXEC UpdateCandidateInformation 
    @CandidateID = 9,
    @Name = 'Robert',
    @Email = 'robert66@gmail.com',
    @Phone = '3159527506',
    @ShortProfile = 'Software Engineer';



	SELECT * 
	FROM Candidates






/*				UpdateInterviewDetails
	Update the details of a specific interview for a candidate.
*/


CREATE PROCEDURE UpdateInterviewDetails
    @InterviewID INT,
    @StartTime DATETIME,
    @EndTime DATETIME
AS
BEGIN
    UPDATE Interviews
    SET StartTime = @StartTime,
        EndTime = @EndTime
    WHERE InterviewID = @InterviewID;
END;


EXEC UpdateInterviewDetails
    @InterviewID = 1, 
    @StartTime = '2024-05-01 09:00:00', 
    @EndTime = '2024-05-01 10:00:00';


SELECT * 
FROM Interviews;









/*				3) RetrieveBackgroundCheckStatus			
			Retrieve the background check status for a specific candidate.
*/





CREATE PROCEDURE RetrieveBackgroundCheckStatus
    @CandidateID INT
AS
BEGIN
    SELECT CandidateID, CriminalBackground, EmploymentHistory, Status, CheckDate
    FROM BackgroundChecks
    WHERE CandidateID = @CandidateID;
END;



EXEC RetrieveBackgroundCheckStatus @CandidateID = 4;




/*				4) Update Reimbursement Status
		Update the reimbursement status of a specific application.
*/

CREATE PROCEDURE UpdateReimbursementStatus
    @ApplicationID INT,
    @Processed BIT,
    @Amount DECIMAL(10, 2)
AS
BEGIN
    UPDATE Reimbursements
    SET Processed = @Processed,
        Amount = @Amount
    WHERE ApplicationID = @ApplicationID;
END;


EXEC UpdateReimbursementStatus @ApplicationID = 1, @Processed = 1, @Amount = 250.00;

SELECT * 
FROM Reimbursements;



/*				5) GenerateMonthlyReport		
			 a monthly report summarizing various metrics such as the number of applications, 
			 interviews conducted, evaluations, and background checks for each month.
*/

CREATE PROCEDURE GenerateMonthlyReport
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT 
        MONTH(iv.StartTime) AS Month,
        YEAR(iv.StartTime) AS Year,
        COUNT(DISTINCT a.ApplicationID) AS NumberOfApplications,
        COUNT(DISTINCT iv.InterviewID) AS NumberOfInterviews,
        COUNT(DISTINCT e.EvaluationID) AS NumberOfEvaluations,
        COUNT(DISTINCT bc.CheckID) AS NumberOfBackgroundChecks
    FROM Interviews iv
    LEFT JOIN Applications a ON iv.ApplicationID = a.ApplicationID
    LEFT JOIN Evaluations e ON a.ApplicationID = e.ApplicationID
    LEFT JOIN BackgroundChecks bc ON a.CandidateID = bc.CandidateID
    WHERE MONTH(iv.StartTime) = @Month AND YEAR(iv.StartTime) = @Year
    GROUP BY MONTH(iv.StartTime), YEAR(iv.StartTime);
END

EXEC GenerateMonthlyReport @Month = 4, @Year = 2024;













/*				Functions				*/



/*				1) 		FormatPhoneNumber		
				format a phone number consistently according to a specified format.			*/
-- Create the FormatPhoneNumber function
CREATE FUNCTION FormatPhoneNumber(@PhoneNumber NVARCHAR(20))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @FormattedPhoneNumber NVARCHAR(20);  
    -- Remove any non-numeric characters from the input phone number
    SET @PhoneNumber = REPLACE(@PhoneNumber, '-', '');
    
    -- Add dashes to the phone number in the format XXX-XXX-XXXX
    SET @FormattedPhoneNumber = LEFT(@PhoneNumber, 3) + '-' + SUBSTRING(@PhoneNumber, 4, 3) + '-' + RIGHT(@PhoneNumber, 4);
    
    RETURN @FormattedPhoneNumber;
END;
GO
-- Update the phone numbers for all candidates using the FormatPhoneNumber function
UPDATE Candidates
SET Phone = dbo.FormatPhoneNumber(Phone);
-- Execute the function with a sample phone number
SELECT *
FROM Candidates;







/*					2) GenerateUsername			
				Generates a username based on the candidate's name and a random number.
*/
CREATE FUNCTION GenerateUsername
    (@FullName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Username NVARCHAR(100);

    -- Check if the full name contains a space character
    IF CHARINDEX(' ', @FullName) > 0
    BEGIN
        DECLARE @FirstName NVARCHAR(50);
        DECLARE @LastName NVARCHAR(50);

        -- Extract first name and last name from the full name
        SET @FirstName = LEFT(@FullName, CHARINDEX(' ', @FullName) - 1);
        SET @LastName = SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, LEN(@FullName) - CHARINDEX(' ', @FullName));

        -- Concatenate the first three letters of the first name and last name
        SET @Username = LEFT(@FirstName, 3) + LEFT(@LastName, 3);
    END
    ELSE
    BEGIN
        -- If the full name does not contain a space, use the entire name as the username
        SET @Username = @FullName;
    END

    RETURN @Username;
END;


SELECT Name, Email, Phone, ShortProfile, dbo.GenerateUsername(Name) AS GeneratedUsername
FROM Candidates;











/*				3) CalculateGrade
				calculates the grade based on the score obtained by a student in an exam		*/
CREATE FUNCTION CalculateGrade
    (@Score FLOAT)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Grade NVARCHAR(10);
    IF @Score >= 90
        SET @Grade = 'A';
    ELSE IF @Score >= 80
        SET @Grade = 'B';
    ELSE IF @Score >= 70
        SET @Grade = 'C';
    ELSE IF @Score >= 60
        SET @Grade = 'D';
    ELSE
        SET @Grade = 'F';
    RETURN @Grade;
END;

SELECT *, dbo.CalculateGrade(Grade) AS Grade
FROM Tests;









/*			4) GenerateEmployeeID
			generates an employee ID based on the first three letters of the first name and 
			the last three letters of the last name, along with a sequence number.
	*/
CREATE FUNCTION GenerateEmployeeID
    (@CandidateID INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @EmployeeID NVARCHAR(20);

    -- Concatenate the first three letters of the first name and last name, and a sequential number
    SELECT @EmployeeID = LEFT(c.Name, 3) + RIGHT(c.Name, 3) + CAST(ROW_NUMBER() OVER (ORDER BY e.EvaluationID) AS NVARCHAR(10))
    FROM Candidates c
    INNER JOIN Evaluations e ON c.CandidateID = e.ApplicationID
    WHERE e.Result = 'Pass' AND c.CandidateID = @CandidateID;

    RETURN @EmployeeID;
END;


SELECT c.CandidateID, c.Name AS CandidateName, dbo.GenerateEmployeeID(c.CandidateID) AS EmployeeID
FROM Candidates c
INNER JOIN Evaluations e ON c.CandidateID = e.ApplicationID
WHERE e.Result = 'Pass';





/*				5) CheckBackgroundCheckStatus	
				To check the status of a candidate's background check.
*/
CREATE FUNCTION CheckBackgroundCheckStatus
    (@CandidateID INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @Status NVARCHAR(20);

    SELECT @Status = Status
    FROM BackgroundChecks
    WHERE CandidateID = @CandidateID;

    RETURN @Status;
END;

SELECT *, dbo.CheckBackgroundCheckStatus(c.CandidateID) AS BackgroundCheckStatus
FROM Candidates AS c;







/*					Triggers				 */

/*					1) OnEvaluationInsertTrigger
				Update the candidate's status based on the evaluation result.
*/



CREATE TRIGGER OnEvaluationInsertTrigger
ON Evaluations
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ApplicationID INT;
    DECLARE @Result NVARCHAR(10);

    SELECT @ApplicationID = inserted.ApplicationID,
           @Result = inserted.Result
    FROM inserted;

    UPDATE StatusFlow
    SET status = CASE 
                    WHEN @Result = 'Pass' THEN 'Accepted'
                    WHEN @Result = 'Fail' THEN 'Rejected'
                    ELSE 'Pending'
                 END
    WHERE candidate_id = @ApplicationID;
END;









/*				2) OnInterviewInsertTrigger
				Update the status flow of the candidate based on interview scheduling.
*/


CREATE TRIGGER OnInterviewInsertTrigger
ON Interviews
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ApplicationID INT;
    DECLARE @Status NVARCHAR(50);

    SELECT @ApplicationID = inserted.ApplicationID
    FROM inserted;

    SET @Status = 'Interview Scheduled';

    INSERT INTO StatusFlow (candidate_id, status, timestamp)
    VALUES (@ApplicationID, @Status, GETDATE());
END;















/*				3) OnDrugTestInsertTrigger
				Update the candidate's status based on the result of the drug test.				*/

CREATE TRIGGER OnDrugTestInsertTrigger
ON DrugTests
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CandidateID INT;
    DECLARE @TestResult NVARCHAR(50);
    DECLARE @NewStatus NVARCHAR(50);

    SELECT @CandidateID = inserted.CandidateID,
           @TestResult = inserted.Results
    FROM inserted;

    IF @TestResult = 'Negative'
        SET @NewStatus = 'Cleared';
    ELSE
        SET @NewStatus = 'Pending Further Review';

    UPDATE StatusFlow
    SET status = @NewStatus
    WHERE candidate_id = @CandidateID;
END;





/*				4) OnBackgroundCheckInsertTrigger			
				Update the candidate's status based on the result of the background check.					*/

CREATE TRIGGER OnBackgroundCheckInsertTrigger
ON BackgroundChecks
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CandidateID INT;
    DECLARE @CheckResult NVARCHAR(50);
    DECLARE @NewStatus NVARCHAR(50);

    SELECT @CandidateID = inserted.CandidateID,
           @CheckResult = inserted.Status
    FROM inserted;

    IF @CheckResult = 'Clear'
        SET @NewStatus = 'Cleared';
    ELSE
        SET @NewStatus = 'Pending Further Review';

    UPDATE StatusFlow
    SET status = @NewStatus
    WHERE candidate_id = @CandidateID;
END;









/*				5) OnJobPlatformJobInsertTrigger
				Maintain consistency between job platforms and job listings upon insertion.							*/


CREATE TRIGGER OnJobPlatformJobInsertTrigger
ON JobPlatformJob
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @JobID INT;
    DECLARE @JobPlatformID INT;

    SELECT @JobID = inserted.job_id,
           @JobPlatformID = inserted.job_platform_id
    FROM inserted;

    IF NOT EXISTS (
        SELECT 1
        FROM Job
        WHERE JobID = @JobID
    )
    BEGIN
        DELETE FROM JobPlatformJob
        WHERE job_id = @JobID AND job_platform_id = @JobPlatformID;
        RAISERROR('Job ID does not exist. Entry in JobPlatformJob table deleted.', 16, 1);
    END;
END;













/*				Transactions					 */


/*				1) 		Hiring a Candidate: 
				To officially hire a candidate after successful completion of evaluations, interviews, and background checks.					 */
BEGIN TRANSACTION HireCandidate;

UPDATE StatusFlow
SET status = 'Hired'
WHERE candidate_id IN (
    SELECT DISTINCT C.CandidateID
    FROM Candidates C
    INNER JOIN Applications A ON C.CandidateID = A.CandidateID
    LEFT JOIN Evaluations E ON A.ApplicationID = E.ApplicationID
    LEFT JOIN Interviews I ON A.ApplicationID = I.ApplicationID
    LEFT JOIN BackgroundChecks BC ON C.CandidateID = BC.CandidateID
    WHERE E.Result = 'Pass' -- Candidate passed evaluations
    AND I.InterviewID IS NOT NULL -- Candidate has been interviewed
    AND BC.Status = 'Clear' -- Candidate's background check is clear
);

COMMIT TRANSACTION HireCandidate;

-- Displaying the details of candidates who have been hired
SELECT c.CandidateID, c.Name, c.Email, c.Phone, StatusFlow.status
FROM StatusFlow
JOIN Candidates c ON StatusFlow.candidate_id = c.CandidateID
WHERE StatusFlow.status = 'Hired';















/*					2) Updating Candidate Status:		
					To update the status of candidates based on evaluation results, interview outcomes, and background checks.				*/

BEGIN TRANSACTION UpdateCandidateStatusTransaction;

-- Update candidate status based on evaluation, interview, and background check results
UPDATE StatusFlow
SET status = 
    CASE 
        WHEN Evaluations.Result = 'Fail' THEN 'Rejected'
        WHEN BackgroundChecks.Status = 'Pending' THEN 'Under Review'
        ELSE 'Accepted'
    END
FROM StatusFlow
JOIN Applications ON StatusFlow.candidate_id = Applications.CandidateID
LEFT JOIN Evaluations ON Applications.ApplicationID = Evaluations.ApplicationID
LEFT JOIN BackgroundChecks ON Applications.CandidateID = BackgroundChecks.CandidateID;

COMMIT TRANSACTION UpdateCandidateStatusTransaction;

-- Displaying the updated status of candidates
SELECT Candidates.CandidateID, Candidates.Name, Candidates.Email, Candidates.Phone, StatusFlow.status
FROM StatusFlow
JOIN Candidates ON StatusFlow.candidate_id = Candidates.CandidateID;










/*						3) Resolving Complaints:
						Objective: To address and resolve any complaints raised by candidates during the hiring process, ensuring a positive candidate experience.					 */



BEGIN TRANSACTION Resolve_Complaints;

-- Update the status of complaints to 'Resolved'
UPDATE Complaint
SET status = 'Resolved', resolution = 'Resolved'
WHERE status = 'Open';

COMMIT;


SELECT *
FROM Complaint
WHERE status = 'Resolved';




/*					4) Handling Job Offer Negotiations:
					Objective: To negotiate job offers with candidates, including salary, benefits, and start date.				 */



BEGIN TRANSACTION;

-- Update the status of candidates who are negotiating job offers
UPDATE StatusFlow
SET status = 'Negotiating'
WHERE candidate_id IN (
    SELECT ApplicationID
    FROM Evaluations
    WHERE Result = 'Pass'
);

-- Display the updated status of candidates who are negotiating job offers
SELECT Candidates.CandidateID, Candidates.Name, Candidates.Email, StatusFlow.Status
FROM StatusFlow
JOIN Candidates ON StatusFlow.candidate_id = Candidates.CandidateID
WHERE StatusFlow.status = 'Negotiating';

COMMIT TRANSACTION;




/*					5) Closing Job Openings:
Objective: To close job openings once positions have been filled, updating the job status accordingly.						 */




BEGIN TRANSACTION;

DELETE FROM JobOpenings
WHERE NumberOfPositions = 0;

COMMIT TRANSACTION;


-- Display job openings after closing
SELECT * 
FROM JobOpenings; /* Since No. of Positions are not filled yet it wont display as 0 yet */






/*				Scripts						*/


/*				1) Granting Permissions for Interviewers			
				 Grant specific permissions to interviewers for accessing and updating interview.			*/

-- Create a new role named 'Interviewers'
CREATE ROLE Interviewers;

-- Grant SELECT permission on the Interviews table to the 'Interviewers' role
GRANT SELECT ON Interviews TO Interviewers;

-- Grant INSERT permission on the Interviews table to the 'Interviewers' role
GRANT INSERT ON Interviews TO Interviewers;

-- Grant UPDATE permission on the Interviews table to the 'Interviewers' role
GRANT UPDATE ON Interviews TO Interviewers;








/*					2) Creating a Role for HR Managers	
					Establish a custom database role named HRManager within the HR_DB database, granting appropriate permissions for HR managers to manage candidate data.			*/



-- Create a new role named 'HRManager'
CREATE ROLE HRManager;


-- Grant EXECUTE permission on the UpdateCandidateInformation stored procedure to the 'HRManager' role
GRANT EXECUTE ON UpdateCandidateInformation TO HRManager;

-- Grant EXECUTE permission on the UpdateInterviewDetails stored procedure to the 'HRManager' role
GRANT EXECUTE ON UpdateInterviewDetails TO HRManager;

-- Grant EXECUTE permission on the RetrieveBackgroundCheckStatus stored procedure to the 'HRManager' role
GRANT EXECUTE ON RetrieveBackgroundCheckStatus TO HRManager;

-- Grant EXECUTE permission on the UpdateReimbursementStatus stored procedure to the 'HRManager' role
GRANT EXECUTE ON UpdateReimbursementStatus TO HRManager;

-- Grant EXECUTE permission on the GenerateMonthlyReport stored procedure to the 'HRManager' role
GRANT EXECUTE ON GenerateMonthlyReport TO HRManager;







/*				3) Setting Permissions for Document Access:
				Permissions for accessing and updating documents uploaded by candidates.				*/



/*				-- Create a new role named 'HRManager'
				CREATE ROLE HRManager;		this part has already been done in the previous so no need to run this but yeah incase no need for the above script then run to create HR Manager before proceeding	 */
-- Grant SELECT permission on the Documents table to the HRManager role
GRANT SELECT ON Documents TO HRManager;

-- Grant UPDATE permission on the Documents table to the HRManager role
GRANT UPDATE ON Documents TO HRManager;








/*				4) Creating a Role for Compliance Officers:
				Granting permissions to monitor and manage compliance-related data such as background checks and drug tests.		*/




-- Create a new database role named ComplianceOfficer
CREATE ROLE ComplianceOfficer;

-- Grant SELECT permission on the BackgroundChecks table to the ComplianceOfficer role
GRANT SELECT ON BackgroundChecks TO ComplianceOfficer;

-- Grant SELECT permission on the DrugTests table to the ComplianceOfficer role
GRANT SELECT ON DrugTests TO ComplianceOfficer;












/*				Business Report			 */


/*				1) MonthlyApplicationTrendsReport			
				Generate a report summarizing the monthly trends in job applications.			*/


SELECT 
    YEAR(StatusFlow.timestamp) AS Year,
    MONTH(StatusFlow.timestamp) AS Month,
    COUNT(*) AS NumberOfApplications
FROM 
    StatusFlow
INNER JOIN 
    Applications ON StatusFlow.candidate_id = Applications.CandidateID
GROUP BY 
    YEAR(StatusFlow.timestamp),
    MONTH(StatusFlow.timestamp)
ORDER BY 
    YEAR(StatusFlow.timestamp) DESC,
    MONTH(StatusFlow.timestamp) DESC;













/*				2) JobOpeningStatusReport		
				Track the status of job openings, including the number of positions filled and pending.						*/

SELECT 
    J.Title,
    COUNT(*) AS TotalPositions,
    SUM(CASE WHEN JO.OpeningID IS NOT NULL THEN 1 ELSE 0 END) AS FilledPositions,
    SUM(CASE WHEN JO.OpeningID IS NULL THEN 1 ELSE 0 END) AS PendingPositions
FROM 
    Job J
LEFT JOIN 
    JobOpenings JO ON J.JobID = JO.JobID
GROUP BY 
    J.Title;









/*				3) Evaluation Scores Distribution Report:			
				Analyze the distribution of evaluation scores for candidates across different stages.

*/


SELECT
    S.status AS Stage,
    AVG(T.Grade) AS Average_Score,
    MIN(T.Grade) AS Min_Score,
    MAX(T.Grade) AS Max_Score,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY T.Grade) OVER (PARTITION BY S.status) AS Q1_Score,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY T.Grade) OVER (PARTITION BY S.status) AS Median_Score,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY T.Grade) OVER (PARTITION BY S.status) AS Q3_Score
FROM
    StatusFlow S
JOIN
    Applications A ON S.candidate_id = A.CandidateID
JOIN
    Tests T ON A.ApplicationID = T.ApplicationID
GROUP BY
    S.status, T.Grade;












/*				4) Maximum Test Score Report:
				Display the maximum score achieved for a specific test across all candidates.
	*/

	SELECT
    Type AS Test_Type,
    MAX(Grade) AS Maximum_Score
FROM	Tests
GROUP BY Type;


/*									 */









/*									 */









/*									 */















/*									 */





/*									 */









/*									 */















/*									 */
















































































