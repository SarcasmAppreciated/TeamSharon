drop table if exists appearsIn;
drop table if exists participatesIn;
drop table if exists makesUp;
drop table if exists creates;
drop table if exists tvSeries;
drop table if exists movie;
drop table if exists book;
drop table if exists distributesMedium;
drop table if exists team; 
drop table if exists fight;
drop table if exists distributor;
drop table if exists creator;
drop table if exists kharacter;

-- Add tables
create table kharacter
	(charName varchar(48) not null,
	comicAge varchar(45) not null,
	personName varchar(45),
	species varchar(45),
	alignment varchar(45),
	gender varchar(45),
	power  varchar(450),
	originPlanet varchar(45),
	primary key (charName, comicAge));


create table creator
	(fullName varchar(45) not null,
	variant varchar(45) not null,
	primary key (fullName, variant));

create table distributor
	(fullName varchar(45) not null,
	variant varchar(45),
	primary key (fullName));

create table fight
	(description varchar(100) not null,
	comicAge varchar(45) not null,
	victor varchar(45),
	primary key (description, comicAge));

create table team
	(teamName varchar(45) not null,
	comicAge varchar(45) not null,
	alignment varchar(45),
	HQ varchar(45),
	primary key (teamName, comicAge));

-- starting to have foreign refs
create table distributesMedium
	(mName varchar(45) not null,
	distName varchar(45),
	primary key (mName),
	foreign key (distName) 
		references distributor (fullName)
		ON DELETE CASCADE ON UPDATE CASCADE);

