create table appearsIn
	(charName varchar(45) not null,
	comicAge varchar(45),
	mName varchar(45),
	primary key (charName),
	foreign key (charName, comicAge) 
		references character (name, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE);
 
grant select on appearsIn to public;
 
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
 
grant select on book to public;
 
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
	
grant select on character to public;

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
 
grant select on creates to public;
 
create table creator
	(name varchar(45) not null,
	type varchar(45) not null,
	primary key (name, type));
 
grant select on creator to public;
 
create table distributesMedium
	(mName varchar(45) not null,
	distName varchar(45),
	primary key (mName),
	foreign key (distName) 
		references distributor (name)
		ON UPDATE CASCADE);
 
grant select on distributesMedium to public;
 
create table distributor
	(name varchar(45) not null,
	type varchar(45),
	primary key (name));
 
grant select on distributor to public;
 
create table fight
	(description varchar(100) not null,
	comicAge varchar(45) not null,
	victor varchar(45),
	primary key (description, comicAge));
	
grant select on fight to public;

create table makesUp
	(teamName varchar(45) not null,
	teamComicAge varchar(45) not null,
	charComicAge varchar(45) not null,
	charName varchar(45) not null,
	primary key(teamName, teamComicAge, charComicAge, charName),
	foreign key(teamName, teamComicAge) 
		references teamName (name, comicAge)
		ON UPDATE CASCADE ON DELETE CASCADE,
	foreign key(charComicAge, charName) 
		references character (name, comicAge)
		ON UPDATE CASCADE ON DELETE CASCADE));
 
grant select on makesUp to public;
 
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

grant select on movie to public;

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
	
grant select on participatesIn to public;

create table team
	(name varchar(45) not null,
	comicAge varchar(45) not null,
	alignment varchar(45),
	HQ varchar(45),
	primary key (name, comicAge));

grant select on team to public;

create table tvSeries
	(mName varchar(45) not null,
	initialAirDate DATE,
	director varchar(45),
	primary key (mName),
	foreign key(mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);

grant select on tvSeries to public;

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
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men');
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
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: First Class');
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
INSERT INTO character VALUES ('Wolverine','Modern','Logan Howlett','Mutant','Hero','Male','Healing Factor','Earth');
INSERT INTO character VALUES ('Cyclops','Modern','Scott Summers','Mutant','Hero','Male','Lasers','Earth');
INSERT INTO character VALUES ('Superman','Modern','Clark Kent','Kryptonian','Hero','Male','Strength;Flight','Krypton');
INSERT INTO character VALUES ('Storm','Modern','Ororo Monroe','Mutant','Hero','Female','Weather Control;Flight','Earth');
INSERT INTO character VALUES ('Doctor Doom','Modern','Viktor Krumm','Human','Villian','Male','Technopathy;Genius;Flight;Force Fields','Earth');
INSERT INTO character VALUES ('Thor','Modern','Thor Odinson','Asgardian','Hero','Male','Mjolnr;God','Asgard');
INSERT INTO character VALUES ('Invisible Woman','Modern','Susan Storm','Human','Hero','Female','Force Fields','Earth');
INSERT INTO character VALUES ('Doctor Octopus','Modern','Otto Gunther Octavius','Human','Villian','Male','Genius','Earth');
INSERT INTO character VALUES ('Captain America','Modern','Steve Rogers','Human','Hero','Male','Strength;Endurance','Earth');
INSERT INTO character VALUES ('Iron Man','Modern','Tony Stark','Human','Hero','Male','Genius;Money','Earth');
INSERT INTO character VALUES ('Batman','Modern','Bruce Wayne','Human','Hero','Male','Genius;Money','Earth');
INSERT INTO character VALUES ('Hawkeye','Modern','Clint Barton','Human','Hero','Male','Archery','Earth');
INSERT INTO character VALUES ('Black Widow','Modern','Natasha Romanoff','Human','Hero','Female','Combat','Earth');

-- creates