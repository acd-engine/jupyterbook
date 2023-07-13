-- create view for Event extraction
create or replace
view acde_event as
select
	e.EVENTID as ori_id,
	e.EVENTID as ori_dbid,
	aep.productionid as ori_dbid_unf,
	aep.same_name_as_org,
	e.EVENT_NAME as title,
	e.UMBRELLA as umbrella,
	e.description as description,
    desc_src.DESCRIPTIONSOURCE as description_source,
	e.PART_OF_A_TOUR as part_of_a_tour,
	e.WORLD_PREMIER as world_premier,
	e.YYYYFIRST_DATE as event_start_year,
    e.YYYYFIRST_DATE, 
    e.MMFIRST_DATE, 
    e.DDFIRST_DATE,
	-- if((length(concat_ws('', e.YYYYFIRST_DATE, e.MMFIRST_DATE, e.DDFIRST_DATE)) = 0),
	-- null,
	-- concat_ws('', e.YYYYFIRST_DATE, e.MMFIRST_DATE, e.DDFIRST_DATE)) as first_date,
	case
		when e.YYYYLAST_DATE = '' then e.YYYYFIRST_DATE
		when e.YYYYLAST_DATE is null then e.YYYYFIRST_DATE
		else e.YYYYLAST_DATE
	end as event_end_year,
    e.YYYYLAST_DATE, 
    e.MMLAST_DATE, 
    e.DDLAST_DATE,
	-- if((length(concat_ws('', e.YYYYLAST_DATE, e.MMLAST_DATE, e.DDLAST_DATE)) = 0),
	-- null,
	-- concat_ws('', e.YYYYLAST_DATE, e.MMLAST_DATE, e.DDLAST_DATE)) as last_date,
	statusm.STATUS as status,
    e.VENUEID as venueid,
	event_txtnatl.text_nationality,
	event_prodnatl.production_nationality,
	event_ci.content_indicators,
    e.YYYYOPENING_NIGHT, e.MMOPENING_NIGHT, e.DDOPENING_NIGHT,
	-- if((length(concat_ws('', e.YYYYOPENING_NIGHT, e.MMOPENING_NIGHT, e.DDOPENING_NIGHT)) = 0),
	-- null,
	-- concat_ws('', e.YYYYOPENING_NIGHT, e.MMOPENING_NIGHT, e.DDOPENING_NIGHT)) as opening_night,
	e.ESTIMATED_DATES as estimated_dates,
	e.FURTHER_INFORMATION as further_information,
	e.review as review,
    e.YYYYDATE_ENTERED, 
    e.MMDATE_ENTERED, 
    e.DDDATE_ENTERED,
	-- if((length(concat_ws('', e.YYYYDATE_ENTERED, e.MMDATE_ENTERED, e.DDDATE_ENTERED)) = 0),
	-- null,
	-- concat_ws('', e.YYYYDATE_ENTERED, e.MMDATE_ENTERED, e.DDDATE_ENTERED)) as date_created,
    e.YYYYDATE_UPDATED, 
    e.MMDATE_UPDATED, 
    e.DDDATE_UPDATED,
	-- if((length(concat_ws('', e.YYYYDATE_UPDATED, e.MMDATE_UPDATED, e.DDDATE_UPDATED)) = 0),
	-- null,
	-- concat_ws('', e.YYYYDATE_UPDATED, e.MMDATE_UPDATED, e.DDDATE_UPDATED)) as date_modified,
	e.ENTERED_BY_USER as contributors_created,
	e.UPDATED_BY_USER as contributors_modified,
    concat("https://ausstage.edu.au/pages/event/", e.EVENTID) as ori_url,
	'AusStage' as data_source,
	'event' as _class,
	'event' as _class_ori
from
	ausstage.events e
left join ausstage.acde_event_production aep on
	e.EVENTID = aep.eventid
left join ausstage.statusmenu statusm on 
		e.STATUS = statusm.STATUSID
left join ausstage.descriptionsrc desc_src on 
		e.DESCRIPTION_SOURCE = desc_src.DESCRIPTIONSOURCEID
