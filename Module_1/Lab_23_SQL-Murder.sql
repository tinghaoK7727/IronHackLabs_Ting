SELECT * 
FROM crime_scene_report
WHERE city = 'SQL City' AND type = 'murder';
# information on two witnesses and their addresses 'Franklin Ave' and 'Northwestern Dr'


SELECT * 
FROM interview 
JOIN person ON person.id = interview.person_id 
WHERE (name LIKE '%Annabel%' AND (address_street_name = 'Franklin Ave'))
OR (address_street_name = 'Northwestern Dr')
# locating witnesses: get fir now gym, gold, '48Z', 


SELECT *
FROM get_fit_now_member 
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE get_fit_now_member.membership_status = 'gold'
AND get_fit_now_member.id LIKE '%48Z%'
AND get_fit_now_check_in.check_in_date = '20180109';
# down to two suspects: Joe Germuska, Jeremy Bowers


SELECT *
FROM person
JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE drivers_license.plate_number LIKE '%H42W%' AND 
((person.name = 'Joe Germuska') OR (person.name ='Jeremy Bowers'));
# Jeremy Bowers is the murder