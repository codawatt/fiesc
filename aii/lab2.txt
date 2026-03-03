1. Rulați următoarele instrucțiuni și analizați-le cu atenție. Specificați ce reprezintă
rezultatele obținute pentru fiecare caz în parte rescriindu-le cu operatorii GROUPING
SETS sau operatorii relaționali.

	a. SELECT department_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY department_id;

	12 rows selected.

	SELECT job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY job_id;

	19 rows selected.

	b. SELECT department_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY ROLLUP (department_id);

	13 rows selected

	c. SELECT department_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY CUBE (department_id);
	
	13 rows selected

	d. SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY department_id, job_id;

	20 rows selected.

	e. SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY ROLLUP (department_id, job_id) ;

	33 rows selected.

	f. SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY CUBE (department_id, job_id) ;

	52 rows selected.

	g. SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY department_id, ROLLUP ( job_id);

	32 rows selected.

	h. SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY department_id, CUBE (job_id);

	32 rows selected.

2. Ce se întâmplă dacă la exercițiul precedent subpunctele d,e și f inversați department_id
cu job_id?

lipseste totalul general

3. Rulați exemplele de la exercițiul 1 subpunctele e și g cu operatorul ROLLUP și specificați
care este diferența dintre ROLLUP și PARTIAL ROLLUP. Refaceți exemplele folosind
operatorii pe mulțimi potriviți.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
		FROM employees
		GROUP BY ROLLUP (department_id, job_id) ;
	33 rows selected.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
		FROM employees
		GROUP BY GROUPING SETS ( (department_id, job_id), department_id, ()) ;
	33 rows selected.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
		FROM employees
		GROUP BY department_id, ROLLUP( job_id);
	32 rows selected.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
		FROM employees
		GROUP BY GROUPING SETS ( (department_id, job_id), department_id) ;
	32 rows selected.

4. Rulați exemplele de la exercițiul 1 subpunctele f și h cu operatorul CUBE și specificați
care este diferența dintre CUBE și PARTIAL CUBE. Refaceți exemplele utilizând operatorii
pe mulțimi.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY CUBE (department_id, job_id) ;

	52 rows selected.

	SELECT department_id, job_id, SUM (salary), COUNT(employee_id)
	FROM employees
	GROUP BY GROUPING SETS ((department_id, job_id), (department_id), (job_id),());

	52 rows selected.

5. Se cere o analiză a totalului angajaților astfel:
a. pentru fiecare departament și tip de job;
b. pentru fiecare departament;
c. pentru fiecare job;
d. totalul general.
Rezolvați problema în două moduri.

	SELECT department_id, job_id, COUNT(employee_id)
	FROM employees
	GROUP BY  GROUPING SETS ((department_id, job_id),department_id, job_id, ());

	52 rows selected.

	SELECT department_id, job_id, COUNT(employee_id)
	FROM employees
	GROUP BY  CUBE (department_id, job_id);

	52 rows selected.

6. Creați o interogare care să permită analiza sumelor cheltuite cu salariile (salariu plus
comision acolo unde există) astfel:
a. la nivel de țară;
b. pentru fiecare țară la nivel de oraș;
c. pentru fiecare țară la nivel de oraș și de departament.
Rezolvați problema în două moduri.

	SELECT c.country_name, l.city, d.department_id,  SUM(e.salary + NVL(e.commission_pct, 0)) AS Suma
	FROM employees e 
	JOIN departments d on d.department_id = e.department_id
	JOIN locations l on l.location_id = d.location_id
	JOIN countries c on c.country_id = l.country_id
	GROUP BY c.country_name, ROLLUP (l.city, d.department_id);

	22 rows selected. 

7. Scrieți o interogare care să afișeze totalul salariilor angajaților subordonați fiecărui
manager cu manager_id mai mic decât 130, atât detaliat pe fiecare tip de job și manager,
cât și pentru fiecare manager.

	SELECT manager_id, job_id, SUM(salary) AS Suma
	FROM employees
	WHERE manager_id < 130
	GROUP BY manager_id, ROLLUP (job_id)

	35 rows selected. 

8. Scrieți o interogare care să calculeze suma salariilor pentru următoarele grupări:
a. department_id, manager_id, job_id;
b. department_id, job_id;
c. manager_id, job_id.

	SELECT manager_id, job_id, SUM(salary) AS Suma
	FROM employees
	GROUP BY GROUPING SETS ((department_id,manager_id,job_id), (department_id, job_id), (manager_id,job_id));

	85 rows selected.

9. Se cere o analiză a totalului angajaților și a mediei salariilor astfel:
a. la nivel de departament;
b. la nivel de job;
c. la nivel de manager;
d. totalul general.

	SELECT department_id, AVG (salary), COUNT(employee_id)
	FROM employees
	GROUP BY GROUPING SETS (department_id, job_id, manager_id, ());

	51 rows selected.

10. Scrieți o interogare care să afișeze numărul de angajați astfel:
- la nivel de țară,
- țară și oraș,
- țară, oraș și departament
- totalul general.

	SELECT c.country_name, l.city, d.department_id, AVG (e.salary), COUNT(e.employee_id)
	FROM employees e 
	JOIN departments d on d.department_id = e.department_id
	JOIN locations l on l.location_id = d.location_id
	JOIN countries c on c.country_id = l.country_id
	GROUP BY GROUPING SETS (d.department_id, job_id, manager_id, ());
	51 rows selected.

11. Filtrați rezultatul obținut la exercițiul 10 astfel încât să fie luați în considerare doar
angajații care lucrează în Statele Unite.

	SELECT c.country_name, l.city, d.department_id, AVG (e.salary),COUNT(employee_id)
	FROM employees e
	JOIN departments d ON d.department_id = e.department_id
	JOIN locations  l ON l.location_id   = d.location_id
	JOIN countries  c ON c.country_id    = l.country_id
	WHERE c.country_id ='US'
	GROUP BY c.country_name, ROLLUP (l.city, d.department_id);

	11 rows selected.

12. Filtrați rezultatul obținut la exercițiul 10 astfel încât să fie luați în considerare doar
angajații care lucrează în Statele Unite și care sunt subordonați managerilor cu
manager_id cuprins între 110 și 150.

	SELECT c.country_name, l.city, d.department_id, AVG (e.salary), COUNT(employee_id)
	FROM employees e
	JOIN departments d ON d.department_id = e.department_id
	JOIN locations  l ON l.location_id   = d.location_id
	JOIN countries  c ON c.country_id    = l.country_id
	WHERE c.country_id ='US' AND e.manager_id BETWEEN 110 AND 150
	GROUP BY c.country_name, ROLLUP (l.city, d.department_id);

	5 rows selected.