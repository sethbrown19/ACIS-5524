--
-- Drop tables in reverse order of their creation
--

DROP TABLE IF EXISTS `billing_party`;
DROP TABLE IF EXISTS `building`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `resort`;
DROP TABLE IF EXISTS `employee`;
DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `room`;
DROP TABLE IF EXISTS `room_reservation`;
DROP TABLE IF EXISTS `service_descriptions`;
DROP TABLE IF EXISTS `state`;


--
-- Table structure for table `billing`
--

CREATE  TABLE `billing` (
                             `billing_party_id` INT UNSIGNED AUTO_INCREMENT,
                             `first_name` VARCHAR(45) NOT NULL,
                             `last_name` VARCHAR(45) NOT NULL,
                             `address` VARCHAR(45) NOT NULL,
                             `phone` VARCHAR(45) NOT NULL,
                             `customer_id` INT UNSIGNED,
                             PRIMARY KEY (`billing_party_id`)
                             FOREIGN KEY('customer_id') REFERENCES  'customer' ('customer_id')
) ENGINE = InnoDB;

--
-- Table structure for table `building`
--

CREATE  TABLE `building` (
                             `building_code` INT NOT NULL,
                             `building_name` VARCHAR(45) NOT NULL,
                             `budiling_desription` VARCHAR(45) NOT NULL,
                             `resort_id` INT NOT NULL,
                             PRIMARY KEY (`biuilding_code`)
                             FOREIGN KEY('resort_id') REFERENCES  'resort' ('resort')
) ENGINE = InnoDB;

--
-- Table structure for table `customer`
--

CREATE  TABLE `customer` (
                             `customer_id` INT UNSIGNED AUTO_INCREMENT,
                             `first_name` VARCHAR(45) NOT NULL,
                             `last_name` VARCHAR(45) NOT NULL,
                             `address` VARCHAR(45) NOT NULL,
                             `phone` VARCHAR(45) NOT NULL,
                             `email` VARCHAR(45) NOT NULL,
                             `billing_party_id` INT NOT NULL,
                             `event_code` INT NOT NULL,
                             PRIMARY KEY (`customer_id`)
                             FOREIGN KEY('room_number') REFERENCES  'room' ('room_number')
                             FOREIGN KEY('billing_party_id') REFERENCES  'billing_party' ('billing_party_id')
) ENGINE = InnoDB;

--
-- Table structure for table `resort`
--

CREATE  TABLE `resort` (
                             `resort_code` INT NOT NULL,
                             `name` VARCHAR(45) NOT NULL,
                             `resort_id` INT NOT NULL,
                             `city` VARCHAR(45) NOT NULL,
                             `address` VARCHAR(45) NOT NULL,
                             `state` VARCHAR(45) NOT NULL,
                             `zip_code` INT NOT NULL,
                             'revenue' INT NOT NULL,
                             PRIMARY KEY (`resort_code`)
                             FOREIGN KEY('city') REFERENCES  'city' ('city')
                             FOREIGN KEY('state') REFERENCES  'state' ('state')
) ENGINE = InnoDB;

--
-- Table structure for table `event`
--

CREATE  TABLE `events` (
                             `event_id` INT UNSIGNED AUTO_INCREMENT,
                             `description` VARCHAR(45) NOT NULL,
                             `start_date` DATE NOT NULL,
                             `end_date` DATE NOT NULL,
                             `billing_party_id` INT NOT NULL,
                             PRIMARY KEY (`event_id`)
                              FOREIGN KEY('billing_party_id') REFERENCES  'billing_party' ('billing_party_id')
           
) ENGINE = InnoDB;

--
-- Table structure for table `employee`
--

CREATE  TABLE `employee` (
                             `employee_id` INT UNSIGNED AUTO_INCREMENT,
                             `first_name` VARCHAR(45) NOT NULL,
                             `middle_name` VARCHAR(45) NOT NULL,
                             `last_name` VARCHAR(45) NOT NULL,
                             `address` VARCHAR(45) NOT NULL,
                             `phone` VARCHAR(45) NOT NULL,
                             `status` VARCHAR(45) NOT NULL,
                             `hire_date` DATE NOT NULL,
                             PRIMARY KEY (`employee_id`)
) ENGINE = InnoDB;

--
-- Table structure for table `room`
--

CREATE  TABLE `room` (
                             `room_number` INT NOT NULL,
                             `floor_number` INT NOT NULL,
                             `wing_code` INT NOT NULL,
                             `room_type` VARCHAR(45) NOT NULL,
                             `room_condition` VARCHAR(45) NOT NULL,
                             PRIMARY KEY (`room_number`)
                             FOREIGN KEY('floor_number') REFERENCES  'floor' ('floor_number')
                             FOREIGN KEY('room_type') REFERENCES  'room_type' ('room_type')
) ENGINE = InnoDB;

--
-- Table structure for table `room_reservation`
--

CREATE  TABLE `room_reservation` (
                             'room_reservation_number', INT UNSIGNED AUTO_INCREMENT,
                             `room_number` INT NOT NULL,
                             `customer_id` INT UNSIGNED,
                             `arrival_date` DATE NOT NULL,
                             `leave_date` DATE NOT NULL,
                             `room_rate` INT NOT NULL,
                             'reservation_filling' VARCHAR(45) NOT NULL,
                             PRIMARY KEY (`room_reservation_number`)
                             FOREIGN KEY('room_number') REFERENCES  'room' ('room_number')
                             FOREIGN KEY('customer_id') REFERENCES  'customer' ('customer_id')
) ENGINE = InnoDB;

--
-- Table structure for table `service_description`
--

CREATE  TABLE `service_description` (
                             `resort_services` VARCHAR(45) NOT NULL
                             `service_type_id` INT NOT NULL,
                             `service_desciption` VARCHAR(45) NOT NULL,
                             `service_price` INT NOT NULL,
                            PRIMARY KEY('resort_services') 
                            FOREIGN KEY('service_type_id') REFERENCES  'service_type' ('service_type_id')
           
) ENGINE = InnoDB;

--
-- Table structure for table `state`
--

CREATE  TABLE `state` (
                             'state_name', VARCHAR(45) NOT NULL,
                             `region_id` INT NOT NULL,
                             `sales_tax` INT NOT NULL,
                             PRIMARY KEY (`state_name`)
                             FOREIGN KEY('region_id') REFERENCES  'region' ('region_id')
) ENGINE = InnoDB;


--
-- Below will answer quesitons 6-10
--

--
-- (6) SQL Statement for resort with highest revenue
--

SELECT resort_id, MAX(resort_revenue) 
FROM resort;

--
-- (7) SQL Statement for highest grossing service
--
SELECT service_description, MAX(service_revenue) 
FROM service_description;

--
-- (8) SQL Statement to track path of a guest
--
SELECT customer_id, room_location, date_room_entered
FROM customer
JOIN customer_location ON customer.customer_id=customer_location.customer_id;


--
-- (9) Answer: How much money is the highest grossing event bringing in.
--
SELECT event_id, event_description, MAX(charge_amount) 
FROM events
JOIN event_price ON events.event_id=event_price.event_id;;