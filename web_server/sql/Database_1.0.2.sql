/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     20.9.2012 15:18:24                           */
/*==============================================================*/


drop index Index_id_accommodation on accommodation;

drop table if exists accommodation;

drop index Index_id_accommodation_has_room on accommodation_has_room;

drop table if exists accommodation_has_room;

drop index Index_accommodation_has_currency on accomodation_has_currency;

drop table if exists accomodation_has_currency;

drop index Index_currency on currency;

drop table if exists currency;

drop index Index_id_goods on goods;

drop table if exists goods;

drop index Index_id_goods_used_item on goods_used_item;

drop table if exists goods_used_item;

drop index Index_id_hotel on hotel;

drop table if exists hotel;

drop index id_invoice on invoice;

drop table if exists invoice;

drop index Index_id_invoice_item on invoice_item;

drop table if exists invoice_item;

drop index Index_id_payment on payment;

drop table if exists payment;

drop index Index_id_payment_type on payment_type;

drop table if exists payment_type;

drop index Index_id_permission on permission;

drop table if exists permission;

drop index Index_id_person on person;

drop table if exists person;

drop index Index_id_person_account on person_account;

drop table if exists person_account;

drop index Index_id_person_account_has_room on person_account_has_room;

drop table if exists person_account_has_room;

drop index Index_id_price_category on price_category;

drop table if exists price_category;

drop index Index_price_season on price_season;

drop table if exists price_season;

drop index Index_id_provider on provider;

drop table if exists provider;

drop index Index_id_role on role;

drop table if exists role;

drop index Index_id_has_permission on role_has_permission;

drop table if exists role_has_permission;

drop index Index_id_room on room;

drop table if exists room;

drop index Index_id_room_photo on room_photo;

drop table if exists room_photo;

drop index Index_id_user on user;

drop table if exists user;

/*==============================================================*/
/* Table: accommodation                                         */
/*==============================================================*/
create table accommodation
(
   id_accommodation     int not null auto_increment,
   date_created         datetime not null,
   date_issued          datetime,
   primary key (id_accommodation)
);

/*==============================================================*/
/* Index: Index_id_accommodation                                */
/*==============================================================*/
create index Index_id_accommodation on accommodation
(
   id_accommodation
);

/*==============================================================*/
/* Table: accommodation_has_room                                */
/*==============================================================*/
create table accommodation_has_room
(
   id_room              int not null,
   id_accommodation     int not null,
   date_from            datetime not null,
   date_to              datetime not null,
   count_persons        int not null,
   count_childs         int not null,
   primary key (id_room, id_accommodation)
);

/*==============================================================*/
/* Index: Index_id_accommodation_has_room                       */
/*==============================================================*/
create index Index_id_accommodation_has_room on accommodation_has_room
(
   id_room,
   id_accommodation
);

/*==============================================================*/
/* Table: accomodation_has_currency                             */
/*==============================================================*/
create table accomodation_has_currency
(
   id_accommodation     int not null,
   id_currency          int not null,
   rate                 float not null,
   primary key (id_accommodation, id_currency)
);

/*==============================================================*/
/* Index: Index_accommodation_has_currency                      */
/*==============================================================*/
create index Index_accommodation_has_currency on accomodation_has_currency
(
   id_accommodation,
   id_currency
);

/*==============================================================*/
/* Table: currency                                              */
/*==============================================================*/
create table currency
(
   id_currency          int not null auto_increment,
   code                 char(3) not null,
   name                 varchar(20) not null,
   primary key (id_currency)
);

