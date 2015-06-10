-- drop tables if they exist
drop table if exists appearsIn;
drop table if exists book;
drop table if exists character;
drop table if exists creates;
drop table if exists creator;
drop table if exists distributesMedium;
drop table if exists distributor;
drop table if exists fight;
drop table if exists makesUp;
drop table if exists movie;
drop table if exists participatesIn;
drop table if exists team;
drop table if exists tvSeries;

-- Add tables
create table appearsIn
	(charName varchar(45) not null,
	comicAge varchar(45),
	mName varchar(45),
	primary key (charName, comicAge, mName),
	foreign key (charName, comicAge)
		references character (name, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (mName)
        references media (mName)
        ON DELETE CASCADE ON UPDATE CASCADE);

create table book
	(mName varchar(45) not null,
	ISBN varchar(20),
	author varchar(45) not null,
	publishDate DATE,
	format varchar(45),
	primary key (mName),
	foreign key (mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);
 
create table character
	(name varchar(48) not null,
	comicAge varchar(45) not null,
	personName varchar(45),
	species varchar(45),
	alignment varchar(45),
	gender varchar(45),
	power  varchar(450),
	originPlanet varchar(45),
	primary key (name, comicAge));
	 
create table creates
	(charName varchar(45) not null,
	charComicAge varchar(45) not null,
	crName varchar(45) not null,
	crType varchar(45) not null,
	primary key (charName, charComicAge, crName, crType),
	foreign key (charName, charComicAge) 
		references character (name, comicAge)
		ON UPDATE CASCADE,
	foreign key (crName, crType) 
		references creator (name, type)
		ON UPDATE CASCADE);

create table creator
	(name varchar(45) not null,
	type varchar(45) not null,
	primary key (name, type));
 
create table distributesMedium
	(mName varchar(45) not null,
	distName varchar(45),
	primary key (mName),
	foreign key (distName) 
		references distributor (name)
		ON UPDATE CASCADE);
 
create table distributor
	(name varchar(45) not null,
	type varchar(45),
	primary key (name));

create table fight
	(description varchar(100) not null,
	comicAge varchar(45) not null,
	victor varchar(45),
	primary key (description, comicAge));

create table makesUp
	(teamName varchar(45) not null,
	teamComicAge varchar(45) not null,
	charComicAge varchar(45) not null,
	charName varchar(45) not null,
	primary key(teamName, teamComicAge, charComicAge, charName),
	foreign key(teamName, teamComicAge) 
		references team (name, comicAge)
		ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key(charComicAge, charName) 
		references character (name, comicAge)
		ON UPDATE CASCADE ON DELETE CASCADE);

create table movie
	(mName varchar(45) not null,
	director varchar(45),
	releaseDate DATE,
	isAnimated BOOLEAN,
	revenue INT, CHECK (revenue >= 0),
	primary key (mName),
	foreign key (mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);

create table participatesIn
	(fightDesc varchar(100) not null,
	fightComicAge varchar(45) not null,
	charName varchar(45) not null,
	charComicAge varchar(45) not null,
	primary key (fightDesc, fightComicAge, charName, charComicAge)
	foreign key (fightDesc, fightComicAge) 
		references fight (description, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (charName, charComicAge) 
		references character (name, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE);
	
create table team
	(name varchar(45) not null,
	comicAge varchar(45) not null,
	alignment varchar(45),
	HQ varchar(45),
	primary key (name, comicAge));

create table tvSeries
	(mName varchar(45) not null,
	initialAirDate DATE,
	director varchar(45),
	primary key (mName),
	foreign key (mName)
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);

-- appearsIn
INSERT INTO appearsIn VALUES ('Superman','Modern','Adventures of Superman');
INSERT INTO appearsIn VALUES ('Superman','Modern','The Superman Chronicles: Volume One');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men Origins: Wolverine');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: First Class');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: Days of Future Past');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Doctor Doom','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Invisible Woman','Modern','Fantastic Four (1994)');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Earth''s Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Earth''s Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers: Earth''s Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Earth''s Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men (1992)');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men (1992)');
INSERT INTO appearsIn VALUES ('Superman','Modern','The Superman Chronicles: Volume 2');
INSERT INTO appearsIn VALUES ('Doctor Doom','Modern','Essential Fantastic Four: Volume 1');
INSERT INTO appearsIn VALUES ('Invisible Woman','Modern','Essential Fantastic Four: Volume 1');
INSERT INTO appearsIn VALUES ('Doctor Octopus','Modern','Spider-Man 2');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men Origins: Wolverine');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men: Days of Future Past');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Black Widow','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Batman','Modern','The Dark Knight Rises');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Volume 2');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Volume 2');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Volume 2');

