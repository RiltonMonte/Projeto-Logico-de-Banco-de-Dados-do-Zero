-- Criação do Banco de dados para oficina.
-- drop database oficina;
create database oficina;
use oficina;

-- Criando tabela cliente
create table clients(
	idClient int auto_increment primary key,
	clientName varchar(255),
    Email varchar(50),
    PhoneNumber varchar(11)   
);

-- Criando tabela mecanico
create table mechanic(
	idMechanic int auto_increment primary key,
    mechanicName varchar(50),
    address varchar(255),
    specialty ENUM('Motor', 'Transmissão', 'Eletrica', 'Basica') default 'Basica'
);

-- Criando tabela equipe
create table team(
 idTeam int auto_increment primary key,
 teamName varchar(9)
);

-- Criando tabela Ordem de Serviço
create table serviceOrder(
	idServiceOrder int auto_increment primary key,
    idSOteam int,
    soNumber int unique not null,
    startDate date,
    endDate date,
    soStatus ENUM('Aguardando Pagamento', 'Em execução', 'Finalizado', 'Cancelado') default 'Aguardando Pagamento',
    soValue float,
    constraint fk_SO_team foreign key(idSOteam) references team(idTeam)
);
-- Criando tabela veiculo
create table vehicle(
	idVehicle int auto_increment primary key,
    idVehicleClient int,
    vehicleBrand varchar(45) not null,
    vehicleModel varchar(45) not null,
    vehicleYear int,
    vehiclePlate char(7) not null,
    constraint unique_plate_vehicle unique (vehiclePlate),
    constraint fk_vehicle_client foreign key (idVehicleClient) references clients(idClient)  
);

-- Criando tabela Mão de Obra
create table service(
	idService int auto_increment primary key,
    serviceType ENUM('Revisão', 'Reparo - Basico', 'Reparo - Motor', 'Reparo - Transmissão', 'Reparo - Eletrica') not null,
    serviceValue float
);

-- Criando tabela Peças
create table parts(
	idParts int auto_increment primary key,
    partsName varchar(30),
    partsValue float
);

-- Criando tabela equipe/mecanico
create table mechanic_team(
	idMTmechanic int,
    idMTteam int,
    primary key(idMTmechanic, idMTteam),
    constraint fk_MT_mechanic foreign key (idMTmechanic) references mechanic(idMechanic),
    constraint fk_MT_team foreign key (idMTteam) references team(idTeam)
);

-- Criando tabela Ordem de serviço/Veiculo
create table serviceOrderVehicle(
	idSOVserviceOrder int unique,
    idSOVvehicle int,
    primary key(idSOVserviceOrder, idSOVvehicle),
    constraint fk_SOV_serviceOrder foreign key (idSOVserviceOrder) references serviceOrder(idServiceOrder),
    constraint fk_SOV_vehicle foreign key (idSOVvehicle) references vehicle(idVehicle)
);

-- Criando tabela peças da OS
create table serviceOrderParts(
    idSOPserviceOrder int,
    idSOPparts int,
    units int default 1,
    primary key(idSOPserviceOrder, idSOPparts),
    constraint fk_SOP_serviceOrder foreign key (idSOPserviceOrder) references serviceOrder(idServiceOrder),
    constraint fk_SOP_parts foreign key (idSOPparts) references parts(idParts)    
);

-- Criando tabela Mão de Obra da OS
create table serviceOrderServices(
	idSOSserviceOrder int,
    idSOSservice int,
    primary key(idSOSserviceOrder, idSOSservice),
	constraint fk_SOS_serviceOrder foreign key (idSOSserviceOrder) references serviceOrder(idServiceOrder),
    constraint fk_SOS_services foreign key (idSOSservice) references service(idService)
);



-- inserção de dados

 
-- tabela cliente
-- idClient, clientName, Email, PhoneNumber
insert into clients(clientName, Email, PhoneNumber)
			values('Fulano', 'fulano@mail.com','73912345678'),
				  ('João','joao@mail.com','71974185296'),
                  ('Maria','Maria@mail.com','73975386942');

-- tabela mecanico
-- idMechanic, mechanicName, address, specialty ENUM('Motor', 'Transmissão', 'Eletrica', 'Basica') default 'Basica'
insert into mechanic(mechanicName, address, specialty)
			values('Carlos','Rua A, 26, Centro - Tilambuco','Basica'),
				  ('Paulo','Rua A, 30, Centro - Tilambuco','Motor'),
                  ('Pedro','Av. do anel, 276, Barro Mole - Tilambuco',default),
                  ('Fabio','Rua do quadrado, 10, Fazenda Verde - Tilambuco','Transmissão'),
                  ('Mario','Rua 2, 4050, Barro Mole - Tilambuco','Motor'),
                  ('Alberto','Av. Tico Grande, 69, Barro Mole - Tilambuco','Eletrica');

-- tabela equipe
-- idTeam, teamName
insert into team(teamName)
			values('Equipe A'),
				  ('Equipe B');
 