create table book
	(mName varchar(45) not null,
	ISBN varchar(20),
	author varchar(45) not null,
	publishDate DATE,
	variant varchar(45),
	primary key (mName),
	foreign key (mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);
 
create table movie
	(mName varchar(45) not null,
	director varchar(45),
	releaseDate DATE,
	isAnimated varchar(10),
	revenue INT, CHECK (revenue >= 0),
	primary key (mName),
	foreign key (mName) 
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);

create table tvSeries
	(mName varchar(45) not null,
	initialAirDate DATE,
	director varchar(45),
	primary key (mName),
	foreign key (mName)
		references distributesMedium (mName)
		ON DELETE CASCADE ON UPDATE CASCADE);
	 
create table creates
	(charName varchar(45) not null,
	charComicAge varchar(45) not null,
	crName varchar(45) not null,
	crType varchar(45) not null,
	primary key (charName, charComicAge, crName, crType),
	foreign key (charName, charComicAge) 
		references kharacter (charName, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (crName, crType) 
		references creator (fullName, variant)
		ON DELETE CASCADE ON UPDATE CASCADE);

 create table makesUp
	(teamName varchar(45) not null,
	teamComicAge varchar(45) not null,
	charComicAge varchar(45) not null,
	charName varchar(45) not null,
	primary key(teamName, teamComicAge, charComicAge, charName),
	foreign key(teamName, teamComicAge) 
		references team (teamName, comicAge)
		 ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key(charComicAge, charName) 
		references kharacter (comicAge, charName)
		 ON DELETE CASCADE ON UPDATE CASCADE);

create table participatesIn
	(fightDesc varchar(100) not null,
	fightComicAge varchar(45) not null,
	charName varchar(45) not null,
	charComicAge varchar(45) not null,
	primary key (fightDesc, fightComicAge, charName, charComicAge),
	foreign key (fightDesc, fightComicAge) 
		references fight 
		ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (charName, charComicAge) 
		references kharacter
		ON DELETE CASCADE ON UPDATE CASCADE);
	

create table appearsIn
	(charName varchar(45) not null,
	comicAge varchar(45),
	mName varchar(45),
	primary key (charName, comicAge, mName),
	foreign key (charName, comicAge)
		references kharacter (charName, comicAge)
		ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (mName)
        references distributesMedium (mName)
        ON DELETE CASCADE ON UPDATE CASCADE);

-- kharacter
INSERT INTO kharacter VALUES ('Aquaman','Modern','Arthur Curry','Human','Hero','Male','Telepathy Hydrokinetic Communicate with Marine Animals','Earth');
INSERT INTO kharacter VALUES ('Archangel','Modern','Warren Worthington III','Mutant','Hero','Male','Healing Factor Flight Strength','Earth');
INSERT INTO kharacter VALUES ('Batman','Modern','Bruce Wayne','Human','Hero','Male','Genius Money Combat','Earth');
INSERT INTO kharacter VALUES ('Beast','Modern','Hank McCoy','Mutant','Hero','Male','Genius Animal Like','Earth');
INSERT INTO kharacter VALUES ('Black Widow','Modern','Natasha Romanoff','Human','Hero','Female','Combat','Earth');
INSERT INTO kharacter VALUES ('Captain America','Modern','Steve Rogers','Human','Hero','Male','Strength Endurance','Earth');
INSERT INTO kharacter VALUES ('Cyclops','Modern','Scott Summers','Mutant','Hero','Male','Lasers','Earth');
INSERT INTO kharacter VALUES ('Doctor Doom','Modern','Viktor Krumm','Human','Villian','Male','Technopathy Genius Flight Force Fields','Earth');
INSERT INTO kharacter VALUES ('Doctor Octopus','Modern','Otto Gunther Octavius','Human','Villian','Male','Genius','Earth');
INSERT INTO kharacter VALUES ('The Flash','Modern','Wally West','Human','Hero','Male','Speed','Earth');
INSERT INTO kharacter VALUES ('The Flash','Silver','Barry Allen','Human','Hero','Male','Speed','Earth');
INSERT INTO kharacter VALUES ('Green Lantern','Modern','Kyle Rayner','Human','Hero','Male','Power Ring Flight','Earth');
INSERT INTO kharacter VALUES ('Green Lantern','Silver','Hal Jordan','Human','Hero','Male','Power Ring Flight','Earth');
INSERT INTO kharacter VALUES ('Hawkeye','Modern','Clint Barton','Human','Hero','Male','Archery','Earth');
INSERT INTO kharacter VALUES ('Hulk','Modern','Bruce Banner','Human','Hero','Male','Genius Strength','Earth');
INSERT INTO kharacter VALUES ('Human Torch','Modern','Johnny Storm','Human','Hero','Male','Pyrokinesis','Earth');
INSERT INTO kharacter VALUES ('Iceman','Modern','Bobby Drake','Mutant','Hero','Male','Thermal Vision Tranform to Ice Generate Ice','Earth');
INSERT INTO kharacter VALUES ('Invisible Woman','Modern','Susan Storm','Human','Hero','Female','Force Fields','Earth');
INSERT INTO kharacter VALUES ('Iron Man','Modern','Tony Stark','Human','Hero','Male','Genius Money','Earth');
INSERT INTO kharacter VALUES ('Magneto','Modern','Erik Lehnsherr','Mutant','Hero','Male','Magnetism','Earth');
INSERT INTO kharacter VALUES ('Mister Fantastic','Modern','Reed Richards','Human','Hero','Male','Genius Elasticity','Earth');
INSERT INTO kharacter VALUES ('Phoenix','Modern','Jean Grey','Mutant','Hero','Female','Telekinesis Telepathy Phoenix Force','Earth');
INSERT INTO kharacter VALUES ('Professor X','Modern','Charles Xavier','Mutant','Hero','Male','Telepathy','Earth');
INSERT INTO kharacter VALUES ('Quicksilver','Modern','Pietro Maximoff','Mutant','Hero','Male','Speed','Earth');
INSERT INTO kharacter VALUES ('Scarlet Witch','Modern','Wanda Maximoff','Mutant','Hero','Female','Reality Warping','Earth');
INSERT INTO kharacter VALUES ('Storm','Modern','Ororo Monroe','Mutant','Hero','Female','Weather Control Flight','Earth');
INSERT INTO kharacter VALUES ('Superman','Modern','Clark Kent','Kryptonian','Hero','Male','Strength Flight','Krypton');
INSERT INTO kharacter VALUES ('The Thing','Modern','Ben Grimm','Human','Hero','Male','Strength Endurance','Earth');
INSERT INTO kharacter VALUES ('Thor','Modern','Thor Odinson','Asgardian','Hero','Male','Mjolnr God','Asgard');
INSERT INTO kharacter VALUES ('Wolverine','Modern','Logan Howlett','Mutant','Hero','Male','Healing Factor','Earth');
INSERT INTO kharacter VALUES ('Wonder Woman','Modern','Princess Diana of Themyscira','Amazon','Hero','Female','Strength Agility Flight Endurance','Earth');

-- creator
INSERT INTO creator VALUES ('Bill Finger','Author');
INSERT INTO creator VALUES ('Bob Kane','Illustrator');
INSERT INTO creator VALUES ('Carl Burgos','Illustrator');
INSERT INTO creator VALUES ('Carl Burgos','Author');
INSERT INTO creator VALUES ('Dave Cockrum','Illustrator');
INSERT INTO creator VALUES ('Don Heck','Illustrator');
INSERT INTO creator VALUES ('Don Rico','Illustrator');
INSERT INTO creator VALUES ('Gardner Fox','Author');
INSERT INTO creator VALUES ('Gil Kane','Illustrator');
INSERT INTO creator VALUES ('Herb Trimpe','Illustrator');
INSERT INTO creator VALUES ('Harry Lampert','Illustrator');
INSERT INTO creator VALUES ('Jack Kirby','Illustrator');
INSERT INTO creator VALUES ('Jerry Siegel','Author');
INSERT INTO creator VALUES ('Joe Shuster','Illustrator');
INSERT INTO creator VALUES ('Joe Simon','Author');
INSERT INTO creator VALUES ('John Broome','Author');
INSERT INTO creator VALUES ('John Romita, Sr.','Illustrator');
INSERT INTO creator VALUES ('Larry Lieber','Author');
INSERT INTO creator VALUES ('Len Wein','Author');
INSERT INTO creator VALUES ('Martin Nodell','Illustrator');
INSERT INTO creator VALUES ('Paul Norris','Illustrator');
INSERT INTO creator VALUES ('Roy Thomas','Author');
INSERT INTO creator VALUES ('Stan Lee','Author');
INSERT INTO creator VALUES ('Steve Ditko','Illustrator');
INSERT INTO creator VALUES ('William Moulton Maston','Author');

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
INSERT INTO fight VALUES ('Battle of New York','Modern','Avengers');
INSERT INTO fight VALUES ('Battle of Sokovia','Modern','Avengers');
INSERT INTO fight VALUES ('Infinite Crisis','Modern','Justice League');
INSERT INTO fight VALUES ('M-Day Genosha Decimation','Modern','None');
INSERT INTO fight VALUES ('Wolverine vs. Sabretooth','Modern','Wolverine');

-- team
INSERT INTO team VALUES ('Avengers','Modern','Hero','Avengers Mansion');
INSERT INTO team VALUES ('Brotherhood of Mutants','Modern','Villain','Various');
INSERT INTO team VALUES ('Fantastic Four','Modern','Hero','Baxter Building');
INSERT INTO team VALUES ('Justice League','Modern','Hero','The Hall The Satellite');
INSERT INTO team VALUES ('Sinister Six','Modern','Villain','New York');
INSERT INTO team VALUES ('X-Men','Modern','Hero','X-Mansion');

-- distributesMedium
INSERT INTO distributesMedium VALUES ('Adventures of Superman','Warner Bros. Television Distribution');
INSERT INTO distributesMedium VALUES ('The Avengers: Volume 1','Marvel Comics');
INSERT INTO distributesMedium VALUES ('The Avengers: Volume 2','Marvel Comics');
INSERT INTO distributesMedium VALUES ('The Avengers: United They Stand','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('The Avengers: Earths Mightiest Heroes','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('The Avengers','Marvel Studios');
INSERT INTO distributesMedium VALUES ('Avengers: Age Of Ultron','Marvel Studios');
INSERT INTO distributesMedium VALUES ('The Dark Knight Rises','Warner Bros. Pictures');
INSERT INTO distributesMedium VALUES ('Essential Fantastic Four: Volume 1','Marvel Comics');
INSERT INTO distributesMedium VALUES ('Fantastic Four (1994)','Disney–ABC Domestic Television');
INSERT INTO distributesMedium VALUES ('Fantastic Four','20th Century Fox');
INSERT INTO distributesMedium VALUES ('Justice League','Warner Bros. Television Distribution');
INSERT INTO distributesMedium VALUES ('Spider-Man 2','Columbia Pictures');
INSERT INTO distributesMedium VALUES ('The Superman Chronicles: Volume 1','DC Comics');
INSERT INTO distributesMedium VALUES ('The Superman Chronicles: Volume 2','DC Comics');
INSERT INTO distributesMedium VALUES ('X-Men','20th Century Fox');
INSERT INTO distributesMedium VALUES ('X-Men: The Last Stand','20th Century Fox');
INSERT INTO distributesMedium VALUES ('X-Men Origins: Wolverine','20th Century Fox');
INSERT INTO distributesMedium VALUES ('X-Men: First Class','20th Century Fox');
INSERT INTO distributesMedium VALUES ('X-Men: Days of Future Past','20th Century Fox');
INSERT INTO distributesMedium VALUES ('X-Men (1992)','Genesis Entertainment');

-- book
INSERT INTO book VALUES ('The Avengers: Volume 1','978-0-7851-3706-1','Stan Lee','2009-05-13','Graphic Novel');
INSERT INTO book VALUES ('The Avengers: Volume 2','978-0-7851-3708-5','Stan Lee','2009-10-14','Graphic Novel');
INSERT INTO book VALUES ('Essential Fantastic Four: Volume 1','978-0-7851-1828-4','Martin Goodman','2005-05-25','Graphic Novel');
INSERT INTO book VALUES ('The Superman Chronicles: Volume 1','978-1-4012-0764-9','Jerry Siegel','2006-02-22','Graphic Novel');
INSERT INTO book VALUES ('The Superman Chronicles: Volume 2','978-1-4012-1215-5','Jerry Siegel','2007-02-07','Graphic Novel');

-- movie
INSERT INTO movie VALUES ('The Avengers','Joss Whedon','2012-05-04','FALSE',1519000000);
INSERT INTO movie VALUES ('Avengers: Age Of Ultron','Joss Whedon','2015-05-01','FALSE',1348000000);
INSERT INTO movie VALUES ('The Dark Knight Rises','Christopher Nolan','2012-07-20','FALSE',1084000000);
INSERT INTO movie VALUES ('Fantastic Four', 'Tim Story', '2005-7-8', 'FALSE', 330600000);
INSERT INTO movie VALUES ('Spider-Man 2','Sam Raimi','2004-06-30','FALSE',783800000);
INSERT INTO movie VALUES ('X-Men','Bryan Singer','2000-07-14','FALSE',296300000);
INSERT INTO movie VALUES ('X-Men: The Last Stand','Brett Ratner','2006-05-26','FALSE',459300000);
INSERT INTO movie VALUES ('X-Men Origins: Wolverine','Gavin Hood','2009-05-01','FALSE',373000000);
INSERT INTO movie VALUES ('X-Men: First Class','Matthew Vaughn','2011-06-03','FALSE',353600000);
INSERT INTO movie VALUES ('X-Men: Days of Future Past','Bryan Singer','2013-05-23','FALSE',748100000);

-- tvSeries
INSERT INTO tvSeries VALUES ('Adventures of Superman','1952-09-19','Whitney Ellsworth');
INSERT INTO tvSeries VALUES ('The Avengers: United They Stand','1999-10-30','Avi Arad');
INSERT INTO tvSeries VALUES ('The Avengers: Earths Mightiest Heroes','2010-09-22','Simon Philips');
INSERT INTO tvSeries VALUES ('Fantastic Four (1994)','1994-09-24','Avi Arad');
INSERT INTO tvSeries VALUES ('Justice League', '2001-11-17', 'Bruce Timm');
INSERT INTO tvSeries VALUES ('X-Men (1992)','1992-10-31','Larry Houston');

-- creates
INSERT INTO creates VALUES ('Aquaman','Modern','Paul Norris','Illustrator');
INSERT INTO creates VALUES ('Archangel','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Archangel','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Batman','Modern','Bill Finger','Author');
INSERT INTO creates VALUES ('Batman','Modern','Bob Kane','Illustrator');
INSERT INTO creates VALUES ('Beast','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Beast','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Black Widow','Modern','Don Rico','Illustrator');
INSERT INTO creates VALUES ('Black Widow','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Black Widow','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Captain America','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Captain America','Modern','Joe Simon','Author');
INSERT INTO creates VALUES ('Cyclops','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Cyclops','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Doctor Doom','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Doctor Doom','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Doctor Octopus','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Doctor Octopus','Modern','Steve Ditko','Illustrator');
INSERT INTO creates VALUES ('The Flash','Modern','Gardner Fox','Author');
INSERT INTO creates VALUES ('The Flash','Silver','Gardner Fox','Author');
INSERT INTO creates VALUES ('The Flash','Modern','Harry Lampert','Illustrator');
INSERT INTO creates VALUES ('The Flash','Silver','Harry Lampert','Illustrator');
INSERT INTO creates VALUES ('Green Lantern','Modern','John Broome','Author');
INSERT INTO creates VALUES ('Green Lantern','Silver','John Broome','Author');
INSERT INTO creates VALUES ('Green Lantern','Modern','Gil Kane','Illustrator');
INSERT INTO creates VALUES ('Green Lantern','Silver','Gil Kane','Illustrator');
INSERT INTO creates VALUES ('Green Lantern','Modern','Bill Finger','Author');
INSERT INTO creates VALUES ('Green Lantern','Silver','Bill Finger','Author');
INSERT INTO creates VALUES ('Green Lantern','Modern','Martin Nodell','Illustrator');
INSERT INTO creates VALUES ('Green Lantern','Silver','Martin Nodell','Illustrator');
INSERT INTO creates VALUES ('Hawkeye','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Hawkeye','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Hulk','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Hulk','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Human Torch','Modern','Carl Burgos','Illustrator');
INSERT INTO creates VALUES ('Human Torch','Modern','Carl Burgos','Author');
INSERT INTO creates VALUES ('Iceman','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Iceman','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Invisible Woman','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Invisible Woman','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Iron Man','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Iron Man','Modern','Larry Lieber','Author');
INSERT INTO creates VALUES ('Iron Man','Modern','Don Heck','Illustrator');
INSERT INTO creates VALUES ('Iron Man','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Magneto','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Magneto','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Mister Fantastic','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Mister Fantastic','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Phoenix','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Phoenix','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Professor X','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Professor X','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Quicksilver','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Quicksilver','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Scarlet Witch','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Scarlet Witch','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Storm','Modern','Dave Cockrum','Illustrator');
INSERT INTO creates VALUES ('Storm','Modern','Len Wein','Author');
INSERT INTO creates VALUES ('Superman','Modern','Joe Shuster','Illustrator');
INSERT INTO creates VALUES ('Superman','Modern','Jerry Siegel','Author');
INSERT INTO creates VALUES ('The Thing','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('The Thing','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Thor','Modern','Stan Lee','Author');
INSERT INTO creates VALUES ('Thor','Modern','Larry Lieber','Author');
INSERT INTO creates VALUES ('Thor','Modern','Jack Kirby','Illustrator');
INSERT INTO creates VALUES ('Wolverine','Modern','Roy Thomas','Author');
INSERT INTO creates VALUES ('Wolverine','Modern','Len Wein','Author');
INSERT INTO creates VALUES ('Wolverine','Modern','John Romita, Sr.','Illustrator');
INSERT INTO creates VALUES ('Wolverine','Modern','Herb Trimpe','Illustrator');
INSERT INTO creates VALUES ('Wonder Woman','Modern','William Moulton Maston','Author');

-- makesUp
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Thor');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Captain America');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Black Widow');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Iron Man');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Hawkeye');
INSERT INTO makesUp VALUES ('Avengers','Modern','Modern','Hulk');
INSERT INTO makesUp VALUES ('Brotherhood of Mutants','Modern','Modern','Magneto');
INSERT INTO makesUp VALUES ('Brotherhood of Mutants','Modern','Modern','Quicksilver');
INSERT INTO makesUp VALUES ('Brotherhood of Mutants','Modern','Modern','Scarlet Witch');
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
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','Superman','Modern');
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','Batman','Modern');
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','Wonder Woman','Modern');
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','The Flash','Modern');
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','Green Lantern','Modern');
INSERT INTO participatesIn VALUES ('Infinite Crisis','Modern','Aquaman','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Scarlet Witch','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Beast','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Quicksilver','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Magneto','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Professor X','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Iceman','Modern');
INSERT INTO participatesIn VALUES ('M-Day Genosha Decimation','Modern','Archangel','Modern');
INSERT INTO participatesIn VALUES ('Wolverine vs. Sabretooth','Modern','Wolverine','Modern');

-- appearsIn
INSERT INTO appearsIn VALUES ('Archangel','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Aquaman','Modern','Justice League');
INSERT INTO appearsIn VALUES ('Batman','Modern','Justice League');
INSERT INTO appearsIn VALUES ('Batman','Modern','The Dark Knight Rises');
INSERT INTO appearsIn VALUES ('Beast','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Black Widow','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Black Widow','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Captain America','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Earths Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Captain America','Modern','The Avengers: Volume 2');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men (1992)');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men Origins: Wolverine');
INSERT INTO appearsIn VALUES ('Cyclops','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Doctor Doom','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Doctor Doom','Modern','Essential Fantastic Four: Volume 1');
INSERT INTO appearsIn VALUES ('Doctor Octopus','Modern','Spider-Man 2');
INSERT INTO appearsIn VALUES ('The Flash','Modern','Justice League');
INSERT INTO appearsIn VALUES ('The Flash','Silver','Justice League');
INSERT INTO appearsIn VALUES ('Green Lantern','Modern','Justice League');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Hawkeye','Modern','The Avengers: Earths Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Hulk','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Hulk','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Human Torch','Modern','Fantastic Four (1994)');
INSERT INTO appearsIn VALUES ('Iceman','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Invisible Woman','Modern','Fantastic Four (1994)');
INSERT INTO appearsIn VALUES ('Invisible Woman','Modern','Essential Fantastic Four: Volume 1');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Earths Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Iron Man','Modern','The Avengers: Volume 2');
INSERT INTO appearsIn VALUES ('Mister Fantastic','Modern','Fantastic Four (1994)');
INSERT INTO appearsIn VALUES ('Phoenix','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Quicksilver','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Scarlet Witch','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men (1992)');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men: Days of Future Past');
INSERT INTO appearsIn VALUES ('Storm','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Superman','Modern','Adventures of Superman');
INSERT INTO appearsIn VALUES ('Superman','Modern','The Superman Chronicles: Volume 1');
INSERT INTO appearsIn VALUES ('Superman','Modern','The Superman Chronicles: Volume 2');
INSERT INTO appearsIn VALUES ('Superman','Modern','Justice League');
INSERT INTO appearsIn VALUES ('The Thing','Modern','Fantastic Four (1994)');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Earths Mightiest Heroes');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers');
INSERT INTO appearsIn VALUES ('Thor','Modern','Avengers: Age Of Ultron');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Volume 1');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: Volume 2');
INSERT INTO appearsIn VALUES ('Thor','Modern','The Avengers: United They Stand');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: The Last Stand');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men Origins: Wolverine');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: First Class');
INSERT INTO appearsIn VALUES ('Wolverine','Modern','X-Men: Days of Future Past');
INSERT INTO appearsIn VALUES ('Wonder Woman','Modern','Justice League');
