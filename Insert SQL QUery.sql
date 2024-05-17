




USE HR_DB;




-- Insert dummy data into the Candidates table
INSERT INTO Candidates (CandidateID, Name, Email, Phone, ShortProfile) VALUES
(1, 'Jainam Shah', 'jainam@gmail.com', '1234567890', 'Data Scientist'),
(2, 'Jackie Chan', 'jackie@hotmail.com', '2345678901', 'Data Scientist'),
(3, 'Gal Gadot', 'gal@syr.edu', '3456789012', 'Java Developer'),
(4, 'Margot Robbie', 'margot@gmail.com', '4567890123', 'Software Engineer'),
(5, 'Dikshita Patel', 'dikshita@hotmail.com', '5678901234', 'Frontend Developer'),
(6, 'Janvi Saddi', 'janvi@syr.edu', '6789012345', 'Frontend Developer'),
(7, 'Bhavya Shah', 'bhavya@gmail.com', '7890123456', 'Data Analyst'),
(8, 'Yash Solanki', 'yash@hotmail.com', '8901234567', 'Data Analyst'),
(9, 'Heet Chedda', 'heet@syr.edu', '9012345678', 'Java Developer'),
(10, 'Sahil Shah', 'sahil@gmail.com', '0123456789', 'Data Analyst');








-- Insert dummy data into the Documents table
INSERT INTO Documents (DocumentID, CandidateID, CV, ReferenceLetter, CoverLetter, OtherDocuments) VALUES
(1, 1, 'jainam_cv.pdf', 'jainam_ref_letter.pdf', 'jainam_cover_letter.pdf', 'jainam_other_docs.pdf'),
(2, 2, 'jackie_cv.pdf', 'jackie_ref_letter.pdf', 'jackie_cover_letter.pdf', 'jackie_other_docs.pdf'),
(3, 3, 'gal_cv.pdf', 'gal_ref_letter.pdf', 'gal_cover_letter.pdf', NULL),
(4, 4, 'margot_cv.pdf', 'margot_ref_letter.pdf', 'margot_cover_letter.pdf', NULL),
(5, 5, 'dikshita_cv.pdf', 'dikshita_ref_letter.pdf', 'dikshita_cover_letter.pdf', 'dikshita_other_docs.pdf'),
(6, 6, 'janvi_cv.pdf', 'janvi_ref_letter.pdf', 'janvi_cover_letter.pdf', NULL),
(7, 7, 'bhavya_cv.pdf', 'bhavya_ref_letter.pdf', 'bhavya_cover_letter.pdf', NULL),
(8, 8, 'yash_cv.pdf', 'yash_ref_letter.pdf', 'yash_cover_letter.pdf', 'yash_other_docs.pdf'),
(9, 9, 'heet_cv.pdf', 'heet_ref_letter.pdf', 'heet_cover_letter.pdf', NULL),
(10, 10, 'sahil_cv.pdf', 'sahil_ref_letter.pdf', 'sahil_cover_letter.pdf', 'sahil_other_docs.pdf');



-- Insert dummy data into the JobPlatform table
INSERT INTO JobPlatform (id, name) VALUES
(1, 'LinkedIn'),
(2, 'Glassdoor'),
(3, 'Handshake'),
(4, 'Referral');





-- Insert dummy data into the Job table
INSERT INTO Job (JobID, Position, Title, Type, Medium, NumberOfPositions) VALUES
(1, 'Data Scientist', 'Data Scientist and AI Developer', 'Fulltime', 'Onsite', 3),
(2, 'Data Scientist', 'Data Scientist', 'Fulltime', 'Hybrid', 2),
(3, 'Software Engineer', 'Software Engineer Position', 'Fulltime', 'Remote', 4),
(4, 'Java Developer', 'Java Developer Full Stack', 'Parttime', 'Onsite', 1),
(5, 'Business Analyst', 'Business Analyst and Data Analyst', 'Internship', 'Hybrid', 2),
(6, 'Frontend Developer', 'Frontend Developer(Full Stack)', 'Co-Op', 'Remote', 3),
(7, 'Software Engineer', 'Software Engineer Designer', 'Fulltime', 'Onsite', 2),
(8, 'Marketing Specialist', 'Marketing Specialist', 'Parttime', 'Hybrid', 1),
(9, 'Financial Analyst', 'Financial Analyst Position', 'Fulltime', 'Remote', 5),
(10, 'Human Resources Coordinator', 'HR Coordinator Position', 'Internship', 'Hybrid', 2);





