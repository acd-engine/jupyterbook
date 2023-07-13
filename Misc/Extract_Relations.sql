# for venue - venue
select
	av1.ori_id as subject_ori_id,
	av1.ori_dbid as subject_ori_dbid,
	av1.`_class` as subject__class,
	av1.`_class_ori` as subject__class_ori,
	av1.display_name as subject_label,
	av1.ori_url as subject_ori_url,
	vvl.NOTES as subject_note,
	av2.ori_id as object_ori_id,
	av2.ori_dbid as object_ori_dbid,
	av2.`_class` as object__class,
	av2.`_class_ori` as object__class_ori,
	av2.display_name as object_label,
	av2.ori_url as object_ori_url,
	vvl.childnotes as object_note,
	'Place_RelatedPlace' as relation_class,
	rl.parent_relation as predicate_term,
	rl.child_relation as predicate_reverse_term,
	vvl.VENUEVENUELINKID as ori_id,
	vvl.VENUEVENUELINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.venuevenuelink vvl
join ausstage.acde_venue av1 on
	vvl.VENUEID = av1.ori_dbid
join ausstage.acde_venue av2 on
	vvl.CHILDID = av2.ori_dbid
join ausstage.relation_lookup rl on
	rl.relationlookupid = vvl.relationlookupid ;

# for event - event
select
	ae1.ori_id as subject_ori_id,
	ae1.ori_dbid as subject_ori_dbid,
	ae1.`_class` as subject__class,
	ae1.`_class_ori` as subject__class_ori,
	ae1.title as subject_label,
	ae1.description as subject_description,
	ae1.ori_url as subject_ori_url,
	eel.NOTES as subject_note,
	ae2.ori_id as object_ori_id,
	ae2.ori_dbid as object_ori_dbid,
	ae2.`_class` as object__class,
	ae2.`_class_ori` as object__class_ori,
	ae2.title as object_label,
	ae2.description as object_description,
	ae2.ori_url as object_ori_url,
	eel.childnotes as object_note,
	'Event_RelatedEvent' as relation_class,
	rl.parent_relation as predicate_term,
	rl.child_relation as predicate_reverse_term,
	eel.EVENTEVENTLINKID as ori_id,
	eel.EVENTEVENTLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.eventeventlink eel
join ausstage.acde_event ae1 on
	eel.EVENTID = ae1.ori_dbid
join ausstage.acde_event ae2 on
	eel.CHILDID = ae2.ori_dbid
join ausstage.relation_lookup rl on
	rl.relationlookupid = eel.relationlookupid ;

# for contributor - event - function
select
	ac.ori_id  as subject_ori_id,
	ac.ori_dbid as subject_ori_dbid,
	ac.`_class` as subject__class,
	ac.`_class_ori` as subject__class_ori,
	ac.display_name as subject_label,
	ac.ori_url as subject_ori_url,
	ae.ori_id  as object_ori_id,
	ae.ori_dbid as object_ori_dbid,
	aep.productionid as object_ori_dbid_unf,
	ae.`_class` as object__class,
	ae.`_class_ori`  as object__class_ori,
	ae.title as object_label,
	ae.description as object_description,
	ae.ori_url as object_ori_url,
	cfp.PREFERREDTERM as 'function',
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	'contributed to' as predicate_term,
	'was contributed by' as predicate_reverse_term,
	'Person_RelatedEvent' as relation_class,
	cel.CONEVLINKID as ori_id,
	cel.CONEVLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.conevlink cel
join ausstage.acde_cont ac on
	cel.CONTRIBUTORID = ac.ori_dbid 
join ausstage.acde_event ae on
	cel.EVENTID = ae.ori_id
join ausstage.contributorfunctpreferred cfp on
	cfp.CONTRIBUTORFUNCTPREFERREDID = cel.`FUNCTION`
join ausstage.acde_event_production aep on
	aep.eventid = cel.EVENTID ;

# for contributor - organisation
select
	ac.ori_id  as subject_ori_id,
	ac.ori_dbid as subject_ori_dbid,
	ac.`_class` as subject__class,
	ac.`_class_ori` as subject__class_ori,
	ac.display_name as subject_label,
	ac.ori_url as subject_ori_url,
	ao.ori_id  as object_ori_id,
	ao.ori_dbid as object_ori_dbid,
	ao.`_class` as object__class,
	ao.`_class_ori` as object__class_ori,
	ao.primary_name as object_label,
	ao.ori_url as object_ori_url,
	col.DESCRIPTION as note,
	'worked in' as predicate_term,
	'was employed by' as predicate_reverse_term,
	'Person_RelatedOrganization' as relation_class,
	col.CONORGLINKID  as ori_id,
	col.CONORGLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.conorglink col