left join (
	select
		e.EVENTID ,
		concat('[', group_concat(distinct 
concat('"', cty.COUNTRYNAME, '"') separator ", "), ']') as text_nationality
	from
		ausstage.events e
	join ausstage.playevlink playel on
		e.EVENTID = playel.EVENTID
	left join ausstage.country cty on
		playel.COUNTRYID = cty.COUNTRYID
	group by
		e.EVENTID) event_txtnatl on
	event_txtnatl.EVENTID = e.EVENTID
left join (
	select
		e.EVENTID ,
		concat('[', group_concat(distinct 
concat('"', cty.COUNTRYNAME, '"') separator ", "), ']') as production_nationality
	from
		ausstage.events e
	join ausstage.productionevlink proel on
		e.EVENTID = proel.EVENTID
	left join ausstage.country cty on
		proel.COUNTRYID = cty.COUNTRYID
	group by
		e.EVENTID) event_prodnatl on
	event_prodnatl.EVENTID = e.EVENTID 
left join (select
	e.EVENTID ,
	concat('[', group_concat(distinct 
concat('"', ci.CONTENTINDICATOR, '"') separator ", "), ']') as content_indicators
from
	ausstage.events e
join ausstage.contentindicator ci on
	e.CONTENT_INDICATOR = ci.CONTENTINDICATORID
group by
		e.EVENTID) event_ci on event_ci.EVENTID = e.EVENTID;

-- events to contributors and functions
create or replace
view acde_event_contfunc as
select
	e.EVENTID ,
	cel.PRIMARY_CREATOR,
	cfp.PREFERREDTERM as contr_functions
from
	ausstage.events e
join ausstage.conevlink cel on
	e.EVENTID = cel.EVENTID
left join ausstage.contributorfunctpreferred cfp on
	cfp.CONTRIBUTORFUNCTPREFERREDID = cel.`FUNCTION`;

-- events to primary_genre & second_genre 
create or replace
view acde_event_genres as
select
	e.EVENTID ,
	pgc.GENRECLASS as primary_type,
	secgpref.PREFERREDTERM as secondary_type
from
	ausstage.events e
join ausstage.prigenreclass pgc on
	e.PRIMARY_GENRE = pgc.GENRECLASSID
left join ausstage.secgenreclasslink secgl on
	e.EVENTID = secgl.EVENTID
left join ausstage.secgenrepreferred secgpref on
	secgl.SECGENREPREFERREDID = secgpref.SECGENREPREFERREDID;

-- create view for Contributor extraction
create or replace
view acde_cont as
select  
	c.`CONTRIBUTORID` as `ori_id`,
    c.`CONTRIBUTORID` as `ori_dbid`,
    acu_ak.contributorid_unf_alsokwn as `ori_dbid_unf`,
	c.`display_name` as `display_name`,
	c.`LAST_NAME` as `family_name`,
    c.`middle_name` as `middle_name`,
	c.`FIRST_NAME` as `first_name`,
    if((length(concat_ws('', c.`FIRST_NAME`, c.`middle_name`)) = 0),
	null,
	concat_ws(' ', c.`FIRST_NAME`, c.`middle_name`)) as given_names,
	c.`prefix` as `prefix`,
	c.`suffix` as `suffix`,
	g.`GENDER` as `gender`,
	c.`NATIONALITY` as `nationality`,
	c.`OTHER_NAMES` as `alternative_names`,
    c.`ADDRESS` as `ori_address`,
	cty.`COUNTRYNAME` as `country`,
	s.`STATE` as `state`,
	c.`SUBURB` as `suburb`,
	c.`POSTCODE` as `postcode`,
	c.`EMAIL` as `email`,
	c.`notes` as `note`,
    c.`YYYYDATE_OF_BIRTH`, 
    c.`MMDATE_OF_BIRTH`, 
    c.`DDDATE_OF_BIRTH`,
	-- if((length(concat_ws('', c.`YYYYDATE_OF_BIRTH`, c.`MMDATE_OF_BIRTH`, c.`DDDATE_OF_BIRTH`)) = 0),
	-- null,
	-- concat_ws('', c.`YYYYDATE_OF_BIRTH`, c.`MMDATE_OF_BIRTH`, c.`DDDATE_OF_BIRTH`)) as date_birth,
    c.`YYYYDATE_OF_DEATH`, 
    c.`MMDATE_OF_DEATH`, 
    c.`DDDATE_OF_DEATH`,
	-- if((length(concat_ws('', c.`YYYYDATE_OF_DEATH`, c.`MMDATE_OF_DEATH`, c.`DDDATE_OF_DEATH`)) = 0),
	-- null,
	-- concat_ws('', c.`YYYYDATE_OF_DEATH`, c.`MMDATE_OF_DEATH`, c.`DDDATE_OF_DEATH`)) as date_death,
	c.`place_of_birth` as `place_of_birth_id`,
	c.`place_of_death` as `place_of_death_id`,
	c.`nla` as `nla`,
	c.`entered_date` as `date_created`,
	c.`ENTERED_BY_USER` as `contributors_created`,
	c.`updated_date` as `date_modified`,
	c.`UPDATED_BY_USER` as `contributors_modified`,
    concat("https://ausstage.edu.au/pages/contributor/", c.CONTRIBUTORID) as ori_url,
    'AusStage' as data_source,
    'person' as _class,
    'contributor' as _class_ori
