<?php
use Nette\Database\Connection;
use \PDOException;
use Katrine\Application\BaseModel;

/**
 * @author: Misak113
 * @date-created: 7.9.12
 */
class TestDatabase extends BaseModel
{

	/** @var Connection */
	protected $db;

	protected static $names = array('Pepa', 'Ondra', 'Michael', 'Honza', 'Alfred', 'Lenka');
	protected static $paymentTypes = array('PayPal', 'Hotově', 'PPL', 'Dobírka');

	public function __construct(Connection $db) {
		$this->db = $db;
	}



	public function prepareData() {
		$hotel = $this->pushHotelWithProvider();
		$paymentTypes = $this->pushPaymentTypes();
		$rooms = $this->pushRooms(40, $hotel);
		$accommodation = $this->createAccommodation();
		$possibleRooms = array();
		for ($i=0;$i < 10;$i++) {
			$room = $rooms[array_rand($rooms)];
			$possibleRooms[] = $room;
			$this->addAccommodationRoom($accommodation, $room);
		}
		$persons = $this->pushPersons(300);
		$payingPerson = $persons[array_rand($persons)];
		$paymentType = $paymentTypes[array_rand($paymentTypes)];
		$payment = $this->createPayment($paymentType, $payingPerson);
		$personAccounts = array();
		foreach ($persons as $person) {
			$personAccount = $this->createPersonAccount($payment, $accommodation, $person);
			$this->addPersonAccountRoom($personAccount, $room);
			$personAccounts[] = $personAccount;
		}
	}

	public function getFreeRooms($dateFrom, $dateTo, $count_persons, $count_additional) {
		$args = array();
		$sql = "
			SELECT
				*
			FROM room
			JOIN accommodation_has_room USING (id_room)
			JOIN person_account_has_room USING (id_room)
			LEFT JOIN price_season USING (id_room)
			LEFT JOIN price_category USING (id_room)
			-- LEFT JOIN room_photo USING (id_room)
			WHERE (person_account_has_room.date_from > :date_to
					AND accommodation_has_room.date_from > :date_to
				OR
					person_account_has_room.date_to < :date_from
					AND accommodation_has_room.date_to < :date_from)
				AND (
					room.count_persons >= :count_persons
					AND room.count_additional >= :count_additional
				)
				GROUP BY id_room
			;
		";
		$args['date_to'] = $dateTo;
		$args['date_from'] = $dateFrom;
		$args['count_persons'] = $count_persons;
		$args['count_additional'] = $count_additional;

		$res = $this->db->queryArgs($sql, $args)->fetchAll();
		return $res;
	}

	public function addPersonAccountRoom($personAccount, $room) {
		$data = array(
			'id_person_account' => $personAccount['id_person_account'],
			'id_room' => $room['id_room'],
			'date_from' => date('Y-m-d H:i:s'),
			'date_to' => date('Y-m-d H:i:s'),
		);
		try {
			$this->db->table('person_account_has_room')->insert($data);
		} catch (PDOException $e) {}
	}

	public function addAccommodationRoom($accommodation, $room) {
		$data = array(
			'id_accommodation' => $accommodation['id_accommodation'],
			'id_room' => $room['id_room'],
			'date_from' => date('Y-m-d H:i:s'),
			'date_to' => date('Y-m-d H:i:s'),
			'count_persons' => rand(1, 5),
			'count_additional' => rand(0, 3),
		);
		try {
			$this->db->table('accommodation_has_room')->insert($data);
		} catch (PDOException $e) {}
	}

	public function pushRooms($count, $hotel) {
		$rooms = array();
		for ($i = 0;$i < $count;$i++) {
			$data = array(
				'id_hotel' => $hotel['id_hotel'],
				'count_persons' => rand(1, 5),
				'count_additional' => rand(0, 3),
				'number' => rand(0, 1402),
				'floor' => rand(0,5),
				'description' => '',
			);
			$rooms[] = $this->db->table('room')->insert($data);
		}
		return $rooms;
	}

	public function pushHotelWithProvider() {
		$data = array(
			'name' => 'Quality a.s.',
			'ico' => '123456789',
		);
		$provider = $this->db->table('provider')->insert($data);
		$data = array(
			'id_provider' => $provider['id_provider'],
			'name' => 'Hotel Quality',
			'address' => 'Ke Kurtům 377, Praha 4, 14200',
			'description' => '',
		);
		return $this->db->table('hotel')->insert($data);
	}

	public function pushPaymentTypes() {
		$payment_types = array();
		foreach (self::$paymentTypes as $paymentType) {
			$data = array(
				'name' => $paymentType,
				'price' => 0,
			);
			$payment_types[] = $this->db->table('payment_type')->insert($data);
		}
		return $payment_types;
	}

	public function createPayment($paymentType, $person) {
		$data = array(
			'id_payment_type' => $paymentType['id_payment_type'],
			'id_person' => $person['id_person'],
			'date_created' => date('Y-m-d H:i:s'),
			'date_paid' => date('Y-m-d H:i:s'),
		);
		return $this->db->table('payment')->insert($data);
	}

	public function createAccommodation() {
		$data = array(
			'date_created' => date('Y-m-d H:i:s')
		);
		$accommodation = $this->db->table('accommodation')->insert($data);
		return $accommodation;
	}

	public function pushPersons($count) {
		$persons = array();
		for ($i = 0;$i < $count;$i++) {
			$data = array(
				'name' => self::$names[array_rand(self::$names)],
			);
			$persons[] = $this->db->table('person')->insert($data);
		}
		return $persons;
	}

	public function createPersonAccount($payment, $accommodation, $person) {
		$data = array(
			'id_payment' => $payment['id_payment'],
			'id_accommodation' => $accommodation['id_accommodation'],
			'id_person' => $person['id_person'],
		);
		return $this->db->table('person_account')->insert($data);
	}



	public function toArray($ar) {
		$array = array();
		foreach ($ar as $row) {
			$array[] = $row;
		}
		return $array;
	}

}
