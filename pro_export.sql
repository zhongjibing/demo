USE test ;

DROP PROCEDURE IF EXISTS pro_export_csv ;

DELIMITER ;;

CREATE PROCEDURE pro_export_csv () 
BEGIN
    DECLARE pos_id INT DEFAULT 0 ;
    DECLARE page_size INT DEFAULT 100000 ;
    DECLARE absolute_path VARCHAR (50) DEFAULT '/tmp/emp' ;
    DECLARE extension_name VARCHAR (50) DEFAULT '.csv' ;
    DECLARE query_sql VARCHAR (2000) DEFAULT '' ;
    DECLARE export_sql_1 VARCHAR (500) DEFAULT ' INTO OUTFILE ''' ;
    DECLARE export_sql_2 VARCHAR (500) DEFAULT '' ;
    -- 数据查询sql
    SET query_sql = CONCAT(
        'SELECT ',
        ' ''empno'',''ename'',''job'',''mgr'',''hiredate'',''sal'',''comm'',''deptno'' ',
        ' FROM DUAL ',
        ' UNION ALL ',
        ' SELECT ',
        ' empno, ename, job, mgr, hiredate, sal, comm, deptno ',
        ' FROM emp WHERE empno > ? AND empno <= ? '
    ) ;
    SET export_sql_2 = ''' FIELDS TERMINATED BY '','' ENCLOSED BY '''' OPTIONALLY ENCLOSED BY ''"'' LINES TERMINATED BY ''\r\n''' ;
    -- 分页查询
    SELECT 
        IFNULL(empno, 0) AS empno INTO @max_id 
    FROM
        emp 
    ORDER BY empno DESC 
    LIMIT 1 ;
    SET @seq = 0 ;
    WHILE
        pos_id < @max_id DO SET @from_id = pos_id ;
        SET @end_id = pos_id + page_size ;
        SET @pre_sql = CONCAT(
            query_sql,
            export_sql_1,
            CONCAT(
                absolute_path,
                '_',
                @seq,
                extension_name
            ),
            export_sql_2
        ) ;
        PREPARE stmt FROM @pre_sql ;
        EXECUTE stmt USING @from_id,
        @end_id ;
        DROP PREPARE stmt ;
        -- 重新设置分页条件
        SET pos_id = @end_id ;
        SET @seq = @seq + 1 ;
    END WHILE ;
END ;;

DELIMITER ;
