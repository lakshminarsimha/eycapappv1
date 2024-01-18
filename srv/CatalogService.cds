using  {eylakshmi.db.master,eylakshmi.db.transaction} from '../db/datamodel';
service CatalogService @(path: 'CatalogService') {
    entity  EmployeeSet as projection on master.employees;
    entity  BusinessPartnerSet as projection on master.businesspartner;
    entity  ProductSet as projection on master.product;
    entity  BPAddresSet as projection on master.address;
    entity  POs @(odata.draft.enabled:true) as projection on transaction.purchaseorder 
        {
        *,
        case OVERALL_STATUS
         When 'P' then 'Open'
         When 'A' then 'Approved'
         When 'X' then 'Rejected'
         When 'D' then 'Delivered'
         When 'N' then 'New'
         end as OverallStatus :String(10),
         case OVERALL_STATUS
         When 'P' then 0
         When 'A' then 3
         When 'X' then 1
         When 'D' then 2
         When 'N' then 0
         end as Criticality :String(10),
    } actions{
        @cds.odata.bindingparameter.name:'eylakshmi'
        @Common.SideEffects:{
            TargetProperties:['eylakshmi/GROSS_AMOUNT']
        }
        //define your action
        action boost();
        function largestOrder() returns array of POs;
    };
    entity  PurchaseOrderItemSet as projection on transaction.poitems;
   
}