-- Insert dummy data into the JobOpenings table
INSERT INTO JobOpenings (OpeningID, JobID, NumberOfPositions) VALUES
(1, 1, 3),
(2, 2, 2),
(3, 3, 4),
(4, 4, 1),
(5, 5, 2),
(6, 6, 3),
(7, 7, 2),
(8, 8, 1),
(9, 9, 5),
(10, 10, 2);




-- Insert dummy data into the StatusFlow table
INSERT INTO StatusFlow (id, candidate_id, status, timestamp) VALUES
(1, 1, 'Under Review', '2024-04-18 08:00:00'),
(2, 2, 'Negotiating', '2024-04-23 08:30:00'),
(3, 3, 'Accepted', '2024-03-30 09:00:00'),
(4, 4, 'Rejected', '2024-01-30 09:30:00'),
(5, 5, 'Rejected', '2023-04-30 10:00:00'),
(6, 6, 'Application Submitted', '2024-04-18 10:30:00'),
(7, 7, 'Under Review', '2024-04-14 11:00:00'),
(8, 8, 'Application Submitted', '2024-04-19 11:30:00'),
(9, 9, 'Under Review', '2024-04-11 12:00:00'),
(10, 10, 'Accepted', '2024-04-09 12:30:00');




-- Insert dummy data into the Applications table
INSERT INTO Applications (ApplicationID, CandidateID, OpeningID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);



-- Insert dummy data into the Tests table
INSERT INTO Tests (TestID, ApplicationID, Type, StartTime, EndTime, Answers, Grade) VALUES
(1, 1, 'OA', '2024-04-18 09:00:00', '2024-04-18 10:00:00', 'A, B, C, D, A', 85.5),
(2, 2, 'Behavioural MCQ', '2024-04-23 10:00:00', '2024-04-23 11:00:00', 'Strongly Agree, Agree, Neutral, Disagree, Strongly Disagree', 70.0),
(3, 3, 'Aptitude', '2024-03-30 09:00:00', '2024-03-30 10:00:00', '25, 36, 42, 55, 63', 90.5),
(4, 4, 'OA', '2024-01-30 09:30:00', '2024-01-30 10:30:00', 'A, C, D, D, B', 78.0),
(5, 5, 'Behavioural MCQ', '2023-04-30 10:00:00', '2023-04-30 11:00:00', 'Disagree, Strongly Agree, Neutral, Agree, Disagree', 65.5),
(6, 6, 'Aptitude', '2024-04-18 10:30:00', '2024-04-18 11:30:00', '30, 42, 56, 68, 75', 82.0),
(7, 7, 'OA', '2024-04-14 11:00:00', '2024-04-14 12:00:00', 'C, A, B, D, C', 88.5),
(8, 8, 'Behavioural MCQ', '2024-04-19 11:30:00', '2024-04-19 12:30:00', 'Neutral, Agree, Disagree, Strongly Agree, Strongly Disagree', 72.0),
(9, 9, 'Aptitude', '2024-04-11 12:00:00', '2024-04-11 13:00:00', '40, 51, 64, 78, 85', 95.0),
(10, 10, 'OA', '2024-04-09 12:30:00', '2024-04-09 13:30:00', 'B, B, D, A, C', 80.5);