join ausstage.acde_cont ac  on
	col.CONTRIBUTORID = ac.ori_dbid
join ausstage.acde_org ao on
	col.ORGANISATIONID = ao.ori_dbid;

# for contributor - contributor
select
	ac1.ori_id  as subject_ori_id,
	ac1.ori_dbid as subject_ori_dbid,
	ac1.`_class` as subject__class,
	ac1.`_class_ori` as subject__class_ori,
	ac1.display_name as subject_label,
	ac1.ori_url as subject_ori_url,
	ccl.NOTES as subject_note,
	ac2.ori_id  as object_ori_id,
	ac2.ori_dbid as object_ori_dbid,
	ac2.`_class` as object__class,
	ac2.`_class_ori` as object__class_ori,
	ac2.display_name as object_label,
	ac2.ori_url as object_ori_url,
	ccl.childnotes as object_note,
	'Person_RelatedPerson' as relation_class,
	rl.parent_relation as predicate_term,
	rl.child_relation as predicate_reverse_term,
	ccl.CONTRIBCONTRIBLINKID  as ori_id,
	ccl.CONTRIBCONTRIBLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.contribcontriblink ccl
join ausstage.acde_cont ac1 on
	ccl.CONTRIBUTORID = ac1.ori_dbid
join ausstage.acde_cont ac2 on
	ccl.CONTRIBUTORID = ac2.ori_dbid
join ausstage.relation_lookup rl on
	rl.relationlookupid = ccl.relationlookupid ;

# for contributor - venue birth
select
	ac.ori_id as subject_ori_id,
	ac.ori_dbid as subject_ori_dbid,
	ac.`_class` as subject__class,
	ac.`_class_ori` as subject__class_ori,
	ac.display_name as subject_label, 
	ac.ori_url as subject_ori_url,
	av.ori_id as object_ori_id,
	av.ori_dbid as object_ori_dbid,
	av.`_class` as object__class,
	av.`_class_ori` as object__class_ori,
	av.display_name as object_label,
	av.ori_url as object_ori_url,
	'was born in' as predicate_term,
	'is the birthplace of' as predicate_reverse_term,
	'Person_RelatedPlace' as relation_class,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.acde_cont ac
join ausstage.acde_venue av on
	ac.place_of_birth_id = av.ori_dbid ;

# for contributor - venue death
select
	ac.ori_id as subject_ori_id,
	ac.ori_dbid as subject_ori_dbid,
	ac.`_class` as subject__class,
	ac.`_class_ori` as subject__class_ori,
	ac.display_name as subject_label, 
	ac.ori_url as subject_ori_url,
	av.ori_id as object_ori_id,
	av.ori_dbid as object_ori_dbid,
	av.`_class` as object__class,
	av.`_class_ori` as object__class_ori,
	av.display_name as object_label,
	av.ori_url as object_ori_url,
	'died in' as predicate_term,
	'is the deathplace of' as predicate_reverse_term,
	'Person_RelatedPlace' as relation_class,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.acde_cont ac
join ausstage.acde_venue av on
	ac.place_of_death_id = av.ori_dbid ;

# for org - org
select
	ao1.ori_id as subject_ori_id,
	ao1.ori_dbid as subject_ori_dbid,
	ao1.`_class` as subject__class,
	ao1.`_class_ori` as subject__class_ori,
	ao1.primary_name as subject_label,
	ao1.ori_url as subject_ori_url,
	ool.NOTES as subject_note,
	ao2.ori_id as object_ori_id,
	ao2.ori_dbid as object_ori_dbid,
	ao2.`_class` as object__class,
	ao2.`_class_ori` as object__class_ori,
	ao2.primary_name as object_label,
	ao2.ori_url as object_ori_url,
	ool.childnotes as object_note,
	'Organization_RelatedOrganization' as relation_class,
	rl.parent_relation as predicate_term,
	rl.child_relation as predicate_reverse_term,
	ool.ORGORGLINKID as ori_id,
	ool.ORGORGLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.orgorglink ool
join ausstage.acde_org ao1 on
	ool.ORGANISATIONID = ao1.ori_dbid
join ausstage.acde_org ao2 on
	ool.CHILDID = ao2.ori_dbid
left join ausstage.relation_lookup rl on
	rl.relationlookupid = ool.relationlookupid ;

