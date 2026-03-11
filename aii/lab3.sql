I. Exerciții
1. Scrieți o interogare care să afișeze numărul de angajați, și suma salariilor cu bonificații:
• Pentru fiecare departament, pentru fiecare tip de job.
• La nivel de departament, indiferent de job.
• La nivel de job, indiferent de departament.
• Totalul general al angajaților.
În rezultat, valorile NULL rezultate din agregări trebuie înlocuite cu etichete
descriptive:
- "Toate departamentele" pentru rândurile unde sunt agregate toate
departamentele.
- "Toate joburile" pentru rândurile unde sunt agregate toate joburile.

SELECT
DECODE(GROUPING(department_id),1,'Toate departamentele',department_id) AS Departament,
DECODE(GROUPING(job_id),1,'Toate joburile',job_id) AS Job,
COUNT(*) AS nr_angajati,
SUM(salary + NVL(commission_pct*salary,0)) AS Total
FROM employees
GROUP BY CUBE(department_id, job_id);

52 rows selected.

2. Adăugați la exercițiul 1 nivelul de agregare. Ordonați după acesta ascendent.

SELECT 
DECODE(GROUPING(department_id),1,'Toate departamentele',department_id) department,
DECODE(GROUPING(job_id),1,'Toate joburile',job_id) job,
COUNT(*) nr_angajati,
SUM(salary + NVL(commission_pct*salary,0)) total_salarii_bonus,
GROUPING_ID(department_id,job_id) nivel_agregare
FROM employees
GROUP BY CUBE(department_id,job_id)
ORDER BY nivel_agregare;

52 rows selected.

3. Modificați instrucțiunea de la exercițiul anterior astfel încât pe coloana department_id
valorile NULL provenite din baza de date să fie înlocuite cu eticheta descriptivă "Fara
Departament".

SELECT 
DECODE(GROUPING(department_id),1,'Toate departamentele',NVL(TO_CHAR(department_id),'Fara Departament')) department,
DECODE(GROUPING(job_id),1,'Toate joburile',job_id) job,
COUNT(*) nr_angajati,
SUM(salary + NVL(commission_pct*salary,0)) total_salarii_bonus,
GROUPING_ID(department_id,job_id) nivel_agregare
FROM employees
GROUP BY CUBE(department_id,job_id)
ORDER BY nivel_agregare;

52 rows selected.

4. Afișați totalul salariilor, bonificația în funcție de comision și totalul salariilor ce include
și bonificația, pentru:
• luna și an
• trimestru
• luna
• an
• totalul general
În rezultat, afișați nivelul de agregare și ordonați după acesta.

SELECT 
EXTRACT(YEAR FROM hire_date) an,
EXTRACT(MONTH FROM hire_date) luna,
TO_CHAR(hire_date,'Q') trimestru,
SUM(salary) total_salarii,
SUM(NVL(commission_pct*salary,0)) bonus,
SUM(salary + NVL(commission_pct*salary,0)) total_cu_bonus,
GROUPING_ID(EXTRACT(YEAR FROM hire_date),
			EXTRACT(MONTH FROM hire_date),
			TO_CHAR(hire_date,'Q')) nivel
FROM employees
GROUP BY GROUPING SETS (
(EXTRACT(YEAR FROM hire_date), EXTRACT(MONTH FROM hire_date)),
(TO_CHAR(hire_date,'Q')),(EXTRACT(MONTH FROM hire_date)),(EXTRACT(YEAR FROM hire_date)),())
ORDER BY nivel;

78 rows selected.

5. Afișați pe baza exercițiului anterior doar acele înregistrări a căror bonificații pe
trimestru depășesc 5000. Scrieți rezolvarea utilizând clauza WITH.
WITH bonusuri AS (
SELECT 
TO_CHAR(hire_date,'Q') trimestru,
SUM(NVL(commission_pct*salary,0)) total_bonus
FROM employees
GROUP BY TO_CHAR(hire_date,'Q'))
SELECT *
FROM bonusuri
WHERE total_bonus > 5000;

4 rows selected. 

6. Pentru angajații din departamentele 30 și 80 afișați salariile și bonificațiile pentru an,
trimestru și lună, luând în considerare toate combinațiile posibile.

SELECT 
    EXTRACT(YEAR FROM hire_date) an,
    TO_CHAR(hire_date,'Q') trimestru,
    EXTRACT(MONTH FROM hire_date) luna,
    SUM(salary) total_salarii,
    SUM(NVL(commission_pct*salary,0)) bonus
FROM employees
WHERE department_id IN (30,80)
GROUP BY CUBE(
    EXTRACT(YEAR FROM hire_date),
    TO_CHAR(hire_date,'Q'),
    EXTRACT(MONTH FROM hire_date));

103 rows selected.

7. Generati un raport complet cu numele departmentului, numele jobului și media
salariilor :
• pentru fiecare departament și fiecare tip de job.
• pentru fiecare departament, indiferent de job.
• la nivel de job, indiferent de departament.

SELECT DECODE(GROUPING(d.department_name),1,'Toate departamentele',d.department_name) department, DECODE(GROUPING(e.job_id),1,'Toate joburile',e.job_id) job, AVG(e.salary) avg_salary
FROM employees e
JOIN departments d ON e.department_id=d.department_id
GROUP BY CUBE(d.department_name, e.job_id);

50 rows selected.

Conectați-vă la schema sh.
1. Generați un raport complet cu totalul vânzărilor:
• pentru fiecare an și trimestru,
• pentru fiecare an,
• pentru fiecare trimestru,
• totalul general.
Ordonați după nivelul de agregare descendent și după totaluri descendent.

