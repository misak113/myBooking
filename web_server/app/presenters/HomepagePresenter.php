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
		$data = array('status' => 'OK');
		if ($this->isAjax()) {
			$response = new \Nette\Application\Responses\JsonResponse($data);
		} else {
			$response = new \Nette\Application\Responses\TextResponse(_dRet($data), true);
		}
		$this->sendResponse($response);
	}

	public function renderTest() {
		$data = $this->testDatabase->getFreeRooms('', '', 1, 1);
		if ($this->isAjax()) {
			$response = new \Nette\Application\Responses\JsonResponse($data);
		} else {
			$response = new \Nette\Application\Responses\TextResponse(_dRet($data), true);
		}
		$this->sendResponse($response);
	}

}
