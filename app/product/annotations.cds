using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    UI.SelectionFields           : [
        ToCategory_ID,
        ToCurrency_ID,
        StockAvailability_ID,
        ToUnitOfMeasure_ID,
        ToDimensionUnit_ID

    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: Name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: Description,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ImageUrl',
                Value: ImageUrl,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ReleaseDate',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quaintity',
                Value: Quaintity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'UnitOfMeasure_ID',
                Value: UnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Currency_ID',
                Value: Currency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DimensionsUnits_ID',
                Value: DimensionsUnits_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Category',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PriceCondition',
                Value: PriceCondition,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PriceDetermination',
                Value: PriceDetermination,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToUnitOfMeasure_ID',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCurrency_ID',
                Value: ToCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCategory_ID',
                Value: ToCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToDimensionUnit_ID',
                Value: ToDimensionUnit_ID,
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Description',
            Value: Description,
        },
        {
            $Type: 'UI.DataField',
            Label: 'ImageUrl',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: 'ReleaseDate',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'DiscontinuedDate',
            Value: DiscontinuedDate,
        },
    ],
);

annotate service.Products with {
    Supplier @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Supplier',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Supplier_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Fax',
            },
        ],
    }
};

/**
* Annotation for SH
**/
annotate service.Products with {
    //Category
    ToCategory        @(Common: {
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });
    //Currency
    ToCurrency        @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });
    //StockAvailability
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: StockAvailability_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: StockAvailability_ID,
                    ValueListProperty: 'Description'
                }
            ]
        },
    });

    //ToUnitOfMeasure
    ToUnitOfMeasure   @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {

            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_UnityOfMeasure',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToUnitOfMeasure_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToUnitOfMeasure_ID,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });
    //ToDimensionUnit
    ToDimensionUnit @(Common: {
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_DimensionUnits',
            Parameters: [{
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : ToDimensionUnit_ID,
                ValueListProperty : 'Code'
            }, {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : ToDimensionUnit_ID,
                ValueListProperty : 'Text'
            }]
        },

    });

};

/**
* Anotation for VH_Categories Entity
**/
annotate service.VH_Categories with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly,
        }}

    );
    Text @(UI: {HiddenFilter: true});
};

/**
* Anotation for VH_Currencies Entity
**/
annotate service.VH_Currencies with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
* Anotation for StockAvailability Entity
**/
annotate service.StockAvailability with {
    ID @(Common: {Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }, })
};

/**
* Anotation for VH_UnityOfMeasure Entity
**/
annotate service.VH_UnityOfMeasure with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
* Anotation for VH_DimensionUnits Entity
**/
annotate service.VH_DimensionUnits with {
    ID          @(UI: {HiddenFilter: true});
    Description @(UI: {HiddenFilter: true});
};

/**
* Anotation for VH_DimensionUnits Entity
**/
annotate service.VH_UnityOfMeasure with {
    Code @(Common: {Text: {
        $value                : Text,
        ![@UI.TextArrangement]: #TextOnly,
    }})
};
