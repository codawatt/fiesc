Exemplu tabla

SELECT first_name || ' ' || last_name AS Nume,salary + (salary * NVL(commission_pct,0)) AS SalarT
FROM employees
WHERE SALARY > 5000
ORDER BY SalarT

58 rows selected.
================================================================================================================================================

Exerciții – Sortarea datelor
1. Afişaţi angajaţii (numele și prenumele) al căror nume începe cu A, ordonaţi după prenume.

SELECT first_name || ' ' || last_name AS Nume
FROM employees
WHERE last_name LIKE 'A%'
ORDER BY first_name

4 rows selected.

2. Afişaţi angajaţii (id, numele, prenumele) care ocupă un post de funcționar (conține CLERK)
și ordonaţi descrescător după id.

SELECT employee_id, last_name, first_name
FROM employees
WHERE job_id LIKE '%CLERK'
ORDER BY employee_id DESC

45 rows selected.

3. Afişaţi angajaţii al căror manager_id este cuprins între 100 şi 150, ordonaţi după
department_id şi nume.

SELECT employee_id,manager_id, last_name, first_name
FROM employees
WHERE manager_id >= 100 AND manager_id <= 150
ORDER BY department_id, last_name ASC

104 rows selected.

4. Afişaţi angajaţii cu salariul mai mare decât 5000, ordonaţi descrescător după
department_id şi crescător după nume.

SELECT first_name || ' ' || last_name AS Nume,department_id,salary
FROM employees
WHERE SALARY > 5000
ORDER BY department_id, last_name ASC

58 rows selected.
5. Afişaţi locaţiile (tabelul Locations) diferite de Tokyo şi Geneva, ordonate descrescător după
stat (STATE_PROVINCE). Valorile NULL vor fi afişate la sfârşit.

SELECT city, state_province
FROM LOCATIONS
WHERE LOWER(CITY) NOT LIKE LOWER('Tokyo') and LOWER(CITY) NOT LIKE LOWER('Geneva')
ORDER BY state_province DESC NULLS LAST

21 rows selected.

6. Ordonaţi job-urile după diferenţa dintre salariul maxim şi cel minim.

SELECT job_id, job_title, (max_salary - min_salary) as delta_salary
FROM jobs
ORDER BY delta_salary

19 rows selected.

7. Afişaţi toate valorile distincte ale salariului ordonate descrescător.

SELECT DISTINCT salary
FROM Employees
ORDER BY SALARY DESC

58 rows selected.

8. Afișați numele, prenumele, salariul și salariul anual câștigat de fiecare angajat din
departamentul 90. Ordonați descrescător după salariul anual.

select last_name, first_name, salary, salary * 12 as annual_salary
from employees
where department_id = 90
order by annual_salary desc

3 rows selected.
================================================================================================================================================

Exerciții – Funcții predefinite
1. Selectaţi angajaţii (numele și prenumele) al căror nume începe cu litera A. Afișați numele
și prenumele cu majuscule.

SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS Nume
FROM employees
WHERE last_name LIKE 'A%'

4 rows selected.

2. Afișați job-urile din domeniul administraţie (cele care încep cu AD) în 2 moduri, folosind
INSTR și SUBSTR.
select jobs.* , instr(job_id, 'AD'), substr(job_id,1,2)
from jobs
WHERE instr(job_id, 'AD') = 1;

select jobs.* , instr(job_id, 'AD'), substr(job_id,1,2)
from jobs
WHERE substr(job_id,1,2) = 'AD';

3 rows selected.

3. Afişaţi anagajaţii al căror prenume are cel puțin 5 litere, ordonaţi după ID. Realizați ăn 2
moduri.

SELECT employee_id, last_name, first_name
FROM employees
WHERE LENGTH(first_name) >= 5
ORDER BY employee_id;

SELECT employee_id, last_name, first_name
FROM employees
WHERE first_name LIKE '_____%' 
ORDER BY employee_id;

92 rows selected.

4. Afişaţi angajaţii care au început activitatea în anul 2006 ca funcţionar cu un salariu mai
mare decât 4000.

SELECT employee_id, last_name, first_name, hire_date, job_id, salary
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2006' AND job_id LIKE '%CLERK%' AND salary > 4000;

no rows selected. 

5. Afişaţi numele şi data angajării pentru salariaţii din departamentele 50 şi 100. Data
angajarii va fi sub forma “numele zilei, dd.mm.yy” (de exemplu: Joi, 18.07.96) iar numele
cu majuscule.

SELECT UPPER(last_name) AS nume,
TO_CHAR(hire_date, 'Day, DD.MM.YY') AS data_angajarii
FROM employees
WHERE department_id = 50 OR department_id = 100;

51 rows selected.

6. Selectaţi salariaţii care s-au angajat într-o zi de vineri, ordonaţi după nume.

SELECT last_name, first_name, hire_date
FROM employees
WHERE UPPER(TO_CHAR(hire_date, 'DAY')) LIKE 'FRIDAY%'
ORDER BY last_name;

19 rows selected 

7. Afişaţi job-urile de manager, ordonate după salariul maxim. Titlul job-ului va fi afişat cu
litere mari, id_ul cu litere mici, iar salariul minim şi cel maxim vor fi prefixate cu simbolul
‘$’.

SELECT LOWER(job_id) AS job_id,UPPER(job_title) AS job_title,TO_CHAR(min_salary, '$99,999') AS salariu_minim,TO_CHAR(max_salary, '$99,999') AS salariu_maxim
FROM jobs
WHERE UPPER(job_title) LIKE '%MANAGER%'
ORDER BY max_salary;

6 rows selected.

8. Calculaţi bonusul pe care l-ar primi angajaţii al căror nume începe cu S, ştiind că se
acordă 500$ pentru 1 commission_pct. Valorile nule vor fi înlocuite cu 0.
SELECT last_name,first_name, NVL(commission_pct, 0) AS comision, NVL(commission_pct, 0) * 500 AS bonus
FROM employees
WHERE UPPER(last_name) LIKE 'S%';

9 rows selected

9. Afișați angajații cu un salariu total, incluzând bonificațiile, angajaților din
departamentele 20, 50 și 80. Ordonați crescător după departament și descrescător după
salariul total.

SELECT employee_id, last_name, first_name, department_id,salary,NVL(commission_pct, 0) AS commission_pct,salary + salary * NVL(commission_pct, 0) AS salariu_total
FROM employees
WHERE department_id IN (20, 50, 80)
ORDER BY department_id ASC, salariu_total DESC;

81 rows selected

================================================================================================================================================
Exerciții – Tabelul DUAL
1. Afișați structura tabelului DUAL.

DESC DUAL;

DUMMY 	  	VARCHAR2(1) 
2. Afişaţi data curentă sub forma “Numele zilei, zz NumeLuna aaaa” (Ex: Luni, 14 Martie 2022).

SELECT TO_CHAR(SYSDATE, 'DAY, DD MM YYYY') as data_astazi
FROM DUAL;

FRIDAY , 06 03 2026

3. Afişaţi prima zi de Vineri ce precede data curentă sub forma “Numele zilei, zz.ll.aaaa” (Ex:
Luni, 14 Martie 2022).

SELECT TO_CHAR(NEXT_DAY(SYSDATE - 7, 'FRIDAY'),'DAY, DD.MM.YYYY')
FROM DUAL;

FRIDAY , 06.03.2026

4. Afișați rezultatul următorului calcul aritmetic 20+10-5*8/2 folosind tabelul DUAL.

SELECT 20 + 10 - 5 * 8 / 2 AS rezultat
FROM DUAL;

10