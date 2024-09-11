using CatalogService as service from '../../srv/catalog-service';


annotate service.Products with @odata.draft.enabled;
annotate service.Products with @odata.draft.bypass;

annotate service.Products with @(
    Capabilities                 : {
        InsertRestrictions: {
            $Type     : 'Capabilities.InsertRestrictionsType',
            Insertable: true
        },
        DeleteRestrictions: {
            $Type    : 'Capabilities.DeleteRestrictionsType',
            Deletable: true
        },

        UpdateRestrictions: {
            $Type    : 'Capabilities.UpdateRestrictionsType',
            Updatable: true
        }

    },


    UI.HeaderInfo                : {
        TypeName      : '{@i18n>Product}',
        TypeNamePlural: '{@i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: Name},
        Description   : {Value: Description}
    },

    // Estos los cambiamos por campo.id ya que no se les puede cambiar el texto
    // UI.SelectionFields           : [
    //     ToCategory_ID,
    //     ToCurrency_ID,
    //     StockAvailability_ID,
    //     ToUnitOfMeasure_ID,
    //     ToDimensionUnit_ID

    // ],
    UI.SelectionFields           : [
        CategoryId,
        CurrencyId,
        StockAvailabilityId,
        UnitOfMeasureId,
        DimensionsUnitsId

    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [

            {
                $Type: 'UI.DataField',
                Label: '{i18n>ReleaseDate}',
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
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'UnitOfMeasure_ID',
            //     Value: UnitOfMeasure_ID,
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Currency}',
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
                Label: 'CategoryId',
                Value: CategoryId,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToDimensionUnit_ID',
                Value: ToDimensionUnit_ID,
            },

        // {
        //   $Type : 'UI.DataFieldForAnnotation',
        //   Label : 'Rating',
        //   Target: '@UI.DataPoint#AvarageRating'
        // },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'General Information Copia',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    //UI.HeaderFacets              : [{
    //    $Type : 'UI.ReferenceFacet',
    //    Target: '@UI.DataPoint#AvarageRating'
    //}],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'ImageUrl',
            Value: ImageUrl,
        },
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
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Supplier',
            Target: 'Supplier/@Communication.Contact',
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
            Label      : 'Stock Availability',
            Value      : StockAvailability_ID,
            Criticality: StockAvailability_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: Price,
        },
    // {
    //     $Type : 'UI.DataFieldForAnnotation',
    //     Label : 'Rating',
    //     Target: '@UI.DataPoint#AvarageRating'
    // },

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
    //ToCategory
    CategoryId @(
        Common: {
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
                        LocalDataProperty: CategoryId,
                        ValueListProperty: 'Code'
                    },
                    {
                        $Type            : 'Common.ValueListParameterInOut',
                        LocalDataProperty: Category,
                        ValueListProperty: 'Text'
                    }
                ]
            },
        },
        title : '{@i18n>CategoryIdd}',
    );
    //Currency
    //ToCurrency
    CurrencyId
               @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: CurrencyId,
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
    StockAvailabilityId

               @(Common: {
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
    //ToUnitOfMeasure
    UnitOfMeasureId

               @(Common: {
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
    //ToDimensionUnit
    DimensionsUnitsId

               @(Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VH_DimensionUnits',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DimensionsUnitsId,
                ValueListProperty: 'Code'
            },
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ToDimensionUnit_ID,
                ValueListProperty: 'Text'
            }
        ]
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
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
* Anotation for VH_UnityOfMeasure Entity
**/
annotate service.VH_UnityOfMeasure with {
    Code @(Common: {Text: {
        $value                : Text,
        ![@UI.TextArrangement]: #TextOnly,
    }})
};

annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier - Role',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]

}, });

annotate service.Products with {
    //CategoryId          @title: '{i18n>CategoryIdd}';
    CurrencyId          @title: '{@i18n>CurrencyId}';
    StockAvailabilityId @title: '{@i18n>StockAvailabilityId}';
    UnitOfMeasureId     @title: '{@i18n>UnitOfMeasureId}';
    DimensionsUnitsId   @title: '{@i18n>DimensionsUnitsId}';
};

annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};