-- book
INSERT INTO book VALUES ('The Superman Chronicles: Volume 1','978-1-4012-0764-9','Jerry Siegel','2006-02-22','Graphic Novel');
INSERT INTO book VALUES ('The Superman Chronicles: Volume 2','978-1-4012-1215-5','Jerry Siegel','2007-02-07','Graphic Novel');
INSERT INTO book VALUES ('Essential Fantastic Four: Volume 1','978-0-7851-1828-4','Martin Goodman','2005-05-25','Graphic Novel');
INSERT INTO book VALUES ('The Avengers: Volume 1','978-0-7851-3706-1','Stan Lee','2009-05-13','Graphic Novel');
INSERT INTO book VALUES ('The Avengers: Volume 2','978-0-7851-3708-5','Stan Lee','2009-10-14','Graphic Novel');

-- character
INSERT INTO character VALUES ('Aquaman','Modern','Arthur Curry','Human','Hero','Male','Telepathy;Hydrokinetic;Communicate with Marine Animals','Earth');
INSERT INTO character VALUES ('Archangel','Modern','Warren Worthington III','Mutant','Hero','Male','Healing Factor;Flight','Earth');
INSERT INTO character VALUES ('Batman','Modern','Bruce Wayne','Human','Hero','Male','Genius;Money','Earth');
INSERT INTO character VALUES ('Beast','Modern','Hank McCoy','Mutant','Hero','Male','Genius;Animal Like','Earth');
INSERT INTO character VALUES ('Black Widow','Modern','Natasha Romanoff','Human','Hero','Female','Combat','Earth');
INSERT INTO character VALUES ('Captain America','Modern','Steve Rogers','Human','Hero','Male','Strength;Endurance','Earth');
INSERT INTO character VALUES ('Cyclops','Modern','Scott Summers','Mutant','Hero','Male','Lasers','Earth');
INSERT INTO character VALUES ('Dr. C#','Silver','Devon Graham','Human','Hero','Male','Properties;LaTeX','Earth');
INSERT INTO character VALUES ('Doctor Doom','Modern','Viktor Krumm','Human','Villian','Male','Technopathy;Genius;Flight;Force Fields','Earth');
INSERT INTO character VALUES ('Doctor Octopus','Modern','Otto Gunther Octavius','Human','Villian','Male','Genius','Earth');
INSERT INTO character VALUES ('The Flash','Modern','Wally West','Human','Hero','Male','Speed','Earth');
INSERT INTO character VALUES ('The Flash','Silver','Barry Allen','Human','Hero','Male','Speed','Earth');
INSERT INTO character VALUES ('Green Lantern','Modern','Kyle Rayner','Human','Hero','Male','Power Ring','Earth');
INSERT INTO character VALUES ('Green Lantern','Silver','Hal Jordan','Human','Hero','Male','Power Ring','Earth');
INSERT INTO character VALUES ('Hawkeye','Modern','Clint Barton','Human','Hero','Male','Archery','Earth');
INSERT INTO character VALUES ('Hulk','Modern','Bruce Banner','Human','Hero','Male','Genius;Strength','Earth');
INSERT INTO character VALUES ('Human Torch','Modern','Johnny Storm','Human','Hero','Male','Pyrokinesis','Earth');
INSERT INTO character VALUES ('Iceman','Modern','Bobby Drake','Mutant','Hero','Male','Thermal Vision;Tranform to Ice;Generate Ice','Earth');
INSERT INTO character VALUES ('Invisible Woman','Modern','Susan Storm','Human','Hero','Female','Force Fields','Earth');
INSERT INTO character VALUES ('Iron Man','Modern','Tony Stark','Human','Hero','Male','Genius;Money','Earth');
INSERT INTO character VALUES ('Mister Fantastic','Modern','Reed Richards','Human','Hero','Male','Genius;Elasticity','Earth');
INSERT INTO character VALUES ('Phoenix','Modern','Jean Grey','Mutant','Hero','Female','Telekinesis;Telepathy;Phoenix Force','Earth');
INSERT INTO character VALUES ('Professor X','Modern','Charles Xavier','Mutant','Hero','Male','Telepathy','Earth');
INSERT INTO character VALUES ('Quicksilver','Modern','Pietro Maximoff','Mutant','Hero','Male','Speed','Earth');

INSERT INTO character VALUES ('Scarlet Witch','Modern','Wanda Maximoff','Mutant','Hero','Female','Reality Warping','Earth');

INSERT INTO character VALUES ('Storm','Modern','Ororo Monroe','Mutant','Hero','Female','Weather Control;Flight','Earth');
INSERT INTO character VALUES ('Superman','Modern','Clark Kent','Kryptonian','Hero','Male','Strength;Flight','Krypton');
INSERT INTO character VALUES ('The Thing','Modern','Ben Grimm','Human','Hero','Male','Strength;Endurance','Earth');
INSERT INTO character VALUES ('Thor','Modern','Thor Odinson','Asgardian','Hero','Male','Mjolnr;God','Asgard');
INSERT INTO character VALUES ('Wolverine','Modern','Logan Howlett','Mutant','Hero','Male','Healing Factor','Earth');
INSERT INTO character VALUES ('Wonder Woman','Modern','Princess Diana of Themyscira','Amazon','Hero','Female','Strength;Agility;Flight;Endurance','Earth');