-- Insert dummy data into the Interviewers table
INSERT INTO Interviewers (InterviewerID, Name, Department, Title) VALUES
(1, 'John Doe', 'Human Resources', 'HR Manager'),
(2, 'Jane Smith', 'Engineering', 'Senior Software Engineer'),
(3, 'David Martinez', 'Operations', 'Operations Manager'),
(4, 'Daniel Taylor', 'Research and Development', 'Data Science Manager'),
(5, 'Sophia Anderson', 'Product Management', 'Product Manager');





-- Insert dummy data into the Interviews table
INSERT INTO Interviews (InterviewID, ApplicationID, Type, StartTime, EndTime, InterviewerID) VALUES
(1, 1, 'Onsite', '2024-04-20 09:00:00', '2024-04-20 10:45:00', 1),
(2, 2, 'Online', '2024-04-21 10:00:00', '2024-04-21 11:30:00', 2),
(3, 3, 'Onsite', '2024-04-22 11:00:00', '2024-04-22 12:00:00', 1),
(4, 4, 'Online', '2024-04-23 12:00:00', '2024-04-23 12:20:00', 3),
(5, 5, 'Onsite', '2024-04-24 13:00:00', '2024-04-24 14:00:00', 4),
(6, 6, 'Online', '2024-04-25 14:00:00', '2024-04-25 15:00:00', 5),
(7, 7, 'Onsite', '2024-04-26 15:00:00', '2024-04-26 16:00:00', 2),
(8, 8, 'Online', '2024-04-27 16:00:00', '2024-04-27 17:00:00', 1),
(9, 9, 'Onsite', '2024-04-28 17:00:00', '2024-04-28 18:15:00', 3),
(10, 10, 'Online', '2024-04-29 18:00:00', '2024-04-29 19:00:00',5);





INSERT INTO JobReview (id, candidate_id, interviewer_id, review_text, rating) VALUES
(1, 1, 1, 'Good logical skills. Moving onto the next round.', 4),
(2, 2, 2, 'Great interview! Well-prepared and insightful answers.', 5),
(3, 3, 1, 'The interviewer asked irrelevant questions.', 2),
(4, 4, 3, 'The interviewee performed very poorly.', 1),
(5, 5, 4, 'The interviewee needs improvement in communication skills.', 2),
(6, 6, 5, 'Failed to answer critical questions.', 1),
(7, 7, 2, 'Passed the interview with flying colors.', 5),
(8, 8, 1, 'Good logical skills. Moving onto the next round.', 4),
(9, 9, 3, 'Need Improvement in technical skills.', 2),
(10, 10, 5, 'Irrelevant questions were asked during the interview.', 3);



INSERT INTO Evaluations (EvaluationID, ApplicationID, EvaluationNotes, Result) VALUES
(1, 1, 'Passed the interview. Moving onto the next round.', 'Pass'),
(2, 2, 'Failed the interview. Needs improvement in technical skills.', 'Fail'),
(3, 3, 'Can do better in the next round. Improve communication skills.', 'Pending'),
(4, 4, 'Passed the interview with excellent performance.', 'Pass'),
(5, 5, 'Moving onto the next round. Good problem-solving skills.', 'Pass'),
(6, 6, 'Failed the interview due to lack of experience.', 'Fail'),
(7, 7, 'Needs improvement in coding skills. Waiting on other candidates interview.', 'Pending'),
(8, 8, 'Passed the interview with flying colors.', 'Pass'),
(9, 9, 'Moving onto the next round. Great presentation skills.', 'Pass'),
(10, 10, 'Failed to meet expectations. Pending further review.', 'Pending');


