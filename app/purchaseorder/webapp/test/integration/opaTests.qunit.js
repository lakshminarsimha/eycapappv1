sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'lakshmi/papp/purchaseorder/test/integration/FirstJourney',
		'lakshmi/papp/purchaseorder/test/integration/pages/POsList',
		'lakshmi/papp/purchaseorder/test/integration/pages/POsObjectPage',
		'lakshmi/papp/purchaseorder/test/integration/pages/PurchaseOrderItemSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('lakshmi/papp/purchaseorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemSetObjectPage: PurchaseOrderItemSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);