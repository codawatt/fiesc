1. Analizați fiecare exemplu din laborator și specificați în limbaj natural ce reprezintă fiecare.

2. Afișați nivelul de salarizare pe care îl deține fiecare angajat din tabelul employees conform tabelului ZE_nivel_salarizare.

	SELECT e.employee_id, e.last_name ||' '|| e.first_name as Nume, e.salary, z.nivel
	FROM employees e, ze_nivel_salarizare z
	WHERE e.salary >= z.salar_min and e.salary <= z.salar_max

	107 rows selected.

3. Afișați câți angajați se încadrează în fiecare nivel de salarizare.

	SELECT z.nivel, COUNT(e.employee_id) nr_angajati
	FROM employees e
	JOIN ZE_nivel_salarizare z
	ON e.salary BETWEEN z.salar_min AND z.salar_max
	GROUP BY z.nivel
	ORDER BY z.nivel;

	6 rows selected.
4. Să se afișeze numele, salariul, nivelul de salarizare și numele job-ului pentru angajații din
departamentul 50.

	SELECT e.department_id, e.last_name || ' ' || e.first_name, e.salary, z.nivel, j.job_title
	FROM employees e
	JOIN jobs j ON j.job_id = e.job_id
	JOIN ze_nivel_salarizare z ON e.salary BETWEEN z.salar_min AND z.salar_max
	WHERE e.department_id = 50

	45 rows selected.

5. Afișați prenumele, numele, departamentul și salariul pentru toți angajații din firmă care au
un salariu mai mare decât 6500.

	SELECT first_name, last_name, department_id, salary
	FROM employees
	WHERE salary > 6500;

	49 rows selected.

6. Afișați doar angajații din firma care nu sunt asociați cu niciun departament.

	SELECT first_name, last_name, department_id, salary
	FROM employees
	WHERE department_id IS NULL;

	1 row selected.

7. Afișați numele, prenumele și numele jobului pentru angajații care au același job și manager
cu angajații 198 și 109 și care au un salariu mai mare decât 3000.

	SELECT e.last_name, e.first_name, j.job_title
	FROM employees e
	JOIN jobs j ON j.job_id = e.job_id
	WHERE (e.job_id, e.manager_id) IN
		(SELECT job_id, manager_id
		FROM employees
		WHERE employee_id IN (198,109))
	AND salary > 3000;

	6 rows selected.

8. Afișați numele, identificatorul departamentului și salariul pentru angajații al căror
departament și manager, corespund cu al angajaților care nu primesc comision și au un
salariu mai mare de 4000. Rezolvați această problemă folosind compararea împerecheată.

	SELECT last_name || ' ' || first_name as Nume, department_id, salary
	FROM employees
	WHERE (manager_id, department_id) IN 
	(SELECT manager_id, department_id 
	FROM employees
	WHERE  commission_pct IS NULL AND salary > 4000);

	34 rows selected.

9. Afișați numele, numele departamentului și salariul angajaților al căror salariu și comision
corespund salariului și comisionului oricărui angajat care lucrează în aceeași locație cu
identificatorul 1700.

	SELECT e.last_name || ' ' || e.first_name as Nume, d.department_name, e.salary
	FROM employees e
	JOIN departments d ON d.department_id = e.department_id
	WHERE (e.salary, NVL(e.commission_pct,0)) IN 
	(SELECT e2.salary, NVL(e2.commission_pct,0)
	FROM employees e2
	JOIN departments d2 ON d2.department_id = e2.department_id
	WHERE d2.location_id = 1700);
	
	36 rows selected.

10. Scrieți o interogare care să afișeze numele angajaților care au unul sau mai mulți colegi
în departament cu date de angajare mai recente și salarii mai mari, ordonati după
departament.

	SELECT e.last_name
	FROM employees e
	WHERE EXISTS 
	(SELECT e2.last_name
	FROM employees e2
	WHERE e.department_id = e2.department_id
	AND e2.hire_date > e.hire_date
	AND e2.salary > e.salary)
	ORDER BY e.department_id;
	
	70 rows selected.
