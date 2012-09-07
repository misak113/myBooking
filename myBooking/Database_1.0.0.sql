/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     7.9.2012 10:24:36                            */
/*==============================================================*/


drop table if exists authorization_role;

drop table if exists goods;

drop table if exists goods_used_item;

drop table if exists hotel;

drop table if exists invoice;

drop table if exists invoice_item;

drop table if exists payment;

drop table if exists payment_type;

drop table if exists permission;

drop table if exists person;

drop table if exists person_account;

drop table if exists person_account_has_room;

drop table if exists price_category;

drop table if exists provider;

drop table if exists reservation;

drop table if exists reservation_has_room;

drop table if exists room;

drop table if exists room_photo;

drop table if exists user;

/*==============================================================*/
/* Table: authorization_role                                    */
/*==============================================================*/
create table authorization_role
(
   id_role              int not null auto_increment,
   id_permission        int not null,
   name                 varchar(30) not null,
   primary key (id_role)
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   id_goods             int not null auto_increment,
   name                 varchar(100) not null,
   price                float not null,
   date_changed         datetime not null,
   buyable              bool not null,
   global               bool not null,
   primary key (id_goods)
);

/*==============================================================*/
/* Table: goods_used_item                                       */
/*==============================================================*/
create table goods_used_item
(
   id_goods_used_item   int not null auto_increment,
   id_reservation       int not null,
   id_payment           int,
   id_goods             int not null,
   id_room              int,
   date_ordered         datetime not null,
   price                float not null,
   paid                 bool not null,
   primary key (id_goods_used_item)
);

/*==============================================================*/
/* Table: hotel                                                 */
/*==============================================================*/
create table hotel
(
   id_hotel             int not null auto_increment,
   id_provide           int not null,
   name                 varchar(20) not null,
   address              varchar(100) not null,
   description          text,
   primary key (id_hotel)
);

/*==============================================================*/
/* Table: invoice                                               */
/*==============================================================*/
create table invoice
(
   id_invoice           int not null auto_increment,
   id_payment           int not null,
   name                 varchar(50) not null,
   address              varchar(100) not null,
   payment_type         varchar(30) not null,
   bank_number          varchar(30),
   date_issued          date not null,
   date_due             date not null,
   primary key (id_invoice)
);

/*==============================================================*/
/* Table: invoice_item                                          */
/*==============================================================*/
create table invoice_item
(
   id_invoice_item      int not null auto_increment,
   id_invoice           int not null,
   name                 varchar(50) not null,
   price                float not null,
   count                int not null,
   vat                  float not null,
   primary key (id_invoice_item)
);

/*==============================================================*/
/* Table: payment                                               */
/*==============================================================*/
create table payment
(
   id_payment           int not null auto_increment,
   id_payment_type      int not null,
   id_person            int not null,
   date_created         datetime not null,
   date_paid            datetime,
   primary key (id_payment)
);

/*==============================================================*/
/* Table: payment_type                                          */
/*==============================================================*/
create table payment_type
(
   id_payment_type      int not null auto_increment,
   name                 varchar(50) not null,
   price                float not null,
   primary key (id_payment_type)
);

/*==============================================================*/
/* Table: permission                                            */
/*==============================================================*/
create table permission
(
   id_permission        int not null auto_increment,
   name                 varchar(30) not null,
   type                 varchar(20) not null,
   operation            varchar(20) not null,
   primary key (id_permission)
);

/*==============================================================*/
/* Table: person                                                */
/*==============================================================*/
create table person
(
   id_person            int not null auto_increment,
   name                 varchar(100) not null,
   phone                varchar(20),
   email                varchar(50),
   card_number          varchar(30),
   card_expiration      date,
   primary key (id_person)
);

/*==============================================================*/
/* Table: person_account                                        */
/*==============================================================*/
create table person_account
(
   id_person_account    int not null auto_increment,
   id_payment           int not null,
   id_reservation       int not null,
   id_person            int not null,
   primary key (id_person_account)
);

/*==============================================================*/
/* Table: person_account_has_room                               */
/*==============================================================*/
create table person_account_has_room
(
   id_room              int not null,
   id_person_account    int not null,
   date_from            datetime not null,
   date_to              datetime not null,
   primary key (id_room, id_person_account)
);

alter table person_account_has_room comment 'Účet je vázán na pokoj';