INSERT INTO Reimbursements (ReimbursementID, ApplicationID, RequestDate, Processed, Amount) VALUES
(1, 1, '2024-04-18', 1, 200.00),
(2, 2, '2024-04-23', 1, 150.00),
(3, 3, '2024-03-30', 0, 0.00),
(4, 4, '2024-01-30', 1, 100.00),
(5, 5, '2023-04-30', 0, 0.00),
(6, 6, '2024-04-18', 1, 250.00),
(7, 7, '2024-04-14', 1, 180.00),
(8, 8, '2024-04-19', 0, 0.00),
(9, 9, '2024-04-11', 1, 300.00),
(10, 10, '2024-04-09', 1, 220.00);



INSERT INTO Onboarding (OnboardingID, CandidateID, JobID, StartDate)
VALUES
(1, 1, 1, '2024-06-10'),
(2, 2, 2, '2024-06-10'),
(3, 3, 3, '2024-06-07'),
(4, 4, 4, '2024-07-03'),
(5, 5, 5, '2024-07-10'),
(6, 6, 6, '2024-08-21'),
(7, 7, 7, '2024-06-30'),
(8, 8, 8, '2024-05-24'),
(9, 9, 9, '2024-07-17'),
(10, 10, 10, '2024-06-10');


INSERT INTO Complaint (id, candidate_id, description, status, resolution)
VALUES
(1, 1, 'Cannot Start Behavioural Questions', 'Open', 'Investigating'),
(2, 2, 'Link not working', 'Open', 'Resolved'),
(3, 3, 'Poor Connection hence could not give interview', 'Open', 'Investigating'),
(4, 4, NULL, 'Open', 'No action required'),
(5, 5, NULL, 'Open', 'No action required'),
(6, 6, 'Link not working', 'Open', 'Investigating'),
(7, 7, 'Cannot Start Behavioural Questions', 'Open', 'Investigating'),
(8, 8, 'Poor Connection hence could not give interview', 'Open', 'Investigating'),
(9, 9, NULL, 'Open', 'No action required'),
(10, 10, NULL, 'Open', 'No action required');





-- Insert dummy data into the BackgroundChecks table
INSERT INTO BackgroundChecks (CheckID, CandidateID, CriminalBackground, EmploymentHistory, Status, CheckDate) VALUES
(1, 1, 'Clean', 'Stable', 'Clear', '2024-04-18'),
(2, 2, 'Minor Offense', 'Unstable', 'Pending', '2024-04-23'),
(3, 3, 'Clear', 'Stable', 'Clear', '2024-04-30'),
(4, 4, 'Clean', 'Stable', 'Clear', '2024-04-30'),
(5, 5, 'Clean', 'Stable', 'Clear', '2024-04-30'),
(6, 6, 'Clear', 'Unstable', 'Clear', '2024-04-18'),
(7, 7, 'Clear', 'Stable', 'Clear', '2024-04-14'),
(8, 8, 'Minor Offense', 'Stable', 'Pending', '2024-04-19'),
(9, 9, 'Clear', 'Stable', 'Clear', '2024-04-11'),
(10, 10, 'Clean', 'Stable', 'Clear', '2024-04-09');




-- Insert dummy data into the DrugTests table
INSERT INTO DrugTests (TestID, CandidateID, TestType, TestDate, Results) VALUES
-- Candidate 1
(1, 1, 'Urine Test', '2024-04-18', 'Negative'),
(2, 1, 'Blood Test', '2024-04-19', 'Negative'),
(3, 1, 'Saliva Test', '2024-04-20', 'Negative'),

-- Candidate 2
(4, 2, 'Urine Test', '2024-04-21', 'Negative'),
(5, 2, 'Blood Test', '2024-04-22', 'Positive'),
(6, 2, 'Saliva Test', '2024-04-23', 'Negative'),

-- Candidate 3
(7, 3, 'Urine Test', '2024-04-24', 'Negative'),
(8, 3, 'Blood Test', '2024-04-25', 'Negative'),
(9, 3, 'Saliva Test', '2024-04-26', 'Positive'),

-- Candidate 4
(10, 4, 'Urine Test', '2024-04-27', 'Negative'),
(11, 4, 'Blood Test', '2024-04-28', 'Negative'),
(12, 4, 'Saliva Test', '2024-04-29', 'Negative'),