-- creates
INSERT INTO creates VALUES ('Wolverine','Modern','Roy Thomas','Author');
INSERT INTO creates VALUES ('Cyclops','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Superman','Modern','Jerry Siegel','Author');
INSERT INTO creates VALUES ('Storm','Modern','Len Wein','Author');
INSERT INTO creates VALUES ('Doctor Doom','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Thor','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Invisible Woman','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Captain America','Modern','Joe Simon','Author');
INSERT INTO creates VALUES ('Iron Man','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Batman','Modern','Bill Finger','Author');
INSERT INTO creates VALUES ('Hawkeye','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Black Widow','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Superman','Modern','Joe Shuster','Illustrator');
INSERT INTO creates VALUES ('Wolverine','Modern','Len Wein','Author');
INSERT INTO creates VALUES ('Wolverine','Modern','John Romita, Sr.','Illustrator');
INSERT INTO creates VALUES ('Wolverine','Modern','Herb Trimpe','Illustrator');
INSERT INTO creates VALUES ('Cyclops','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Batman','Modern','Bob Kane','Illustrator');
INSERT INTO creates VALUES ('Black Widow','Modern','Don Rico','Illustrator');
INSERT INTO creates VALUES ('Black Widow','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Captain America','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Doctor Doom','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Hawkeye','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Iron Man','Modern','Larry Lieber','Author');
INSERT INTO creates VALUES ('Iron Man','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Iron Man','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Storm','Modern','Dave Cockrum','Illustrator');
INSERT INTO creates VALUES ('Thor','Modern','Larry Lieber','Author');
INSERT INTO creates VALUES ('Thor','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Invisible Woman','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Doctor Octopus','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Doctor Octopus','Modern','Steve Ditko','Illustrator');

-- creator
INSERT INTO creator VALUES ('Bill Finger','Author');
INSERT INTO creator VALUES ('Bob Kane','Illustrator');
INSERT INTO creator VALUES ('Dave Cockrum','Illustrator');
INSERT INTO creator VALUES ('Don Heck','Illustrator');
INSERT INTO creator VALUES ('Don Rico','Illustrator');
INSERT INTO creator VALUES ('Herb Trimpe','Illustrator');
INSERT INTO creator VALUES ('Jack Kirby','Illustrator');
INSERT INTO creator VALUES ('Jerry Siegel','Author');
INSERT INTO creator VALUES ('Joe Shuster','Illustrator');
INSERT INTO creator VALUES ('Joe Simon','Author');
INSERT INTO creator VALUES ('John Romita, Sr.','Illustrator');
INSERT INTO creator VALUES ('Larry Lieber','Author');
INSERT INTO creator VALUES ('Len Wein','Author');
INSERT INTO creator VALUES ('Roy Thomas','Author');
INSERT INTO creator VALUES ('Stan Lee','Author');
INSERT INTO creator VALUES ('Steve Ditko','Illustrator');

