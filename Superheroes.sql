create table appearsIn
	(charName varchar(45) not null,
	comicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze'),
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
	format ENUM('Novel', 'Graphic Novel', 'Other'),
	primary key (mName),
	foreign key (mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);
 
grant select on book to public;
 
create table character
	(name varchar(48) not null,
	comicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	personName varchar(45),
	species varchar(45),
	alignment ENUM('Hero', 'Villian', 'Other'),
	gender ENUM('Male', 'Female', 'Other'),
	power  varchar(450),
	originPlanet varchar(45),
	primary key (name, comicAge));
	
grant select on character to public;

create table creates
	(charName varchar(45) not null,
	charComicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	crName varchar(45) not null,
	crType ENUM('Author', 'Illustrator', 'Other') not null,
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
	type ENUM('Author', 'Illustrator', 'Other') not null,
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
	comicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	victor varchar(45),
	primary key (description, comicAge));
	
grant select on fight to public;

create table makesUp
	(teamName varchar(45) not null,
	teamComicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	charComicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
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
	fightComicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	charName varchar(45) not null,
	charComicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
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
	comicAge ENUM('Modern', 'Silver', 'Golden', 'Bronze') not null,
	alignment ENUM('Hero', 'Villian', 'Other'),
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
