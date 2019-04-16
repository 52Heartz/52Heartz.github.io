CREATE TABLE student (sno varchar(3) NOT NULL,
                                     sname varchar(4) NOT NULL,
                                                      ssex varchar(2) NOT NULL,
                                                                      sbirthday datetime,
                                                                      CLASS varchar(5));


CREATE TABLE course (cno varchar(5) NOT NULL,
                                    cname varchar(10) NOT NULL,
                                                      tno varchar(10) NOT NULL);


CREATE TABLE score (sno varchar(3) NOT NULL,
                                   cno varchar(5) NOT NULL,
                                                  degree numeric(10, 1) NOT NULL);


CREATE TABLE teacher (tno varchar(3) NOT NULL,
                                     tname varchar(4) NOT NULL,
                                                      tsex varchar(2) NOT NULL,
                                                                      tbirthday datetime NOT NULL,
                                                                                         prof varchar(6),
                                                                                              depart varchar(10) NOT NULL);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (108, '曾华' , '男', '1977-09-01', 95033);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (105, '匡明' , '男', '1975-10-02', 95031);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (107, '王丽' , '女', '1976-01-23', 95033);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (101, '李军' , '男', '1976-02-20', 95033);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (109, '王芳' , '女', '1975-02-10', 95031);


INSERT INTO student (sno, sname, ssex, sbirthday, CLASS)
VALUES (103, '陆君' , '男', '1974-06-03', 95031);


INSERT INTO course (cno, cname, tno)
VALUES ('3-105', '计算机导论', 825);


INSERT INTO course (cno, cname, tno)
VALUES ('3-245', '操作系统', 804);


INSERT INTO course (cno, cname, tno)
VALUES ('6-166', '数据电路', 856);


INSERT INTO course (cno, cname, tno)
VALUES ('9-888', '高等数学', 100);


INSERT INTO score (sno, cno, degree)
VALUES (103, '3-245', 86);


INSERT INTO score (sno, cno, degree)
VALUES (105, '3-245', 75);


INSERT INTO score (sno, cno, degree)
VALUES (109, '3-245', 68);


INSERT INTO score (sno, cno, degree)
VALUES (103, '3-105', 92);


INSERT INTO score (sno, cno, degree)
VALUES (105, '3-105', 88);


INSERT INTO score (sno, cno, degree)
VALUES (109, '3-105', 76);


INSERT INTO score (sno, cno, degree)
VALUES (101, '3-105', 64);


INSERT INTO score (sno, cno, degree)
VALUES (107, '3-105', 91);


INSERT INTO score (sno, cno, degree)
VALUES (101, '6-166', 85);


INSERT INTO score (sno, cno, degree)
VALUES (107, '6-106', 79);


INSERT INTO score (sno, cno, degree)
VALUES (108, '3-105', 78);


INSERT INTO score (sno, cno, degree)
VALUES (108, '6-166', 81);


INSERT INTO teacher (tno, tname, tsex, tbirthday, prof, depart)
VALUES (804, '李诚', '男', '1958-12-02', '副教授', '计算机系');


INSERT INTO teacher (tno, tname, tsex, tbirthday, prof, depart)
VALUES (856, '张旭', '男', '1969-03-12', '讲师', '电子工程系');


INSERT INTO teacher (tno, tname, tsex, tbirthday, prof, depart)
VALUES (825, '王萍', '女', '1972-05-05', '助教', '计算机系');


INSERT INTO teacher (tno, tname, tsex, tbirthday, prof, depart)
VALUES (831, '刘冰', '女', '1977-08-14', '助教', '电子工程系');

-- 1、 查询Student表中的所有记录的Sname、Ssex和Class列。

SELECT sname,
       ssex,
       CLASS
FROM student;

-- 2、 查询教师所有的单位即不重复的Depart列。

SELECT DISTINCT depart
FROM teacher1;

-- 3、 查询Student表的所有记录。

SELECT *
FROM student;

-- 4、 查询Score表中成绩在60到80之间的所有记录。

SELECT *
FROM score
WHERE degree > 60
  AND degree < 80;

-- 5、 查询Score表中成绩为85，86或88的记录。

SELECT *
FROM score
WHERE degree = 85
  OR degree = 86
  OR degree = 88;

-- 6、 查询Student表中“95031”班或性别为“女”的同学记录。

SELECT *
FROM student
WHERE CLASS = '95031'
  OR ssex = '女';

-- 7、 以Class降序查询Student表的所有记录。

SELECT *
FROM student
ORDER BY CLASS DESC;