-- distributesMedium
INSERT INTO distributesMedium VALUES ('X-Men: Days of Future Past','20th Century Fox');
INSERT INTO distributesMedium VALUES ('The Superman Chronicles: Volume One','DC Comics');
INSERT INTO distributesMedium VALUES ('The Superman Chronicles: Volume Two','DC Comics');
INSERT INTO distributesMedium VALUES ('Essential Fantastic Four: Volume 1','Marvel Comics');
INSERT INTO distributesMedium VALUES ('The Avengers: Volume 1','Marvel Comics');
INSERT INTO distributesMedium VALUES ('The Avengers: Volume 2','Marvel Comics');
INSERT INTO distributesMedium VALUES ('Adventures of Superman','Warner Bros. Television Distribution');
INSERT INTO distributesMedium VALUES ('Fantastic Four (1994)','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('The Avengers: United They Stand','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('The Avengers: Earth''s Mightiest Heroes','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('X-Men (1992)','Genesis Entertainment');
INSERT INTO distributesMedium VALUES ('The Avengers','Marvel Studios');
INSERT INTO distributesMedium VALUES ('The Dark Knight Rises','Warner Bros. Pictures');
INSERT INTO distributesMedium VALUES ('Spider-Man 2','Columbia Pictures');

-- distributor
INSERT INTO distributor VALUES ('20th Century Fox','Studio');
INSERT INTO distributor VALUES ('DC Comics','Publisher');
INSERT INTO distributor VALUES ('Marvel Comics','Publisher');
INSERT INTO distributor VALUES ('Warner Bros. Television Distribution','Studio');
INSERT INTO distributor VALUES ('Disney–ABC Domestic Television','Studio');
INSERT INTO distributor VALUES ('Genesis Entertainment','Studio');
INSERT INTO distributor VALUES ('Marvel Studios','Studio');
INSERT INTO distributor VALUES ('Columbia Pictures','Studio');
INSERT INTO distributor VALUES ('Warner Bros. Pictures','Studio');

-- fight
INSERT INTO fight VALUES ('M-Day;Genosha;Decimation','Modern','None');
INSERT INTO fight VALUES ('Battle of New York','Modern','Avengers');
INSERT INTO fight VALUES ('Wolverine vs. Sabretooth','Modern','Wolverine');
INSERT INTO fight VALUES ('Battle of Sokovia','Modern','Avengers');
INSERT INTO fight VALUES ('Infinite Crisis','Modern','Justice League');

-- makesUp
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Thor');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Captain America');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Black Widow');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Iron Man');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Hawkeye');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Hulk');
INSERT INTO makesUp VALUES ('Brotherhood of Mutants','Modern','Modern','Magneto');
INSERT INTO makesUp VALUES ('Fantastic Four','Modern','Modern','Invisible Woman');
INSERT INTO makesUp VALUES ('Fantastic Four','Modern','Modern','Mister Fantastic');
INSERT INTO makesUp VALUES ('Fantastic Four','Modern','Modern','The Thing');
INSERT INTO makesUp VALUES ('Fantastic Four','Modern','Modern','Human Torch');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','The Flash');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','Superman');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','Batman');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','Green Lantern');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','Aquaman');
INSERT INTO makesUp VALUES ('Justice League','Modern','Modern','Wonder Woman');
INSERT INTO makesUp VALUES ('Sinister Six','Modern','Modern','Doctor Octopus');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Archangel');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Beast');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Cyclops');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Iceman');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Phoenix');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Professor X');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Storm');
INSERT INTO makesUp VALUES ('X-Men','Modern','Modern','Wolverine');

-- movie
INSERT INTO movie VALUES ('X-Men','Bryan Singer','2000-07-14','FALSE',296300000);
INSERT INTO movie VALUES ('X-Men: The Last Stand','Brett Ratner','2006-05-26','FALSE',459300000);
INSERT INTO movie VALUES ('X-Men Origins: Wolverine','Gavin Hood','2009-05-01','FALSE',373000000);
INSERT INTO movie VALUES ('X-Men: First Class','Matthew Vaughn','2011-06-03','FALSE',353600000);
INSERT INTO movie VALUES ('X-Men: Days of Future Past','Bryan Singer','2013-05-23','FALSE',748100000);
INSERT INTO movie VALUES ('The Avengers','Joss Whedon','2012-05-04','FALSE',1519000000);
INSERT INTO movie VALUES ('Spider-Man 2','Sam Raimi','2004-06-30','FALSE',783800000);
INSERT INTO movie VALUES ('The Dark Knight Rises','Christopher Nolan','2012-07-20','FALSE',1084000000);

-- participatesIn
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Black Widow','Modern');
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Iron Man','Modern');
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Thor','Modern');
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Hawkeye','Modern');
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Captain America','Modern');
INSERT INTO participatesIn VALUES ('Battle of New York','Modern','Hulk','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Black Widow','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Captain America','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Hawkeye','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Hulk','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Quicksilver','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Scarlet Witch','Modern');
INSERT INTO participatesIn VALUES ('Battle of Sokovia','Modern','Thor','Modern');

-- team
INSERT INTO team VALUES ('Avengers','Modern','Hero','Avengers Mansion');
INSERT INTO team VALUES ('Brotherhood of Mutants','Modern','Villian','Various');
INSERT INTO team VALUES ('Fantastic Four','Modern','Hero','Baxter Building');
INSERT INTO team VALUES ('Justice League','Modern','Hero','The Hall;The Satellite');
INSERT INTO team VALUES ('Sinister Six','Modern','Villian','New York');
INSERT INTO team VALUES ('X-Men','Modern','Hero','X-Mansion');

-- tvSeries
INSERT INTO tvSeries VALUES ('Adventures of Superman','1952-09-19','Whitney Ellsworth');
INSERT INTO tvSeries VALUES ('Fantastic Four (1994)','1994-09-24','Avi Arad');
INSERT INTO tvSeries VALUES ('The Avengers: United They Stand','1999-10-30','Avi Arad');
INSERT INTO tvSeries VALUES ('The Avengers: Earth''s Mightiest Heroes','2010-09-22','Simon Philips');
INSERT INTO tvSeries VALUES ('X-Men (1992)','1992-10-31','Larry Houston');