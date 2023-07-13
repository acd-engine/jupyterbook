DROP VIEW IF EXISTS acde_venue;
CREATE VIEW IF NOT EXISTS acde_venue
AS 
select
    'CircusOZ' as data_source,
    'place' as _class,
    'venue' as _class_ori,
    v."EVENT.NUMBER" as event_number,
	v."VENUE.NAME" as name,
	v."VENUE.ADDRESS" as address,
	v."VENUE.TYPE" as `type`
from
	VENUE v;
    
DROP VIEW IF EXISTS acde_person;
CREATE VIEW IF NOT EXISTS acde_person
AS
SELECT
    'CircusOZ' as data_source,
    'person' as _class,
    'person' as _class_ori,
	p."PERSON.NUMBER" as ori_id,
	p."FIRST.NAME" as given_names,
	p."SECOND.NAME" as family_name,
	p."COMBINED.NAME" as display_name,
	p."ALTERNATIVE.SPELLING (Discrepancy or inaccuracy)" as alternative_names
FROM
	PERSON p;
    
DROP VIEW IF EXISTS acde_pa;
CREATE VIEW IF NOT EXISTS acde_pa
AS
select
	pa."PERSON.NUMBER" as ori_id,
	pa."Contributor.ID_(AS)" as `id_(AS)`,
	pa."Gender_(AS)" as gender,
	pa."Contributor.Function.1_(AS)",
	pa."Contributor.Function.2_(AS)",
	pa."Contributor.Function.3_(AS)"
from
	PERSON_AS pa; 

DROP VIEW IF EXISTS acde_pc;
CREATE VIEW IF NOT EXISTS acde_pc
AS
select
    pc."PERSON.NUMBER" as ori_id,
	pc."Video.ID_(CO-vids)" as `videoid_(CO-vids)`,
	pc."Video.Id.description_(CO-clips)" as detailed_role,
	r."ROLE CATEGORIES"  as broad_role
from
	PERSON_CO pc
left join "ROLE" r on
	pc.`ROLE.NUMBER` = r."ROLE.NUMBER";

DROP VIEW IF EXISTS acde_pf;
CREATE VIEW IF NOT EXISTS acde_pf
AS
select
    pf."PERSON.NUMBER" as ori_id,
	pf."Personnel.Number_(FMP)" as `id_(FMP)`,
	trim(ifnull(pf."Personnel.Note.1_(FMP)", "") || ' ' || pf."Personnel.Note.2_(FMP)") as `notes_(FMP)`,
	r."ROLE CATEGORIES" as broad_role
from
	PERSON_FMP pf
left join "ROLE" r on
	pf.`ROLE.NUMBER` = r."ROLE.NUMBER";
    
DROP VIEW IF EXISTS acde_event;
CREATE VIEW IF NOT EXISTS acde_event
AS
select
    'CircusOZ' as data_source,
    'event' as _class,
    'event' as _class_ori,
	e."EVENT.NUMBER" as ori_id,
	"TYPE" as `type`,
	TITLE as title,
	ea."Alt.Event.Name_(AS)" as alternative_titles,
	"UMBRELLA.EVENT" as `umbrella_1`,
	"UMBRELLA.EVENT.2" as `umbrella_2`,
	strftime('%Y', "DATE.FROM.(General)") as date_start_year,
	strftime('%m', "DATE.FROM.(General)") as date_start_month,
	strftime('%d', "DATE.FROM.(General)") as date_start_day,
	strftime('%Y', "DATE.TO.(General)") as date_end_year,
	strftime('%m', "DATE.TO.(General)") as date_end_month,
	strftime('%d', "DATE.TO.(General)") as date_end_day,
	ea."Event.ID_(AS)" as `id_(AS)`,
	ea."Event.ID.Alt_(AS)" as `id_alt_(AS)`,
	ef."Category_(FMP)" as `category_(FMP)`,
	ef."Show.Name_(FMP)" as `show_name_(FMP)`,
	ef."Activity_(FMP)" as `type_(FMP)`,
	ef."Producer.Promoter_(FMP)" as `producer_promoter_(FMP)`,
	ef."Season.Number_(FMP)" as `season_number_(FMP)`,
	e."PERSON.NUMBER" as "person_number"
from
	EVENT e 
left join EVENT_AS ea on ea."EVENT.NUMBER" = e."EVENT.NUMBER" 
left join event_FMP ef on ef."EVENT.NUMBER" = e."EVENT.NUMBER" ;