# for org - event - function (production)
select
	ao.ori_id as subject_ori_id,
	ao.ori_dbid as subject_ori_dbid,
	ao.`_class` as subject__class,
	ao.`_class_ori` as subject__class_ori,
	ao.primary_name as subject_label,
	ao.ori_url as subject_ori_url,
	ae.ori_id as object_ori_id,
	ae.ori_dbid as object_ori_dbid,
	aep.productionid as object_ori_dbid_unf,
	ae.`_class` as object__class,
	ae.`_class_ori` as object__class_ori,
	ae.title as object_label,
	ae.description as object_description,
	ae.ori_url as object_ori_url,
	ofunct.ORGFUNCTION as 'function',
	'production' as 'function_type',
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	'contributed to' as predicate_term,
	'was contributed by' as predicate_reverse_term,
	'Organization_RelatedEvent' as relation_class,
	oel.ORGEVLINKID as ori_id,
	oel.ORGEVLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.orgevlink oel
join ausstage.acde_org ao on
	oel.ORGANISATIONID = ao.ori_dbid
join ausstage.acde_event ae on
	oel.EVENTID = ae.ori_id
join ausstage.orgfunctmenu ofunct on
	ofunct.ORGFUNCTIONID = oel.`FUNCTION`
left join ausstage.acde_event_production aep on
	aep.eventid = oel.EVENTID ;
	
# for org - event - function (artistic)
select
	ao.ori_id as subject_ori_id,
	ao.ori_dbid as subject_ori_dbid,
	ao.`_class` as subject__class,
	ao.`_class_ori` as subject__class_ori,
	ao.primary_name as subject_label,
	ao.ori_url as subject_ori_url,
	ae.ori_id as object_ori_id,
	ae.ori_dbid as object_ori_dbid,
	aep.productionid as object_ori_dbid_unf,
	ae.`_class` as object__class,
	ae.`_class_ori` as object__class_ori,
	ae.title as object_label,
	ae.description as object_description,
	ae.ori_url as object_ori_url,
	ofunct.ORGFUNCTION as 'function',
	'artistic' as 'function_type',
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	'contributed to' as predicate_term,
	'was contributed by' as predicate_reverse_term,
	'Organization_RelatedEvent' as relation_class,
	oel.ORGEVLINKID as ori_id,
	oel.ORGEVLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.orgevlink oel
join ausstage.acde_org ao on
	oel.ORGANISATIONID = ao.ori_dbid
join ausstage.acde_event ae on
	oel.EVENTID = ae.ori_id
join ausstage.orgfunctmenu ofunct on
	ofunct.ORGFUNCTIONID = oel.ARTISTIC_FUNCTION 
join ausstage.acde_event_production aep on
	aep.eventid = oel.EVENTID ;

# for event - venue
select
	ae.ori_id as subject_ori_id,
	ae.ori_dbid as subject_ori_dbid,
	ae.`_class` as subject__class,
	ae.`_class_ori` as subject__class_ori,
	ae.title as subject_label, 
	ae.ori_url as subject_ori_url,
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	av.ori_id as object_ori_id,
	av.ori_dbid as object_ori_dbid,
	av.`_class` as object__class,
	av.`_class_ori` as object__class_ori,
	av.display_name as object_label,
	av.ori_url as object_ori_url,
	'was hosted in' as predicate_term,
	'is the host place of' as predicate_reverse_term,
	'Event_RelatedPlace' as relation_class,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.acde_event ae
join ausstage.acde_venue av on
	ae.venueid = av.ori_dbid ;
	
# for event - work
select
	ae.ori_id  as subject_ori_id,
	ae.ori_dbid as subject_ori_dbid,
	ae.`_class` as subject__class,
	ae.`_class_ori` as subject__class_ori,
	ae.title as subject_label,
	ae.ori_url as subject_ori_url,
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	aw.ori_id  as object_ori_id,
	aw.ori_dbid as object_ori_dbid,
	aw.title as object_label,
	aw.ori_url as object_ori_url,
	aw.`_class` as object__class,
	aw.`_class_ori` as object__class_ori,
	'is adapted from' as predicate_term,
	'is the source material of' as predicate_reverse_term,
	'Event_RelatedWork' as relation_class,
	ewl.EVENTWORKLINKID  as ori_id,
	ewl.EVENTWORKLINKID  as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.eventworklink ewl
join ausstage.acde_event ae  on
	ewl.EVENTID = ae.ori_dbid
join ausstage.acde_work aw on
	ewl.WORKID  = aw.ori_dbid;
	