/*==============================================================*/
/* Index: Index_currency                                        */
/*==============================================================*/
create index Index_currency on currency
(
   id_currency
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
/* Index: Index_id_goods                                        */
/*==============================================================*/
create index Index_id_goods on goods
(
   id_goods
);

/*==============================================================*/
/* Table: goods_used_item                                       */
/*==============================================================*/
create table goods_used_item
(
   id_goods_used_item   int not null auto_increment,
   id_accommodation     int not null,
   id_payment           int,
   id_goods             int,
   id_room              int not null,
   date_ordered         datetime not null,
   price                float not null,
   paid                 bool not null,
   name                 varchar(100) not null,
   primary key (id_goods_used_item)
);

/*==============================================================*/
/* Index: Index_id_goods_used_item                              */
/*==============================================================*/
create index Index_id_goods_used_item on goods_used_item
(
   id_goods_used_item
);

/*==============================================================*/
/* Table: hotel                                                 */
/*==============================================================*/
create table hotel
(
   id_hotel             int not null auto_increment,
   id_provider          int not null,
   name                 varchar(20) not null,
   address              varchar(100) not null,
   description          text,
   primary key (id_hotel)
);

/*==============================================================*/
/* Index: Index_id_hotel                                        */
/*==============================================================*/
create index Index_id_hotel on hotel
(
   id_hotel
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
/* Index: id_invoice                                            */
/*==============================================================*/
create index id_invoice on invoice
(
   id_invoice
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
/* Index: Index_id_invoice_item                                 */
/*==============================================================*/
create index Index_id_invoice_item on invoice_item
(
   id_invoice_item
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
/* Index: Index_id_payment                                      */
/*==============================================================*/
create index Index_id_payment on payment
(
   id_payment
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
/* Index: Index_id_payment_type                                 */
/*==============================================================*/
create index Index_id_payment_type on payment_type
(
   id_payment_type
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
/* Index: Index_id_permission                                   */
/*==============================================================*/
create index Index_id_permission on permission
(
   id_permission
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
/* Index: Index_id_person                                       */
/*==============================================================*/
create index Index_id_person on person
(
   id_person
);

/*==============================================================*/
/* Table: person_account                                        */
/*==============================================================*/
create table person_account
(
   id_person_account    int not null auto_increment,
   id_payment           int not null,
   id_accommodation     int not null,
   id_person            int not null,
   primary key (id_person_account)
);

/*==============================================================*/
/* Index: Index_id_person_account                               */
/*==============================================================*/
create index Index_id_person_account on person_account
(
   id_person_account
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
/* Index: Index_id_person_account_has_room                      */
/*==============================================================*/
create index Index_id_person_account_has_room on person_account_has_room
(
   id_room,
   id_person_account
);

/*==============================================================*/
/* Table: price_category                                        */
/*==============================================================*/
create table price_category
(
   id_price_category    int not null auto_increment,
   id_room              int not null,
   price                float not null,
   date_from            datetime,
   date_to              datetime,
   priority             int,
   primary key (id_price_category)
);

/*==============================================================*/
/* Index: Index_id_price_category                               */
/*==============================================================*/
create index Index_id_price_category on price_category
(
   id_price_category
);

/*==============================================================*/
/* Table: price_season                                          */
/*==============================================================*/
create table price_season
(
   id_price_season      int not null auto_increment,
   id_room              int not null,
   price                float not null,
   type                 char(3) not null,
   primary key (id_price_season)
);

/*==============================================================*/
/* Index: Index_price_season                                    */
/*==============================================================*/
create index Index_price_season on price_season
(
   id_price_season
);

/*==============================================================*/
/* Table: provider                                              */
/*==============================================================*/
create table provider
(
   id_provider          int not null auto_increment,
   name                 varchar(50) not null,
   ico                  varchar(20) not null,
   primary key (id_provider)
);

/*==============================================================*/
/* Index: Index_id_provider                                     */
/*==============================================================*/
create index Index_id_provider on provider
(
   id_provider
);

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   id_role              int not null auto_increment,
   name                 varchar(30) not null,
   primary key (id_role)
);

/*==============================================================*/
/* Index: Index_id_role                                         */
/*==============================================================*/
create index Index_id_role on role
(
   id_role
);

/*==============================================================*/
/* Table: role_has_permission                                   */
/*==============================================================*/
create table role_has_permission
(
   id_role              int not null,
   id_permission        int not null,
   primary key (id_role, id_permission)
);

/*==============================================================*/
/* Index: Index_id_has_permission                               */
/*==============================================================*/
create index Index_id_has_permission on role_has_permission
(
   id_role,
   id_permission
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
/* Index: Index_id_room                                         */
/*==============================================================*/
create index Index_id_room on room
(
   id_room
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
/* Index: Index_id_room_photo                                   */
/*==============================================================*/
create index Index_id_room_photo on room_photo
(
   id_room_photo
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

/*==============================================================*/
/* Index: Index_id_user                                         */
/*==============================================================*/
create index Index_id_user on user
(
   id_user
);

alter table accommodation_has_room add constraint FK_Relationship_21 foreign key (id_accommodation)
      references accommodation (id_accommodation) on delete restrict on update restrict;

alter table accommodation_has_room add constraint FK_Relationship_22 foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table accomodation_has_currency add constraint FK_Reference_23 foreign key (id_currency)
      references currency (id_currency) on delete restrict on update restrict;

alter table accomodation_has_currency add constraint FK_Reference_24 foreign key (id_accommodation)
      references accommodation (id_accommodation) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Do platby zaúčtována položka zboží` foreign key (id_payment)
      references payment (id_payment) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Položka zboží byla použita na pokoji` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Použitá položka zboží v rámci ubytování` foreign key (id_accommodation)
      references accommodation (id_accommodation) on delete restrict on update restrict;

alter table goods_used_item add constraint `FK_Zboží je vázáno k použité položce` foreign key (id_goods)
      references goods (id_goods) on delete restrict on update restrict;

alter table hotel add constraint `FK_Hotel provozuje provozovatel` foreign key (id_provider)
      references provider (id_provider) on delete restrict on update restrict;

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

alter table person_account add constraint `FK_Z ubytování vychází účty` foreign key (id_accommodation)
      references accommodation (id_accommodation) on delete restrict on update restrict;

alter table person_account_has_room add constraint FK_Relationship_18 foreign key (id_person_account)
      references person_account (id_person_account) on delete restrict on update restrict;

alter table person_account_has_room add constraint FK_Relationship_19 foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table price_category add constraint `FK_Pokoj je v cenové kategorii po dobu` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table price_season add constraint FK_Reference_25 foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table role_has_permission add constraint FK_Reference_21 foreign key (id_role)
      references role (id_role) on delete restrict on update restrict;

alter table role_has_permission add constraint FK_Reference_22 foreign key (id_permission)
      references permission (id_permission) on delete restrict on update restrict;

alter table room add constraint `FK_Pokoj je v hotelu` foreign key (id_hotel)
      references hotel (id_hotel) on delete restrict on update restrict;

alter table room_photo add constraint `FK_Fotky pokoje` foreign key (id_room)
      references room (id_room) on delete restrict on update restrict;

alter table user add constraint `FK_Uživatel je v roli` foreign key (id_role)
      references role (id_role) on delete restrict on update restrict;