-- Candidate 5
(13, 5, 'Urine Test', '2024-04-30', 'Negative'),
(14, 5, 'Blood Test', '2024-05-01', 'Negative'),
(15, 5, 'Saliva Test', '2024-05-02', 'Negative'),

-- Candidate 6
(16, 6, 'Urine Test', '2024-05-03', 'Negative'),
(17, 6, 'Blood Test', '2024-05-04', 'Negative'),
(18, 6, 'Saliva Test', '2024-05-05', 'Negative'),

-- Candidate 7
(19, 7, 'Urine Test', '2024-05-06', 'Negative'),
(20, 7, 'Blood Test', '2024-05-07', 'Negative'),
(21, 7, 'Saliva Test', '2024-05-08', 'Negative'),

-- Candidate 8
(22, 8, 'Urine Test', '2024-05-09', 'Positive'),
(23, 8, 'Blood Test', '2024-05-10', 'Positive'),
(24, 8, 'Saliva Test', '2024-05-11', 'Negative'),

-- Candidate 9
(25, 9, 'Urine Test', '2024-05-12', 'Positive'),
(26, 9, 'Blood Test', '2024-05-13', 'Positive'),
(27, 9, 'Saliva Test', '2024-05-14', 'Positive'),

-- Candidate 10
(28, 10, 'Urine Test', '2024-05-15', 'Negative'),
(29, 10, 'Blood Test', '2024-05-16', 'Negative'),
(30, 10, 'Saliva Test', '2024-05-17', 'Negative');






-- Insert dummy data into the JobCategory table
INSERT INTO JobCategory (id, name) VALUES
(1, 'Data Science'),
(2, 'Software Development'),
(3, 'Data Analyst'),
(4, 'Java Developer'),
(5, 'Business Analysis'),
(6, 'Human Resource');


-- Insert dummy data into the JobPlatformJob table
INSERT INTO JobPlatformJob (job_platform_id, job_id) VALUES
(1, 1),
(1, 2),
(3, 3),
(4, 4),
(2, 5),
(2, 6),
(4, 7),
(1, 8),
(1, 9),
(3, 10);


-- Insert dummy data into the JobCategoryJob table
INSERT INTO JobCategoryJob (job_category_id, job_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(4, 4),
(5, 5),
(2, 6),
(2, 7),
(5, 8),
(5, 9),
(6, 10);



-- Display data from the Candidates table
SELECT * FROM Candidates;

-- Display data from the Documents table
SELECT * FROM Documents;

-- Display data from the JobPlatform table
SELECT * FROM JobPlatform;

-- Display data from the Job table
SELECT * FROM Job;

-- Display data from the JobOpenings table
SELECT * FROM JobOpenings;

-- Display data from the StatusFlow table
SELECT * FROM StatusFlow;

-- Display data from the Applications table
SELECT * FROM Applications;

-- Display data from the Tests table
SELECT * FROM Tests;

-- Display data from the Interviewers table
SELECT * FROM Interviewers;

-- Display data from the Interviews table
SELECT * FROM Interviews;

-- Display data from the JobReview table
SELECT * FROM JobReview;

-- Display data from the Evaluations table
SELECT * FROM Evaluations;

-- Display data from the Reimbursements table
SELECT * FROM Reimbursements;

-- Display data from the Onboarding table
SELECT * FROM Onboarding;

-- Display data from the Complaint table
SELECT * FROM Complaint;

-- Display data from the BackgroundChecks table
SELECT * FROM BackgroundChecks;

-- Display data from the DrugTests table
SELECT * FROM DrugTests;

-- Display data from the JobCategory table
SELECT * FROM JobCategory;

-- Display data from the JobPlatformJob table
SELECT * FROM JobPlatformJob;

-- Display data from the JobCategoryJob table
SELECT * FROM JobCategoryJob;
