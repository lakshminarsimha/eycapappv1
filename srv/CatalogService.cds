using {
    eylakshmi.db.master,
    eylakshmi.db.transaction
} from '../db/datamodel';

service CatalogService @(
    path    : 'CatalogService',
    requires: 'authenticated-user'
) {
    entity EmployeeSet @(restrict: [
        {
            grant: ['READ'],
            to   : 'Viewer',
            where: 'bankName = $user.BankName'
        },
        {
            grant: ['WRITE'],
            to   : 'Admin'
        }
    ])                                      as projection on master.employees;

    entity BusinessPartnerSet               as projection on master.businesspartner;
    entity ProductSet                       as projection on master.product;
    entity BPAddresSet                      as projection on master.address;

    entity POs @(odata.draft.enabled: true) as
        projection on transaction.purchaseorder {
            *,
            case OVERALL_STATUS
                when
                    'P'
                then
                    'Open'
                when
                    'A'
                then
                    'Approved'
                when
                    'X'
                then
                    'Rejected'
                when
                    'D'
                then
                    'Delivered'
                when
                    'N'
                then
                    'New'
            end as OverallStatus : String(10),
            case OVERALL_STATUS
                when
                    'P'
                then
                    0
                when
                    'A'
                then
                    3
                when
                    'X'
                then
                    1
                when
                    'D'
                then
                    2
                when
                    'N'
                then
                    0
            end as Criticality   : String(10),
        } actions {
            @cds.odata.bindingparameter.name: 'eylakshmi'
            @Common.SideEffects             : {TargetProperties: ['eylakshmi/GROSS_AMOUNT']}
            //define your action
            action   boost();
            function largestOrder() returns array of POs;
        };

    entity PurchaseOrderItemSet             as projection on transaction.poitems;

}