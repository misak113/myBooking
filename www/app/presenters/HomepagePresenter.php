<?php

/**
 * Homepage presenter.
 */
class HomepagePresenter extends BasePresenter
{
	/** @var TestDatabase */
	protected $testDatabase;

	public function setContext(TestDatabase $testDatabase) {
		$this->testDatabase = $testDatabase;
	}

	public function renderDefault()
	{
		$this->template->anyVariable = 'any value';
	}

	public function renderTest() {
		$this->testDatabase->testReservation();
	}

}
