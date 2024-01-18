using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
 UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        CURRENCY_code,
        OVERALL_STATUS
    ],
   UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
            {
            $Type : 'UI.DataFieldForAction',
            Inline : true,
            Label : 'Boost',
            Action : 'CatalogService.boost',
        },
       {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality:Criticality
        }
    ],
     UI.HeaderInfo:{
        TypeName : 'PO',
        TypeNamePlural: 'POs',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        Description: {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
        ImageUrl: 'https://1000logos.net/wp-content/uploads/2023/07/SAP-Logo-768x432.png'
    },
    UI.Facets:[
        {
            $Type:'UI.CollectionFacet',
            Label:'More Detail',
            Facets:[
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.Identification',
                    Label:'More Info'
                },
                {
                    $Type:'UI.ReferenceFacet',
                    Target:'@UI.FieldGroup#PriceInfo',
                    Label:'PriceInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status Info',
                    Target : '@UI.FieldGroup#Status',
                },
            ]
        },
         {
            $Type : 'UI.ReferenceFacet',
            Label : 'Line Item',
            Target : 'Items/@UI.LineItem',
        },
    
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Label : 'Purchase Order Id',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Seller',
            Value : PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : OVERALL_STATUS,
        },
    ],
     UI.FieldGroup #PriceInfo:{
        Label : 'Price Details',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
          
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #Status:{
        Label : 'Status',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
        ],
    }
);
annotate CatalogService.POs with {
    PARTNER_GUID@(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};

annotate CatalogService.PurchaseOrderItemSet with {
    PRODUCT_GUID@(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};

@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);
annotate service.PurchaseOrderItemSet with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },

    ],
    UI.HeaderInfo:{
         TypeName: 'PO Item',
         TypeNamePlural: 'PO Items'
    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'More Item Data',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Label : 'Item Position',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Label: 'Product Id',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ]
);

