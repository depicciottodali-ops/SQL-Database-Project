CREATE DATABASE StrangerThingsS5_Disappointment_
GO
USE StrangerThingsS5_Disappointment_
GO


CREATE TABLE dbo.Seasons   (SeasonID       INT IDENTITY(1,1) PRIMARY KEY,
                             SeasonNumber   TINYINT NOT NULL UNIQUE,
                             ReleaseYear    SMALLINT NULL,
CONSTRAINT CK_Seasons_SeasonNumber CHECK (SeasonNumber BETWEEN 1 AND 20))

CREATE TABLE dbo.Episodes (EpisodeID       INT IDENTITY(1,1) PRIMARY KEY,
                             SeasonID       INT NOT NULL,
                             EpisodeNumber  TINYINT NOT NULL,
                             EpisodeTitle   NVARCHAR(100) NOT NULL,
                             AirDate        DATE NULL,
                             IsFinalEpisode BIT NOT NULL CONSTRAINT DF_Episodes_IsFinal DEFAULT (0),

CONSTRAINT FK_Episodes_Seasons
FOREIGN KEY (SeasonID) REFERENCES dbo.Seasons(SeasonID),
CONSTRAINT UQ_Episodes_Season_Episode UNIQUE (SeasonID, EpisodeNumber),)



CREATE TABLE dbo.Viewers    (ViewerID       INT IDENTITY(1,1) PRIMARY KEY,
                             DisplayName    NVARCHAR(50) NOT NULL,
                             webpage        CHAR(2) NULL,
                             Age            TINYINT NULL,
CONSTRAINT CK_Viewers_Age CHECK (Age IS NULL OR Age BETWEEN 13 AND 99))



CREATE TABLE dbo.Categories (CategoryID   INT IDENTITY(1,1) PRIMARY KEY,
                               CategoryName NVARCHAR(40) NOT NULL UNIQUE)


CREATE TABLE dbo.Comments (CommentID     INT IDENTITY(1,1) PRIMARY KEY,
                              EpisodeID     INT NOT NULL,
                              ViewerID      INT NOT NULL,
                              CategoryID    INT NOT NULL,
                              Rating        TINYINT NOT NULL,
                              CommentText   NVARCHAR(400) NOT NULL,
                              CreatedAt     DATETIME2 NOT NULL CONSTRAINT DF_Comments_CreatedAt DEFAULT (SYSUTCDATETIME()),

CONSTRAINT FK_Comments_Episodes
FOREIGN KEY (EpisodeID) REFERENCES dbo.Episodes (EpisodeID),

CONSTRAINT FK_Comments_Viewers
FOREIGN KEY (ViewerID) REFERENCES dbo.Viewers (ViewerID),

CONSTRAINT FK_Comments_Categories
FOREIGN KEY (CategoryID) REFERENCES dbo.Categories (CategoryID),

CONSTRAINT CK_Comments_Rating CHECK (Rating BETWEEN 1 AND 5))


INSERT INTO dbo.Seasons (SeasonNumber, ReleaseYear) 
VALUES (5, NULL)

INSERT INTO dbo.Categories (CategoryName)
VALUES (N'Ending'), (N'Plot'), (N'Pacing'), (N'Character'), (N'Writing')

INSERT INTO dbo.Viewers (DisplayName, webpage, Age)
VALUES
(N'Fan_Alpha', 'US', 22),
(N'MikeRules', 'GB', 19),
(N'UpsideDownSad', 'CA', 28),
(N'Critic_99', 'FR', 31),
(N'BingeWatcher', 'IL', 25)


DECLARE @S5 INT = (SELECT SeasonID FROM dbo.Seasons WHERE SeasonNumber = 5)

INSERT INTO dbo.Episodes (SeasonID, EpisodeNumber, EpisodeTitle, AirDate, IsFinalEpisode)
VALUES
(@S5, 1, N'The Return', NULL, 0),
(@S5, 2, N'Cracks in Hawkins', NULL, 0),
(@S5, 3, N'The Hunt', NULL, 0),
(@S5, 4, N'No Way Back', NULL, 0),
(@S5, 5, N'The Final Gate', NULL, 1)


DECLARE @FinalEpisodeID INT =
(SELECT EpisodeID 
FROM dbo.Episodes 
WHERE SeasonID = (SELECT SeasonID 
                  FROM dbo.Seasons 
                  WHERE SeasonNumber=5) AND IsFinalEpisode=1)

DECLARE @Ep3 INT =
(SELECT EpisodeID 
FROM dbo.Episodes 
WHERE SeasonID = (SELECT SeasonID 
                  FROM dbo.Seasons 
                  WHERE SeasonNumber=5) AND EpisodeNumber=3)

INSERT INTO dbo.Comments (EpisodeID, ViewerID, CategoryID, Rating, CommentText)
VALUES

(@FinalEpisodeID, 1, (SELECT CategoryID 
                      FROM dbo.Categories 
                      WHERE CategoryName=N'Ending'), 1,
 N'That ending felt rushed and pointless. Years of buildup for a lazy wrap-up.'),
(@FinalEpisodeID, 2, (SELECT CategoryID 
                      FROM dbo.Categories 
                      WHERE CategoryName=N'Writing'), 2,
 N'The dialogue was cheesy and the payoff didn’t match the hype.'),
(@FinalEpisodeID, 3, (SELECT CategoryID 
                      FROM dbo.Categories 
                      WHERE CategoryName=N'Plot'), 2,
 N'Too many unresolved threads. It felt like they forgot their own rules.'),
(@FinalEpisodeID, 4, (SELECT CategoryID 
                      FROM dbo.Categories 
                      WHERE CategoryName=N'Character'), 3,
 N'Some character choices made no sense, but there were a few strong moments.'),
(@FinalEpisodeID, 5, (SELECT CategoryID 
                      FROM dbo.Categories 
                      WHERE CategoryName=N'Pacing'), 4,
 N'Pacing was better than expected. Still not perfect, but I enjoyed parts of it.'),

(@Ep3, 1, (SELECT CategoryID 
           FROM dbo.Categories 
           WHERE CategoryName=N'Pacing'), 2,
 N'Dragged too much in the middle, felt like filler.'),
(@Ep3, 2, (SELECT CategoryID 
           FROM dbo.Categories 
           WHERE CategoryName=N'Plot'), 3,
 N'Decent episode, not amazing, but okay.'),
(@Ep3, 3, (SELECT CategoryID 
           FROM dbo.Categories 
           WHERE CategoryName=N'Writing'), 1,
 N'Worst writing in the season so far.')
