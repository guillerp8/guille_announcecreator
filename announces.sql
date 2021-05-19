CREATE TABLE `announces` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`job` VARCHAR(1000) NOT NULL COLLATE 'utf8mb4_general_ci',
	`pic` VARCHAR(5000) NOT NULL COLLATE 'utf8mb4_general_ci',
	`color` VARCHAR(1000) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`name` VARCHAR(1000) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`titlecolor` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`colorbar` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=22
;