-- 8、 以Cno升序、Degree降序查询Score表的所有记录。

SELECT *
FROM score
ORDER BY cno ASC,
         degree DESC;

-- 9、 查询“95031”班的学生人数。

SELECT count(*)
FROM student
WHERE CLASS = '95031';

-- 10、查询Score表中的最高分的学生学号和课程号。

SELECT sno,
       cno
FROM score
WHERE degree =
    (SELECT max(degree)
     FROM score);

-- 11、查询‘3-105’号课程的平均分。

SELECT avg(degree)
FROM score
WHERE cno = '3-105';

-- 12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。

SELECT avg(degree),
       cno
FROM score
WHERE cno LIKE '3%'
GROUP BY cno
HAVING count(*) > 5;

-- 13、查询最低分大于70，最高分小于90的Sno列。

SELECT sno
FROM score
GROUP BY sno
HAVING min(degree) > 70
AND max(degree) < 90;

-- 14、查询所有学生的Sname、Cno和Degree列。

SELECT sname,
       cno,
       degree
FROM student,
     score
WHERE student.sno = score.sno;

-- 15、查询所有学生的Sno、Cname和Degree列。

SELECT score.sno,
       cno,
       degree
FROM student,
     score
WHERE student.sno = score.sno;

-- 16、查询所有学生的Sname、Cname和Degree列。

SELECT a.sname,
       b.cname,
       c.degree
FROM student a
JOIN (course b,
      score c) ON a.sno = c.sno
AND b.cno = c.cno;

-- 17、查询“95033”班所选课程的平均分。

SELECT avg(degree)
FROM score
WHERE sno IN
    (SELECT sno
     FROM student
     WHERE CLASS = '95033');

-- 18、假设使用如下命令建立了一个grade表：

CREATE TABLE grade (low numeric(3, 0),
                        upp numeric(3),
                            rank char(1));


INSERT INTO grade
VALUES (90, 100, 'A');


INSERT INTO grade
VALUES (80, 89, 'B');


INSERT INTO grade
VALUES (70, 79, 'C');


INSERT INTO grade
VALUES (60, 69, 'D');


INSERT INTO grade
VALUES (0, 59, 'E');

-- 现查询所有同学的Sno、Cno和rank列。

SELECT a.sno,
       a.cno,
       b.rank
FROM score a,
     grade b
WHERE a.degree BETWEEN b.low AND b.upp
ORDER BY rank;

-- 19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。

SELECT *
FROM score
WHERE cno = '3-105'
  AND degree >
    (SELECT degree
     FROM score
     WHERE sno = '109'
       AND cno = '3-105' );


SET @@global.sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';


SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- 20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录

SELECT *
FROM score
WHERE degree <
    (SELECT max(degree)
     FROM score)
GROUP BY sno
HAVING count(*) > 1;

-- 21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
-- 同19
 -- 22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。

SELECT sno,
       sname,
       sbirthday
FROM student
WHERE year(sbirthday) =
    (SELECT year(sbirthday)
     FROM student
     WHERE sno = '108' );

-- 23、查询“张旭“教师任课的学生成绩。

SELECT *
FROM score
WHERE cno =
    (SELECT cno
     FROM course
     INNER JOIN teacher ON course.tno = teacher.tno
     AND tname = '张旭');

-- 24、查询选修某课程的同学人数多于5人的教师姓名。

SELECT tname
FROM teacher
WHERE tno =
    (SELECT tno
     FROM course
     WHERE cno =
         (SELECT cno
          FROM score
          GROUP BY cno
          HAVING count(sno) > 5) );

-- 25、查询95033班和95031班全体学生的记录。

SELECT *
FROM student
WHERE CLASS IN ('95033',
                '95031');

-- 26、查询存在有85分以上成绩的课程Cno.

SELECT cno
FROM score
GROUP BY cno
HAVING max(degree) > 85;

-- 27、查询出“计算机系“教师所教课程的成绩表。

SELECT *
FROM score
WHERE cno IN
    (SELECT cno
     FROM teacher,
          course
     WHERE depart = '计算机系'
       AND course.tno = teacher.tno);

-- 28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof

SELECT tname,
       prof
FROM teacher
WHERE depart = '计算机系'
  AND prof NOT IN
    (SELECT prof
     FROM teacher
     WHERE depart = '电子工程系' );

-- 29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。

SELECT cno,
       sno,
       degree
FROM score
WHERE cno = '3-105'
  AND degree > ANY
    (SELECT degree
     FROM score
     WHERE cno = '3-245' )
ORDER BY degree DESC;

