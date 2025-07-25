

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`) VALUES ('ink', 'Ink', '50', '1', 'item_standard', '0', NULL, '1', '{}', 'Dark liquid stuff for writin\' or printin\'.');

UPDATE `items` SET `limit` = '50', `usable` = '0', `desc` = 'White, long-grained, smudge-proof paper perfect for mimeography.' WHERE `items`.`item` = 'paper';

UPDATE `items` SET `label` = 'Newspaper' WHERE `items`.`item` = 'newspaper';

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`) VALUES ('card', 'Card', '100', '1', 'item_standard', '1', NULL, '1', '{}', 'nice item');


CREATE TABLE `printables` (
  `id` int(11) NOT NULL,
  `type` varchar(11) NOT NULL,
  `press_id` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(5550) NOT NULL,
  `count_printed` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `publisher` int(11) NOT NULL,
  `data` longtext NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE `printables`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `printables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