SELECT t.calendar_year, t.calendar_quarter_desc, SUM(s.amount_sold) total_sales, GROUPING_ID(t.calendar_year, t.calendar_quarter_desc) nivel
FROM sales s
JOIN times t ON s.time_id=t.time_id
GROUP BY CUBE(t.calendar_year, t.calendar_quarter_desc)
ORDER BY nivel DESC, total_sales DESC;

28 rows selected.

2. Generați un raport complet cu totalul încasat din vânzări și numărul de articole
vândute în funcție de:
• categorie,
• subcategorie,
• produs.
Ordonați după totalul încasat descendent.

SELECT p.prod_category, p.prod_subcategory,p.prod_name, SUM(s.amount_sold) total_incasari, SUM(s.quantity_sold) nr_articole
FROM sales s
JOIN products p ON s.prod_id=p.prod_id
GROUP BY CUBE(p.prod_category,p.prod_subcategory,p.prod_name)
ORDER BY total_incasari DESC;

2989 rows selected.

3. Generati un raport complet cu totalul vânzărilor și numărul total de produse vândute
în funcție de:
• canalul de vânzare și țară,
• fiecare canal de vânzare,
• totalul general.
Ordonați după nivelul de agregare.
SELECT c.channel_desc, co.country_name, SUM(s.amount_sold) total_vanzari, COUNT(s.prod_id) nr_produse, GROUPING_ID(c.channel_desc,co.country_name) nivel
FROM sales s
JOIN channels c ON s.channel_id=c.channel_id
JOIN customers cu ON s.cust_id=cu.cust_id
JOIN countries co ON cu.country_id=co.country_id
GROUP BY CUBE(c.channel_desc,co.country_name)
ORDER BY nivel;

120 rows selected.

4. Generați un raport care să calculeze totalul încasărilor, luând în considerare toate
combinațiile posibile de agregare pe an și canal de vânzare, doar pentru acei ani în
care vânzările totale depășesc 1 milion.

SELECT t.calendar_year, c.channel_desc, SUM(s.amount_sold) total_vanzari
FROM sales s
JOIN times t ON s.time_id=t.time_id
JOIN channels c ON s.channel_id=c.channel_id
GROUP BY CUBE(t.calendar_year,c.channel_desc)
HAVING SUM(s.amount_sold) > 1000000;

24 rows selected.

5. Afișați totalul vânzărilor grupate pe ani și categorii de produse, incluzând atât
detalierea pe fiecare combinație, cât și nivelurile de agregare. Selectați doar categoriile
de produse ale căror vânzări totale depășesc valoarea medie a tuturor vânzărilor.

SELECT t.calendar_year, p.prod_category,SUM(s.amount_sold) total_vanzari
FROM sales s
JOIN times t ON s.time_id=t.time_id
JOIN products p ON s.prod_id=p.prod_id
GROUP BY CUBE(t.calendar_year,p.prod_category)
HAVING SUM(s.amount_sold) > (SELECT AVG(amount_sold) FROM sales);

20 rows selected.

6. Generați un raport care afișează suma totală a încasărilor grupată pe an fiscal, lună
fiscală și săptămână fiscală. Raportul trebuie să includă detalierea încasărilor pentru:
• an fiscal, lună fisacală, săptămână fiscală,
• an fiscal, lună fiscală,
• an fiscal,
• luna fiscală,
• săptămână fiscală.

SELECT t.fiscal_year,t.fiscal_month_number, t.fiscal_week_number, SUM(s.amount_sold) total_incasari
FROM sales s
JOIN times t ON s.time_id=t.time_id
GROUP BY GROUPING SETS((t.fiscal_year,t.fiscal_month_number,t.fiscal_week_number),(t.fiscal_year,t.fiscal_month_number),(t.fiscal_year),(t.fiscal_month_number),(t.fiscal_week_number));

254 rows selected.

7. Generați un raport care afișează suma totală a încasărilor pentru canalul de vânzare
Direct Sales, grupată pe an fiscal, lună fiscală și total general. Raportul trebuie să
includă nivelul de agregare care reflectă nivelul de detaliere al fiecărei înregistrări.
• 0 → Vânzări detaliate pe an și lună
• 1 → Vânzări agregate pe an
• 2 → Vânzări agregate pe lună
• 3 → Total general (toate vânzările)
Rezultatele trebuie sortate crescător după an fiscal și lună fiscală, cu valorile NULL
plasate la final.

SELECT t.fiscal_year, t.fiscal_month_number,SUM(s.amount_sold) total_sales, GROUPING_ID(t.fiscal_year,t.fiscal_month_number) nivel
FROM sales s
JOIN times t ON s.time_id=t.time_id
JOIN channels c ON s.channel_id=c.channel_id
WHERE c.channel_desc='Direct Sales'
GROUP BY CUBE(t.fiscal_year,t.fiscal_month_number)
ORDER BY t.fiscal_year, t.fiscal_month_number NULLS LAST;

52 rows selected.

8. Generați un raport care afișează numărul de produse distincte vândute pentru fiecare
categorie de produse, grupate pe an fiscal și trimestru fiscal. Raportul trebuie să
includă totalurile pentru fiecare combinație posibilă (pe an și trimestru, pe an, pe
trimestru și total general) și să fie ordonat cronologic.

SELECT  t.fiscal_year, t.fiscal_quarter_desc, p.prod_category, COUNT(DISTINCT s.prod_id) nr_produse
FROM sales s
JOIN times t ON s.time_id=t.time_id
JOIN products p ON s.prod_id=p.prod_id
GROUP BY CUBE(t.fiscal_year,t.fiscal_quarter_desc,p.prod_category)
ORDER BY t.fiscal_year,t.fiscal_quarter_desc;

140 rows selected.