# for work - contributor workconlink
select
	aw.ori_id  as subject_ori_id,
	aw.ori_dbid as subject_ori_dbid,
	aw.`_class` as subject__class,
	aw.`_class_ori` as subject__class_ori,
	aw.title as subject_label,
	aw.ori_url as subject_ori_url,
	ac.ori_id  as object_ori_id,
	ac.ori_dbid as object_ori_dbid,
	ac.display_name as object_label,
	ac.ori_url as object_ori_url,
	ac.`_class` as object__class,
	ac.`_class_ori` as object__class_ori,
	'was performed by' as predicate_term,
	'has performed' as predicate_reverse_term,
	'Work_RelatedPerson' as relation_class,
	wcl.WORKCONLINKID  as ori_id,
	wcl.WORKCONLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.workconlink wcl
join ausstage.acde_work aw  on
	wcl.WORKID = aw.ori_dbid
join ausstage.acde_cont ac on
	wcl.CONTRIBUTORID = ac.ori_dbid;

# for work - organisation workorglink
select
	aw.ori_id  as subject_ori_id,
	aw.ori_dbid as subject_ori_dbid,
	aw.`_class` as subject__class,
	aw.`_class_ori` as subject__class_ori,
	aw.title as subject_label,
	aw.ori_url as subject_ori_url,
	ao.ori_id  as object_ori_id,
	ao.ori_dbid as object_ori_dbid,
	ao.primary_name as object_label,
	ao.ori_url as object_ori_url,
	ao.`_class` as object__class,
	ao.`_class_ori` as object__class_ori,
	'is produced by' as predicate_term,
	'produces' as predicate_reverse_term,
	'Work_RelatedOrganization' as relation_class,
	wol.WORKORGLINKID  as ori_id,
	wol.WORKORGLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.workorglink wol
join ausstage.acde_work aw  on
	wol.WORKID = aw.ori_dbid
join ausstage.acde_org ao on
	wol.ORGANISATIONID = ao.ori_dbid;

# for work - work workworklink
select
	aw1.ori_id  as subject_ori_id,
	aw1.ori_dbid as subject_ori_dbid,
	aw1.`_class` as subject__class,
	aw1.`_class_ori` as subject__class_ori,
	aw1.title as subject_label,
	aw1.ori_url as subject_ori_url,
	wwl.NOTES as subject_note,
	aw2.ori_id  as object_ori_id,
	aw2.ori_dbid as object_ori_dbid,
	aw2.`_class` as object__class,
	aw2.`_class_ori` as object__class_ori,
	aw2.title as object_label,
	aw2.ori_url as object_ori_url,
	wwl.childnotes as object_note,
	'Work_RelatedWork' as relation_class,
	rl.parent_relation as predicate_term,
	rl.child_relation as predicate_reverse_term,
	wwl.WORKWORKLINKID  as ori_id,
	wwl.WORKWORKLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.workworklink wwl
join ausstage.acde_work aw1 on
	wwl.WORKID = aw1.ori_dbid
join ausstage.acde_work aw2 on
	wwl.WORKID = aw2.ori_dbid
join ausstage.relation_lookup rl on
	rl.relationlookupid = wwl.relationlookupid ;
	
# for resource - resource acde_item.sourceid
select
	ai1.ori_id as subject_ori_id,
	ai1.ori_dbid as subject_ori_dbid,
	ai1.`_class` as subject__class,
	ai1.`_class_ori` as subject__class_ori,
	ai1.title as subject_label, 
	ai1.ori_url as subject_ori_url,
	ai2.ori_id as object_ori_id,
	ai2.ori_dbid as object_ori_dbid,
	ai2.`_class` as object__class,
	ai2.`_class_ori` as object__class_ori,
	ai2.title as object_label,
	ai2.ori_url as object_ori_url,
	'is the source of' as predicate_term,
	'is the citation of' as predicate_reverse_term,
	'Resource_RelatedResource' as relation_class,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.acde_item ai1 
join ausstage.acde_item ai2 on
	ai1.sourceid = ai2.ori_dbid ;

# for resource - work itemworklink
select
	ai.ori_id  as subject_ori_id,
	ai.ori_dbid as subject_ori_dbid,
	ai.`_class` as subject__class,
	ai.`_class_ori` as subject__class_ori,
	ai.title as subject_label,
	ai.ori_url as subject_ori_url,
	aw.ori_id  as object_ori_id,
	aw.ori_dbid as object_ori_dbid,
	aw.title as object_label,
	aw.ori_url as object_ori_url,
	aw.`_class` as object__class,
	aw.`_class_ori` as object__class_ori,
	'is reference of' as predicate_term,
	'refers to' as predicate_reverse_term,
	'Resource_RelatedWork' as relation_class,
	iwl.ITEMWORKLINKID  as ori_id,
	iwl.ITEMWORKLINKID  as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.itemworklink iwl