-- 30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.

SELECT *
FROM score
WHERE degree > ALL
    (SELECT degree
     FROM score
     WHERE cno = '3-245' )
ORDER BY degree DESC;

-- 31、查询所有教师和同学的name、sex和birthday.

SELECT tname name,
       tsex sex,
       tbirthday birthday
FROM teacher
UNION
SELECT sname name,
       ssex sex,
       sbirthday birthday
FROM student;

-- 32、查询所有“女”教师和“女”同学的name、sex和birthday.

SELECT tname name,
       tsex sex,
       tbirthday birthday
FROM teacher
WHERE tsex = '女'
UNION
SELECT sname name,
       ssex sex,
       sbirthday birthday
FROM student
WHERE ssex = '女';

-- 33、查询成绩比该课程平均成绩低的同学的成绩表。

SELECT a.*
FROM score a
WHERE degree <
    (SELECT avg(degree)
     FROM score b
     WHERE a.cno = b.cno);

-- 34、查询所有任课教师的Tname和Depart.

SELECT tname,
       depart
FROM teacher a
WHERE exists
    (SELECT *
     FROM course b
     WHERE a.tno = b.tno);

-- 35、查询所有未讲课的教师的Tname和Depart.

SELECT tname,
       depart
FROM teacher a
WHERE tno NOT IN
    (SELECT tno
     FROM course);

-- 36、查询至少有2名男生的班号。

SELECT CLASS
FROM student
WHERE ssex = '男'
GROUP BY CLASS
HAVING count(ssex) > 1;

-- 37、查询Student表中不姓“王”的同学记录。

SELECT *
FROM student
WHERE sname NOT LIKE "王%";

-- 38、查询Student表中每个学生的姓名和年龄。

SELECT sname,
       year(now()) - year(sbirthday)
FROM student;

-- 39、查询Student表中最大和最小的Sbirthday日期值。

SELECT min(sbirthday) birthday
FROM student
UNION
SELECT max(sbirthday) birthday
FROM student;

-- 40、以班号和年龄从大到小的顺序查询Student表中的全部记录。

SELECT *
FROM student
ORDER BY CLASS DESC, year(now()) - year(sbirthday) DESC;

-- 41、查询“男”教师及其所上的课程。

SELECT *
FROM teacher,
     course
WHERE tsex = '男'
  AND course.tno = teacher.tno;

-- 42、查询最高分同学的Sno、Cno和Degree列。

SELECT sno,
       cno,
       degree
FROM score
WHERE degree =
    (SELECT max(degree)
     FROM score);

-- 43、查询和“李军”同性别的所有同学的Sname.

SELECT sname
FROM student
WHERE ssex =
    (SELECT ssex
     FROM student
     WHERE sname = '李军');

-- 44、查询和“李军”同性别并同班的同学Sname.

SELECT sname
FROM student
WHERE (ssex,
       CLASS) =
    (SELECT ssex,
            CLASS
     FROM student
     WHERE sname = '李军');

-- 45、查询所有选修“计算机导论”课程的“男”同学的成绩表

SELECT *
FROM score,
     student
WHERE score.sno = student.sno
  AND ssex = '男'
  AND cno =
    (SELECT cno
     FROM course
     WHERE cname = '计算机导论');

-- 46、使用游标方式来同时查询每位同学的名字，他所选课程及成绩。
 DECLARE
CURSOR student_cursor IS
SELECT s.sno,
       s.sname,
       c.cname,
       sc.degree AS degree
FROM student s,
     course c,
     score sc
WHERE s.sno=sc.sno
  AND sc.cno=c.cno;

student_row student_cursor%rowtype;

BEGIN OPEN student_cursor;

LOOP FETCH student_cursor INTO student_row;

exit WHEN student_cursor%NOTFOUND;

dbms_output.put_line(student_row.sno || '' || student_row.sname|| '' || student_row.cname || '' || student_row.degree);

END LOOP;

CLOSE student_cursor;

END;

/ -- 47、 声明触发器指令，每当有同学转换班级时执行触发器显示当前和之前所在班级。

CREATE OR REPLACE TRIGGER display_class_changes AFTER
DELETE
OR
INSERT
OR
UPDATE ON student
FOR EACH ROW WHEN (new.sno > 0) BEGIN dbms_output.put_line('Old class: ' || :OLD.class); dbms_output.put_line('New class: ' || :NEW.class); END;

/
UPDATE student
SET CLASS=95031
WHERE sno=109;

-- 48、 删除已设置的触发器指令

DROP TRIGGER display_class_changes;