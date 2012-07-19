SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `alti` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `alti`;

-- -----------------------------------------------------
-- Table `alti`.`system_admins`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`system_admins` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`organizations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`organizations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `contact` VARCHAR(45) NULL ,
  `address` VARCHAR(45) NULL ,
  `phone` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`organization_admins`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`organization_admins` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `organizations_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `organizations_id`) ,
  INDEX `fk_administrative_users_organizations1` (`organizations_id` ASC) ,
  CONSTRAINT `fk_administrative_users_organizations1`
    FOREIGN KEY (`organizations_id` )
    REFERENCES `alti`.`organizations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`shelters`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`shelters` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`desk_workers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`desk_workers` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `shelters_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `shelters_id`) ,
  INDEX `fk_desk_workers_shelters` (`shelters_id` ASC) ,
  CONSTRAINT `fk_desk_workers_shelters`
    FOREIGN KEY (`shelters_id` )
    REFERENCES `alti`.`shelters` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`rooms`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(45) NULL ,
  `capacity` INT NOT NULL ,
  `available` INT NOT NULL ,
  `organizations_id` INT NOT NULL ,
  `gender` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`, `organizations_id`) ,
  INDEX `fk_rooms_organizations1` (`organizations_id` ASC) ,
  CONSTRAINT `fk_rooms_organizations1`
    FOREIGN KEY (`organizations_id` )
    REFERENCES `alti`.`organizations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alti`.`clients`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `alti`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `rooms_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `rooms_id`) ,
  INDEX `fk_clients_rooms1` (`rooms_id` ASC) ,
  CONSTRAINT `fk_clients_rooms1`
    FOREIGN KEY (`rooms_id` )
    REFERENCES `alti`.`rooms` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `alti`.`system_admins`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `system_admins` (`id`, `username`, `password`) VALUES (0, 'admin', 'admin');

COMMIT;

-- -----------------------------------------------------
-- Data for table `alti`.`organizations`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `organizations` (`id`, `name`, `contact`, `address`, `phone`) VALUES (0, 'YWCA', 'Jane Smith', '123 somewhere', '1234567');
INSERT INTO `organizations` (`id`, `name`, `contact`, `address`, `phone`) VALUES (1, 'another org.', 'John Doe', '555 faraway', '7654321');

COMMIT;

-- -----------------------------------------------------
-- Data for table `alti`.`organization_admins`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `organization_admins` (`id`, `username`, `password`, `organizations_id`) VALUES (0, 'admin0', 'admin0', 0);
INSERT INTO `organization_admins` (`id`, `username`, `password`, `organizations_id`) VALUES (1, 'admin1', 'admin1', 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `alti`.`shelters`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `shelters` (`id`, `name`) VALUES (0, 'shelter1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `alti`.`desk_workers`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `desk_workers` (`id`, `username`, `password`, `shelters_id`) VALUES (0, 'worker1', 'worker1', 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `alti`.`rooms`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `alti`;
INSERT INTO `rooms` (`id`, `type`, `capacity`, `available`, `organizations_id`, `gender`) VALUES (0, 'Dormitory', 16, 8, 0, 'Adult Men');
INSERT INTO `rooms` (`id`, `type`, `capacity`, `available`, `organizations_id`, `gender`) VALUES (1, 'Rooms (single)', 6, 3, 0, 'Adult Women');
INSERT INTO `rooms` (`id`, `type`, `capacity`, `available`, `organizations_id`, `gender`) VALUES (2, 'Rooms (double)', 12, 9, 0, '');

COMMIT;