join ausstage.acde_item ai  on
	iwl.ITEMID = ai.ori_dbid
join ausstage.acde_work aw  on
	iwl.WORKID = aw.ori_dbid;

# for resource - venue itemvenuelink
select
	ai.ori_id  as subject_ori_id,
	ai.ori_dbid as subject_ori_dbid,
	ai.`_class` as subject__class,
	ai.`_class_ori` as subject__class_ori,
	ai.title as subject_label,
	ai.ori_url as subject_ori_url,
	av.ori_id  as object_ori_id,
	av.ori_dbid as object_ori_dbid,
	av.display_name as object_label,
	av.ori_url as object_ori_url,
	av.`_class` as object__class,
	av.`_class_ori` as object__class_ori,
	'is stored in' as predicate_term,
	'is the storage place of' as predicate_reverse_term,
	'Resource_RelatedPlace' as relation_class,
	ivl.ITEMVENUELINKID  as ori_id,
	ivl.ITEMVENUELINKID  as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.itemvenuelink ivl
join ausstage.acde_item ai  on
	ivl.ITEMID = ai.ori_dbid
join ausstage.acde_venue av on
	ivl.VENUEID = av.ori_dbid;

# for resource - person itemconlink
select
	ai.ori_id  as subject_ori_id,
	ai.ori_dbid as subject_ori_dbid,
	ai.`_class` as subject__class,
	ai.`_class_ori` as subject__class_ori,
	ai.title as subject_label,
	ai.ori_url as subject_ori_url,
	ac.ori_id  as object_ori_id,
	ac.ori_dbid as object_ori_dbid,
	ac.display_name as object_label,
	ac.ori_url as object_ori_url,
	ac.`_class` as object__class,
	ac.`_class_ori` as object__class_ori,
	'is related to' as predicate_term,
	'is related to' as predicate_reverse_term,
	'Resource_RelatedPerson' as relation_class,
	icl.ITEMCONLINKID  as ori_id,
	icl.ITEMCONLINKID  as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.itemconlink icl
join ausstage.acde_item ai  on
	icl.ITEMID = ai.ori_dbid
join ausstage.acde_cont ac on
	icl.CONTRIBUTORID = ac.ori_dbid;

# for resource - event datasourceevlink
select
	ad.ori_id  as subject_ori_id,
	ad.ori_dbid as subject_ori_dbid,
	ad.`_class` as subject__class,
	ad.`_class_ori` as subject__class_ori,
	ad.title as subject_label,
	ae.ori_id  as object_ori_id,
	ae.ori_dbid as object_ori_dbid,
	ae.title as object_label,
	ae.ori_url as object_ori_url,
	ae.`_class` as object__class,
	ae.`_class_ori` as object__class_ori,
    ae.YYYYFIRST_DATE as time_date_start_year, 
    ae.MMFIRST_DATE as time_date_start_month, 
    ae.DDFIRST_DATE as time_date_start_day,
    ae.YYYYLAST_DATE as time_date_end_year, 
    ae.MMLAST_DATE as time_date_end_month, 
    ae.DDLAST_DATE as time_date_end_day,
	'is the data source of' as predicate_term,
	'is sourced from' as predicate_reverse_term,
	'Resource_RelatedEvent' as relation_class,
	ad.DATASOURCEEVLINKID  as ori_id,
	ad.DATASOURCEEVLINKID as ori_dbid,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.acde_datasrc ad
join ausstage.acde_event ae on
	ad.EVENTID = ae.ori_dbid;
    
# for resource - organization institutionid
select
	i.ITEMID as subject_ori_id ,
	i.ITEMID as subject_ori_dbid ,
	i.TITLE  as subject_label,
	'resource' as subject__class,
	'item' as subject__class_ori,
	i.INSTITUTIONID  as object_ori_id ,
	i.INSTITUTIONID  as object_ori_dbid ,
	o.NAME as object_label,
	'organization' as object__class,
	'organisation' as object__class_ori,
	'is held by' as predicate_term,
	'holds' as predicate_reverse_term,
	'Resource_RelatedOrganization' as relation_class,
	"relationship" as _class,
	"AusStage" as data_source
from
	ausstage.organisation o
join ausstage.item i on
	i.INSTITUTIONID = o.ORGANISATIONID ;