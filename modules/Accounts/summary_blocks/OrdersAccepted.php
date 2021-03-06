<?php
class OrdersAccepted{
	public $name = 'Orders accepted';
	public $sequence = 5;
	public $reference = 'SalesOrder';
	
    public function process( $instance ) {
		$adb = PearDatabase::getInstance();
		$salesorder ='SELECT COUNT(sostatus) AS count FROM vtiger_salesorder
				INNER JOIN vtiger_crmentity ON vtiger_crmentity.crmid=vtiger_salesorder.salesorderid
				WHERE vtiger_crmentity.deleted=0 AND vtiger_salesorder.accountid = ? AND vtiger_salesorder.sostatus = ?';
		$result_salesorder = $adb->pquery($salesorder, array( $instance->getId(), 'Approved' ));
		$count = $adb->query_result($result_salesorder, 0, 'count');
		return $count;
    }
}