from
	ausstage.contributor c
left join ausstage.acde_cont_unf_alsokwn acu_ak on
    c.CONTRIBUTORID = acu_ak.contributorid
left join ausstage.states s on
	c.STATE = s.STATEID
left join ausstage.country cty on
	c.COUNTRYID = cty.COUNTRYID
left join ausstage.gendermenu g on
	c.GENDER = g.GENDERID;
    
-- contributors to events, production and functions 
create or replace view acde_cont_evfunc as
select
	`cel`.`CONTRIBUTORID`,
	cel.EVENTID as eventid,
    e.title as event_title,
    aep.productionid,
	cel.PRIMARY_CREATOR as is_primary_creator,
	cel.NOTES as note,
	`cfp`.`PREFERREDTERM` as `title`,
    e.YYYYFIRST_DATE, 
    e.MMFIRST_DATE, 
    e.DDFIRST_DATE,
    e.YYYYLAST_DATE, 
    e.MMLAST_DATE, 
    e.DDLAST_DATE,
	e.venueid
from
	ausstage.conevlink cel
join ausstage.acde_event e on
	cel.EVENTID = e.ori_id
	and cel.CONTRIBUTORID is not null
left join ausstage.contributorfunctpreferred cfp on
	cfp.CONTRIBUTORFUNCTPREFERREDID = cel.`FUNCTION`
left join ausstage.acde_event_production aep on
	cel.EVENTID = aep.eventid ;  
    

-- create view for Organisation Extraction
create or replace view acde_org as
select
	o.ORGANISATIONID as ori_id,
    o.ORGANISATIONID as ori_dbid,
	aou_ak.organisationid_unf_alsokwn as ori_dbid_unf,
	o.NAME as primary_name,
	if(length(concat(trim(o.OTHER_NAMES1), trim(o.OTHER_NAMES2), trim(o.OTHER_NAMES3))) = 0,
	"",
	trim("; " from concat_ws("; ", o.OTHER_NAMES1, o.OTHER_NAMES2, o.OTHER_NAMES3))) as alternative_names, 
	o.ADDRESS as ori_address,
    c.COUNTRYNAME as country,
    s.STATE as state,
	o.SUBURB as suburb,	
	o.postcode as postcode,
	o.CONTACT as contact,
	if(length(concat(trim(o.PHONE1), trim(o.PHONE2), trim(o.PHONE3))) = 0,
	"",
	trim("; " from concat_ws("; ", o.PHONE1, o.PHONE2, o.PHONE3))) as phones, 
	o.FAX as fax,
	o.EMAIL as email,
	o.WEB_LINKS as web_links,
	o.notes as note,	
	ot.TYPE as organisation_type,
    o.yyyyfirst_date, 
    o.mmfirst_date, 
    o.ddfirst_date,
	-- if((length(concat_ws('', o.yyyyfirst_date, o.mmfirst_date, o.ddfirst_date)) = 0),
	-- null,
	-- concat_ws('', o.yyyyfirst_date, o.mmfirst_date, o.ddfirst_date)) as date_start,
    o.yyyylast_date, 
    o.mmlast_date, 
    o.ddlast_date,
	-- if((length(concat_ws('', o.yyyylast_date, o.mmlast_date, o.ddlast_date)) = 0),
	-- null,
	-- concat_ws('', o.yyyylast_date, o.mmlast_date, o.ddlast_date)) as date_end,
	o.place_of_origin as place_of_origin,
	o.place_of_demise as place_of_demise,
	o.nla as nla,
	o.UPDATED_BY_USER as contributors_modified,
	o.ENTERED_BY_USER as contributors_created,
	o.entered_date as date_created,
	o.updated_date as date_modified,
    concat("https://ausstage.edu.au/pages/organisation/", o.ORGANISATIONID) as ori_url,
    'AusStage' as data_source,
    'organization' as _class,
    'organisation' as _class_ori
