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

	public function renderPrepareTest() {
		$this->testDatabase->prepareData();
		$this->sendResponse(new \Nette\Application\Responses\TextResponse('OK'));
		$this->sendResponse(new \Nette\Application\Responses\JsonResponse(array('status' => 'OK')));
	}

	public function renderTest() {
		$this->testDatabase->testAccommodation();
		$this->sendResponse(new \Nette\Application\Responses\TextResponse('OK'));
		$this->sendResponse(new \Nette\Application\Responses\JsonResponse(array('status' => 'OK')));
	}

}
