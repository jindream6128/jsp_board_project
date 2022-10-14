CREATE TABLE BBS(
  bbsID int(11) AUTO_INCREMENT PRIMARY KEY,
  bbsTitle varchar(50),
  userID varchar(20),
  bbsDate datetime DEFAULT CURRENT_TIMESTAMP,
  bbsContent varchar(2048),
  bbsAvailable int(11)
);