-- tabela ordem de serviço
-- idServiceOrder, idSOteam, soNumber, startDate, endDate, soStatus ENUM('Aguardando Pagamento', 'Em execução', 'Finalizado', 'Cancelado'), soValue
insert into serviceOrder(idSOteam, soNumber, startDate, endDate, soStatus, soValue)
			values(1,202203,'2022-10-05', null, 'Em execução', 600),
				  (1,202201,'2022-08-17','2022-09-04','Finalizado',1000),
                  (2,202205,'2022-10-31',null,default,750),
                  (2,202202,'2022-09-10','2022-09-11','Finalizado',200),
                  (1,202204,'2022-10-25','2022-10-26','Cancelado',200);

-- tabela equipe/mecanico
-- idMTmechanic, idMTteam	
insert into mechanic_team(idMTmechanic, idMTteam)
			values(1,2),
				  (2,2),
                  (3,1),
                  (4,1),
                  (5,1),
                  (6,2);

-- tabela veiculo
-- idVehicle, idVehicleClient, vehicleBrand, vehicleModel, vehicleYear, vehiclePlate 
insert into vehicle(idVehicleClient, vehicleBrand, vehicleModel, vehicleYear, vehiclePlate)
			values(1,'VW','Gol',2013,'ABC1234'),
				  (1,'Honda','bis',2019,'AEI7410'),
                  (2,'Ford','Ka',2015,'QWE9512'),
                  (3,'Chevrolet','Celta',2010,'GHT6284');

-- tabela Ordem de serviço/Veiculo
-- idSOVserviceOrder, idSOVvehicle
insert into serviceOrderVehicle(idSOVserviceOrder, idSOVvehicle)
			values(1,1),
				  (2,4),
                  (3,3),
                  (4,2),
                  (5,4);
                  
-- tabela Mão de Obra
-- idService, serviceType ENUM('Revisão', 'Reparo - Basico', 'Reparo - Motor', 'Reparo - Transmissão', 'Reparo - Eletrica') default 'Revisão', serviceValue
insert into service(serviceType, serviceValue)
			values('Revisão', 100),
				  ('Reparo - Basico', 250),
                  ('Reparo - Motor', 500),
                  ('Reparo - Transmissão', 500),
                  ('Reparo - Eletrica', 350);

-- tabela Mão de Obra da OS
-- idSOSserviceOrder, idSOSservices
insert into serviceOrderServices(idSOSserviceOrder, idSOSservice)
			values(1, 3),				
                  (2, 3),
                  (2, 4),
                  (3, 2),
                  (3, 5),
                  (4, 1),
                  (5, 1);
	

-- tabela Peças
-- idParts, partsName, partsValue
insert into parts(partsName, partsValue)
			values('Fusivel', 50),
				  ('Oleo de motor', 100),
                  ('Bico injetor', 200);

-- tabela peças da OS
-- idSOPserviceOrder, idSOPparts, units
insert into serviceOrderParts(idSOPserviceOrder, idSOPparts, units)
			values(1, 2, 1),
				  (3, 1, 3),
                  (4, 2, 1),
                  (5, 2, 1);



-- Queries 

-- Relação de Clientes e veiculos
select idClient, clientName, idVehicle, vehicleBrand, vehicleModel, vehiclePlate from vehicle, clients where idClient = idVehicleClient;

-- Quantidade de veiculos por cliente
select idClient, clientName, Email, PhoneNumber, count(*) as number_of_vehicles
		from vehicle, clients 
        where idClient = idVehicleClient
        group by idClient;
        
-- Relação de Clientes com mais de um veiculo
select idClient, clientName, Email, PhoneNumber, count(*) as number_of_vehicles
		from vehicle, clients 
        where idClient = idVehicleClient
        group by idClient
        having count(*)>1;

-- Relação de Mão de Obra e Ordem de Serviço, ordenado por valor do serviço
select idServiceOrder, soNumber, startDate, endDate, soStatus, soValue, serviceValue, idService, serviceType 
		from serviceOrder, service, serviceOrderServices
		where idSOSserviceOrder = idServiceOrder and idSOSservice = idService
        order by soValue;

-- Quais mecanicos pertencem a qual equipe
select teamName as team, mechanicName as mechanic, specialty 
		from mechanic_team, team, mechanic 
        where idMTmechanic = idMechanic and idMTteam = idTeam;

-- Relação entre veiculos e estados da Ordem de serviço
select idVehicle, vehicleBrand, vehicleModel, vehiclePlate, soNumber, startDate, endDate, soStatus 
		from vehicle, serviceOrder, serviceOrderVehicle 
		where idSOVserviceOrder = idServiceOrder and idSOVvehicle = idVehicle;

-- Relação entre peças e ordem de serviço e valor total de peças de cada OS
select idServiceOrder, soNumber, idParts, partsName, units, partsValue, (units*partsValue) as totalPartsValue, soValue
		from parts join serviceOrderParts on idParts = idSOPparts
		join serviceOrder on idServiceOrder = idSOPserviceOrder;