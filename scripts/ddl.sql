/*
Here is the table creation script for our example database, testing.db
To use: 
  in a terminal, navigate to dir containing this script
  at zsh/bash prompt, run 'sqlite3 testing.db' to create the empty database
  at the sqlite3 prompt, run '.read ddl.sql' to create the following tables

*/


create table if not exists acep_regions (
    acep_region_id integer unique not null primary key,
    acep_region_name text
);

create table if not exists aea_regions (
    aea_region_id integer unique not null primary key,
    acep_region_id integer,
    aea_region_name text,
    foreign key(acep_region_id) references acep_regions(acep_region_id)
);

/*
create table if not exists interties (
    intertie_id integer unique not null primary key,
    intertie_name text,
    current_id integer,
    month_of_intertie integer,
    year_of_intertie integer,
    acep_region_id integer,
    source text,
    foreign key(acep_region_id) references acep_regions(acep_region_id)
);

create table if not exists utilities (
    utility_id integer unique not null primary key,
    utility_name text,
    intertie_id integer,
    foreign key(intertie_id) references interties(intertie_id)
);

create table if not exists communities (
    community_id integer unique not null primary key,
    community_name text,
    utility_id integer,
    foreign key(utility_id) references utilities(utility_id)
);

*/


/*
drop table regions;
drop table interties;
drop table utilities;
*/