11. Scrieți o interogare care să afișeze numele angajaților care câștigă mai mult decât media
salariilor din departamentul în care lucrează. Afișați în interogare și media.

	SELECT last_name, salary,department_id,
	(SELECT AVG(salary)
	FROM employees
	WHERE department_id = e.department_id) Media
	FROM employees e
	WHERE salary >
	(SELECT AVG(salary)
	FROM employees
	WHERE department_id = e.department_id);

	38 rows selected.

12. Rescrieți exercițiul anterior folosind clauza WITH.

	WITH medie_dep AS
	(SELECT department_id,AVG(salary) Media
	FROM employees
	GROUP BY department_id)
	SELECT e.last_name,	e.salary,e.department_id,d.Media
	FROM employees e
	JOIN medie_dep d
	ON e.department_id = d.department_id
	WHERE e.salary > d.Media;

	38 rows selected.

13. Utilizând clauza WITH, scrieți o interogare care să afișeze denumirea acelor job-uri pentru
care salariul maxim câștigat este mai mare decât jumătate din cel mai mare salariu din
companie.
	WITH max_company AS
	(SELECT MAX(salary) max_sal
	FROM employees),
	job_max AS
	(SELECT job_id, MAX(salary) max_job
	FROM employees
	GROUP BY job_id)
	SELECT job_id
	FROM job_max, max_company
	WHERE max_job > max_sal/2;

	6 rows selected.

14. Utilizând vederile inline, afișați următoarele informații despre departamente: numele,
numărul de angajați și identificatorul locației.
	SELECT d.department_name, a.nr_angajati, d.location_id
	FROM departments d,
	(SELECT department_id, COUNT(employee_id) nr_angajati
	FROM employees
	GROUP BY department_id) a
	WHERE d.department_id = a.department_id;

	11 rows selected.

15. Studiați următorul exemplu și reconstituiți pe baza lui tabelele și coloanele. Ce reprezintă
acest script? Specificați ce tipuri de JOIN recunoașteți.
	SELECT
	flight.FlightId,
	flight.AirplaneId,
	flight.StartAirportId,
	startairport.Country as StartAirportCountry,
	startairport.City as StartAirportCity,
	flight.EndAirportId,
	endairport.Country as EndAirportCountry,
	endairport.City as EndAirportCity
	FROM Flight flight
	JOIN Airport startairport ON flight.StartAirportId = startairport.AirportId
	JOIN Airport endairport ON flight.EndAirportId = endairport.AirportId

	Inner JOIN

16. Studiați următorul exemplu și reconstituiți pe baza lui tabelele și coloanele implicate. Ce
reprezintă acest script? Specificați ce tipuri de JOIN recunoașteți.
	SELECT b.boat_id, b.boat_name, b.boat_type, count(r.rental_id) as total_rentals
	FROM boats b, rentals r
	WHERE b.boat_id = r.boat_id (+)
	GROUP BY b.boat_id, b.boat_name, b.boat_type
	ORDER BY total_rentals desc;

	Outer LEFT JOIN

17. Afișați departamentele care au mai mult de 5 angajați cu un salariu peste 5000.
	SELECT department_id
	FROM employees
	WHERE salary > 5000
	GROUP BY department_id
	HAVING COUNT(employee_id) > 5;

	2 rows selected.
18. Afișați angajații care câștigă mai mult decât managerul lor.
	SELECT e.last_name, e.salary
	FROM employees e
	JOIN employees m
	ON e.manager_id = m.employee_id
	WHERE e.salary > m.salary;

	2 rows selected.
19. Afișați toate joburile distincte care au mai mult de 3 angajați cu salariu peste medie
	SELECT job_id
	FROM employees
	WHERE salary > (SELECT AVG(salary) FROM employees)
	GROUP BY job_id
	HAVING COUNT(employee_id) > 3;

	4 rows selected.
20. Afisati angajații care nu au manager și au salarii mai mari decât salariul mediu al tuturor
angajaților
	SELECT last_name, salary
	FROM employees
	WHERE manager_id IS NULL
	AND salary > (SELECT AVG(salary) FROM employees);

	1 row selected;
21. Afisați cei mai bine plătiți angajați din fiecare department.

	SELECT last_name, department_id, salary
	FROM employees e
	WHERE salary =
	(SELECT MAX(salary)
	FROM employees
	WHERE department_id = e.department_id);

	11 rows selected.