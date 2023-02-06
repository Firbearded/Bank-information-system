-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `tr_counts`
--

DROP TABLE IF EXISTS `tr_counts`;
/*!50001 DROP VIEW IF EXISTS `tr_counts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tr_counts` AS SELECT 
 1 AS `id_c`,
 1 AS `c`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `tr_counts`
--

/*!50001 DROP VIEW IF EXISTS `tr_counts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tr_counts` (`id_c`,`c`) AS select `cl`.`id_c` AS `id_c`,count(0) AS `c` from ((`client` `cl` join `bank_account` `ba` on((`cl`.`id_c` = `ba`.`id_c`))) join `transactions` `tr` on((`ba`.`id_a` = `tr`.`id_a1`))) where (`tr`.`datetime_of_transact` like '2020%') group by `cl`.`id_c` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'bank'
--

--
-- Dumping routines for database 'bank'
--
/*!50003 DROP PROCEDURE IF EXISTS `client_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_report`(in_month INT, in_year INT)
BEGIN
declare done int default 0;
declare made_deal, ended_deal int default 0;

declare C1 cursor for
select count(*) from client
where month(date_of_deal) = in_month and year(date_of_deal) = in_year
group by month(date_of_deal), year(date_of_deal);

declare C2 cursor for
select count(*) from client
where month(end_of_deal) = in_month and year(end_of_deal) = in_year
group by month(end_of_deal), year(end_of_deal);

declare exit handler for sqlstate '02000' set done = 1;
open C1;
open C2;
while done = 0 do
fetch C1 into made_deal;
fetch C2 into ended_deal;
insert into client_report values(NULL, made_deal, ended_deal, in_month, in_year);
end while;
close C1;
close C2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `currency_exchange_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `currency_exchange_report`(in_month INT, in_year INT)
BEGIN
declare done int default 0;
declare chek, id1, id2 int;
declare sum_add, sum_sub double;
declare cur1, cur2 varchar(50);
declare C1 cursor for
select (select currency from bank_account where id_a = id_a2) cur11, currency, sum(amount_of_money), sum(amount_of_money * exchange_rate) from transactions join bank_account on transactions.id_a1 = bank_account.id_a
where month(datetime_of_transact) = in_month and year(datetime_of_transact) = in_year
group by cur11, currency;

declare exit handler for sqlstate '02000' set done = 1;
select (select currency from bank_account where id_a = id_a2) cur11, currency, sum(amount_of_money), sum(amount_of_money * exchange_rate) from transactions join bank_account on transactions.id_a1 = bank_account.id_a
where month(datetime_of_transact) = in_month and year(datetime_of_transact) = in_year
group by cur11, currency;
open C1;
while done = 0 do
fetch C1 into cur1, cur2, sum_sub, sum_add;

select count(*) into chek from curr_exchange_report
where currency1 = cur1 and currency2 = cur2 and rep_month = in_month and rep_year = in_year;
if chek = 0 then
	insert into curr_exchange_report values(NULL, cur1, cur2, round(sum_add, 2), 0, in_month, in_year);
else
	select id_c_e_r into id1 from curr_exchange_report 
    where currency1 = cur1 and currency2 = cur2 and rep_month = in_month and rep_year = in_year;
	update curr_exchange_report 
		set sum_cur2_to_cur1 = round(sum_add, 2) 
        where id_c_e_r = id1;
end if;
select count(*) into chek from curr_exchange_report
where currency1 = cur2 and currency2 = cur1 and rep_month = in_month and rep_year = in_year;
if chek = 0 then
	insert into curr_exchange_report values(NULL, cur2, cur1, 0, round(sum_sub, 2), in_month, in_year);
else
	select id_c_e_r into id2 from curr_exchange_report 
    where currency1 = cur2 and currency2 = cur1 and rep_month = in_month and rep_year = in_year;
	update curr_exchange_report 
		set sum_cur1_to_cur2 = round(sum_sub, 2) 
		where id_c_e_r = id2;
end if;

end while;

close C1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `currency_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `currency_report`(in_month INT, in_year INT)
BEGIN
declare done int default 0;
declare trans_count, trans_sum int;
declare cur varchar(50);
declare C1 cursor for
select currency, count(*), sum(amount_of_money) from transactions join bank_account on transactions.id_a1 = bank_account.id_a
where month(datetime_of_transact) = in_month and year(datetime_of_transact) = in_year
group by currency;
declare exit handler for sqlstate '02000' set done = 1;
open C1;
while done = 0 do
fetch C1 into cur, trans_count, trans_sum;
insert into currency_report values(NULL, cur, trans_count, trans_sum, in_month, in_year);
end while;
close C1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `money_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `money_report`(in_month INT, in_year INT)
BEGIN
declare done, counter, err int default 0;
declare sum_overall, deposit, withdrawal double default 0;

declare C1 cursor for
select sum((new_balance - old_balance) * rate)
from account_history right join bank_account using(id_a) join inside_exchange_rate on currency1 = currency and currency2 = 'ruble'
where (reason = 'deposit' and year(datetime_of_new_balance) = in_year and month(datetime_of_new_balance) = in_month) or id_a = 10
group by reason;


declare C2 cursor for
select sum((old_balance - new_balance) * rate)
from account_history right join bank_account using(id_a) join inside_exchange_rate on currency1 = currency and currency2 = 'ruble'
where (reason = 'withdrawal' and year(datetime_of_new_balance) = in_year and month(datetime_of_new_balance) = in_month) or id_a = 10
group by reason;

declare C3 cursor for
select sum(balance * (select rate from inside_exchange_rate where currency1 = currency and currency2 = 'ruble'))
from bank_account;

declare exit handler for sqlstate '02000' set done = 1;

open C1;
fetch C1 into deposit;
close C1;

open C2;
fetch C2 into withdrawal;
close C2;

select withdrawal;

open C3;
set done = 0;
fetch C3 into sum_overall;
close C3;

if withdrawal is null then
	set withdrawal = 0;
end if;
if deposit is null then
	set deposit = 0;
end if;

select deposit, withdrawal, sum_overall;

insert into money_report values(NULL, round(deposit, 2), round(withdrawal, 2), round(sum_overall, 2), in_month, in_year);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_account`(in_id_c INT, in_cur varchar(20), in_num char(12))
BEGIN

insert into bank_account values(NULL, in_num, in_cur, 0, now(), in_id_c);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_report`(in_month INT, in_year INT)
BEGIN
declare done, counter, err int default 0;
declare sum_overall, deposit, withdrawal double default 0;

declare C1 cursor for
select sum((new_balance - old_balance) * rate)
from account_history right join bank_account using(id_a) join inside_exchange_rate on currency1 = currency and currency2 = 'ruble'
where (reason = 'deposit' and year(datetime_of_new_balance) = in_year and month(datetime_of_new_balance) = in_month) or id_a = 100
group by reason;


declare C2 cursor for
select sum((old_balance - new_balance) * rate)
from account_history right join bank_account using(id_a) join inside_exchange_rate on currency1 = currency and currency2 = 'ruble'
where (reason = 'withdrawal' and year(datetime_of_new_balance) = in_year and month(datetime_of_new_balance) = in_month) or id_a = 100
group by reason;

declare C3 cursor for
select sum(balance * (select rate from inside_exchange_rate where currency1 = currency and currency2 = 'ruble'))
from bank_account;

declare exit handler for sqlstate '02000' set done = 1;

open C1;
fetch C1 into deposit;
close C1;

open C2;
fetch C2 into withdrawal;
close C2;

select withdrawal;

open C3;
set done = 0;
fetch C3 into sum_overall;
close C3;

if withdrawal is null then
	set withdrawal = 0;
end if;
if deposit is null then
	set deposit = 0;
end if;

select deposit, withdrawal, sum_overall;

insert into money_report values(NULL, deposit, withdrawal, sum_overall, in_month, in_year);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transact`(num_from char(12), num_to char(12), amount double)
begin
declare done int default 0;
declare exch_rate double default 1;
declare old_balance_from, old_balance_to, new_balance_from, new_balance_to double;
declare id_a_from, id_a_to int;
declare dat datetime;
declare continue handler for sqlstate 'HY000'
	set done = 1;
declare continue handler for sqlstate '02000'
	set done = 1;
    
select id_a, balance into id_a_from, old_balance_from from bank_account where number = num_from;
select id_a, balance into id_a_to, old_balance_to from bank_account where number = num_to;

select rate into exch_rate from inside_exchange_rate
where currency1 = (select currency from bank_account where number = num_from)
and currency2 = (select currency from bank_account where number = num_to);

start transaction;
set new_balance_from = old_balance_from - amount;
set new_balance_to = old_balance_to + amount * exch_rate;

insert into transactions values(null, amount, exch_rate, now(), id_a_from, id_a_to);
insert into account_history values(null, old_balance_from, new_balance_from, now(), 'transact', id_a_from);
insert into account_history values(null, old_balance_to, new_balance_to, now(), 'transact', id_a_to);
update bank_account
	set balance = new_balance_from, datetime_of_balance = now() where id_a = id_a_from;
update bank_account
	set balance = new_balance_to, datetime_of_balance = now() where id_a = id_a_to;
select new_balance_from, now() from bank_account where id_a = id_a_from;
select new_balance_to, now() from bank_account where id_a = id_a_to;
if done = 0 then
	commit;
else
	rollback;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transact_from_sem4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transact_from_sem4`(num_t int)
begin
declare a1, a2, amount int;
declare done int default 0;
declare exch_rate float default 1;
declare dat datetime;
declare continue handler for sqlstate 'HY000'
	set done = 1;
declare continue handler for sqlstate '02000'
	set done = 1;
select id_a1, id_a2, amount_of_money, datetime_of_transact into a1, a2, amount, dat 
from transactions where id_t_h = num_t;
select rate into exch_rate from inside_exchange_rate
where currency1 = (select currency from bank_account where id_a = (select id_a1 from transactions where id_t_h = num_t))
and currency2 = (select currency from bank_account where id_a = (select id_a2 from transactions where id_t_h = num_t));
start transaction;
update bank_account
	set balance = balance - amount, datetime_of_balance = dat where id_a = a1;
update bank_account
	set balance = balance + amount * exch_rate, datetime_of_balance = dat where id_a = a2;
if done = 0 then
	commit;
else
	rollback;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07  0:34:05