from
	ausstage.organisation o
left join ausstage.acde_org_unf_alsokwn aou_ak on
	o.ORGANISATIONID = aou_ak.organisationid
left join ausstage.states s on
	o.STATE = s.STATEID
left join ausstage.country c on
	o.COUNTRYID = c.COUNTRYID
left join ausstage.organisation_type ot on
	o.ORGANISATION_TYPE_ID = ot.ORGANISATION_TYPE_ID;

-- orgnisations to events, production and artistic functions 
create or replace view acde_org_evfunc as
select
	o.ORGANISATIONID,
	oel.EVENTID as eventid,
	e.title as event_title,
	aep.productionid,
    e.YYYYFIRST_DATE, 
    e.MMFIRST_DATE, 
    e.DDFIRST_DATE,
    e.YYYYLAST_DATE, 
    e.MMLAST_DATE, 
    e.DDLAST_DATE,
	ofunct.ORGFUNCTION as function_title,
	'production' as function_type,
    e.venueid
from
	ausstage.organisation o
join ausstage.orgevlink oel on
	o.ORGANISATIONID = oel.ORGANISATIONID
join ausstage.acde_event e on
	e.ori_id = oel.EVENTID
join ausstage.orgfunctmenu ofunct on
	ofunct.ORGFUNCTIONID = oel.`FUNCTION`
left join ausstage.acde_event_production aep on
	oel.EVENTID = aep.eventid
union
select
	o.ORGANISATIONID,
	oel.EVENTID as eventid,
	e.title as event_title,
	aep.productionid,
    e.YYYYFIRST_DATE, 
    e.MMFIRST_DATE, 
    e.DDFIRST_DATE,
    e.YYYYLAST_DATE, 
    e.MMLAST_DATE, 
    e.DDLAST_DATE,
	cfp.PREFERREDTERM as function_title,
	'artistic' as function_type,
    e.venueid
from
	ausstage.organisation o
join ausstage.orgevlink oel on
	o.ORGANISATIONID = oel.ORGANISATIONID
join ausstage.acde_event e on
	e.ori_id = oel.EVENTID
join ausstage.contributorfunctpreferred cfp on
	cfp.CONTRIBUTORFUNCTPREFERREDID = oel.`ARTISTIC_FUNCTION`
left join ausstage.acde_event_production aep on
	oel.EVENTID = aep.eventid ;
    
    
set
session group_concat_max_len = 100000000;