/*==============================================================*/
/* Table: price_category                                        */
/*==============================================================*/
create table price_category
(
   id_price_category    int not null auto_increment,
   id_room              int not null,
   price                float not null,
   vat                  float not null,
   date_from            datetime,
   date_to              datetime,
   primary key (id_price_category)
);

/*==============================================================*/
/* Table: provider                                              */
/*==============================================================*/
create table provider
(
   id_provide           int not null auto_increment,
   name                 varchar(50) not null,
   ico                  varchar(20) not null,
   primary key (id_provide)
);

/*==============================================================*/
/* Table: reservation                                           */
/*==============================================================*/
create table reservation
(
   id_reservation       int not null auto_increment,
   primary key (id_reservation)
);

/*==============================================================*/
/* Table: reservation_has_room                                  */
/*==============================================================*/
create table reservation_has_room
(
   id_room              int not null,
   id_reservation       int not null,
   date_from            datetime not null,
   date_to              datetime not null,
   count_persons        int not null,
   count_childs         int not null,
   primary key (id_room, id_reservation)
);

/*==============================================================*/
/* Table: room                                                  */
/*==============================================================*/
create table room
(
   id_room              int not null auto_increment,
   id_hotel             int not null,
   count_persons        int not null,
   count_child          int not null,
   number               int not null,
   floor                char(4) not null,
   description          text not null,
   primary key (id_room)
);

/*==============================================================*/
/* Table: room_photo                                            */
/*==============================================================*/
create table room_photo
(
   id_room_photo        int not null auto_increment,
   id_room              int not null,
   date_created         datetime not null,
   active               bool not null,
   primary key (id_room_photo)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id_user              int not null auto_increment,
   id_role              int not null,
   username             varchar(20) not null,
   authetification      varchar(128) not null,
   email                varchar(50) not null,
   first_name           varchar(30),
   last_name            varchar(30),
   primary key (id_user)
);

alter table authorization_role add constraint `FK_Role má práva` foreign key (id_permission)
      references permission (id_permission) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Do platby zaúčtována položka zboží` foreign key (id_payment)
      references payment (id_payment) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Položka zboží byla použita na pokoji` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Použitá položka zboží v rámci rezervace` foreign key (id_reservation)
      references reservation (id_reservation) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Zboží je vázáno k použité položce` foreign key (id_goods)
      references goods (id_goods) on delete restrict on update restrict;

alter table hotel add constraint `FK_Hotel provozuje provozovatel` foreign key (id_provide)
      references provider (id_provide) on delete restrict on update restrict;

alter table invoice add constraint `FK_Faktura výchází z platby` foreign key (id_payment)
      references payment (id_payment) on delete restrict on update restrict;

alter table invoice_item add constraint `FK_Faktura má položky` foreign key (id_invoice)
      references invoice (id_invoice) on delete restrict on update restrict;

alter table payment add constraint `FK_Osoba je plátcem platby` foreign key (id_person)
      references person (id_person) on delete restrict on update restrict;

alter table payment add constraint `FK_Platba je způsobu` foreign key (id_payment_type)
      references payment_type (id_payment_type) on delete restrict on update restrict;

alter table person_account add constraint `FK_Osoba má otevřené účty` foreign key (id_person)
      references person (id_person) on delete restrict on update restrict;

alter table person_account add constraint `FK_Platba obsahuje účty` foreign key (id_payment)
      references payment (id_payment) on delete restrict on update restrict;

alter table person_account add constraint `FK_Z rezervace vychází účty` foreign key (id_reservation)
      references reservation (id_reservation) on delete restrict on update restrict;

alter table person_account_has_room add constraint FK_Relationship_18 foreign key (id_person_account)
      references person_account (id_person_account) on delete restrict on update restrict;

alter table person_account_has_room add constraint FK_Relationship_19 foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table price_category add constraint `FK_Pokoj je v cenové kategorii po dobu` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table reservation_has_room add constraint FK_Relationship_21 foreign key (id_reservation)
      references reservation (id_reservation) on delete restrict on update restrict;

alter table reservation_has_room add constraint FK_Relationship_22 foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table room add constraint `FK_Pokoj je v hotelu` foreign key (id_hotel)
      references hotel (id_hotel) on delete restrict on update restrict;

alter table room_photo add constraint `FK_Fotky pokoje` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table user add constraint `FK_Uživatel je v roli` foreign key (id_role)
      references authorization_role (id_role) on delete restrict on update restrict;

