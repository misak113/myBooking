<?php
use Nette\Database\Connection;
/**
 * @author: Misak113
 * @date-created: 7.9.12
 */
class TestDatabase
{

	/** @var Connection */
	protected $db;

	public function __construct(Connection $db) {
		$this->db = $db;
	}

	public function testAccommodation() {
		$this->prepareData();

		$roomsInfo = $this->getFreeRooms('', '', 4);
	}

	public function prepareData() {
		$hotel = $this->pushHotelWithProvider();
		$paymentTypes = $this->pushPaymentTypes();
		$rooms = $this->pushRooms(40, $hotel);
		$accommodation = $this->createAccommodation();
		$possibleRooms = array();
		for ($i=0;$i < 10;$i++) {
			$room = array_rand($rooms);
			$possibleRooms[] = $room;
			$this->addAccommodationRoom($accommodation, $room);
		}
		$persons = $this->pushPersons(300);
		$payingPerson = array_rand($persons);
		$paymentType = array_rand($paymentTypes);
		$payment = $this->createPayment($paymentType, $payingPerson);
		$personAccounts = array();
		foreach ($persons as $person) {
			$personAccount = $this->createPersonAccount($payment, $accommodation, $person);
			$this->addPersonRoom($person, $room);
			$personAccounts[] = $personAccount;
		}
	}

	public  function getFreeRooms($dateFrom, $dateTo, $count) {

	}

	public function addPersonRoom($person, $room) {

	}

	public function addAccommodationRoom($accommodation, $room) {

	}

	public function pushRooms($count, $hotel) {

	}

	public function pushHotelWithProvider() {

	}

	public function pushPaymentTypes() {

	}

	public function createPayment($paymentType, $person) {

	}

	public function createAccommodation() {
		$data = array();
		$accommodation = $this->db->table('accommodation')->insert($data);
		return $accommodation;
	}

	public function pushPersons($count) {

	}

	public function createPersonAccount($payment, $reservation, $person) {

	}

}