-- create view for Item (resource) extraction
create or replace
view acde_item as

		
select
	i.ITEMID as ori_id,
	i.ITEMID as ori_dbid,
	i.CATALOGUEID as catalogue,
	ausstage.organisation.NAME as institution,
	i.ITEM_DESCRIPTION as description,
	i.DESCRIPTION_ABSTRACT as description_abstract,
	ausstage.condition.CONDITION as item_condition,
	i.DETAIL_COMMENTS as detail_comments,
	i.DONATED_PURCHASED as donated_purchased,
	i.AQUIRED_FROM as aquired_from,
	i.STORAGE as storage,
	i.PROVENANCE as provenance,
	i.SIGNIFICANCE as significance,
	i.COMMENTS as comments,
	i.ITEM_URL as item_url,
	i.FORMAT_EXTENT as format_extent,
	i.FORMAT_MEDIUM as format_medium,
	i.FORMAT_MIMETYPE as format_mimetype,
	i.`FORMAT` as format,
	i.IDENT_ISBN as ident_isbn,
	i.IDENT_ISMN as ident_ismn,
	i.IDENT_ISSN as ident_issn,
	i.IDENT_SICI as ident_sici,
	i.RIGHTS_ACCESS_RIGHTS as rights_access_rights,
	i.RIGHTS as rights,
	i.RIGHTS_HOLDER as rights_holder,
	i.TITLE as title,
	i.TITLE_ALTERNATIVE as alternative_titles,
	-- 	i.DC_CREATOR as dc_creator,
	i.CITATION as citation,
	i.DATE_NOTES as date_notes,
	i.PUBLISHER as publisher,
	i.PUBLISHER_LOCATION as publisher_location,
	i.VOLUME as volume,
	i.ISSUE as issue,
	i.PAGE as page,
	i.SOURCEID as sourceid,
	item_type_lov.DESCRIPTION as primary_type,
	item_sub_type_lov.DESCRIPTION as secondary_type,
	language_lov.DESCRIPTION as language,
	i.CREATED_DATE as created_date,
	i.COPYRIGHT_DATE as copyright_date,
	i.ISSUED_DATE as issued_date,
	i.ACCESSIONED_DATE as accessioned_date,
	i.TERMINATED_DATE as terminated_date,
	ici.content_indicators,
	isg.secondary_genres,
	i.ENTERED_BY_USER as contributors_created,
	i.ENTERED_DATE as date_created,
	i.MODIFIED_BY_USER as contributors_modified,
	i.MODIFIED_DATE as date_modified,
    concat("https://ausstage.edu.au/pages/resource/", i.ITEMID) as ori_url,
	'AusStage' as data_source,
	'resource' as _class,
	'item' as _class_ori
from
	ausstage.item i
left join ausstage.condition on
	i.ITEM_CONDITION_ID = ausstage.condition.CONDITION_ID
left join ausstage.organisation on
	i.INSTITUTIONID = ausstage.organisation.ORGANISATIONID
left join ausstage.lookup_codes language_lov on
	i.LANGUAGE_LOV_ID = language_lov.CODE_LOV_ID
left join ausstage.lookup_codes item_type_lov on
	i.ITEM_TYPE_LOV_ID = item_type_lov.CODE_LOV_ID
left join ausstage.lookup_codes item_sub_type_lov on
	i.ITEM_SUB_TYPE_LOV_ID = item_sub_type_lov.CODE_LOV_ID
left join (
	select
		i.ITEMID ,
		concat('[', group_concat(distinct 
concat('"', ci.CONTENTINDICATOR, '"') separator ", "), ']') as content_indicators
	from
		ausstage.item i
	join ausstage.itemcontentindlink icil on
		i.ITEMID = icil.ITEMID
	left join ausstage.contentindicator ci on
		icil.CONTENTINDICATORID = ci.CONTENTINDICATORID
	group by
		i.ITEMID) ici on
	ici.ITEMID = i.ITEMID
left join (
	select
		i.ITEMID ,
		concat('[', group_concat(distinct 
concat('"', secgpref.PREFERREDTERM, '"') separator ", "), ']') as secondary_genres
	from
		ausstage.item i
	join ausstage.itemsecgenrelink isgl on
		i.ITEMID = isgl.ITEMID
	left join ausstage.secgenrepreferred secgpref on
		isgl.SECGENREPREFERREDID = secgpref.SECGENREPREFERREDID
	group by
		i.ITEMID) isg on
	isg.ITEMID = i.ITEMID ;
    
-- create veiw data_sources 
create or replace
view acde_datasrc as
select
    dsrcel.DATASOURCEID as ori_id,
    dsrcel.DATASOURCEID as ori_dbid,
    dsrcel.DATASOURCEEVLINKID,
    dsrcel.EVENTID,
    concat(dsrc.DATASOURCE, " %% ", dsrcel.DATASOURCEDESCRIPTION) as title,	
	dsrcel.COLLECTION as is_collection,	
	dsrc.DATADESCRIPTION as description,
    "resource" as _class,
    "datasource" as _class_ori,
    "AusStage" as data_source
from
	ausstage.datasourceevlink dsrcel
