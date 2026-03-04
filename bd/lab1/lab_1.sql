1. Conectați-vă la serverul Oracle folosind iSQL*Plus.

	http://172.20.1.39/isqlplus

	Date de conectare:
	user: hr_ez
	pass: hr

2. Afișați și studiați structurile tabelelor Employees, Departments, Jobs și Locations.

	DESCRIBE EMPLOYEES;

	DESCRIBE DEPARTMENTS;

	DESCRIBE JOBS;

	DESCRIBE LOCATIONS;

3. Testați exemplele din lucrare.


4. Afișați toate datele din tabelele Employees, Departments, Jobs și Locations.

	SELECT * FROM EMPLOYEES;
	107 rows selected.

	SELECT * FROM DEPARTMENTS;
	27 rows selected.

	SELECT * FROM JOBS;
	19 rows selected.

	SELECT * FROM LOCATIONS;
	23 rows selected.

5. Afișați următoarele informații despre angajați: numele, prenumele și data angajării –

	SELECT FIRST_NAME as Nume, LAST_NAME as Prenume, HIRE_DATE as "Data Angajarii"
	FROM EMPLOYEES;

	107 rows selected.


folosiți aceste denumiri (în limba română!) pentru coloanele afișate.

6. Afișați first_name, last_name, job_id, salary pentru angajații din tabelul Employees cu
salariul mai mare decât 7000.

	SELECT FIRST_NAME as Nume, LAST_NAME as Prenume, job_id, salary
	FROM EMPLOYEES
	WHERE salary > 7000;

	44 rows selected.

7. Selectați job-urile (din tabelul jobs) care au diferența dintre salariul maxim și cel minim
mai mare decât 3000.

	SELECT *
	FROM JOBS
	WHERE MAX_SALARY - MIN_SALARY > 3000

	14 rows selected. 

8. Afișați first_name, last_name, job_id, salary pentru angajații din tabelul Employees cu ID-
ul cuprins între 110 și 150 și care ocupă un post de programator.

	SELECT FIRST_NAME as Nume, LAST_NAME as Prenume, job_id, salary
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID >= 110 AND EMPLOYEE_ID <= 150 AND JOB_ID = 'IT_PROG'

	no rows selected 

9. Selectați job-urile distincte din domeniul IT (care încep cu IT) și administrație (care încep
cu AD).

	SELECT DISTINCT JOB_ID
	FROM JOBS
	WHERE JOB_ID LIKE 'AD%' OR JOB_ID LIKE 'IT%'

	4 rows selected. !

10. Afișați angajații al căror prenume are 5 litere.

	SELECT *
	FROM EMPLOYEES
	WHERE FIRST_NAME LIKE '_____' 

	35 rows selected. 

11. Afișați angajații al căror prenume are cel puțin 6 litere și începe cu litera A.

	SELECT *
	FROM EMPLOYEES
	WHERE FIRST_NAME LIKE 'A_____%'

	6 rows selected. 

12. Afișați angajații al căror job_ID este IT_PROG sau FI_ACCOUNT. Scrieți condiția în două
moduri.

	SELECT *
	FROM EMPLOYEES
	WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_ACCOUNT'

	SELECT *
	FROM EMPLOYEES
	WHERE JOB_ID IN ('IT_PROG', 'FI_ACCOUNT')

	10 rows selected. 
 
13. Creați un fișier script care sa conțină instrucțiunile DESCRIBE și SELECT aplicate pe același
tabel și lansați-l în execuție.
	
	
	DESCRIBE JOBS;
	SELECT * FROM JOBS;

	19 rows selected.

14. Afișați departamentele al căror nume încep cu A sau S.

	SELECT DEPARTMENT_NAME
	FROM DEPARTMENTS
	WHERE DEPARTMENT_NAME LIKE 'A%' OR DEPARTMENT_NAME LIKE 'S%'

	5 rows selected.

15. Selectați job-urile de tip funcționar (cele care se termină cu CLERK).

	SELECT JOB_TITLE
	FROM JOBS
	WHERE JOB_ID LIKE '%CLERK'

	3 rows selected. 

16. Afişaţi anagajaţii (numele, prenumele, job_id) al căror job_id este IT_PROG sau
FI_ACCOUNT utilizând unul dintre operatorii de comparație ANY/SOME.

	SELECT FIRST_NAME AS NUME,LAST_NAME AS PRENUME, JOB_ID
	FROM EMPLOYEES 
	WHERE JOB_ID = ANY('IT_PROG','FI_ACCOUNT')

	10 rows selected.

17. Afişaţi anagajaţii (numele, prenumele, comision) care au puncte de comision.

	SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT
	FROM EMPLOYEES
	WHERE COMMISSION_PCT IS NOT NULL

	35 rows selected.

18. Selectaţi departamentele care au manager (manager_id să nu fie NULL).

	SELECT *
	FROM DEPARTMENTS
	WHERE MANAGER_ID IS NOT NULL

	11 rows selected.

19. Selectaţi angajaţii (numele, prenumele, salar) cu salariul mai mic decât toate valorile din
lista (4000, 5000, 3000).

	SELECT FIRST_NAME || ' ' || LAST_NAME AS Nume, SALARY AS Salar
	FROM EMPLOYEES
	WHERE SALARY < ALL(4000,5000,3000)

	24 rows selected. ! 26


20. Selectaţi angajaţii (numele, prenumele, salar) cu salariul mai mic decât oricare valori din
lista (4000, 5000, 3000).

	SELECT FIRST_NAME || ' ' || LAST_NAME AS Nume, SALARY AS Salar
	FROM EMPLOYEES
	WHERE SALARY < ANY(4000,5000,3000)

	49 rows selected.

21. Selectaţi locaţiile care nu sunt din Canada (CA) şi US.

	SELECT * FROM LOCATIONS
	WHERE NOT COUNTRY_ID = 'CA' AND NOT COUNTRY_ID = 'US'

	17 rows selected.