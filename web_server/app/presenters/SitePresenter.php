<?php

use Katrine\Application\BasePresenter;

/**
 * Homepage presenter.
 */
class SitePresenter extends BasePresenter
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
		set_time_limit(300);
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
		set_time_limit(300);
		$data = array();
		for ($i=0;$i < 1000;$i++) {
			$data[] = $this->testDatabase->getFreeRooms('', '', 1, 1);
		}
		if ($this->isAjax()) {
			$response = new \Nette\Application\Responses\JsonResponse($data);
		} else {
			$response = new \Nette\Application\Responses\TextResponse(_dRet($data), true);
		}
		$this->sendResponse($response);
	}

}