left join ausstage.datasource dsrc on
		dsrcel.DATASOURCEID = dsrc.DATASOURCEID;
-- create view for Venue extraction
create or replace
view acde_venue as
select
	v.VENUEID as ori_id,
    v.VENUEID as ori_dbid,
	avu_ak.venueid_unf_alsokwn as ori_dbid_unf,
	v.VENUE_NAME as display_name,
	if(length(concat(trim(v.OTHER_NAMES1), trim(v.OTHER_NAMES2), trim(v.OTHER_NAMES3))) = 0,
	"",
	trim("; " from concat_ws("; ", trim(v.OTHER_NAMES1), trim(v.OTHER_NAMES2), trim(v.OTHER_NAMES3)))) as alternative_names, 
    v.POSTCODE as postcode,
	v.STREET as street,
	v.SUBURB as suburb,
	s.STATE as state,
    c.COUNTRYNAME as country,
	v.LONGITUDE as longitude,
	v.LATITUDE as latitude,
	v.CAPACITY as capacity,
	v.CONTACT as contact,
	v.PHONE as phone,
	v.FAX as fax,
	v.EMAIL as email,
	v.WEB_LINKS as web_links,
	v.notes as note,	
	v.REGIONAL_OR_METRO as regional_or_metro,
	v.radius as radius,
	v.elevation as elevation,
    v.yyyyfirst_date, 
    v.mmfirst_date, 
    v.ddfirst_date,
    v.yyyylast_date, 
    v.mmlast_date,
    v.ddlast_date,
	-- if((length(concat_ws('', v.yyyyfirst_date, v.mmfirst_date, v.ddfirst_date)) = 0),
	-- null,
	-- concat_ws('', v.yyyyfirst_date, v.mmfirst_date, v.ddfirst_date)) as date_start,
	-- if((length(concat_ws('', v.yyyylast_date, v.mmlast_date,v.ddlast_date)) = 0),
	-- null,
	-- concat_ws('', v.yyyylast_date, v.mmlast_date,v.ddlast_date)) as date_end,
	v.updated_date as date_modified,
	v.entered_date as date_created,
	v.ENTERED_BY_USER as contributors_created,
	v.UPDATED_BY_USER as contributors_modified,
    concat("https://ausstage.edu.au/pages/venue/", v.VENUEID) as ori_url,
    'AusStage' as data_source,
    'place' as _class,
    'venue' as _class_ori
from
	ausstage.venue v
left join ausstage.acde_venue_unf_alsokwn avu_ak on
	v.VENUEID = avu_ak.venueid
left join ausstage.states s on
	v.STATE = s.STATEID
left join ausstage.country c on
	v.COUNTRYID = c.COUNTRYID;
    
-- create view for raw work 
create or replace
view acde_work as
select	
	w.WORKID as ori_id,
    w.WORKID as ori_dbid,
	w.WORK_TITLE as title,
	w.ALTER_WORK_TITLE as alternative_titles,
	work_cty.country_of_work as country,
    w.yyyydate_first_known, 
    w.mmdate_first_known, 
    w.dddate_first_known,
	-- if((length(concat_ws('', w.yyyydate_first_known, w.mmdate_first_known, w.dddate_first_known)) = 0),
	-- null,
	-- concat_ws('', w.yyyydate_first_known, w.mmdate_first_known, w.dddate_first_known)) as date_first_known,
	w.ENTERED_DATE as date_created,
	w.ENTERED_BY_USER as contributors_created,
	w.MODIFIED_DATE as date_modified ,
	w.MODIFIED_BY_USER as contributors_modified,
    concat("https://ausstage.edu.au/pages/work/", w.WORKID) as ori_url,
    'AusStage' as data_source,
    'work' as _class,
    'work' as _class_ori
from
	ausstage.`work` w
left join (
	-- works to countries
	select
		w.WORKID,
		cty.COUNTRYNAME as country_of_work
	from
		ausstage.`work` w
	join ausstage.workcountrylink wctyl on
		w.WORKID = wctyl.workid
	left join ausstage.country cty on 
		wctyl.countryid = cty.COUNTRYID) work_cty on
	w.WORKID = work_cty.WORKID;

